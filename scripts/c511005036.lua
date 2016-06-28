--Poseidon Wind
--  By Shad3

local self=c511005036

function self.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_ATTACK_ANNOUNCE)
  e1:SetCategory(CATEGORY_DAMAGE)
  e1:SetCondition(self.cd)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return Duel.GetAttacker():IsControler(1-tp)
end

function self.attr_fil(c)
  return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  local tc=Duel.GetAttacker()
  if chkc then return chkc==tc end
  if chk==0 then return tc:IsOnField() and tc:IsCanBeEffectTarget(e) end
  Duel.SetTargetCard(tc)
  local n=Duel.GetMatchingGroup(self.attr_fil,tp,LOCATION_MZONE,0,nil):GetCount()
  if n>0 then Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,n*800) end
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) then Duel.NegateAttack() end
  local n=Duel.GetMatchingGroup(self.attr_fil,tp,LOCATION_MZONE,0,nil):GetCount()
  if n>0 then Duel.Damage(1-tp,n*800,REASON_EFFECT) end
end