--coded by Lyris
--Absorbing Lamp
function c511007002.initial_effect(c)
	--When your opponent activates a Spell Card: Activate this card by targeting that Spell Card; negate the activation, and if you do, add that target to your hand. [Magic Jammer & Exchange]
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511007002.condition)
	e1:SetTarget(c511007002.target)
	e1:SetOperation(c511007002.activate)
	c:RegisterEffect(e1)
	--If this card leaves the field, return that card to your opponent's hand. [Oasis of Dragon Souls]
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_LEAVE_FIELD_P)
	e2:SetOperation(c511007002.checkop)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetOperation(c511007002.desop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
function c511007002.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c511007002.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=re:GetHandler()
	if chk==0 then return tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c511007002.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsRelateToEffect(e) then
		--While this card is face-up on the field, that card is treated as your own card.
		re:GetHandler():CancelToGrave()
		Duel.SendtoDeck(re:GetHandler(),nil,-2,REASON_RULE)
		local rc=Duel.CreateToken(tp,re:GetHandler():GetCode())
		Duel.SendtoHand(rc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,rc)
		e:GetLabelObject():SetLabelObject(rc)
	end
end
function c511007002.checkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsDisabled() then
		e:SetLabel(1)
	else e:SetLabel(0) end
end
function c511007002.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetLabel()~=0 then return end
	local tc=e:GetLabelObject():GetLabelObject()
	if tc and (tc:IsControler(tp) or not tc:IsLocation(LOCATION_HAND)) then
		local code=tc:GetCode()
		Duel.SendtoDeck(tc,nil,-2,REASON_RULE)
		local rc=Duel.CreateToken(1-tp,code)
		Duel.SendtoHand(rc,nil,REASON_EFFECT)
		Duel.ConfirmCards(tp,rc)
	end
end
