--Tao the chanter
--Scripted by GameMaster (GM)
local id,cod=511005607,c511005607
function cod.initial_effect(c)
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(id,0))
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
    e1:SetTarget(cod.target)
    e1:SetOperation(cod.operation)
    c:RegisterEffect(e1)
end
function cod.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
end
function cod.operation(e,tp,eg,ep,ev,re,r,rp)
    Debug.Message("Operation")
    local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
    local tc=g:GetFirst()
    while tc do
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
        e1:SetValue(ATTRIBUTE_DARK)
        e1:SetReset(RESET_EVENT+0x1ff0000)
        tc:RegisterEffect(e1,true)
        tc=g:GetNext()
    end
end
