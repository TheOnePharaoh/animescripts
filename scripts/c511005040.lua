--Surprise Inspection
--  By Shad3

local self=c511005040

function self.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetCategory(CATEGORY_POSITION)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
end

function self.fd_fil(c)
  return c:GetPosition()==POS_FACEDOWN_DEFENCE
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsOnField() end
  if chk==0 then return Duel.IsExistingTarget(self.fd_fil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
  Duel.SetOperationInfo(0,CATEGORY_POSITION,Duel.SelectTarget(tp,self.fd_fil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil),1,0,0)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) then Duel.ChangePosition(tc,POS_FACEUP_DEFENCE) end
end