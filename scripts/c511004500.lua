--Realize Defense
local id,ref=GIR()

function ref.start(c)
  --Change Position
  local e1=c:AddActivateProc()
  e1:SetCategory(CATEGORY_POSITION)
  e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e1:SetTarget(CCF(ref.tg,ref.tg_check,ref.tg_target))
  e1:SetOperation(ref.op)
end

--Change Position
local function check(c) return c:IsBaseDefenceAbove(c:GetBaseAttack()+1) end
ref.filter=AndFunctions(check,Card.IsFaceup,Card.IsAttackPos)

function ref.tg_target(e,tp,eg,ep,ev,re,r,rp,chkc)
  return chkc:TargetFilterCheck(ref.filter,tp,LOCATION_MZONE)
end

function ref.tg_check(e,tp,eg,ep,ev,re,r,rp)
  return Duel.PlayerFilterTargetCheck(ref.filter,tp,LOCATION_MZONE)
end

function ref.tg(e,tp,eg,ep,ev,re,r,rp)
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUPATTACK)
  local g=Duel.SelectTarget(tp,ref.filter,tp,LOCATION_MZONE)
  Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end

function ref.op(e,tp,eg,ep,ev,re,r,rp)
  local m=Duel.MaybeUncheckedTarget(e)
  m:OnValue(Duel.ChangePosition,POS_FACEUP_DEFENCE)
end
