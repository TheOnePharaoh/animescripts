--Acid Hell Fly
--  By Shad3

local self=c511005014
function self.initial_effect(c)
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
  e1:SetCode(EVENT_SUMMON_SUCCESS)
  e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
  e1:SetDescription(aux.Stringid(511005014,0))
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
  local e2=e1:Clone()
  e2:SetCode(EVENT_SPSUMMON_SUCCESS)
  c:RegisterEffect(e2)
  local e3=e2:Clone()
  e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
  c:RegisterEffect(e3)
end

function self.fil(c)
  return c:IsFaceup() and c:GetType()==0x40002 --and c:GetSequence()<5
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsOnField() and self.fil(chkc) end
  if chk==0 then return Duel.IsExistingTarget(self.fil,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
  Duel.SetOperationInfo(0,CATEGORY_DESTROY,Duel.SelectTarget(tp,self.fil,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil),1,0,0)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) then
    local tec=tc:GetEquipTarget()
    local v=0
    if tec then
      v=tec:GetAttack()/2
    end
    if Duel.Destroy(tc,REASON_EFFECT) then
      if v==0 then return end
      local c=e:GetHandler()
      local e1=Effect.CreateEffect(c)
      e1:SetType(EFFECT_TYPE_SINGLE)
      e1:SetCode(EFFECT_SET_ATTACK_FINAL)
      e1:SetValue(v)
      e1:SetReset(RESET_EVENT+0x1fe0000)
      tec:RegisterEffect(e1)
      local e2=Effect.CreateEffect(c)
      e2:SetType(EFFECT_TYPE_SINGLE)
      e2:SetCode(EFFECT_UPDATE_ATTACK)
      e2:SetRange(LOCATION_MZONE)
      e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
      e2:SetValue(v)
      e1:SetReset(RESET_EVENT+0x1fe0000)
      c:RegisterEffect(e2)
    end
  end
end