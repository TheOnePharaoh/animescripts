--Fool's Dice
--  By Shad3

local self=c511005005

function self.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_LEAVE_FIELD)
  e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
  e1:SetCategory(CATEGORY_DAMAGE)
  e1:SetCondition(self.cd)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
end

function self.fil(c,p)
  return c:IsType(TYPE_MONSTER) and c:GetPreviousControler()~=p
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return eg:IsExists(self.fil,1,nil,tp)
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  local g=eg:Filter(self.fil,nil,tp)
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

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local p,n=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
  Duel.Damage(p,n,REASON_EFFECT)
end