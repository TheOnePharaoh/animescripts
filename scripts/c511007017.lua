--coded by Lyris
--Comic Field
function c511007017.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--If exactly 1 "Comics Hero" monster would be destroyed by battle, it gains 500 ATK instead. [Puzzle Reborn & Crystal Protector]
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTarget(c511007017.indtg)
	e2:SetValue(c511007017.indval)
	c:RegisterEffect(e2)
end
function c511007017.indtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return eg:GetCount()==1 and tc:IsLocation(LOCATION_MZONE) and tc:IsFaceup()
		and (tc:IsCode(77631175) or tc:IsCode(13030280)) and tc:IsReason(REASON_BATTLE) and not tc:IsImmuneToEffect(e) end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(500)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
	return true
end
