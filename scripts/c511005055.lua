--Flattery
--  By Shad3

local self=c511005055

function self.initial_effect(c)
  --Global Reg
  if not self['gl_reg'] then
    self['gl_reg']=true
    local ge1=Effect.CreateEffect(c)
    ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    ge1:SetCode(EVENT_ADJUST)
    ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    ge1:SetOperation(self.flag_op)
    Duel.RegisterEffect(ge1,0)
  end
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(511005055)
  e1:SetCategory(CATEGORY_ATKCHANGE)
  e1:SetCondition(self.cd)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
end

function self.flag_reg(c)
  if c:IsFaceup() and c:GetFlagEffect(511005055)==0 then
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_ADJUST)
    e1:SetRange(LOCATION_MZONE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    e1:SetLabel(c:GetAttack())
    e1:SetOperation(self.flag_raise)
    c:RegisterEffect(e1)
    c:RegisterFlagEffect(511005055,RESET_EVENT+0x1fe0000,0,1)
  end
end

function self.flag_op(e,tp,eg,ep,ev,re,r,rp)
  Duel.GetFieldGroup(0,LOCATION_MZONE,LOCATION_MZONE):ForEach(self.flag_reg)
end

function self.flag_raise(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  if e:GetLabel()==c:GetAttack() then return end
  if Duel.GetCurrentPhase()==PHASE_BATTLE then
    Duel.RaiseEvent(Group.FromCards(c),511005055,e,REASON_EFFECT,rp,tp,math.abs(e:GetLabel()-c:GetAttack()))
  end
  e:SetLabel(c:GetAttack())
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return ep~=tp
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsFaceup() and chkc:IsControler(tp) end
  if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
  Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) then
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
    e1:SetValue(ev)
    tc:RegisterEffect(e1)
  end
end