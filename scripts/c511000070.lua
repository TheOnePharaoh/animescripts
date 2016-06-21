--Wiretap (anime)
function c511000070.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DECK_REVERSE_CHECK)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511000070.condition)
	e1:SetTarget(c511000070.target)
	e1:SetOperation(c511000070.activate)
	c:RegisterEffect(e1)
end
function c511000070.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and re:IsActiveType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c511000070.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_TODECK,eg,1,0,0)
	end
end
function c511000070.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=re:GetHandler()
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		ec:CancelToGrave()
		Duel.SendtoDeck(ec,nil,2,REASON_EFFECT)
		if not ec:IsLocation(LOCATION_DECK) then return end
		Duel.ShuffleDeck(1-tp)
		ec:ReverseInDeck()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_ACTIVATE)
		e1:SetTargetRange(0,1)
		e1:SetValue(c511000070.aclimit)
		e1:SetLabel(re:GetHandler():GetCode())
		Duel.RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e2:SetCode(EVENT_TO_HAND)
		e2:SetLabelObject(e1)
		e2:SetCondition(c511000070.negcon)
		e2:SetOperation(c511000070.negop)
		e2:SetReset(RESET_EVENT+0x1de0000)
		ec:RegisterEffect(e2)
	end
end
function c511000070.aclimit(e,re,tp)
	return re:GetHandler():IsCode(e:GetLabel())
end
function c511000070.negcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DRAW)
end
function c511000070.negop(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetValue(0)
end
