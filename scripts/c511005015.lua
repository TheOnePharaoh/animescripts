--Anchor Whale
--  By Shad3

local self=c511005015

function self.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetProperty(EVENT_FLAG_CARD_TARGET)
  e1:SetCategory(CATEGORY_EQUIP)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
  --Attack down
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
  e2:SetCode(EVENT_PHASE+PHASE_END)
  e2:SetRange(LOCATION_SZONE)
  e2:SetCategory(CATEGORY_ATKCHANGE)
  e2:SetCountLimit(1)
  e2:SetOperation(self.atkdn_op)
  c:RegisterEffect(e2)
  --Self Destruct
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_EQUIP)
  e3:SetCode(EFFECT_SELF_DESTROY)
  e3:SetCondition(self.sdes_cd)
  c:RegisterEffect(e3)
  --Cannot be banished
  local e4=Effect.CreateEffect(c)
  e4:SetType(EFFECT_TYPE_EQUIP)
  e4:SetCode(EFFECT_CANNOT_REMOVE)
  c:RegisterEffect(e4)
  --Equip limit
  local e5=Effect.CreateEffect(c)
  e5:SetType(EFFECT_TYPE_SINGLE)
  e5:SetCode(EFFECT_EQUIP_LIMIT)
  e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e5:SetValue(1)
  c:RegisterEffect(e5)
end

--Effect 1 Activate (Equip)

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:GetLocation()==LOCATION_MZONE and chkc:IsFaceup() end
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
  end
end

--Effect 2 Attack Down

function self.atkdn_op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  if not c:IsRelateToEffect(e) then return end
  local tc=c:GetEquipTarget()
  if not e:GetLabelObject() then
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_EQUIP)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetValue(-1000)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    c:RegisterEffect(e1)
    e:SetLabelObject(e1)
    e:SetLabel(1)
  else
    local ne=e:GetLabelObject()
    local nv=e:GetLabel()+1
    e:SetLabel(nv)
    ne:SetValue(-1000*nv)
  end
end

--Effect 3 Self Destruct

function self.sdes_cd(e)
  return e:GetHandler():GetEquipTarget():GetAttack()==0
end