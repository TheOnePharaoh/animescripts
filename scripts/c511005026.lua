--Breaking the Norm
--By Shad3

local self=c511005026

function self.initial_effect(c)
  --Activation
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
  e1:SetCondition(self.cd)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
end

function self.lv_fil(c,i)
  return c:GetLevel()==i and not c:IsType(TYPE_XYZ)
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
  local c=g:GetFirst()
  while c do
    if g:FilterCount(self.lv_fil,nil,c:GetLevel())>=3 then return true end
    c=g:GetNext()
  end
  return false
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
  Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
  local c=g:GetFirst()
  local lv=0
  while c do
    local i=c:GetLevel()
    if g:FilterCount(self.lv_fil,nil,i)>=3 then
      lv=i
      break
    end
    c=g:GetNext()
  end
  local dg=Duel.GetFieldGroup(1-tp,LOCATION_DECK,0)
  Duel.ConfirmCards(tp,dg)
  if lv>0 then
    local tg=dg:Filter(self.lv_fil,nil,lv):Filter(Card.IsCanBeSpecialSummoned,nil,e,0,tp,false,false):Select(tp,1,1,nil)
    Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)
  end
end