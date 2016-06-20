--Backlash
-- By Shad3

local self=c511005008

function self.initial_effect(c)
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_BATTLED)
  e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_DRAW)
  e1:SetCondition(self.act_cd)
  e1:SetTarget(self.act_tg)
  e1:SetOperation(self.act_op)
  c:RegisterEffect(e1)
end

function self.act_cd(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetAttackTarget()
  return tc and (not tc:IsStatus(STATUS_BATTLE_DESTROYED)) and tc:IsOnField() and tc:IsControler(tp) and (tc:GetBattlePosition()==POS_FACEUP_DEFENCE or tc:GetBattlePosition()==POS_FACEDOWN_DEFENCE)
end

function self.act_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
  Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,1,tp,0)
end

function self.act_op(e,tp,eg,ep,ev,re,r,rp)
  Duel.Damage(1-tp,800,REASON_EFFECT)
  Duel.Draw(tp,1,REASON_EFFECT)
end