--Supreme King Servant Dragon Darkvrm (Anime)
function c511009442.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80538728,0))
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511009442.condition)
	e1:SetOperation(c511009442.operation)
	c:RegisterEffect(e1)
	--negate attack 2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(27143874,0))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetCondition(c511009442.con)
	e2:SetOperation(c511009442.operation)
	c:RegisterEffect(e2)
end
--OCG Supreme King collection
c511009442.collection={
-- Odd-Eyes Raging Dragon 
-- Odd-Eyes Rebellion Dragon
 -- Supreme King Dragon Zarc
 -- Supreme King Gate Infinity
 -- Supreme King Gate Zero 
-- Supreme King Servant Dragon Darkvrm 
--King of Yamimakai
--Number 80: Rhapsody in Berserk
--Number C80: Requiem in Berserk
[86238081]=true;[45627618]=true;[100912039]=true;
[100912017]=true;[100912018]=true;[100912019]=true;
[69455834]=true;[93568288]=true;[20563387]=true;
}
function c511009442.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) and d:IsFaceup() and (c511009442.collection[d:GetCode()] or d:IsSetCard(0xfb) )
end
function c511009442.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c511009442.filter(c)
	return c:IsFaceup() and (c511009442.collection[c:GetCode()] or c:IsSetCard(0xfb))
end
function c511009442.con(e)
	return Duel.IsExistingMatchingCard(c511009442.filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,e:GetHandler())
end
