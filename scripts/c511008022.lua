--Golden Form
--Scripted by Snrk
function c511008022.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetValue(1)
	e1:SetTarget(c511008022.target)
	e1:SetOperation(c511008022.activate)
	c:RegisterEffect(e1)
end
function c511008022.pfil(c,eg,tp)
	return c:GetPosition()==POS_FACEUP_ATTACK and eg:GetFirst():GetControler()==tp
		and c:GetPreviousPosition()>0x3
end
function c511008022.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return eg:IsContains(chkc) and c511008022.pfil(chkc,eg,tp) end
	if chk==0 then return eg:IsExists(c511008022.pfil,1,nil,eg,tp) end
	Duel.SetTargetCard(eg)
end
function c511008022.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetAttack()*2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
		tc:RegisterEffect(e1)
	end
end