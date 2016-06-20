--Double Evolution
--  By Shad3

local self=c511005005

function self.initial_effect(c)
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetProperty(EVENT_FLAG_CARD_TARGET)
  e1:SetTarget(self.act_tg)
  e1:SetOperation(self.act_op)
  c:RegisterEffect(e1)
end

function self.fil(c)
  return c:IsFaceup() and c:GetType()==0x40002
end

function self.act_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsOnField() and self.fil(chkc) end
  if chk==0 then return Duel.IsExistingTarget(self.fil,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
  Duel.SelectTarget(tp,self.fil,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil)
end

function self.act_op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) then
    tc:CopyEffect(tc:GetCode(),RESET_EVENT+0x1fe0000)
  end
end