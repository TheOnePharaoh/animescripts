--Quiz Monkey
function c511002025.initial_effect(c)
	--Question
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCountLimit(1)
	e1:SetCondition(c511002025.condition)
	e1:SetOperation(c511002025.operation)
	c:RegisterEffect(e1)
end
function c511002025.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511002025.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x213)
end
function c511002025.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(4003,10))
	local quest=Duel.AnnounceNumber(1-tp,0,1,2,3,4,5)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetCountLimit(1)
	e1:SetLabel(quest)
	e1:SetOperation(c511002025.op)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511002025.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local quest=e:GetLabel()
	Duel.Hint(HINT_CARD,0,511002025)
	if Duel.GetMatchingGroupCount(c511002025.cfilter,tp,LOCATION_MZONE,0,nil)==quest then
		Duel.Recover(1-tp,1000,REASON_EFFECT)
	else
		if c:IsLocation(LOCATION_GRAVE) then
			if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
				local g=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
				local tc=g:GetFirst()
				if tc then
					Duel.HintSelection(g)
					if Duel.Destroy(tc,REASON_EFFECT)>0 then
						local e1=Effect.CreateEffect(c)
						e1:SetType(EFFECT_TYPE_SINGLE)
						e1:SetCode(EFFECT_SET_ATTACK)
						e1:SetValue(tc:GetAttack())
						e1:SetReset(RESET_EVENT+0x1ff0000)
						c:RegisterEffect(e1)
						local e2=Effect.CreateEffect(c)
						e2:SetType(EFFECT_TYPE_SINGLE)
						e2:SetCode(EFFECT_SET_DEFENSE)
						e2:SetValue(tc:GetDefense())
						e2:SetReset(RESET_EVENT+0x1ff0000)
						c:RegisterEffect(e2)
					end
				end
			end
		end
	end
end
