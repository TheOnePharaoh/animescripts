--Atmospheric Transference
function c511002298.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511002298.condition)
	e1:SetTarget(c511002298.target)
	e1:SetOperation(c511002298.activate)
	c:RegisterEffect(e1)
end
--Sphere collection
c511002299.collection={
	[60202749]=true;[75886890]=true;[32559361]=true;
	[14466224]=true;[82693042]=true;[26302522]=true;
	[29552709]=true;[60417395]=true;[72144675]=true;
	[66094973]=true;[1992816]=true;[51043053]=true;
	[70780151]=true;[10000080]=true;
}
function c511002298.cfilter(c)
	return c:IsFaceup() and (c511002299.collection[c:GetCode()] or c:IsSetCard(0x406)) and c:IsType(TYPE_MONSTER)
end
function c511002298.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002298.cfilter,1,nil)
end
function c511002298.filter(c,e,tp)
	return (c511002299.collection[c:GetCode()] or c:IsSetCard(0x406)) and c:IsType(TYPE_MONSTER) and c:IsLevelBelow(4) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002298.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511002298.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511002298.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002298.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
