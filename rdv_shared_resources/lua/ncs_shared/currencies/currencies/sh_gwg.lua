NCS_SHARED.RegisterCurrency("gatewaygaming", {
    addMoney = function(P, AMOUNT)
        P:AddBalance(AMOUNT)
    end,
    canAfford = function(P, AMOUNT)
        if P:GetBalance() >= AMOUNT then
            return true
        else
            return false
        end
    end,
    getMoney = function(P)
        return P:GetBalance()
    end,
    formatMoney = function(AMOUNT)
        return string.Comma(AMOUNT).."RC"
    end,
})