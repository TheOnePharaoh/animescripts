--Timaeus the Knight of Destiny
function c170000210.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcCode3(c,80019195,85800949,84565800,true,true)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37115575,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c170000210.spcon)
	e1:SetOperation(c170000210.spop)
	c:RegisterEffect(e1)
	--spsummon condition
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(aux.FALSE)
	c:RegisterEffect(e2)
	--Indestructible by Battle
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
function c170000210.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,true) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end

function c170000210.spfil(c)
	return c:IsCode(80019195) and c:GetFlagEffect(170000202)>0  and c:GetFlagEffect(170000202+1)>0
end
function c170000210.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1 and Duel.IsExistingMatchingCard(c170000210.spfil,c:GetControler(),LOCATION_ONFIELD,0,1,nil)
end
function c170000210.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c170000210.spfil,tp,LOCATION_ONFIELD,0,1,1,nil)
	local atk=g:GetFirst():GetAttack()
	local def=g:GetFirst():GetDefence()
	Duel.SendtoGrave(g,REASON_COST)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(atk)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_DEFENCE)
	e2:SetValue(def)
	c:RegisterEffect(e2)
end