--Flash Tune
--  By Shad3

local self=c511005070

function self.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_TO_GRAVE)
  --e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
  e1:SetCategory(CATEGORY_REMOVE+CATEGORY_SPECIAL_SUMMON)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return bit.band(r,REASON_DESTROY)~=0 and eg:GetCount()==1 and eg:GetFirst():IsType(TYPE_SYNCHRO) and eg:GetFirst():GetPreviousControler()==tp
end

function self.syn_fil(c,lv,tc,mc)
  return c:IsType(TYPE_SYNCHRO) and c:GetLevel()==lv and mc:IsCanBeSynchroMaterial(c,tc)
end

function self.tun_fil(c,mg,tp)
  local lv=mg:GetFirst():GetLevel()+c:GetLevel()
  return c:IsType(TYPE_TUNER) and Duel.IsExistingMatchingCard(self.syn_fil,tp,LOCATION_EXTRA,0,1,nil,lv,c,mg:GetFirst())
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then
  Debug.Message(Duel.IsExistingMatchingCard(self.tun_fil,tp,LOCATION_HAND,0,1,nil,eg,tp))
  return Duel.IsExistingMatchingCard(self.tun_fil,tp,LOCATION_HAND,0,1,nil,eg,tp) end
  Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,2,0,LOCATION_HAND+LOCATION_GRAVE)
  Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,0)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  Duel.Hint(HINT_SELECTMSG,tp,503)
  local tc=Duel.SelectMatchingCard(tp,self.tun_fil,tp,LOCATION_HAND,0,1,1,nil,eg,tp):GetFirst()
  if not tc then return end
  Duel.Hint(HINT_SELECTMSG,tp,509)
  local sc=Duel.SelectMatchingCard(tp,self.syn_fil,tp,LOCATION_EXTRA,0,1,1,nil,eg:GetFirst():GetLevel()+tc:GetLevel(),tc,eg:GetFirst()):GetFirst()
  if not sc then return end
  local mg=Group.FromCards(tc,eg:GetFirst())
  Duel.Remove(mg,POS_FACEUP,REASON_EFFECT)
  Duel.SpecialSummon(sc,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP_ATTACK)
  --c:SetMaterial(mg)
end