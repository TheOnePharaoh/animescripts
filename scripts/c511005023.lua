--Bonds of Hope
--  By Shad3

local self=c511005023

function self.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
  e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
  e1:SetCondition(self.cd)
	e1:SetTarget(self.tg)
	e1:SetOperation(self.op)
	c:RegisterEffect(e1)
end

function self.xyz_sum_fil(c,p)
  return c:IsType(TYPE_XYZ) and c:GetControler()==p
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return eg:IsExists(self.xyz_sum_fil,1,nil,tp)
end

function self.xyz_grv_fil(c,e,p)
  return c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,0,p,false,false)
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingTarget(self.xyz_grv_fil,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
  Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,Duel.SelectTarget(tp,self.xyz_grv_fil,tp,LOCATION_GRAVE,0,1,1,nil,e,tp),1,0,0)
end

function self.xyz_fup_fil(c)
  return c:IsType(TYPE_XYZ) and c:IsFaceup()
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  local tc=Duel.GetFirstTarget()
  if not (tc:IsRelateToEffect(e) and self.xyz_grv_fil(tc,e,tp)) then return end
  if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP) then
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEXYZ)
    local og=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_MZONE,0,1,1,nil,TYPE_XYZ):GetFirst():GetOverlayGroup()
    if c:IsRelateToEffect(e) then
      c:CancelToGrave()
      og:AddCard(c)
    end
    if og:GetCount()>0 then
      Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
      local nc=Duel.SelectMatchingCard(tp,self.xyz_fup_fil,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
      Duel.Overlay(nc,og)
    end
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_PHASE+PHASE_END)
    e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
    e1:SetReset(RESET_PHASE+PHASE_END)
    e1:SetCountLimit(1)
    e1:SetOperation(des_op)
    e1:SetLabelObject(tc)
    Duel.RegisterEffect(e1,tp)
  end
end

function des_op(e,tp,eg,ep,ev,re,r,rp)
  local tc=e:GetLabelObject()
  if tc:IsOnField() then Duel.Destroy(tc,REASON_EFFECT) end
end