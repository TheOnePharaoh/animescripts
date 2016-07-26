--Automatic Gearspring Machine
function c511009018.initial_effect(c)
	c:EnableCounterPermit(0x108)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetTarget(c511009018.target)
	c:RegisterEffect(e2)
	--counter
	local e2=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000720,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)	
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511009018.addcon)
	e1:SetOperation(c511009018.addop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(61156777,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511009018.spcost)
	e2:SetTarget(c511009018.sptg)
	e2:SetOperation(c511009018.spop)
	c:RegisterEffect(e2)
end
function c511009018.addcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c511009018.addop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:AddCounter(0x108,1)
	Duel.RaiseEvent(c,95100633,e,0,tp,0,0)
end
function c511009018.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	local c=e:GetHandler()
	c:AddCounter(0x108,2)
	Duel.RaiseEvent(c,95100633,e,0,tp,0,0)
end

function c511009018.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() and e:GetHandler():GetCounter(0x108)>1 end
	local ct=c:GetCounter(0x108)
	e:SetLabel(ct)
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511009018.filter(c,e,tp)
		return c:IsFaceup() and c:IsCanAddCounter(0x108,1)
end
function c511009018.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsOnField() and c34029630.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c34029630.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(34029630,2))
	Duel.SelectTarget(tp,c34029630.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
end
function c511009018.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsCanAddCounter(0x108,1) then
		tc:AddCounter(0x108,e:GetLabel)
	end
end