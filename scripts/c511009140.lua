--Amazoness Audience Room
function c511009140.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(3701074,0))
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c511009140.rectg2)
	e2:SetOperation(c511009140.recop2)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c511009140.descon)
	c:RegisterEffect(e3)
end

function c511009140.filter(c,e,tp)
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:GetSummonPlayer()==1-tp
		and (not e or c:IsRelateToEffect(e))
end
function c511009140.rectg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511009140.filter,1,nil,nil,tp) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,1-tp,0)
end
function c511009140.recop2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(c511009140.filter,nil,e,tp)
	if g:GetCount()>0 then
		local atk=g:GetSum(Card.GetAttack)
		Duel.Recover(tp,atk,REASON_EFFECT)
	end
end
function c511009140.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x4)
end
function c511009140.descon(e)
	return not Duel.IsExistingMatchingCard(c511009140.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end