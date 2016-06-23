--Rival Crush
--  By Shad3

local self=c511005021

function self.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  --For ChainAttack check
  local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetTargetRange(0,LOCATION_MZONE)
  e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTarget(self.exattack_tg)
  e1:SetValue(0)
	Duel.RegisterEffect(e1,tp)
  --Actual Attack Cutoff
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD)
  e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetTargetRange(0,LOCATION_MZONE)
  e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetTarget(self.noattack_tg)
  e2:SetLabel(0)
  Duel.RegisterEffect(e2,tp)
  --Below is horrible horrible check
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
  e3:SetCode(EVENT_PHASE_START+PHASE_BATTLE)
  e3:SetReset(RESET_PHASE+PHASE_END)
  e3:SetOperation(self.update_op)
  e3:SetLabelObject(e2)
  Duel.RegisterEffect(e3,tp)
  local e4=e3:Clone()
  e4:SetCode(EVENT_CHAIN_END)
  Duel.RegisterEffect(e4,tp)
  local e5=e3:Clone()
  e5:SetCode(EVENT_ATTACK_ANNOUNCE)
  e5:SetOperation(self.atkupdate_op)
  Duel.RegisterEffect(e5,tp)
  local e6=e5:Clone()
  e6:SetCode(EVENT_BATTLED)
  Duel.RegisterEffect(e6,tp)
end

function self.exattack_tg(e,c)
  return true
end

function self.noattack_tg(e,c)
  return c:GetAttack()<e:GetLabel()
end

function self.update_op(e,tp,eg,ep,ev,re,r,rp)
  e:GetLabelObject():SetLabel(0)
  local atkv=0
  local g=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
  local c=g:GetFirst()
  while c do
    if c:IsAttackable() and c:GetAttack()>atkv then atkv=c:GetAttack() end
    c=g:GetNext()
  end
  e:GetLabelObject():SetLabel(atkv)
end

function self.atkupdate_op(e,tp,eg,ep,ev,re,r,rp)
  e:GetLabelObject():SetLabel(0)
  local atkv=0
  local g=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
  local c=g:GetFirst()
  while c do
    if c:IsChainAttackable() and c:GetAttack()>atkv then atkv=c:GetAttack() end
    c=g:GetNext()
  end
  e:GetLabelObject():SetLabel(atkv)
end