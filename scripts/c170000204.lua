--Legendary Knight Hermos
--Scripted by Edo9300
function c170000204.initial_effect(c)
	c:EnableReviveLimit()
	--change battle target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000047,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c170000204.cbcon)
	e1:SetOperation(c170000204.cbop)
	c:RegisterEffect(e1)
	--gain effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10032958,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCost(c170000204.effcost)
	e2:SetTarget(c170000204.efftg)
	e2:SetOperation(c170000204.effop)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(89770167,0))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c170000204.con)
	e3:SetCost(c170000204.atcost)
	e3:SetTarget(c170000204.attg)
	e3:SetOperation(c170000204.atop)
	c:RegisterEffect(e3)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(89770167,0))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BE_BATTLE_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetLabelObject(e3)
	e4:SetTarget(c170000204.attg)
	e4:SetCondition(c170000204.atcon)
	e4:SetOperation(c170000204.atop)
	c:RegisterEffect(e4)
end
function c170000204.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=eg:GetFirst()
	return c~=bt and bt:GetControler()==c:GetControler() and e:GetHandler():GetFlagEffect(170000204+1)==0
end
function c170000204.cbop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeAttackTarget(e:GetHandler())
end
function c170000204.cfilter(c)
	return c:IsType(TYPE_EFFECT) and c:IsAbleToRemoveAsCost()
end
function c170000204.effcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c170000204.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c170000204.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(g:GetFirst():GetCode())
end
function c170000204.efftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetParam(e:GetLabel())
	e:SetLabel(0)
end
function c170000204.effop(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if ac==0 then return end
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(ac)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN)
		c:RegisterEffect(e1)
		c:CopyEffect(ac,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN)
		c:RegisterFlagEffect(170000204+1,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
	end
end
function c170000204.costfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c170000204.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(170000204+1)==0
end
function c170000204.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c170000204.costfilter,tp,LOCATION_DECK,0,3,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c170000204.costfilter,tp,LOCATION_DECK,0,3,3,nil)
	ct=Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(ct)
	e:GetHandler():RegisterFlagEffect(170000204,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END,0,1)
end
function c170000204.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c170000204.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local att=Duel.GetAttacker()
	local ct=e:GetLabel()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(c:GetAttack()*ct)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		Duel.ChangeAttackTarget(att)
	end
end
function c170000204.atcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(170000204)>0 and e:GetHandler():GetFlagEffect(170000204+1)==0
end