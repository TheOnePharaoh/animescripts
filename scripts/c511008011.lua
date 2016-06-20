--Trion Barrier
--Scripted by Snrk
function c511008011.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511008011.condition)
	e1:SetTarget(c511008011.target)
	e1:SetOperation(c511008011.activate)
	c:RegisterEffect(e1)
end
function c511008011.hfilter(c)
	return c:IsCode(34796454) and not c:IsPublic()
end
function c511008011.cfilter(c)
	return c:IsAttackPos()
end
function c511008011.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetLocationCount(tp,LOCATION_MZONE)>2
		and Duel.IsExistingMatchingCard(c511008011.hfilter,tp,LOCATION_HAND,0,3,nil)
end
function c511008011.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c511008011.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.SelectTarget(tp,c511008011.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c511008011.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c511008011.hfilter,tp,LOCATION_HAND,0,3,nil)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)<3 then return end
	local tc=Duel.GetFirstTarget()
	local hc=Duel.GetMatchingGroup(c511008011.hfilter,tp,LOCATION_HAND,0,nil)
	if tc:IsRelateToEffect(e) and tc:IsPosition(POS_FACEUP_ATTACK) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENCE)
		Duel.SpecialSummon(hc,0,tp,tp,false,false,POS_FACEUP)
	end
end