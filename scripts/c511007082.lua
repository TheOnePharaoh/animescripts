--coded by Lyris1007
--Masked Beast of Guardius
function c511007082.initial_effect(c)
	--If this card is sent from the field to the Graveyard: Equip 1 "The Mask of Renmants" from your Deck to 1 monster on the field. [Dandylion & Dragunity Primus Pilus]
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c511007082.condition)
	e1:SetTarget(c511007082.target)
	e1:SetOperation(c511007082.operation)
	c:RegisterEffect(e1)
end
--trigger: if this is sent to the Graveyard from the field
function c511007082.condition(e)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
--Equip 1 "The Mask of Renmants" from your Deck to 1 monster on the field.
function c511007082.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_DECK)
end
function c511007082.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local eq=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK,0,1,1,nil,22610082)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local ec=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.HintSelection(ec)
	local eqc=eq:GetFirst()
	local tc=ec:GetFirst()
	if eqc and tc then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511007082.eqlimit)
		e1:SetLabelObject(tc)
		eqc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(eqc)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetCode(EFFECT_SET_CONTROL)
		e2:SetValue(tp)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		eqc:RegisterEffect(e2)
	end
end
function c511007082.eqlimit(e,c)
	return c==e:GetLabelObject()
end
