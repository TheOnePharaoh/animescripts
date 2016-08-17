--Gagaga Thunder
--  By Shad3

local scard=c511005080

function scard.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetCategory(CATEGORY_DAMAGE)
  e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e1:SetTarget(scard.tg)
  e1:SetOperation(scard.op)
  c:RegisterEffect(e1)
end

function scard.fil(c)
  return c:IsSetCard(0x54) and c:IsFaceup() and not c:IsStatus(STATUS_NO_LEVEL)
end

function scard.dif_lv(c,i)
  return c:GetLevel()~=i
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return false end
  local g=Duel.GetMatchingGroup(scard.fil,tp,LOCATION_MZONE,0,nil):Filter(Card.IsCanBeEffectTarget,nil,e)
  if chk==0 then
    local i=0
    local tc=g:GetFirst()
    while tc do
      if scard.fil(tc) and tc:IsCanBeEffectTarget(e) and i~=tc:GetLevel() then
        if i==0 then
          i=tc:GetLevel()
        else
          return true
        end
      end
      tc=g:GetNext()
    end
    return false
  end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
  local c1=g:Select(tp,1,1,nil):GetFirst()
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
  local c2=g:FilterSelect(tp,scard.dif_lv,1,1,nil,c1:GetLevel()):GetFirst()
  Duel.SetTargetCard(Group.FromCards(c1,c2))
  local val=math.abs(c1:GetLevel()-c2:GetLevel())
  Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,val*300)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
  local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
  local c1=tg:GetFirst()
  local c2=tg:GetNext()
  if c1:IsRelateToEffect(e) and scard.fil(c1) and c2:IsRelateToEffect(e) and scard.fil(c2) then
    local val=math.abs(c1:GetLevel()-c2:GetLevel())
    if val>0 then Duel.Damage(1-tp,val*300,REASON_EFFECT) end
  end
end