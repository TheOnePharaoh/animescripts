--Armored Gravitation
function c110000116.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c110000116.condition)
	e1:SetTarget(c110000116.target)
	e1:SetOperation(c110000116.activate)
	c:RegisterEffect(e1)
end
function c110000116.cfilter(c)
	return c:IsFaceup() and c:IsCode(110000104)
end
function c110000116.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c110000116.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c110000116.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsType(0x10000000) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c110000116.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c110000116.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c110000116.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if ft>4 then ft=4 end
	local g=Duel.GetMatchingGroup(c110000116.filter,tp,LOCATION_DECK,0,nil,e,tp)
	local sg=Group.CreateGroup()
	local chk=0
	while sg:GetCount()<4 and (chk==0 or Duel.SelectYesNo(tp,aux.Stringid(525110,1))) do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		if tc then
			chk=1
			sg:AddCard(tc)
			g:Remove(Card.IsCode,nil,tc:GetCode())
		end
	end
	if sg:GetCount()>0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end