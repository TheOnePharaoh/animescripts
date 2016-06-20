--Champion's Faction
--[[
Notes
SetCode ("King" archetype) subject to change. Or maybe change to alt method.
]]

local self=c511005002

function self.initial_effect(c)
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_ATTACK_ANNOUNCE)
  e1:SetCategory(CATEGORY_SPSUMMON)
  e1:SetCondition(self.cd)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
end

if not self.Set_King then
  self.Set_King={ --replace when "King" archetype available
    [60990740]=true, --Absolute King Back Jack
    [34408491]=true, --Beelze
    [8763963]=true, --Beelzeus
    [32995007]=true, --Sirius
    [44186624]=true, ---D/D/D Kaiser
    [19012345]=true, --Gash the Dust Lord
    [75326861]=true, --Dark Highlander
    [9601008]=true, --Phantom King Hydride
    [62242678]=true, --Hot Red Dragon Archfiend King Calamity
    [511001602]=true, --Cursed Fire King Doom Burst
    [511000760]=true, --Absolute King Back Jack (Anime)
    [511001992]=true, --Beelze (Anime)
    [511001993]=true, --Beelzeus (Anime)
    [511002037]=true, --Gash the Dust Lord (Anime)
    [511000761]=true, --Magic King Moon Star
    [511000763]=true, --Morph King Stygi-Gell
    [511000745]=true, --Hot Red Dragon Archfiend King Calamity (Anime)
    [511000762]=true, --Red Lotus King Flame Crime
    [511001601]=true --Wandering King Wild Wind
  }
end

--Main effect

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  local c=Duel.GetAttackTarget()
  return c and self.Set_King[c:GetCode()] --and c:IsFaceup()
end

function self.fil(c,e,tp)
  return self.Set_King[c:GetCode()] and c:GetLevel()<=4 and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK)
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=3 and Duel.IsExistingMatchingCard(self.fil,tp,LOCATION_DECK,0,3,nil,e,tp) end
  Duel.SetOperationInfo(0,CATEGORY_SPSUMMON,nil,3,tp,LOCATION_DECK)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  if Duel.GetLocationCount(tp,LOCATION_MZONE)<3 then return end
  local g=Duel.GetMatchingGroup(self.fil,tp,LOCATION_DECK,0,nil,e,tp)
  if g:GetCount()<3 then return end
  local c=e:GetHandler()
  local lbl=c:GetFieldID()
  Duel.NegateAttack()
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
  local sg=g:Select(tp,3,3,nil)
  local tc=sg:GetFirst()
  while tc do
    Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
    local e1=Effect.CreateEffect(tc)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_DISABLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    tc:RegisterEffect(e1)
    tc:RegisterFlagEffect(511005002,RESET_EVENT+0x1fe0000,0,1,lbl)
    tc=sg:GetNext()
  end
  Duel.SpecialSummonComplete()
  sg:KeepAlive()
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
  e2:SetCode(EVENT_PHASE+PHASE_END)
  e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e2:SetCountLimit(1)
  e2:SetLabel(lbl)
  e2:SetLabelObject(sg)
  e2:SetCondition(self.des_cd)
  e2:SetOperation(self.des_op)
  Duel.RegisterEffect(e2,tp)
end

--End Phase Destruction effect

function self.des_fil(c,lbl)
  return lbl==c:GetFlagEffectLabel(511005002)
end

function self.des_cd(e,tp,eg,ep,ev,re,r,rp)
  local g=e:GetLabelObject()
  if g:IsExists(self.des_fil,1,nil,e:GetLabel()) then return true end
  g:DeleteGroup()
  e:Reset()
  return false
end

function self.des_op(e,tp,eg,ep,ev,re,r,rp)
  local g=e:GetLabelObject()
  local tg=g:Filter(self.des_fil,nil,e:GetLabel())
  Duel.Destroy(tg,REASON_EFFECT)
end