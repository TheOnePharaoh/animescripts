--Blue-Eyes White Dragon (DM)
--Scripted by edo9300
function c511000559.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCondition(c511000559.con)
	e1:SetTarget(c511000559.op)
	c:RegisterEffect(e1)
	if not c511000559.global_check then
		c511000559.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511000559.chk)
		Duel.RegisterEffect(ge1,0)
	end
end
c511000559.dm=true
function c511000559.chk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,300)
	Duel.CreateToken(1-tp,300)
end
function c511000559.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(300)>0
end
function c511000559.op(e,tp,eg,ep,ev,re,r,rp)
	if chk==0 then return true end
	if Duel.GetTurnPlayer()==e:GetHandler():GetControler() then
	local a=0
	if Duel.GetFlagEffect(tp,300+4)>0 then a=2 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_SKIP_TURN)
	e1:SetTargetRange(1,1)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,a)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetLabel(a)
	e2:SetCode(EFFECT_SKIP_M1)
	e2:SetCondition(c511000559.skipcon)
	e2:SetReset(RESET_PHASE+PHASE_END,3+a)
	Duel.RegisterEffect(e2,tp)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_EP)
    Duel.RegisterEffect(e3,tp)
    local e4=e2:Clone()
	e4:SetCode(EFFECT_CANNOT_BP)
    Duel.RegisterEffect(e4,tp)
    local e5=e2:Clone()
	e5:SetCode(EFFECT_SKIP_SP)
    Duel.RegisterEffect(e5,tp)
    local e6=e2:Clone()
	e6:SetCode(EFFECT_SKIP_DP)
	e6:SetLabel(a+1)
    Duel.RegisterEffect(e6,tp)
	local e7=Effect.CreateEffect(e:GetHandler())
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_CANNOT_ATTACK)
	e7:SetTargetRange(LOCATION_MZONE,0)
	e7:SetTarget(c511000559.ftarget)
	e7:SetReset(RESET_PHASE+PHASE_END,3+a)
	Duel.RegisterEffect(e7,tp)
end
end
function c511000559.skipcon(e)
	return Duel.GetTurnCount()<3+e:GetLabel()
end
function c511000559.ftarget(e,c)
	return not c:IsType(TYPE_FUSION)
end