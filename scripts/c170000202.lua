--Legendary Knight Timaeus
--Scripted by  Edo9300
function c170000202.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--Gain ATK
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c170000202.condition)
	e2:SetTarget(c170000202.target)
	e2:SetOperation(c170000202.operation)
	c:RegisterEffect(e2)
end
function c170000202.condition(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c170000202.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsReleasableByEffect,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
end
function c170000202.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,Card.IsReleasableByEffect,tp,LOCATION_MZONE,0,1,99,c)
	if g:GetCount()>0 then
		local atk=g:GetSum(Card.GetAttack)
		local def=g:GetSum(Card.GetDefence)
		if Duel.Release(g,REASON_EFFECT)~=0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(atk+def)
			e1:SetReset(RESET_EVENT+0x1ff0000)
			c:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENCE)
			c:RegisterEffect(e2)
			if g:IsExists(Card.IsCode,1,nil,85800949) and c:GetFlagEffect(170000202)==0 then
				c:RegisterFlagEffect(170000202,RESET_EVENT+0x1ff0000,0,1)
			end
			if g:IsExists(Card.IsCode,1,nil,84565800) and c:GetFlagEffect(170000202+1)==0 then
				c:RegisterFlagEffect(170000202+1,RESET_EVENT+0x1ff0000,0,1)
			end
		end
	end
end
