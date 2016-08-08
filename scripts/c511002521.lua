--魂のリレー
function c511002521.initial_effect(c)
	--Survive
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511002521.condition)
	e1:SetTarget(c511002521.target)
	e1:SetOperation(c511002521.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetCondition(c511002521.condition2)
	c:RegisterEffect(e2)
end
function c511002521.condition(e,tp,eg,ep,ev,re,r,rp)
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if not ex then
		ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
		if not ex or not Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_RECOVER) then return false end
		if (cp==tp or cp==PLAYER_ALL) and cv>=Duel.GetLP(tp) then return true end
	else return (cp==tp or cp==PLAYER_ALL) and cv>=Duel.GetLP(tp)
	end
	return false
end
function c511002521.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>=Duel.GetLP(tp)
end
function c511002521.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002521.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511002521.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511002521.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002521.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_DESTROY)
		e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		e2:SetLabel(tp)
		e2:SetOperation(c511002521.leaveop)
		tc:RegisterEffect(e2)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_BE_MATERIAL)
		e1:SetOperation(c511002521.tfop)
		e1:SetLabel(tp)
		e1:SetLabelObject(e2)
		tc:RegisterEffect(e1)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e3:SetCode(EFFECT_DRAW_COUNT)
		e3:SetTargetRange(1,0)
		e3:SetValue(0)
		e3:SetCondition(c511002521.drcon)
		Duel.RegisterEffect(e3,tp)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		e4:SetCode(EVENT_DAMAGE)
		e4:SetOperation(c511002521.damop)
		Duel.RegisterEffect(e4,tp)
		Duel.SpecialSummonComplete()
	end
end
function c511002521.leaveop(e,tp,eg,ep,ev,re,r,rp)
	local p=e:GetLabel()
	if Duel.GetLP(p)==1 then
		Duel.SetLP(p,0)
	end
	e:Reset()
end
function c511002521.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0
end
function c511002521.damop(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp and Duel.GetLP(tp)<=0 then
		Duel.SetLP(tp,1)
	end
end
function c511002521.tfop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local c2=e:GetOwner()
	local card=c:GetReasonCard()
	local p=e:GetLabel()
	local e2=Effect.CreateEffect(c2)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DESTROY)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetLabel(p)
	e2:SetOperation(c511002521.leaveop)
	card:RegisterEffect(e2,true)
	local e1=Effect.CreateEffect(c2)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetOperation(c511002521.tfop)
	e1:SetLabel(p)
	e1:SetLabelObject(e2)
	card:RegisterEffect(e1,true)
	e:Reset()
	if e:GetLabelObject() then
		e:GetLabelObject():Reset()
	end
end
