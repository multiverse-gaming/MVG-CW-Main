NCS_SHARED.RegisterCurrency("nutscript", {
    addMoney = function(P, AMOUNT)
        if AMOUNT > 0 then
            P:getChar():giveMoney(AMOUNT)
        else
            P:getChar():takeMoney(AMOUNT)
        end
    end,
    canAfford = function(P, AMOUNT)
        if not P:getChar():hasMoney(AMOUNT) then
            return false
        else
            return true
        end
    end,
    getMoney = function(P)
        return P:getChar():getMoney()
    end,
    formatMoney = function(AMOUNT)
        return nut.currency.get(AMOUNT)
    end,
})