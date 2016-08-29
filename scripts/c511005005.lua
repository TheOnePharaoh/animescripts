--Fool's Dice
--  By Shad3

local scard=c511005005

function scard.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_LEAVE_FIELD)
  e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
  e1:SetCategory(CATEGORY_DAMAGE)
  e1:SetCondition(scard.cd)
  e1:SetCost(scard.cs)
  e1:SetTarget(scard.tg)
  e1:SetOperation(scard.op)
  c:RegisterEffect(e1)
end

function scard.fil(c,p)
  return c:IsType(TYPE_MONSTER) and c:GetPreviousControler()~=p
end

function scard.norm_fil(c)
  return c:IsType(TYPE_NORMAL) and c:GetLevel()<=2 and c:IsDiscardable()
end

function scard.cd(e,tp,eg,ep,ev,re,r,rp)
  return eg:IsExists(scard.fil,1,nil,tp)
end

function scard.cs(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingMatchingCard(scard.norm_fil,tp,LOCATION_HAND,0,1,nil) end
  Duel.DiscardHand(tp,scard.norm_fil,1,1,REASON_COST,nil)
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  local g=eg:Filter(scard.fil,nil,tp)
  local lv=0
  if g:GetCount()>1 then
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
    lv=g:Select(tp,1,1,nil):GetLevel()
  else
    lv=g:GetFirst():GetLevel()
  end
  Duel.SetTargetPlayer(1-tp)
  Duel.SetTargetParam(lv*200)
  Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,lv*200)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
  local p,n=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
  Duel.Damage(p,n,REASON_EFFECT)
end