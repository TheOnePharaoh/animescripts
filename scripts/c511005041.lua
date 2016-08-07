--Traplin
--  By Shad3

local self=c511005041

function self.initial_effect(c)
  --SpSummon proc
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_FIELD)
  e1:SetCode(EFFECT_SPSUMMON_PROC)
  e1:SetRange(LOCATION_HAND)
  e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
  e1:SetCondition(self.sp_cd)
  e1:SetOperation(self.sp_op)
  c:RegisterEffect(e1)
end

function self.sp_fil(c)
  return c:IsType(TYPE_TRAP+TYPE_CONTINUOUS) and c:IsFaceup() and c:IsReleasable()
end

function self.sp_cd(e,c)
  if c==nil then return true end
  local tp=c:GetOwner()
  return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(self.sp_fil,tp,LOCATION_SZONE,0,1,nil)
end

function self.sp_op(e,tp,eg,ep,ev,re,r,rp,c)
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
  Duel.Release(Duel.SelectMatchingCard(tp,self.sp_fil,tp,LOCATION_SZONE,0,1,1,nil),REASON_COST)
end