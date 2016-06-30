--Galactic Fury
--  By Shad3

local self=c511005045

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
  --Global check
  if not self['gl_chk'] then
    self['gl_chk']=true
    local ge1=Effect.CreateEffect(c)
    ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    ge1:SetCode(EVENT_DAMAGE)
    ge1:SetOperation(self.reg_op)
    Duel.RegisterEffect(ge1,0)
    local ge2=ge1:Clone()
    ge2:SetCode(EVENT_TURN_END)
    ge2:SetOperation(self.clr_op)
    Duel.RegisterEffect(ge2,0)
    self['dmg0']=0
    self['dmg1']=0
  end
end

function self.reg_op(e,tp,eg,ep,ev,re,r,rp)
  self['dmg'..ep]=self['dmg'..ep]+ev
end

function self.clr_op(e,tp,eg,ep,ev,re,r,rp)
  self['dmg0']=0
  self['dmg1']=0
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return self['dmg'..tp]>0
end

function self.sum_fil(c,e,tp)
  return c:IsSetCard(0x7b) and c:GetDefence()<=self['dmg'..tp] and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingTarget(self.sum_fil,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
  local g=Duel.SelectTarget(tp,self.sum_fil,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
  Duel.SetOperationInfo(o,CATEGORY_SPECIAL_SUMMON,g,1,tp,0)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) then
    Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
  end
end