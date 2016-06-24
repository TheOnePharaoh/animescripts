--古生代化石マシン スカルコンボイ
function c100000023.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_FUSION_MATERIAL)
	e0:SetCondition(c100000023.fcon)
	e0:SetOperation(c100000023.fop)
	c:RegisterEffect(e0)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)	
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000023,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCondition(c100000023.damcon)
	e2:SetTarget(c100000023.damtg)
	e2:SetOperation(c100000023.damop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EXTRA_ATTACK)	
	e3:SetCondition(c100000023.con)
	e3:SetValue(2)
	c:RegisterEffect(e3)
end
function c100000023.filter1(c,tp)
	return c:IsRace(RACE_ROCK) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(tp)
end
function c100000023.filter2(c,tp)
	return c:IsLevelAbove(7) and c:IsRace(RACE_MACHINE) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(1-tp)
end
function c100000023.fcon(e,g,gc,chkf)
	local tp=e:GetHandlerPlayer()
	if g==nil then return false end
	if gc then return (c100000023.filter1(gc,tp) and g:IsExists(c100000023.filter2,1,gc,tp))
		or (c100000023.filter2(gc,tp) and g:IsExists(c100000023.filter1,1,gc,tp)) end
	local g1=Group.CreateGroup() local g2=Group.CreateGroup()
	local tc=g:GetFirst()
	while tc do
		if c100000023.filter1(tc,tp) then g1:AddCard(tc) end
		if c100000023.filter2(tc,tp) then g2:AddCard(tc) end
		tc=g:GetNext()
	end
	return g1:GetCount()>0 and g2:GetCount()>0
end
function c100000023.fop(e,tp,eg,ep,ev,re,r,rp,gc,chkf)
	local tp=e:GetHandlerPlayer()
	if gc then
		local sg=Group.CreateGroup()
		if c100000023.filter1(gc,tp) then sg:Merge(eg:Filter(c100000023.filter2,gc,tp)) end
		if c100000023.filter2(gc,tp) then sg:Merge(eg:Filter(c100000023.filter1,gc,tp)) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g1=sg:Select(tp,1,1,nil)
		Duel.SetFusionMaterial(g1)
		return
	end
	local g1=eg:Filter(c100000023.filter1,nil,tp)
	local g2=eg:Filter(c100000023.filter2,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local tc1=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local tc2=g2:Select(tp,1,1,nil)
	tc1:Merge(tc2)
	Duel.SetFusionMaterial(tc1)
end
function c100000023.con(e)
	return Duel.GetFieldGroupCount(e:GetOwnerPlayer(),0,LOCATION_MZONE)>0
end
function c100000023.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d=Duel.GetAttacker()
	if d==c then d=Duel.GetAttackTarget() end
	return c:IsRelateToBattle() and d:IsLocation(LOCATION_GRAVE) and d:IsReason(REASON_BATTLE) and d:IsType(TYPE_MONSTER)
end
function c100000023.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c100000023.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
