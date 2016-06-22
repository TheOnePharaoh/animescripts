--Astral Shift
--  By Shad3

local self=c511005016

function self.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_ATTACK_ANNOUNCE)
  e1:SetCategory(CATEGORY_DRAW)
  e1:SetCondition(self.act_cd)
  e1:SetTarget(self.act_tg)
  e1:SetOperation(self.act_op)
  c:RegisterEffect(e1)
end

function self.act_cd(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetAttackTarget()
  return tc and tc:IsControler(tp)
end

function self.act_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,1,tp,0)
end

function self.act_op(e,tp,eg,ep,ev,re,r,rp)
  Duel.ChangeAttackTarget(nil)
  local e1=Effect.CreateEffect(e:GetHandler())
  e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
  e1:SetCode(EVENT_BATTLED)
  e1:SetOperation(self.draw_op)
  e1:SetReset(RESET_PHASE+PHASE_END)
  e1:SetCountLimit(1)
  Duel.RegisterEffect(e1,tp)
end

function self.draw_op(e,tp,eg,ep,ev,re,r,rp)
  Duel.Draw(tp,1,REASON_EFFECT)
end