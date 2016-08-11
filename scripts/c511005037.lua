--Tempt to the Crystal
--  By Shad3

local scard=c511005037

function scard.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DRAW)
  e1:SetCondition(scard.cd)
  e1:SetTarget(scard.tg)
  e1:SetOperation(scard.op)
  c:RegisterEffect(e1)
end

function scard.cd(e,tp,eg,ep,ev,re,r,rp)
  return Duel.IsAnyMatchingCard(Card.IsSetCard,tp,LOCATION_SZONE,0,2,nil,0x1034)
end

function scard.sp_fil(c,e,tp)
  return c:IsSetCard(0x1034) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsAnyMatchingCard(scard.sp_fil,tp,LOCATION_DECK,0,1,nil,e,tp)
  Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
  Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,1,1-tp,0)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
  local tc=Duel.SelectMatchingCard(tp,scard.sp_fil,tp,LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
  if tc then Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP) end
  Duel.BreakEffect()
  Duel.Draw(1-tp,1,REASON_EFFECT)
end