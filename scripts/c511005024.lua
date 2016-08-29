--Booming Urchin
--  By Shad3

local scard=c511005024

function scard.initial_effect(c)
  --Avtivation
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_CHAINING)
  e1:SetCondition(scard.cd)
  c:RegisterEffect(e1)
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
  e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
  e2:SetRange(LOCATION_SZONE)
  e2:SetCategory(CATEGORY_DAMAGE)
  e2:SetCondition(scard.dmg_cd)
  e2:SetTarget(scard.dmg_tg)
  e2:SetOperation(scard.dmg_op)
  e2:SetCountLimit(1)
  c:RegisterEffect(e2)
end

function scard.cd(e,tp,eg,ep,ev,re,r,rp)
  return re and re:IsActiveType(TYPE_TRAP) and rp~=tp
end

function scard.dmg_cd(e,tp,eg,ep,ev,re,r,rp)
  return Duel.GetTurnPlayer()==tp
end

function scard.dmg_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end

function scard.dmg_op(e,tp,eg,ep,ev,re,r,rp)
  if e:GetHandler():IsRelateToEffect(e) then Duel.Damage(1-tp,1000,REASON_EFFECT) end
end