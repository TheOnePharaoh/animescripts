--Attack Guidance Armor
--By Edo9300
function c511001140.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001140.condition)
	e1:SetTarget(c511001140.target)
	e1:SetOperation(c511001140.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetCondition(c511001140.condition2)
	c:RegisterEffect(e2)
end
function c511001140.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():GetControler()==e:GetHandlerPlayer()
end
function c511001140.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget():GetControler()==e:GetHandlerPlayer()
end
function c511001140.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDefencePos,tp,LOCATION_MZONE,0,1,nil) end
end
function c511001140.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local g=Duel.SelectMatchingCard(tp,Card.IsDefencePos,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENCE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(600)
		tc:RegisterEffect(e1)
		if a:IsAttackable() and not a:IsImmuneToEffect(e) and not tc:IsImmuneToEffect(e) then 
			Duel.ChangeAttackTarget(tc)
			--Skip
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e2:SetCode(EVENT_BATTLED)
			e2:SetCountLimit(1)
			e2:SetReset(RESET_PHASE+PHASE_BATTLE)
			e2:SetOperation(c511001140.op)
			Duel.RegisterEffect(e2,0)
		end
	end
end
function c511001140.op(e,tp)
	Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end
