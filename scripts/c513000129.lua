--Cross Xyz
--Scripted by Keddy
function c513000129.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(513000129,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c513000129.target)
	e1:SetOperation(c513000129.activate)
	c:RegisterEffect(e1)
end
function c513000129.xfilter(c,e)
	return c:IsType(TYPE_XYZ) and c:IsCanBeEffectTarget(e)
		and Duel.IsExistingMatchingCard(c513000129.lfilter,c:GetControler(),LOCATION_MZONE,0,1,nil,c:GetRank(),c,e)
end
function c513000129.lfilter(c,rk,xc,e)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeEffectTarget(e) and c:GetLevel()==rk 
		and Duel.IsExistingMatchingCard(c513000129.xyzfilter,c:GetControler(),LOCATION_EXTRA,0,1,nil,xc,c,rk)
end
function c513000129.xyzfilter(sc,xc,c,rk)
	local temp=false
	if not xc:IsHasEffect(EFFECT_XYZ_LEVEL) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_XYZ_LEVEL)
		e1:SetValue(function (e,c) return c:GetRank() end)
		e1:SetReset(RESET_CHAIN)
		xc:RegisterEffect(e1)
		temp=true
	end
	local g=Group.FromCards(c,xc)
	local res=sc:IsXyzSummonable(g,2,2)
	if temp then xc:ResetEffect(EFFECT_XYZ_LEVEL,RESET_CODE) end
	return res
end
function c513000129.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c513000129.xfilter,tp,LOCATION_MZONE,0,1,nil,e) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g1=Duel.SelectMatchingCard(tp,c513000129.xfilter,tp,LOCATION_MZONE,0,1,1,nil,e)
	local tc=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g2=Duel.SelectMatchingCard(tp,c513000129.lfilter,tp,LOCATION_MZONE,0,1,1,nil,tc:GetRank(),tc,e)
	g2:Merge(g1)
	Duel.SetTargetCard(g2)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c513000129.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local xc=tg:GetFirst()
	local lc=tg:GetNext()
	if not xc:IsType(TYPE_XYZ) then
		lc=tg:GetFirst()
		xc=tg:GetNext()
	end
	if lc:IsRelateToEffect(e) and xc:IsRelateToEffect(e) then
		if not xc:IsHasEffect(EFFECT_XYZ_LEVEL) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_XYZ_LEVEL)
			e1:SetValue(function (e,c) return c:GetRank() end)
			e1:SetReset(RESET_CHAIN)
			xc:RegisterEffect(e1)
		end
	end
	local g=Duel.GetMatchingGroup(Card.IsXyzSummonable,tp,LOCATION_EXTRA,0,nil,Group.FromCards(lc,xc),2,2)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.XyzSummon(tp,sg:GetFirst(),Group.FromCards(lc,xc))
	end
end