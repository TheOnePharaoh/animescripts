--Fair Exchange
--Scripted by Snrk
function c511008018.initial_effect(c)
    --activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DECKDES)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCost(c511008018.cost)
    e1:SetTarget(c511008018.target)
    e1:SetOperation(c511008018.activate)
    c:RegisterEffect(e1)
end
function c511008018.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDiscardDeckAsCost(tp,3) end
    Duel.DiscardDeck(tp,3,REASON_COST)
    local og=Duel.GetOperatedGroup()
    local gc=og:GetFirst()
    local sum=0
    while gc do
        local lv=gc:GetLevel()
        sum=sum+lv
        gc=og:GetNext()
    end
    e:SetLabel(sum)
end
function c511008018.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    local ct=e:GetLabel()
    Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,ct)
end
function c511008018.activate(e,tp,eg,ep,ev,re,r,rp)
    local ct=e:GetLabel()
	Duel.DiscardDeck(1-tp,ct,REASON_EFFECT)
end
