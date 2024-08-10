NCS_SHARED.RegisterCurrency("helix", {
    addMoney = function(P, AMOUNT)
        if AMOUNT > 0 then
            P:GetCharacter():GiveMoney(AMOUNT)
        else
            P:GetCharacter():TakeMoney(AMOUNT)
        end
    end,
    canAfford = function(P, AMOUNT)
        if not P:GetCharacter():HasMoney(AMOUNT) then
            return false
        else
            return true
        end
    end,
    getMoney = function(P)
        return P:GetCharacter():GetMoney()
    end,
    formatMoney = function(AMOUNT)
        return ix.currency.Get(AMOUNT)
    end,
})