--coded by Lyris
--Armored Back
function c511007004.initial_effect(c)
	--When a monster you control equipped with an Equip Spell Card is destroyed: [Rusted Blade - Rust Edge] Special Summon that monster from the Graveyard, and if you do, equip it with the Equip Card it was equipped with. It cannot be destroyed by battle or by card effects this turn. [Pinpoint Guard]
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511007004.condition)
	e1:SetTarget(c511007004.target)
	e1:SetOperation(c511007004.operation)
	c:RegisterEffect(e1)
end
--Ignore Monsters and other cards that left the field along with the Equip Spell
function c511007004.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsType,1,nil,TYPE_EQUIP)
end
function c511007004.cfilter(c)
	if not c:IsType(TYPE_EQUIP) then return false end
	local ec=c:GetPreviousEquipTarget()
	return c:IsReason(REASON_LOST_TARGET) and ec and ec:IsReason(REASON_DESTROY)
end
function c511007004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		--A Monster Zone AND a Spsll & Trap Zone must be open
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return false end
		--Exactly 1 Equip Spell must be lost
		local g1=eg:Filter(c511007004.cfilter,nil)
		if g1:GetCount()~=1 then return false end
		--Check the monster that the Equip Spell was equipped to: under your control, in the Graveyard, can it be Special Summoned?
		local tc=g1:GetFirst()
		local ec=tc:GetPreviousEquipTarget()
		return ec:IsLocation(LOCATION_GRAVE) and ec:IsControler(tp) and ec:IsCanBeSpecialSummoned(e,0,tp,false,false)
	end
	--Save the Equip Spell and the monster it was equipped to
	local g1=eg:Filter(c511007004.cfilter,nil,tp)
	local tc=g1:GetFirst()
	e:SetLabelObject(tc)
	local ec=tc:GetPreviousEquipTarget()
	Duel.SetTargetCard(ec)
	--Notify Counter Traps that this is trying to Special Summon
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,ec,1,0,0)
end
function c511007004.operation(e,tp,eg,ep,ev,re,r,rp)
	--Special Summon that monster from the Graveyard
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		--and if you do, equip it with the Equip Card it was equipped with
		Duel.Equip(tp,e:GetLabelObject(),tc)
		--It cannot be destroyed by battle or by card effects this turn.
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		tc:RegisterEffect(e2)
	end
end
