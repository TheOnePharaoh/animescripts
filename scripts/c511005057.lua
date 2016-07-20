--Remember Attack
--  By Shad3

local self=c511005057

function self.initial_effect(c)
  --Global reg
  if not self['gl_reg'] then
    self['gl_reg']=true
    local ge1=Effect.CreateEffect(c)
    ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    ge1:SetCode(EVENT_CHAIN_NEGATED)
    ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    ge1:SetOperation(self.flag_op)
    Duel.RegisterEffect(ge1,0)
  end
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
end

function self.flag_op(e,tp,eg,ep,ev,re,r,rp)
  if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetCode()==EVENT_FREE_CHAIN then
    local c=re:GetHandler()
    if c:GetOriginalCode()==511005057 then return end
    if c:GetFlagEffect(511005057)~=0 then c:ResetFlagEffect(511005057) end
    c:RegisterFlagEffect(511005057,RESET_PHASE+PHASE_END,0,3)
    c:RegisterFlagEffect(511005057,RESET_PHASE+PHASE_END,0,1)
  end
end

function self.rpl_fil(c,e,tp,eg,ep,ev,re,r,rp)
  if c:GetFlagEffect(511005057)==1 and c:IsCanBeEffectTarget(e) then
    local te=c:GetActivateEffect()
    local cd=te:GetCondition()
    local cs=te:GetCost()
    local tg=te:GetTarget()
    return te:IsActivatable(tp) and
      (not cd or cd(te,tp,eg,ep,ev,re,r,rp)) and
      (not cs or cs(te,tp,eg,ep,ev,re,r,rp,0)) and
      (not tg or tg(te,tp,eg,ep,ev,re,r,rp,0))
  end
  return false
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  local g=Duel.GetMatchingGroup(self.rpl_fil,tp,LOCATION_GRAVE,0,nil,e,tp,eg,ep,ev,re,r,rp)
  if chk==0 then
    local loc
    if e:GetHandler():IsLocation(LOCATION_SZONE) then
      loc=Duel.GetLocationCount(tp,LOCATION_SZONE)>0
    else
      loc=Duel.GetLocationCount(tp,LOCATION_SZONE)>1
    end
    return loc and g:GetCount()>0
  end
  e:SetProperty(EFFECT_FLAG_CARD_TARGET)
  local tc=g:Select(tp,1,1,nil)
  Duel.SetTargetCard(tc)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if not tc:IsRelateToEffect(e) or Duel.GetLocationCount(tp,LOCATION_SZONE)<1 then return end
  local te=tc:GetActivateEffect()
  local cd=te:GetCondition()
  local cs=te:GetCost()
  local tg=te:GetTarget()
  local op=te:GetOperation()
  if te:IsActivatable(tp) and
    (not cd or cd(te,tp,eg,ep,ev,re,r,rp)) and
    (not cs or cs(te,tp,eg,ep,ev,re,r,rp,0)) and
    (not tg or tg(te,tp,eg,ep,ev,re,r,rp,0))
  then
    Duel.ClearTargetCard()
    e:SetProperty(te:GetProperty())
    Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
    Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
    if not (tc:IsType(TYPE_SPELL) and tc:IsType(TYPE_CONTINUOUS)) then tc:CancelToGrave(false) end
    if not tc:IsType(TYPE_SPELL) then return end
    tc:CreateEffectRelation(te)
    if cs then cs(te,tp,eg,ep,ev,re,r,rp,1) end
    if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
    local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
    if g then
      local tgc=g:GetFirst()
      while tgc do
        tgc:CreateEffectRelation(te)
        tgc=g:GetNext()
      end
    end
    tc:SetStatus(STATUS_ACTIVATED,true)
    if op then op(te,tp,eg,ep,ev,re,r,rp) end
    tc:ReleaseEffectRelation(te)
    if g then
      local tgc=g:GetFirst()
      while tgc do
        tgc:ReleaseEffectRelation(te)
        tgc=g:GetNext()
      end
    end
  end
end