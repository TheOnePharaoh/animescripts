--Final Prophecy
--  By Shad3

local self=c511005046

function self.initial_effect(c)
  --Damage
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
  e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
  e1:SetRange(LOCATION_SZONE)
  e1:SetDescription(aux.Stringid(511005046,0))
  e1:SetCategory(CATEGORY_DAMAGE)
  e1:SetCondition(self.dm_cd)
  e1:SetTarget(self.dm_tg)
  e1:SetOperation(self.dm_op)
  e1:SetCountLimit(1)
  c:RegisterEffect(e1)
  --Activate
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_ACTIVATE)
  e2:SetCode(EVENT_CHAINING)
  e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
  e2:SetCondition(self.cd)
  e2:SetCost(self.cs)
  e2:SetTarget(self.tg)
  e2:SetOperation(self.op)
  e2:SetLabelObject(e1)
  c:RegisterEffect(e2)
end

function self.dm_cd(e,tp,eg,ep,ev,re,r,rp)
  return Duel.GetTurnPlayer()==tp and e:GetHandler():GetFlagEffect(511005046)==0
end

function self.dm_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,e:GetLabel())
end

function self.dm_op(e,tp,eg,ep,ev,re,r,rp)
  if not e:GetHandler():IsRelateToEffect(e) then return end
  if e:GetLabel()>0 then
    Duel.Damage(tp,e:GetLabel(),REASON_EFFECT)
    Duel.Damage(1-tp,e:GetLabel(),REASON_EFFECT)
  end
  Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return re:IsActiveType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) and rp~=tp
end

function self.eq_fil(c)
  return c:IsType(TYPE_EQUIP) and c:IsFaceup()
end

function self.cs(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingMatchingCard(self.eq_fil,tp,LOCATION_SZONE,0,1,nil) end
  local g=Duel.SelectMatchingCard(tp,self.eq_fil,tp,LOCATION_ONFIELD,0,1,1,nil)
  local tc=g:GetFirst():GetEquipTarget()
  local atk=tc:GetAttack()
  Duel.Destroy(g,REASON_COST)
  e:GetLabelObject():SetLabel(math.abs(atk-tc:GetAttack()))
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
  if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
  end
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  if e:GetHandler():IsRelateToEffect(e) then
    Duel.NegateEffect(ev)
    if re:GetHandler():IsRelateToEffect(re) then
      Duel.Destroy(re:GetHandler(),REASON_EFFECT)
    end
    if Duel.GetCurrentPhase()==PHASE_STANDBY and Duel.GetTurnPlayer()==tp then
      e:GetHandler():RegisterFlagEffect(511005046,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
    end
  end
end