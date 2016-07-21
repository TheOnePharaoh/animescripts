--Overlay Marker
--  By Shad3

local self=c511005059

function self.initial_effect(c)
  Duel.EnableGlobalFlag(GLOBALFLAG_DETACH_EVENT)
  --Global Check
  if not self['gl_chk'] then
    self['gl_chk']=true
    local ge1=Effect.CreateEffect(c)
    ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    ge1:SetCode(EVENT_DETACH_MATERIAL)
    ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    ge1:SetOperation(self.flag_op)
    Duel.RegisterEffect(ge1,0)
  end
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_CHAINING)
  e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY+CATEGORY_DAMAGE)
  e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
  e1:SetCondition(self.cd)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
end

function self.flag_op(e,tp,eg,ep,ev,re,r,rp)
  local cid=Duel.GetCurrentChain()
  if cid>0 then self['det_chk']=Duel.GetChainInfo(cid,CHAININFO_CHAIN_ID) end
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return Duel.GetAttacker() and Duel.GetAttackTarget() and Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)==self['det_chk'] and re:IsActiveType(TYPE_XYZ) and re:GetHandler():GetOverlayCount()==0 and Duel.IsChainNegatable(ev)
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
  if re:GetHandler():IsRelateToEffect(re) then
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
  end
  local val=Duel.GetAttacker():GetAttack()+Duel.GetAttackTarget():GetAttack()
  Duel.SetTargetPlayer(1-tp)
  Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,val)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  Duel.NegateActivation(ev)
  if re:GetHandler():IsRelateToEffect(re) then
    Duel.Destroy(re:GetHandler(),REASON_EFFECT)
  end
  Duel.BreakEffect()
  local val=0
  if Duel.GetAttacker() then val=val+Duel.GetAttacker():GetAttack() end
  if Duel.GetAttackTarget() then val=val+Duel.GetAttackTarget():GetAttack() end
  if val>0 then
    local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
    Duel.Damage(p,val,REASON_EFFECT)
  end
end