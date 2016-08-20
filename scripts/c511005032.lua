--Line World
--  By Shad3

local scard=c511005032

function scard.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  c:RegisterEffect(e1)
  --Line Monster 500 atk
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD)
  e2:SetCode(EFFECT_UPDATE_ATTACK)
  e2:SetRange(LOCATION_FZONE)
  e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
  e2:SetValue(scard.line_val)
  c:RegisterEffect(e2)
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
  e3:SetCode(EFFECT_SEND_REPLACE)
  e3:SetRange(LOCATION_FZONE)
  e3:SetTarget(scard.tg)
  e3:SetValue(scard.val)
  c:RegisterEffect(e3)
end

if not scard.SetLineW then
  scard.setLineW={
    [41493640]=true,
    [32476434]=true,
    [75253697]=true,
    [511005006]=true
  }
end

function scard.line_val(e,c)
  if scard.setLineW[c:GetCode()] then return 500 end
  return 0
end

function scard.fil(c)
  Debug.Message(bit.band(c:GetReason(),REASON_DESTROY)~=0 and bit.band(c:GetReason(),REASON_RULE+REASON_REDIRECT)==0 and c:GetDestination()==LOCATION_GRAVE and c:GetOwner()~=c:GetReasonPlayer())
  return bit.band(c:GetReason(),REASON_DESTROY)~=0 and bit.band(c:GetReason(),REASON_RULE+REASON_REDIRECT)==0 and c:GetDestination()==LOCATION_GRAVE and c:GetOwner()~=c:GetReasonPlayer()
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return eg:IsExists(scard.fil,1,nil) end
  local c=eg:GetFirst()
  while c do
    if scard.fil(c) then Duel.SendtoGrave(c,r+REASON_REDIRECT,c:GetReasonPlayer()) end
    c=eg:GetNext()
  end
  return true
end

function scard.val(e,c)
  return false
end