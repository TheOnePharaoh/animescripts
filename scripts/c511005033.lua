--Line World Revival
-- By Shad3

local self=c511005033

function self.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
  e1:SetCondition(self.cd)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
end

function self.lw_fil(c)
  return c:IsCode(511005032) and c:IsFaceup()
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return Duel.IsExistingMatchingCard(self.lw_fil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end

function self.sum_fil(c,e,tp)
  return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingMatchingCard(self.sum_fil,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
  Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
  local g=Duel.GetMatchingGroup(self.sum_fil,tp,LOCATION_GRAVE,0,nil,e,tp)
  if g:GetCount()<1 then return end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
  Duel.SpecialSummon(g:Select(tp,1,1,nil),0,tp,tp,false,false,POS_FACEUP)
end