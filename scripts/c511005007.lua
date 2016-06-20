--Assault Cyclone
--  By Shad3

local self=c511005007

function self.initial_effect(c)
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_CHAINING)
  e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
  e1:SetCondition(self.act_cd)
  e1:SetTarget(self.act_tg)
  e1:SetOperation(self.act_op)
  c:RegisterEffect(e1)
end

function self.act_cd(e,tp,eg,ep,ev,re,r,rp)
  ph=Duel.GetCurrentPhase()
  return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) and re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end

function self.act_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end

function self.act_op(e,tp,eg,ep,ev,re,r,rp)
  Duel.NegateActivation(ev)
  if re:GetHandler():IsRelateToEffect(re) then
    Duel.Destroy(eg,REASON_EFFECT)
  end
end