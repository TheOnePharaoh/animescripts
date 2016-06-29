--Guidance to Salvation
--  By Shad3

local self=c511005007

function self.initial_effect(c)
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
  e1:SetCondition(self.cd)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return Duel.GetLP(tp)<=1500
end

function self.fil(c,e,tp)
  return c:IsType(TYPE_TUNER) and c:GetAttack()<=1500 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingMatchingCard(self.fil,tp,LOCATION_DECK,0,1,nil,e,tp) end
  Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.SelectMatchingCard(tp,self.fil,tp,LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
  if tc then
    Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
  end
end