NCS_SHARED.RegisterCurrency("santos", {
    addMoney = function(P, AMOUNT)
        P:AddMoney(AMOUNT)
    end,
    canAfford = function(P, AMOUNT)
        if not P:CanAfford(AMOUNT) then
            return false
        else
            return true
        end
    end,
    getMoney = function(P)
        return P:GetMoney() -- I DON'T KNOW IF THIS WORKS
    end,
    formatMoney = function(AMOUNT)
        return "$"..string.Comma(AMOUNT)
    end,
})