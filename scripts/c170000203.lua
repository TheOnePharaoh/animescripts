--Legendary Knight Critias
--Scripted by Edo9300
function c170000203.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--Absorb Traps
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c170000203.con)
	e2:SetTarget(c170000203.tg)
	e2:SetOperation(c170000203.op)
	c:RegisterEffect(e2)
	--Absorb Traps part 2
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c170000203.con2)
	e3:SetTarget(c170000203.tg2)
	e3:SetOperation(c170000203.op2)
	c:RegisterEffect(e3)
end
function c170000203.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingTarget(c170000203.filter1,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil) and e:GetHandler():GetFlagEffect(170000203)==0
end
function c170000203.filter1(c,e,tp,eg,ep,ev,re,r,rp)
	return c:GetType()==TYPE_TRAP and c:IsAbleToRemove()
end
function c170000203.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c170000203.filter1,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil) end
	local tc=Duel.SelectMatchingCard(tp,c170000203.filter1,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil)
	local fid=e:GetHandler():GetFieldID()
	tc:GetFirst():RegisterFlagEffect(170000203,RESET_PHASE+PHASE_END,0,1,fid)
	e:GetHandler():RegisterFlagEffect(170000203,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END,0,1,fid)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	if tc:GetFirst():CheckActivateEffect(false,true,false)~=nil then
		local te,eg,ep,ev,re,r,rp=tc:GetFirst():CheckActivateEffect(false,true,true)
		e:SetLabelObject(tc:GetFirst())
		local tc=e:GetLabelObject()
		local te,eg,ep,ev,re,r,rp=tc:CheckActivateEffect(false,true,true)
		local tg=te:GetTarget()
		e:SetLabelObject(te)
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
	end
end
function c170000203.op(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
    if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end
function c170000203.con2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingTarget(c170000203.filter2,tp,0xff,0xff,1,nil,e:GetHandler():GetFlagEffectLabel(170000203)) and e:GetHandler():GetFlagEffect(170000203)>0
	-- and e:GetLabel()~=1
end
function c170000203.filter2(c,fid)
	return c:CheckActivateEffect(false,true,false)~=nil and c:GetType()==TYPE_TRAP and c:GetFlagEffectLabel(170000203)==fid
end

function c170000203.tg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c170000203.filter2,tp,0xff,0xff,1,nil,e:GetHandler():GetFlagEffectLabel(170000203)) end
	local tc=Duel.GetMatchingGroup(c170000203.filter2,tp,0xff,0xff,nil,e:GetHandler():GetFlagEffectLabel(170000203))
	-- e:SetLabel(1)
	local te,eg,ep,ev,re,r,rp=tc:GetFirst():CheckActivateEffect(false,true,true)
	e:SetLabelObject(tc:GetFirst())
	local tc=e:GetLabelObject()
	local te,eg,ep,ev,re,r,rp=tc:CheckActivateEffect(false,true,true)
	local tg=te:GetTarget()
	e:SetLabelObject(te)
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
end
function c170000203.op2(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
    if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
	-- e:SetLabel(0)
end