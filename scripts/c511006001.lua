--Explosive Blast
function c511006001.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511006001.condition)
	e1:SetTarget(c511006001.target)
	e1:SetOperation(c511006001.activate)
	c:RegisterEffect(e1)
end
function c511006001.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511006001.filter(c)
	return c:IsRace(RACE_MACHINE) and c:GetBattledGroupCount()==0 and c:IsDestructable()
end
function c511006001.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511006001.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511006001.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511006001.filter,tp,LOCATION_MZONE,0,1,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511006001.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local n=Duel.Destroy(tg,REASON_EFFECT)
	if n>0 then Duel.Damage(1-tp,n*400,REASON_EFFECT) end
end

