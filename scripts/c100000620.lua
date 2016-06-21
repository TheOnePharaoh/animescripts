--新生代化石マシン　スカルバギー
function c100000620.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c100000620.fcon)
	e1:SetOperation(c100000620.fop)
	c:RegisterEffect(e1)
end
function c100000620.filter1(c,tp)
	return c:IsRace(RACE_ROCK) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(tp)
end
function c100000620.filter2(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(1-tp)
end
function c100000620.fcon(e,g,gc,chkf)
	local tp=e:GetHandlerPlayer()
	if g==nil then return false end
	if gc then return (c100000620.filter1(gc,tp) and g:IsExists(c100000620.filter2,1,gc,tp))
		or (c100000620.filter2(gc,tp) and g:IsExists(c100000620.filter1,1,gc,tp)) end
	local g1=Group.CreateGroup() local g2=Group.CreateGroup()
	local tc=g:GetFirst()
	while tc do
		if c100000620.filter1(tc,tp) then g1:AddCard(tc) end
		if c100000620.filter2(tc,tp) then g2:AddCard(tc) end
		tc=g:GetNext()
	end
	return g1:GetCount()>0 and g2:GetCount()>0
end
function c100000620.fop(e,tp,eg,ep,ev,re,r,rp,gc,chkf)
	local tp=e:GetHandlerPlayer()
	if gc then
		local sg=Group.CreateGroup()
		if c100000620.filter1(gc,tp) then sg:Merge(eg:Filter(c100000620.filter2,gc,tp)) end
		if c100000620.filter2(gc,tp) then sg:Merge(eg:Filter(c100000620.filter1,gc,tp)) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g1=sg:Select(tp,1,1,nil)
		Duel.SetFusionMaterial(g1)
		return
	end
	local g1=eg:Filter(c100000620.filter1,nil,tp)
	local g2=eg:Filter(c100000620.filter2,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local tc1=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local tc2=g2:Select(tp,1,1,nil)
	tc1:Merge(tc2)
	Duel.SetFusionMaterial(tc1)
end
