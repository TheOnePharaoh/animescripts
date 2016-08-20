--Guard Plus
--ガードプラス
--  By Shad3

local scard=c511005078

function scard.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetCategory(CATEGORY_DEFCHANGE)
  e1:SetCost(scard.cs)
  e1:SetTarget(scard.tg)
  e1:SetOperation(scard.op)
  c:RegisterEffect(e1)
end

function scard.tfil(c)
  return c:IsReleasable() and bit.band(c:GetOriginalType(),TYPE_MONSTER)==TYPE_MONSTER
end

function scard.cs(e,tp,eg,ep,ev,re,r,rp,chk)
  local g1=Duel.GetFieldGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
  local g2=Duel.GetFieldGroup(scard.tfil,tp,LOCATION_MZONE,0,nil)
  if g1:GetCount()==1 then g2:Sub(g1) end
  if chk==0 then return g1:GetCount()>0 and g2:GetCount()>0 end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
  local tc=g2:Select(tp,1,1,nil):GetFirst()
  Duel.Release(tc,REASON_COST)
  e:SetLabel(tc:GetAttack())
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  Duel.SetOperationInfo(0,CATEGORY_DEFCHANGE,nil,1,tp,e:GetLabel())
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
  if tc then
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_DEFENSE)
    e1:SetValue(e:GetLabel())
    e1:SetReset(RESET_EVENT+0x1fe0000)
    tc:RegisterEffect(e1)
  end
end