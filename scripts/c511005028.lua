--Overlay Banish

local self=c511005028

function self.initial_effect(c)
  Duel.EnableGlobalFlag(GLOBALFLAG_DETACH_EVENT)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
  e1:SetCategory(CATEGORY_NEGATE)
  e1:SetCondition(self.cd)
	e1:SetTarget(self.tg)
	e1:SetOperation(self.op)
	c:RegisterEffect(e1)
  if not self.global_chk then
    self['ev0']=nil
    self.global_chk=true
    local ge=Effect.CreateEffect(c)
    ge:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    ge:SetCode(EVENT_DETACH_MATERIAL)
    ge:SetOperation(self.det_op)
    Duel.RegisterEffect(ge,0)
  end
end

function self.det_op(e,tp,eg,ep,ev,re,r,rp)
  local cid=Duel.GetCurrentChain()
  if cid>0 then
    self['ev0']=Duel.GetChainInfo(cid,CHAININFO_CHAIN_ID)
  end
end

function self.cd(e,tp,eg,ep,ev,re,r,rp)
  return Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_BATTLE and Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)==self['ev0'] and re:IsActiveType(TYPE_XYZ) and Duel.IsChainNegatable(ev)
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  Duel.NegateEffect(ev)
end