NCS_SHARED.RegisterCurrency("nmoney2", {
    addMoney = function(P, AMOUNT)
        local MONEY = tonumber(P:GetNWString( "WalletMoney", "0" ))

        P:SetNWString( "WalletMoney", tostring((MONEY + AMOUNT)) )
    end,
    canAfford = function(P, AMOUNT)
        local MONEY = P:GetNWString( "WalletMoney", "0" )

        return tonumber(MONEY) >= AMOUNT
    end,
    getMoney = function(P)
        return tonumber(P:GetNWString( "WalletMoney", "0" ))
    end,
    formatMoney = function(AMOUNT)
        return string.Comma(AMOUNT)
    end,
})