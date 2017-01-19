--Zombie's Jewel
--scripted by GameMaster(GM) 
function c511000170.initial_effect(c)
--AddSpell and op.Draws1
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(511000170,0))
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c511000170.target)
e1:SetOperation(c511000170.operation)
c:RegisterEffect(e1)
end
function c511000170.filter(c)
return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c511000170.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsPlayerCanDraw(1-tp,1) and 
Duel.IsExistingMatchingCard(c511000170.filter,tp,0,LOCATION_GRAVE,1,nil)end
Duel.SetTargetPlayer(1-tp)
Duel.SetTargetParam(1)
Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c511000170.operation(e,tp,eg,ep,ev,re,r,rp)
local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
local g=Duel.SelectMatchingCard(tp,c511000170.filter,tp,0,LOCATION_GRAVE,1,1,nil)
if g:GetCount()>0 then
Duel.SendtoHand(g,tp,REASON_EFFECT)
end
Duel.Draw(p,d,REASON_EFFECT)
end