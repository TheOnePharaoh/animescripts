--Substitution Shield
--身代わりの盾
--  By Shad3

local self=c511005074

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
  --Equip limit
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_SINGLE)
  e2:SetCode(EFFECT_EQUIP_LIMIT)
  e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e2:SetValue(1)
  c:RegisterEffect(e2)
  --Negate 1 attack
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
  e3:SetCode(EVENT_ATTACK_ANNOUNCE)
  e3:SetRange(LOCATION_SZONE)
  e3:SetOperation(self.neg_op)
  c:RegisterEffect(e3)
end

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

function self.neg_op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  local tc=c:GetEquipTarget()
  local tep=tc:GetControler()
  if Duel.GetFlagEffect(tep,511005074)==0 and c:GetFlagEffect(511005074)==0 and not tc:IsDisabled() and Duel.SelectYesNo(tep,aux.Stringid(511005074,0)) then
    Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
    Duel.NegateAttack()
    Duel.RegisterFlagEffect(tep,511005074,RESET_PHASE+PHASE_DAMAGE,0,0)
    c:RegisterFlagEffect(511005074,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
  end
end