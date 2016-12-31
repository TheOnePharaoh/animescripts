--Supreme King Gate Zero (Anime)
function c511009443.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e1:SetTargetRange(1,0)
	e1:SetCondition(c511009443.splimcon)
	e1:SetTarget(c511009443.splimit)
	c:RegisterEffect(e1)
	--avoid damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_AVAILABLE_BD)
	e2:SetTargetRange(1,0)
	e2:SetCondition(c511009443.ndcon)
	e2:SetValue(0)
	c:RegisterEffect(e2)
	--Search
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(100912018,2))
	e6:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_DESTROYED)
	e6:SetProperty(EFFECT_FLAG_DELAY)
	e6:SetCondition(c511009443.thcon)
	e6:SetTarget(c511009443.thtg)
	e6:SetOperation(c511009443.thop)
	c:RegisterEffect(e6)
end
--OCG Supreme King collection
c511009443.collection={
-- Odd-Eyes Raging Dragon 
-- Odd-Eyes Rebellion Dragon
 -- Supreme King Dragon Zarc
 -- Supreme King Gate Infinity
 -- Supreme King Gate Zero 
-- Supreme King Servant Dragon Darkvrm 
[86238081]=true;[45627618]=true;[100912039]=true;
[100912017]=true;[100912018]=true;[100912019]=true;
}
function c511009443.splimcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)>0
end
function c511009443.splimit(e,c,sump,sumtype,sumpos,targetp)
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end

function c511009443.ndcfilter(c)
	return c:IsFaceup() and (c511009443.collection[c:GetCode()] or c:IsSetCard(0xfb))
end
function c511009443.ndcon(e)
	return Duel.IsExistingMatchingCard(c511009443.ndcfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c511009443.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsFaceup()
end
function c511009443.thfil(c)
	return c:IsCode(100912018) and c:IsAbleToHand()
end
function c511009443.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009443.thfil,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511009443.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511009443.thfil,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
