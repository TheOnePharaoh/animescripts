--Phantom Scales
--  By Shad3

local self=c511005051

function self.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
  e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
end

function self.sel_fil(c,e)
  return c:IsFaceup() and c:IsRace(RACE_INSECT) and c:IsCanBeEffectTarget(e)
end

function self.sum_fil(c,e,p,co)
  return c:IsCode(co) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsFaceup() and chkc:IsOnField() end
  local g=Duel.GetMatchingGroup(self.sel_fil,tp,LOCATION_MZONE,0,nil,e)
  local tg=g:Clone()
  local c=g:GetFirst()
  while c do
    if Duel.GetMatchingGroupCount(self.sum_fil,tp,LOCATION_DECK,0,nil,e,tp,c:GetCode())==0 then
      tg:RemoveCard(c)
    end
    c=g:GetNext()
  end
  if chk==0 then return tg:GetCount()>0 end
  local tc=tg:Select(tp,1,1,nil)
  Duel.SetTargetCard(tc)
  Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,tp,0)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) then
    local ttc=Duel.SelectMatchingCard(tp,self.sum_fil,tp,LOCATION_DECK,0,1,1,nil,e,tp,tc:GetCode()):GetFirst()
    if ttc then
      Duel.SpecialSummon(ttc,0,tp,tp,false,false,POS_FACEUP)
    else
      local chkg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
      Duel.ConfirmCards(1-tp,chkg)
      Duel.ConfirmCards(tp,chkg)
      Duel.ShuffleDeck(tp)
    end
  end
end