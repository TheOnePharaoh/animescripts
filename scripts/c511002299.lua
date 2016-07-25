--Unbroken Atmosphere
function c511002299.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002299.condition)
	e1:SetOperation(c511002299.activate)
	c:RegisterEffect(e1)
end
--Sphere collection
c511002299.collection={
	[60202749]=true;[75886890]=true;[32559361]=true;
	[14466224]=true;[82693042]=true;[26302522]=true;
	[29552709]=true;[60417395]=true;[72144675]=true;
	[66094973]=true;[1992816]=true;[51043053]=true;
	[70780151]=true;[10000080]=true;
}
function c511002299.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttackTarget()
	return a and a:IsFaceup() and (c511002299.collection[a:GetCode()] or a:IsSetCard(0x406)) and a:IsControler(tp)
end
function c511002299.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
