--Air Sphere
function c511002289.initial_effect(c)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c511002289.con)
	c:RegisterEffect(e2)
end
--Sphere collection
c511002299.collection={
	[60202749]=true;[75886890]=true;[32559361]=true;
	[14466224]=true;[82693042]=true;[26302522]=true;
	[29552709]=true;[60417395]=true;[72144675]=true;
	[66094973]=true;[1992816]=true;[51043053]=true;
	[70780151]=true;[10000080]=true;
}
function c511002289.filter(c)
	return c:IsFaceup() and (c511002299.collection[c:GetCode()] or c:IsSetCard(0x406)) and c:IsType(TYPE_MONSTER) 
end
function c511002289.con(e)
	return Duel.IsExistingMatchingCard(c511002289.filter,e:GetHandlerPlayer(),LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
