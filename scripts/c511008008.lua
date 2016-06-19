--Thousand Buster
--Scripted by Snrk
function c511008008.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511008008.cost)
	e1:SetTarget(c511008008.target)
	e1:SetOperation(c511008008.activate)
	c:RegisterEffect(e1)
end
function c511008008.filter(c)
	return c:IsDestructable() and (c:IsPosition(POS_FACEUP_ATTACK) and c:IsAttackBelow(1000))
		or (c:IsPosition(POS_FACEUP_DEFENCE) and c:IsDefenceBelow(1000))
end
function c511008008.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c511008008.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511008008.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(c511008008.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511008008.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511008008.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if Duel.Destroy(sg,REASON_EFFECT)>0 then
		Duel.Damage(1-tp,1000,REASON_EFFECT)
		Duel.Damage(tp,1000,REASON_EFFECT)
	end
end