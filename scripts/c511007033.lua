--Exus Summon
function c511007033.initial_effect(c)
	--Activate only when a monster you control is selected as an attack target. Return that monster to the hand, then Special Summon 1 monster from your hand in Attack Position, whose ATK is lower than the returned monster's ATK.
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetTarget(c8698851.target)
	e1:SetOperation(c8698851.operation)
	c:RegisterEffect(e1)
end
function c511007033.filter(c,e,tp,atk)
	return c:GetAttack()<atk and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511007033.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsAbleToHand() and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511007033.filter,tp,LOCATION_HAND,0,1,nil,e,tp,tc:GetAttack()) end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON.nil,1,tp,LOCATION_HAND)
end
function c511007033.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local atk=tc:GetAttack()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		local g=Duel.SelectMatchingCard(tp,c511007033.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp,atk)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		end
	end
end
