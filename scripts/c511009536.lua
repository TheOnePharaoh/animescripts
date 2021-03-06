--En Bird
function c511009536.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511009536.condition)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_REMOVED)
	e2:SetTarget(c511009536.disable)
	e2:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e2)
	--type
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_REMOVED)
	e3:SetCode(EFFECT_ADD_TYPE)
	e3:SetTarget(c511009536.disable)
	e3:SetValue(TYPE_NORMAL)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_REMOVE_TYPE)
	e4:SetValue(TYPE_XYZ)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EFFECT_REMOVE_TYPE)
	e5:SetValue(TYPE_EFFECT)
	c:RegisterEffect(e5)
end
function c511009536.filter(c)
	return c:IsFaceup() and c:IsCode(511009533)
end
function c511009536.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009536.filter,tp,LOCATION_SZONE,0,1,nil)
	and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,3,nil,TYPE_XYZ)
end
function c511009536.disable(e,c)
	return c:IsType(TYPE_XYZ) 
end