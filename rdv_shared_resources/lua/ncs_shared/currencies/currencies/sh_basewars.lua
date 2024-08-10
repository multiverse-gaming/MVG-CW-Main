NCS_SHARED.RegisterCurrency("basewars", {
    addMoney = function(P, AMOUNT)
        P:GiveMoney(AMOUNT)
    end,
    canAfford = function(P, AMOUNT)
        return P:GetMoney() >= AMOUNT
    end,
    getMoney = function(P)
        return P:GetMoney()
    end,
    formatMoney = function(AMOUNT)
        return string.Comma(AMOUNT)
    end,
})