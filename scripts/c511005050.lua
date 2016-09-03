--Spell Summon Stopper
--  By Shad3

local scard=c511005050

function scard.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetOperation(scard.op)
  c:RegisterEffect(e1)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
  local e1=Effect.CreateEffect(e:GetHandler())
  e1:SetType(EFFECT_TYPE_FIELD)
  e1:SetCode(EFFECT_CANNOT_ACTIVATE)
  e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
  e1:SetTargetRange(1,1)
  e1:SetReset(RESET_PHASE+PHASE_END,2)
  e1:SetValue(scard.lm_val)
  e1:SetLabel(Duel.GetTurnCount())
  Duel.RegisterEffect(e1,tp)
end

function scard.lm_val(e,re,tp)
  return Duel.GetTurnCount()>e:GetLabel() and re:IsActiveType(TYPE_SPELL) and (re:IsHasCategory(CATEGORY_SUMMON) or re:IsHasCategory(CATEGORY_SPECIAL_SUMMON))
end