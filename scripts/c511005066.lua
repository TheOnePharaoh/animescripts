--Knight Hunger Monger
--  By Shad3

local self=c511005066

function self.initial_effect(c)
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
  e1:SetCode(EVENT_BE_MATERIAL)
  e1:SetCondition(self.mat_cd)
  e1:SetOperation(self.mat_op)
  c:RegisterEffect(e1)
end

function self.mat_cd(e,tp,eg,ep,ev,re,r,rp)
  return r==REASON_XYZ
end

function self.mat_op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  local rc=c:GetReasonCard()
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
  e1:SetCode(EVENT_LEAVE_FIELD)
  e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
  e1:SetReset(RESET_EVENT+0x5000000)
  e1:SetDescription(aux.Stringid(511005066,0))
  e1:SetCondition(self.cd)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  rc:RegisterEffect(e1,true)
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  return c:IsReason(REASON_DESTROY) and c:GetOverlayCount()>0 and c:GetOverlayGroup():IsContains(e:GetOwner())
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end

function self.fil(c,e,tp)
  return c:IsLevelBelow(3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENCE)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
  local g=Duel.SelectMatchingCard(tp,self.fil,tp,LOCATION_HAND,0,1,1,nil,e,tp)
  if g:GetCount()>0 then
    Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEDOWN_DEFENCE)
  else
    local dg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
    Duel.ConfirmCards(1-tp,dg)
    Duel.ShuffleHand(tp)
  end
end