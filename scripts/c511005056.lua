--Reservation Reward
--  By Shad3

local self=c511005056

function self.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  c:RegisterEffect(e1)
  --Pierce
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
  e2:SetCode(EVENT_CHAINING)
  e2:SetRange(LOCATION_SZONE)
  e2:SetCondition(self.cd)
  e2:SetOperation(self.op)
  c:RegisterEffect(e2)
  --Set
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_IGNITION)
  e3:SetRange(LOCATION_SZONE)
  e3:SetTarget(self.set_tg)
  e3:SetOperation(self.set_op)
  e3:SetCountLimit(1)
  c:RegisterEffect(e3)
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) and re:IsActiveType(TYPE_SPELL) and re:IsActiveType(TYPE_QUICKPLAY)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  local eg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
  local tc=eg:GetFirst()
  while tc do
    if tc:IsFaceup() and tc:IsLocation(LOCATION_MZONE) then
      if not c:IsRelateToCard(tc) then
        c:CreateRelation(tc,RESET_EVENT+0x1fe0000)
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_PIERCE)
        e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        e1:SetCondition(self.fx_cd)
        tc:RegisterEffect(e1)
      end
      if c:IsRelateToCard(re:GetHandler()) and not c:IsHasCardTarget(tc) then
        c:SetCardTarget(tc)
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_SET_ATTACK_FINAL)
        e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        e1:SetCondition(self.dbl_cd)
        e1:SetValue(self.dbl_val)
        tc:RegisterEffect(e1)
      end
    end
    tc=eg:GetNext()
  end
end

function self.fx_cd(e,c)
  if e:GetOwner():IsRelateToCard(e:GetHandler()) then return e:GetHandler():GetControler()==e:GetOwner():GetControler() end
  e:Reset()
  return false
end

function self.dbl_cd(e,c)
  if e:GetOwner():IsRelateToCard(e:GetHandler()) then
    local ph=Duel.GetCurrentPhase()
    return ph>=0x08 and ph<=0x20
  end
  e:Reset()
  return false
end

function self.dbl_val(e,c)
  return c:GetAttack()*2
end

function self.qui_fil(c)
  return c:IsType(TYPE_SPELL) and c:IsType(TYPE_QUICKPLAY) and c:IsSSetable()
end

function self.set_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.IsExistingMatchingCard(self.qui_fil,tp,LOCATION_HAND,0,1,nil) end
end

function self.set_op(e,tp,eg,ep,ev,re,r,rp)
  if not e:GetHandler():IsRelateToEffect(e) then return end
  local tc=Duel.SelectMatchingCard(tp,self.qui_fil,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
  if tc then
    Duel.SSet(tp,tc)
    e:GetHandler():CreateRelation(tc,RESET_EVENT+0x1fe0000)
    local te=tc:GetActivateEffect()
    if not te then return end
    local e1=Effect.CreateEffect(tc)
    e1:SetType(EFFECT_TYPE_QUICK_O)
    e1:SetCode(te:GetCode())
    e1:SetRange(LOCATION_SZONE)
    e1:SetCountLimit(1)
    if te:GetCondition() then e1:SetCondition(te:GetCondition()) end
    e1:SetCost(self.mimic_cs)
    if te:GetTarget() then e1:SetTarget(te:GetTarget()) end
    e1:SetOperation(self.mimic_op)
    e1:SetProperty(bit.bor(te:GetProperty(),EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_UNCOPYABLE))
    e1:SetCategory(te:GetCategory())
    e1:SetLabel(te:GetLabel())
    e1:SetLabelObject(te:GetLabelObject())
    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    tc:RegisterEffect(e1)
  end
end

function self.mimic_cs(e,tp,eg,ep,ev,re,r,rp,chk)
  local cost=e:GetHandler():GetActivateEffect():GetCost()
  if chk==0 then return not cost or cost(e,tp,eg,ep,ev,re,r,rp,0) end
  Duel.ChangePosition(e:GetHandler(),POS_FACEUP)
  e:SetType(EFFECT_TYPE_ACTIVATE)
  if cost then cost(e,tp,eg,ep,ev,re,r,rp,chk) end
end

function self.mimic_op(e,tp,eg,ep,ev,re,r,rp)
  e:GetHandler():SetStatus(STATUS_ACTIVATED,true)
  local op=e:GetHandler():GetActivateEffect():GetOperation()
  if op then op(e,tp,eg,ep,ev,re,r,rp) end
  e:GetHandler():CancelToGrave(false)
end