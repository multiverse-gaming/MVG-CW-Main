NCS_SHARED.RegisterCurrency("blank", {
    addMoney = function(P, AMOUNT)
    end,
    canAfford = function(P, AMOUNT)
        return true
    end,
    getMoney = function(P)
        return 0
    end,
    formatMoney = function(AMOUNT)
        return string.Comma(AMOUNT)
    end,
})