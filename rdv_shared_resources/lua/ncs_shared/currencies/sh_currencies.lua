NCS_SHARED.CURRENCIES = {}

function NCS_SHARED.RegisterCurrency(NAME, DATA)
    NCS_SHARED.CURRENCIES[NAME] = DATA
end

function NCS_SHARED.AddMoney(P, CURRENCY, AMOUNT)
    if !CURRENCY then
        CURRENCY = NCS_SHARED.GetDataOption("currency_library")
    end

    local TAB = NCS_SHARED.CURRENCIES[CURRENCY]

    if not TAB or not isfunction(TAB.addMoney) then
        return false
    end

    TAB.addMoney(P, AMOUNT)
end

function NCS_SHARED.GetMoney(P, CURRENCY)
    if !CURRENCY then
        CURRENCY = NCS_SHARED.CFG.currency
    end

    local TAB = NCS_SHARED.CURRENCIES[CURRENCY]

    if not TAB or not isfunction(TAB.getMoney) then
        return false
    end

    return TAB.getMoney(P)
end

function NCS_SHARED.CanAfford(P, CURRENCY, AMOUNT)
    if !CURRENCY then
        CURRENCY = NCS_SHARED.GetDataOption("currency_library")
    end

    local TAB = NCS_SHARED.CURRENCIES[CURRENCY]

    if not TAB or not isfunction(TAB.canAfford) then
        return false
    end

    return TAB.canAfford(P, AMOUNT)
end

function NCS_SHARED.FormatMoney(CURRENCY, AMOUNT)
    if !CURRENCY then
        CURRENCY = NCS_SHARED.GetDataOption("currency_library")
    end
    
    local TAB = NCS_SHARED.CURRENCIES[CURRENCY]

    if not TAB or not isfunction(TAB.formatMoney) then
        return false
    end

    return TAB.formatMoney(AMOUNT)
end