--Relay Soul (Anime)
--By Edo9300
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
	Duel.SetLP(tp,1)
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
		tc:RegisterFlagEffect(511002521,0,0,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_BE_MATERIAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetOperation(c511002521.matop)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_LEAVE_FIELD)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e2:SetLabel(tp)
		e2:SetOperation(c511002521.leaveop)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e3:SetCode(EFFECT_DRAW_COUNT)
		e3:SetTargetRange(1,0)
		e3:SetValue(0)
		e3:SetLabel(tp)
		e3:SetCondition(c511002521.drcon)
		Duel.RegisterEffect(e3,tp)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		e4:SetRange(LOCATION_MZONE)
		e4:SetCode(EVENT_DAMAGE)
		e4:SetLabel(tp)
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
end
function c511002521.matcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_FUSION or r==REASON_SYNCHRO or r==REASON_XYZ
end
function c511002521.matop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(511002521)>0 then
		local rc=c:GetReasonCard()
		rc:RegisterFlagEffect(511002521,0,0,1)
		c:ResetFlagEffect(511002521)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_BE_MATERIAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetCondition(c511002521.matcon)
		e1:SetOperation(c511002521.matop)
		rc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_LEAVE_FIELD)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e2:SetLabel(tp)
		e2:SetOperation(c511002521.leaveop)
		rc:RegisterEffect(e2)
		Duel.SetLP(tp,1)
	end
end
function c511002521.drcon(e,tp,eg,ep,ev,re,r,rp)
	local tp=e:GetLabel()
	return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 and Duel.IsExistingMatchingCard(c511002521.filter2,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511002521.filter2(c)
	return c:GetFlagEffect(511002521)>0
end
function c511002521.damop(e,tp,eg,ep,ev,re,r,rp)
	local tp=e:GetLabel()
	if ep==tp and Duel.GetLP(tp)<=0 and Duel.IsExistingMatchingCard(c511002521.filter2,tp,LOCATION_ONFIELD,0,1,nil) then
		Duel.SetLP(tp,1)
	end
end
