--Giant Kra-Corn
--  By Shad3

local self=c511005044
function self.initial_effect(c)
  --Continual effect
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_FIELD)
  e1:SetCode(EFFECT_UPDATE_ATTACK)
  e1:SetRange(LOCATION_MZONE)
  e1:SetTargetRange(LOCATION_MZONE,0)
  e1:SetTarget(self.tg)
  e1:SetValue(self.val)
  c:RegisterEffect(e1)
end

function self.fil(c)
  return c:IsRace(RACE_PLANT) and c:IsPosition(POS_FACEUP_ATTACK)
end

function self.tg(e,c)
  return self.fil(c)
end

function self.val(e,c)
  return Duel.GetMatchingGroup(self.fil,c:GetControler(),LOCATION_MZONE,0,c):GetSum(Card.GetBaseAttack)
end