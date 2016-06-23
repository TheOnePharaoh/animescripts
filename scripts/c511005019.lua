--Black Cyclone
--  By Shad3
--[[
Need to change to Blackwing Tamer Setcode
]]
local self=c511005019

function self.initial_effect(c)
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
  e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
  e1:SetCondition(self.cd)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
  --Becoming Quickplay
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_SINGLE)
  e2:SetCode(EFFECT_CHANGE_TYPE)
  e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
  e2:SetValue(TYPE_SPELL+TYPE_QUICKPLAY)
  e2:SetCondition(self.qp_cd)
  c:RegisterEffect(e2)
end

function self.qp_fil(c)
  return c:IsFaceup() and c:IsSetCard(0x33)
end

function self.qp_cd(e)
  Debug.Message("Type:")
  Debug.Message(e:GetHandler():IsType(TYPE_QUICKPLAY))
  Debug.Message("Valid")
  Debug.Message(Duel.IsExistingMatchingCard(self.qp_fil,tp,LOCATION_MZONE,0,1,nil))
  return Duel.IsExistingMatchingCard(self.qp_fil,tp,LOCATION_MZONE,0,1,nil)
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  if not (re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsDestructable()) then return end
  Duel.SetOperationInfo(0,CATEGORY_DESTROY,re:GetHandler(),1,0,0)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  Duel.NegateActivation(ev)
  if re:GetHandler():IsRelateToEffect(re) then Duel.Destroy(re:GetHandler(),REASON_EFFECT) end
end