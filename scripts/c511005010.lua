--Name Erasure
--  By Shad3

local scard=c511005010

function scard.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  c:RegisterEffect(e1)
  --Effect
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_IGNITION)
  e2:SetRange(LOCATION_SZONE)
  e2:SetCategory(CATEGORY_HANDES+CATEGORY_DAMAGE)
  e2:SetTarget(scard.tg)
  e2:SetOperation(scard.op)
  e2:SetCountLimit(1)
  c:RegisterEffect(e2)
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,0,LOCATION_HAND,1,nil) end
  e:SetLabel(Duel.AnnounceCard(tp))
  Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,1,1-tp,0)
  Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,1000,tp,0)
end

function scard.code_fil(c,i)
  return c:IsCode(i)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
  if not e:GetHandler():IsRelateToEffect(e) then return end
  local g=Duel.GetMatchingGroup(Card.IsDiscardable,tp,0,LOCATION_HAND,nil)
  local i=e:GetLabel()
  Duel.ConfirmCards(tp,g)
  local tg=g:Filter(scard.code_fil,nil,i)
  if tg:GetCount()>0 then
    Duel.HintSelection(tg)
    Duel.SendtoGrave(tg,REASON_EFFECT+REASON_DISCARD)
  else
    Duel.Damage(tp,1000,REASON_EFFECT)
  end
  Duel.ShuffleHand(1-tp)
end