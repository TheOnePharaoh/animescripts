--Refracting Prism
--By Edo9300
function c511002456.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002456.condition)
	e1:SetTarget(c511002456.target)
	e1:SetOperation(c511002456.activate)
	c:RegisterEffect(e1)
end
function c511002456.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==1 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>1
end
function c511002456.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
	local tc=Duel.GetFieldGroup(tp,LOCATION_MZONE,0):GetFirst()
	local atk=tc:GetAttack()/ct
	local def=tc:GetDefence()/ct
	local ct=ct-1
	if chk==0 then return ct>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>=ct and tc 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,tc:GetCode(),0,tc:GetType(),atk,def,tc:GetLevel()+tc:GetRank(),tc:GetRace(),tc:GetAttribute()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct,0,0)
end
function c511002456.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local tc=g:GetFirst()
	local atk=tc:GetAttack()/ct
	local def=tc:GetDefence()/ct
	local ct=ct-1
	if ct<=0 or ft<ct or g:GetCount()~=1 
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,tc:GetCode(),0,tc:GetType(),atk,def,tc:GetLevel()+tc:GetRank(),tc:GetRace(),tc:GetAttribute()) then return end
	local ea=Effect.CreateEffect(e:GetHandler())
	ea:SetType(EFFECT_TYPE_SINGLE)
	ea:SetCode(EFFECT_UPDATE_ATTACK)
	ea:SetValue(-atk*ct)
	ea:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(ea)
	local eb=ea:Clone()
	eb:SetCode(EFFECT_UPDATE_DEFENCE)
	eb:SetValue(-def*ct)
	tc:RegisterEffect(eb)
	for i=1,ct do
		local token=Duel.CreateToken(tp,511004007)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_BASE_DEFENCE)
		e2:SetValue(def)
		token:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CHANGE_LEVEL)
		e3:SetValue(tc:GetLevel())
		token:RegisterEffect(e3)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_CHANGE_RACE)
		e4:SetValue(tc:GetRace())
		token:RegisterEffect(e4)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e5:SetValue(tc:GetAttribute())
		token:RegisterEffect(e5)
		local e6=Effect.CreateEffect(e:GetHandler())
		e6:SetType(EFFECT_TYPE_SINGLE)
		e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e6:SetReset(RESET_EVENT+0x1fe0000)
		e6:SetCode(EFFECT_CHANGE_CODE)
		e6:SetValue(tc:GetCode())
		token:RegisterEffect(e6)
	end
	Duel.SpecialSummonComplete()
end
