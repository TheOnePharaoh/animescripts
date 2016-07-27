--Power Gravity
--パワー・グラヴィティ
--  By Shad3

local self=c511005071

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
  e1:SetCode(511005071)
  e1:SetCondition(self.cd)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
  --Destroy
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
  e2:SetCode(EVENT_PHASE+PHASE_END)
  e2:SetRange(LOCATION_SZONE)
  e2:SetCondition(self.selfds_cd)
  e2:SetOperation(self.selfds_op)
  c:RegisterEffect(e2)
end

function self.flag_reg(c)
  if c:IsFaceup() and c:GetFlagEffect(511005071)==0 then
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_ADJUST)
    e1:SetRange(LOCATION_MZONE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    e1:SetLabel(c:GetAttack())
    e1:SetOperation(self.flag_raise)
    c:RegisterEffect(e1)
    c:RegisterFlagEffect(511005071,RESET_EVENT+0x1fe0000,0,1)
  end
end

function self.flag_op(e,tp,eg,ep,ev,re,r,rp)
  Duel.GetFieldGroup(0,LOCATION_MZONE,LOCATION_MZONE):ForEach(self.flag_reg)
end

function self.flag_raise(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  if e:GetLabel()==c:GetAttack() then return end
  Duel.RaiseEvent(Group.FromCards(c),511005071,e,REASON_EFFECT,tp,tp,math.abs(e:GetLabel()-c:GetAttack()))
  e:SetLabel(c:GetAttack())
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return rp~=tp
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
  if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
  Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
  Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) and tc:IsFaceup() and c:IsRelateToEffect(e) then
    Duel.Equip(tp,c,tc)
    local e0=Effect.CreateEffect(c)
    e0:SetType(EFFECT_TYPE_SINGLE)
    e0:SetCode(EFFECT_SET_ATTACK_FINAL)
    e0:SetValue(0)
    e0:SetReset(RESET_EVENT+0x1fe0000)
    re:GetHandler():RegisterEffect(e0)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_EQUIP_LIMIT)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetLabelObject(tc)
    e1:SetValue(function(e,c) return c==e:GetLabelObject() end)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    c:RegisterEffect(e1)
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_EQUIP)
    e2:SetCode(EFFECT_UPDATE_ATTACK)
    e2:SetValue(ev)
    e2:SetReset(RESET_EVENT+0x1fe0000)
    c:RegisterEffect(e2)
  end
end

function self.selfds_cd(e,tp,eg,ep,ev,re,r,rp)
  local ec=e:GetHandler():GetEquipTarget()
  return ec and ec:GetAttackAnnouncedCount()>0
end

function self.selfds_op(e,tp,eg,ep,ev,re,r,rp)
  Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end