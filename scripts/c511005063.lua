--Magical Hats (Anime)
--  By Shad3

local self=c511005063

function self.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_ATTACK_ANNOUNCE)
  e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
  e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e1:SetCondition(self.cd)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return Duel.GetAttacker():IsControler(1-tp)
end

function self.fil(c)
  return c:IsRace(RACE_SPELLCASTER) and c:IsFaceup()
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(self.fil,tp,LOCATION_MZONE,0,1,nil) end
  Duel.SelectTarget(tp,self.fil,tp,LOCATION_MZONE,0,1,1,nil)
  Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,Duel.GetLocationCount(tp,LOCATION_MZONE),tp,0)
end

function self.sum_fil(c,e,tp)
  return c:IsType(TYPE_SPELL+TYPE_TRAP) and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetCode(),nil,0x11,0,0,0,0,0)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if not tc:IsRelateToEffect(e) then return end
  local loc=Duel.GetLocationCount(tp,LOCATION_MZONE)
  if loc<1 then return end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
  local sg=Duel.SelectMatchingCard(tp,self.sum_fil,tp,LOCATION_DECK,0,0,loc,nil,e,tp)
  local sco=sg:GetCount()
  if loc-sco>0 then
    for i=1,loc-sco do
      sg:AddCard(Duel.CreateToken(tp,511005062))
    end
  end
  local stc=sg:GetFirst()
  while stc do
    if stc:IsType(TYPE_TRAP) then
      local te=stc:GetActivateEffect()
      if te and te:GetCode()==EVENT_FREE_CHAIN then
        local se1=Effect.CreateEffect(stc)
        se1:SetType(EFFECT_TYPE_QUICK_O)
        se1:SetCondition(self.mimic2_cd)
        se1:SetCost(self.mimic2_cs)
        if te:GetTarget() then se1:SetTarget(te:GetTarget()) end
        se1:SetOperation(self.mimic2_op)
        se1:SetProperty(bit.bor(te:GetProperty(),EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_UNCOPYABLE))
        se1:SetCategory(te:GetCategory())
        se1:SetLabel(te:GetLabel())
        se1:SetLabelObject(te:GetLabelObject())
        se1:SetReset(RESET_EVENT+0x47c0000)
        if not stc:IsType(TYPE_CONTINUOUS) then
          local se2=se1:Clone()
          se2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
          se2:SetCondition(self.mimic_cd)
          se2:SetCost(self.mimic_cs)
          se2:SetOperation(self.mimic_op)
          se2:SetProperty(bit.bor(te:GetProperty(),EFFECT_FLAG_UNCOPYABLE))
          stc:RegisterEffect(se2)
        end
        se1:SetCode(EVENT_FREE_CHAIN)
        se1:SetRange(LOCATION_MZONE)
        se1:SetCountLimit(1)
        stc:RegisterEffect(se1)
      end
    elseif stc:IsType(TYPE_SPELL) and not stc:IsType(TYPE_CONTINUOUS) then
      local te=stc:GetActivateEffect()
      if te and te:GetCode()==EVENT_FREE_CHAIN then
        local se1=Effect.CreateEffect(stc)
        se1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
        se1:SetCondition(self.mimic_cd)
        se1:SetCost(self.mimic_cs)
        if te:GetTarget() then se1:SetTarget(te:GetTarget()) end
        se1:SetOperation(self.mimic_op)
        se1:SetProperty(bit.bor(te:GetProperty(),EFFECT_FLAG_UNCOPYABLE))
        se1:SetCategory(te:GetCategory())
        se1:SetLabel(te:GetLabel())
        se1:SetLabelObject(te:GetLabelObject())
        se1:SetReset(RESET_EVENT+0x47c0000)
        stc:RegisterEffect(se1)
      end
    end
    local e1=Effect.CreateEffect(stc)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_CHANGE_TYPE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetValue(TYPE_NORMAL+TYPE_MONSTER)
    e1:SetReset(RESET_EVENT+0x47c0000)
    stc:RegisterEffect(e1,true)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_REMOVE_RACE)
    e2:SetValue(RACE_ALL)
    stc:RegisterEffect(e2,true)
    local e3=e1:Clone()
    e3:SetCode(EFFECT_REMOVE_ATTRIBUTE)
    e3:SetValue(0xff)
    stc:RegisterEffect(e3,true)
    local e4=e1:Clone()
    e4:SetCode(EFFECT_SET_BASE_ATTACK)
    e4:SetValue(0)
    stc:RegisterEffect(e4,true)
    local e5=e1:Clone()
    e5:SetCode(EFFECT_SET_BASE_DEFENCE)
    e5:SetValue(0)
    stc:RegisterEffect(e5,true)
    stc:SetStatus(STATUS_NO_LEVEL,true)
    stc=sg:GetNext()
  end
  Duel.SpecialSummon(sg,0,tp,tp,true,false,POS_FACEDOWN_DEFENCE)
  if tc:IsFaceup() then
    if tc:IsHasEffect(EFFECT_DEVINE_LIGHT) then Duel.ChangePosition(tc,POS_FACEUP_DEFENCE)
    else
      Duel.ChangePosition(tc,POS_FACEDOWN_DEFENCE)
      tc:ClearEffectRelation()
    end
  end
  sg:AddCard(tc)
  Duel.ConfirmCards(1-tp,sg)
  Duel.ShuffleSetCard(sg)
end

function self.mimic_cd(e,tp,eg,ep,ev,re,r,rp)
  if Duel.GetCurrentPhase()==PHASE_DAMAGE then
    local cond=e:GetHandler():GetActivateEffect():GetCondition()
    if cond then return cond(e,tp,eg,ep,ev,re,r,rp) end
    return true
  end
  return false
end

function self.mimic_cs(e,tp,eg,ep,ev,re,r,rp,chk)
  local cost=e:GetHandler():GetActivateEffect():GetCost()
  if chk==0 then return not cost or cost(e,tp,eg,ep,ev,re,r,rp,0) end
  e:SetType(EFFECT_TYPE_ACTIVATE)
  if cost then cost(e,tp,eg,ep,ev,re,r,rp,chk) end
end

function self.mimic_op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  c:SetStatus(STATUS_ACTIVATED,true)
  local op=c:GetActivateEffect():GetOperation()
  if op then op(e,tp,eg,ep,ev,re,r,rp) end
  c:CancelToGrave(false)
end

function self.mimic2_cd(e,tp,eg,ep,ev,re,r,rp)
  if Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.GetAttackTarget() and Duel.GetAttackTarget()==e:GetHandler() then
    local cond=e:GetHandler():GetActivateEffect():GetCondition()
    return not cond or cond(e,tp,eg,ep,ev,re,r,rp)
  end
  return false
end

function self.mimic2_cs(e,tp,eg,ep,ev,re,r,rp,chk)
  local c=e:GetHandler()
  local cost=c:GetActivateEffect():GetCost()
  if chk==0 then return not cost or cost(e,tp,eg,ep,ev,re,r,rp,0) end
  Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
  c:ResetEffect(EFFECT_CHANGE_TYPE,RESET_CODE)
  e:SetType(EFFECT_TYPE_ACTIVATE)
  Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
  if cost then cost(e,tp,eg,ep,ev,re,r,rp,chk) end
end

function self.mimic2_op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  c:SetStatus(STATUS_ACTIVATED,true)
  local op=c:GetActivateEffect():GetOperation()
  if op then op(e,tp,eg,ep,ev,re,r,rp) end
  if c:IsType(TYPE_CONTINUOUS+TYPE_EQUIP) and c:IsOnField() then c:CancelToGrave() end
end