--Offerings to the Bound Deity
function c511009090.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511009090.cost)
	e1:SetTarget(c511009090.target)
	e1:SetOperation(c511009090.activate)
	c:RegisterEffect(e1)
end
function c511009090.filter(c)
	return c:IsFaceup() and c:IsCode(100000432) and c:IsCanAddCounter(0x94,2)
end
function c511009090.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c511009090.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c511009090.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009090.filter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(75014062,1))
	Duel.SelectTarget(tp,c511009090.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x94)
end
function c511009090.tfilter(c)
	return c:IsCode(75014062) and c:IsAbleToHand()
end
function c511009090.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		tc:AddCounter(0x94,2) 
	end
end
