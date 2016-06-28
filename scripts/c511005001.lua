--Eye of Illusion
--  By Shad3

local self=c511005001

function self.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetProperty(EVENT_FLAG_CARD_TARGET)
  e1:SetCategory(CATEGORY_EQUIP)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
  --Attack redirect/negation
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
  e2:SetCode(EVENT_ATTACK_ANNOUNCE)
  e2:SetRange(LOCATION_SZONE)
  e2:SetDescription(aux.Stringid(511005001,0))
  e2:SetCondition(self.sfx1_cd)
  e2:SetOperation(self.sfx1_op)
  c:RegisterEffect(e2)
  --Taking control
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
  e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
  e3:SetRange(LOCATION_SZONE)
  e3:SetCategory(CATEGORY_CONTROL)
  e3:SetCountLimit(1)
  e3:SetTarget(self.sfx2_tg)
  e3:SetOperation(self.sfx2_op)
  c:RegisterEffect(e3)
  --Equip limit
  local e4=Effect.CreateEffect(c)
  e4:SetType(EFFECT_TYPE_SINGLE)
  e4:SetCode(EFFECT_EQUIP_LIMIT)
  e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e4:SetValue(self.eq_limit)
  c:RegisterEffect(e4)
end

--Effect 1 Activate (Equip)

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:GetLocation()==LOCATION_MZONE and chkc:GetControler()==tp and chkc:IsFaceup() end
  if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
  Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
  Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) and tc:IsFaceup() and e:GetHandler():IsRelateToEffect(e) then
    Duel.Equip(tp,e:GetHandler(),tc)
  end
end

function self.eq_limit(e,c)
  return e:GetHandler():GetControler()==c:GetControler()
end

--Effect 2 Negate/Redirect attack

function self.sfx1_cd(e,tp,eg,ep,ev,re,r,rp)
  local tc=e:GetHandler():GetEquipTarget()
  return Duel.GetAttackTarget()==tc or (Duel.GetAttacker()==tc and Duel.GetAttackTarget())
end

function self.sfx1_op(e,tp,eg,ep,ev,re,r,rp)
  if not e:GetHandler():IsRelateToEffect(e) then return end
  local tc=e:GetHandler():GetEquipTarget()
  local ac=Duel.GetAttacker()
  local op=0
  if Duel.GetAttackTarget()==tc and Duel.IsExistingMatchingCard(Card.IsAttackable,tp,LOCATION_MZONE,0,1,tc) then
    op=Duel.SelectOption(tp,aux.Stringid(511005001,1),aux.Stringid(511005001,2))
  else
    op=Duel.SelectOption(tp,aux.Stringid(511005001,1))
  end
  if ac==tc then ac=Duel.GetAttackTarget() end
  if op==0 then
    Duel.NegateAttack()
    ac:RegisterFlagEffect(511005001,RESET_PHASE+PHASE_END,0,2)
  else
    Duel.ChangeAttackTarget(Duel.SelectMatchingCard(tp,Card.IsAttackable,tp,LOCATION_MZONE,0,1,1,tc):GetFirst())
  end
end

--Effect 3 Take control

function self.sfx2_fil(c)
  return c:GetFlagEffect(511005001)~=0 and c:IsControlerCanBeChanged()
end

function self.sfx2_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingMatchingCard(self.sfx2_fil,tp,0,LOCATION_MZONE,1,nil) end
end

function self.sfx2_op(e,tp,eg,ep,ev,re,r,rp)
  if not e:GetHandler():IsRelateToEffect(e) then return end --(maybe)
  local loc=Duel.GetLocationCount(tp,LOCATION_MZONE)
  local g=Duel.GetMatchingGroup(self.sfx2_fil,tp,0,LOCATION_MZONE,nil)
  local cg=nil
  if g:GetCount()>loc and loc>0 then
    cg=g:Select(tc,loc,loc,nil)
  else
    cg=g:Clone()
  end
  local tc=cg:GetFirst()
  while tc do
    g:RemoveCard(tc)
    Duel.HintSelection(Group.FromCards(tc))
    Duel.GetControl(tc,tp)
    tc=cg:GetNext()
  end
end