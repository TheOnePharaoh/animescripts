--Sealer Formation
--  By Shad3

local self=c511005067

function self.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  c:RegisterEffect(e1)
  --Add/Draw
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
  e2:SetCode(EVENT_PREDRAW)
  e2:SetRange(LOCATION_SZONE)
  e2:SetCondition(self.cd)
  e2:SetOperation(self.op)
  c:RegisterEffect(e2)
  --Global const
  if not self.['gl_chk'] then
    self.['gl_chk']=true
    self.seal_lst={
      25880422,29549364,63102017,
      511000176
    }
  end
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 and Duel.GetDrawCount(tp)>0
end

function self.fil(c)
  for _,i=pairs(self.seal_lst) do
    if c:IsCode(i) then return c:IsAbleToHand() end
  end
  return false
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  if Duel.GetDrawCount(tp)>0 and Duel.IsExistingMatchingCard(self.fil,tp,LOCATION_GRAVE,0,1,nil) and Duel.SelectYesNo(tp,1) then
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EFFECT_DRAW_COUNT)
    e1:SetTargetRange(1,0)
    e1:SetReset(RESET_PHASE+PHASE_DRAW)
    e1:SetValue(0)
    Duel.RegisterEffect(e1,tp)
    local g=Duel.SelectMatchingCard(tp,self.fil,tp,LOCATION_GRAVE,0,1,1,nil)
    if g:GetCount()>0 then Duel.SendtoHand(g,tp,REASON_EFFECT+REASON_REVEAL) end
  end
end