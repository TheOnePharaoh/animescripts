--Final Cross
--  By Shad3

local self=c511005021

function .initial_effect(c)
  --Global effect
  if not self['gl_reg'] then
    local ge1=Effect.CreateEffect(c)
    ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    ge1:SetCode(EVENT_TO_GRAVE)
    ge1:SetOperation(self.reg_op)
    Duel.RegisterEffect(ge1,0)
    self['gl_reg']=true
  end
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetCondition(self.cd)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
end

function self.reg_op(e,tp,eg,ep,ev,re,r,rp)
  if Duel.GetFlagEffect(0,511005021)~=0 then return end
  local c=eg:GetFirst()
  while c do
    if c:IsType(TYPE_SYNCHRO) then
      Duel.RegisterFlagEffect(0,511005021,RESET_PHASE+PHASE_END,0,1)
      break
    end
    c=eg:GetNext()
  end
end

function self.at_fil(c)
  return c:IsType(TYPE_SYNCHRO) and c:IsFaceup() and c:GetAttackAnnouncedCount()>0 and c:RegisterFlagEffect(511005021)==0
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return Duel.GetFlagEffect(0,511005021)~=0
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingMatchingCard(self.at_fil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
  local tc=Duel.SelectMatchingCard(tp,self.at_fil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil):GetFirst()
  if tc then
    tc:RegisterFlagEffect(511005021,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_EXTRA_ATTACK)
    e1:SetValue(1)
    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    tc:RegisterEffect(e1)
  end
end