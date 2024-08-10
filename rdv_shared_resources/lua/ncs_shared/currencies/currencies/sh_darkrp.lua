NCS_SHARED.RegisterCurrency("darkrp", {
    addMoney = function(P, AMOUNT)
        P:addMoney(AMOUNT)
    end,
    canAfford = function(P, AMOUNT)
        return P:canAfford(AMOUNT)
    end,
    getMoney = function(P)
        return P:getDarkRPVar("money")
    end,
    formatMoney = function(AMOUNT)
        return DarkRP.formatMoney(AMOUNT)
    end,
})