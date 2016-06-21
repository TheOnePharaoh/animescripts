--Infinite Aura
function c511000974.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	c:RegisterEffect(e1)
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetOperation(c511000974.ctop)
	c:RegisterEffect(e1)
end
function c511000974.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if ep~=tp then return end
	local ct=math.floor(ev/100)
	c:AddCounter(0x100,ct)
end
