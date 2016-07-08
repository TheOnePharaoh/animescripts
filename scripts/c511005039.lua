--Synchro Rivalry
--  By Shad3

local self=c511005039

function self.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_SUMMON_SUCCESS)
  e1:SetCondition(self.cd)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
  local e2=e1:Clone()
  e2:SetCode(EVENT_SPSUMMON_SUCCESS)
  c:RegisterEffect(e2)
  local e3=e2:Clone()
  e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
  c:RegisterEffect(e3)
end

function self.syn_fil(c)
  return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsControler(p)
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return eg:IsExists(self.syn_fil,1,nil,1-tp)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local e1=Effect.CreateEffect(e:GetHandler())
  e1:SetType(EFFECT_TYPE_FIELD)
  e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
  e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
  e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
  e1:SetReset(RESET_PHASE+PHASE_END)
  e1:SetValue(1)
  Duel.RegisterEffect(e1,tp)
end