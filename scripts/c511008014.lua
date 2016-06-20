--Cornfused
--Scripted by Snrk
function c511008014.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511008014.condition)
	e1:SetTarget(c511008014.target)
	e1:SetOperation(c511008014.activate)
	c:RegisterEffect(e1,tp)
end
function c511008014.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER) and ep~=tp and Duel.IsChainNegatable(ev)
end
function c511008014.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c511008014.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end