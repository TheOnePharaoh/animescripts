--Coded by Lyris
--Devoted Love
function c511007027.initial_effect(c)
	--During your opponent's Battle Phase: End the Battle Phase, then your opponent draws 1 card. [Electromagnetic Turtle & Dark Bribe]
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511007027.condition)
	e1:SetOperation(c511007027.operation)
	c:RegisterEffect(e1)
end
function c511007027.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_BATTLE
end
function c511007027.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	Duel.BreakEffect()
	Duel.Draw(1-tp,1,REASON_EFFECT)
	--At the End Phase of this turn, your Life Points become 0. [Power Bond & Self-Destruct Button]
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetOperation(c511007027.damop)
	Duel.RegisterEffect(e2,tp)
end
function c511007027.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(tp,0)
end
