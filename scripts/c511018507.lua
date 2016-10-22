--Raidraptor - Satellite Cannon Falcon (Anime)
--RR－サテライト・キャノン・ファルコン
function c511018507.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_WINDBEAST),8,2)
	c:EnableReviveLimit()
	--atkdown
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511018507,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511018507.atkcost)
	e1:SetTarget(c511018507.atktg)
	e1:SetOperation(c511018507.atkop)
	c:RegisterEffect(e1)
end
function c511018507.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511018507.atkfilter(c)
	return c:IsSetCard(0xba) and c:IsType(TYPE_MONSTER)
end
function c511018507.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingMatchingCard(c511018507.atkfilter,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end		
end
function c511018507.atkop(e,tp,eg,ep,ev,re,r,rp)
	    local g=Duel.GetMatchingGroup(c511018507.atkfilter,tp,LOCATION_GRAVE,0,nil)
		if g:GetCount()>0 then
		local ct=g:GetFirst()
		while ct do
		if Duel.SelectYesNo(tp,aux.Stringid(511018507,1)) then
		local code=ct:GetCode()
		Duel.Hint(HINT_CARD,0,code)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local tc=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
		local tc=Duel.GetFirstTarget()
		if tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-800)
		tc:RegisterEffect(e1)
		end
		Duel.BreakEffect()
		ct=g:GetNext()
		end
		end
	end
end
