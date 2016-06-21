--H・C ダブル・ランス
function c511002760.initial_effect(c)
	c511002760.xyzlimit2=function(mc) return mc:IsSetCard(0x206f) end
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(511001225)
	c:RegisterEffect(e2)
	if not c511002760.global_check then
		c511002760.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511002760.xyzchk)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002760.xyzchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,419)
	Duel.CreateToken(1-tp,419)
end
