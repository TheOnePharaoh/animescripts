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
  e3:SetCode(EVENT_DESTROYED)
  e3:SetRange(LOCATION_FZONE)
  e3:SetOperation(scard.swapgrv_op)
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

function scard.swapgrv_fil(c,p)
  return c:IsLocation(LOCATION_GRAVE) and c:GetOwner()~=p
end

function scard.swapgrv_op(e,tp,eg,ep,ev,re,r,rp)
  if not re then
    Debug.Message(eg:GetCount())
    local c=eg:GetFirst()
    while c do
      if not (c:IsLocation(LOCATION_GRAVE) and c:GetPreviousControler()~=c:GetOwner()) then
        local np=1-c:GetPreviousControler()
      --local g=eg:Filter(scard.swapgrv_fil,nil,rp)
      --if g:GetCount()==0 then return end
        local dg=Duel.GetFieldGroup(np,LOCATION_DECK,0)
        Duel.Remove(dg,POS_FACEDOWN,REASON_RULE+REASON_TEMPORARY)
        Duel.SendtoDeck(Duel.GetFieldGroup(np,LOCATION_GRAVE,0),np,0,REASON_RULE)
        Duel.SendtoDeck(c,np,0,REASON_RULE)
        Duel.SwapDeckAndGrave(np)
        Duel.DisableShuffleCheck()
        Duel.SendtoDeck(dg,np,0,REASON_RULE)
      end
      c=eg:GetNext()
    end
  else
    local np=re:GetHandler()
    if np~=0 and np~=1 then np=np:GetOwner() end
    local g=eg:Filter(scard.swapgrv_fil,nil,np)
    if g:GetCount()==0 then return end
    local dg=Duel.GetFieldGroup(np,LOCATION_DECK,0)
    Duel.Remove(dg,POS_FACEDOWN,REASON_RULE+REASON_TEMPORARY)
    Duel.SendtoDeck(Duel.GetFieldGroup(np,LOCATION_GRAVE,0),np,0,REASON_RULE)
    Duel.SendtoDeck(g,np,0,REASON_RULE)
    Duel.SwapDeckAndGrave(np)
    Duel.DisableShuffleCheck()
    Duel.SendtoDeck(dg,np,0,REASON_RULE)
  end
end