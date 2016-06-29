--Line Monster K Horse
--  By Shad3

local self=c511005006

function self.initial_effect(c)
  --Normal/Special Summon effect
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
  e1:SetCode(EVENT_SUMMON_SUCCESS)
  e1:SetCategory(CATEGORY_DESTROY)
  e1:SetDescription(HINTMSG_DESTROY)
  e1:SetTarget(self.me1_tg)
  e1:SetOperation(self.me1_op)
  c:RegisterEffect(e1)
  local e2=e1:Clone()
  e2:SetCode(EVENT_SPSUMMON_SUCCESS)
  c:RegisterEffect(e2)
  --Special Summon lv3
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
  e3:SetRange(LOCATION_MZONE)
  e3:SetCode(EVENT_DESTROYED)
  e3:SetCategory(CATEGORY_SPSUMMON)
  e3:SetDescription(HINTMSG_SPSUMMON)
  e3:SetCondition(self.me2_cd)
  e3:SetTarget(self.me2_tg)
  e3:SetOperation(self.me2_op)
  c:RegisterEffect(e3)
end

--Normal/Special Summon effect

function self.me1_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  local tc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,4-e:GetHandler():GetSequence())
  if chk==0 then return tc and tc:IsDestructable() end
  Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,tp,LOCATION_SZONE)
end

function self.me1_op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,4-e:GetHandler():GetSequence())
  if not tc then return end
  Duel.HintSelection(Group.FromCards(tc))
  Duel.Destroy(tc,REASON_EFFECT)
end

--Special Summon lv3

function self.me2_cd(e,tp,eg,ep,ev,re,r,rp)
  return re and re:GetOwner()==e:GetHandler() and eg:IsExists(aux.FilterBoolFunction(Card.IsType,TYPE_TRAP),1,nil)
end

function self.me2_sfil(c,e,tp)
  return c:GetLevel()==3 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not (c:IsCode(41493640) or c:IsCode(511005006))
end

function self.me2_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingMatchingCard(self.me2_sfil,tp,LOCATION_HAND,0,1,nil,e,tp) end
  Duel.SetOperationInfo(0,CATEGORY_SPSUMMON,nil,1,tp,LOCATION_HAND)
end

function self.me2_op(e,tp,eg,ep,ev,re,r,rp)
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
  local tg=Duel.SelectMatchingCard(tp,self.me2_sfil,tp,LOCATION_HAND,0,1,1,nil,e,tp)
  if tg:GetCount()<1 then return end
  Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)
end