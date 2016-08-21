--Wind Witch Crystal Bell
function c511009174.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,7543,c511009174.mat_filter,1,true,true)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(41209827,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c511009174.nmtg)
	e2:SetOperation(c511009174.nmop)
	c:RegisterEffect(e2)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23899727,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c511009174.condition)
	e1:SetTarget(c511009174.target)
	e1:SetOperation(c511009174.operation)
	c:RegisterEffect(e1)
end
c511009174.miracle_synchro_fusion=true
function c511009174.mat_filter(c)
	return c:IsFusionSetCard(0x410)
end

function c511009174.nmfil(c)
  return c:IsType(TYPE_MONSTER)
end
function c511009174.nmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c511009174.nmfil(chkc) end
  if chk==0 then return Duel.IsExistingTarget(c511009174.nmfil,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
  Duel.SelectTarget(tp,c511009174.nmfil,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
end
function c511009174.nmop(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  local tc=Duel.GetFirstTarget()
  if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) then
	local code=tc:GetCode()
	c:CopyEffect(code,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,1)
  end
end
--special summon
function c511009174.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c511009174.spfil1(c)
	return c:IsCode(95100902) and c:IsType(TYPE_MONSTER)
end
function c511009174.spfil2(c)
	return c:IsLevelBelow(4) 
end
function c511009174.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingTarget(c511009174.spfil1,tp,LOCATION_GRAVE,0,1,nil) 
		and Duel.IsExistingTarget(c511009174.spfil2,tp,LOCATION_GRAVE,0,1,nil)
		end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c511009174.spfil1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g2=Duel.SelectTarget(tp,c511009174.spfil2,tp,LOCATION_GRAVE,0,1,1,nil,tp,g1:GetFirst())
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE)
end
function c511009174.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=2 then return end
	local tc1=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc2=g:GetFirst()
	if tc1==tc2 then tc2=g:GetNext() end
	if tc:IsRelateToEffect(e) and tc2:IsRelateToEffect(e) then
		Duel.SpecialSummonStep(tc1,0,tp,tp,false,false,POS_FACEUP)
		Duel.SpecialSummonStep(tc2,0,tp,tp,true,false,POS_FACEUP)
		Duel.SpecialSummonComplete()
	end
end
