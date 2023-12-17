local CURRENCIES = {}

function RDV.LIBRARY.RegisterCurrency(NAME)
    CURRENCIES[NAME] = {}

    return CURRENCIES[NAME]
end

function RDV.LIBRARY.CurrencyExists(NAME)
    if not CURRENCIES[NAME] then
        return false
    else
        return true
    end
end

--[[
    Currency Functions.
--]]

function RDV.LIBRARY.AddMoney(ply, currency, amount)
    if !currency then
        currency = RDV.LIBRARY.GetConfigOption("SAL_curChoose")
    end

    local TAB = CURRENCIES[currency]

    if not TAB or not isfunction(TAB.AddMoney) then
        return false
    end

    TAB:AddMoney(ply, amount)
end

function RDV.LIBRARY.CanAfford(ply, currency, amount)
    if !currency then
        currency = RDV.LIBRARY.GetConfigOption("SAL_curChoose")
    end

    local TAB = CURRENCIES[currency]

    if not TAB or not isfunction(TAB.CanAfford) then
        return false
    end

    return TAB:CanAfford(ply, amount)
end

function RDV.LIBRARY.FormatMoney(currency, amount)
    if !currency then
        currency = RDV.LIBRARY.GetConfigOption("SAL_curChoose")
    end
    
    local TAB = CURRENCIES[currency]

    if not TAB or not isfunction(TAB.FormatMoney) then
        return false
    end

    return TAB:FormatMoney(amount)
end

function RDV.LIBRARY.GetCurrencies()
    local TAB = CURRENCIES

    local NEW = {}

    for k, v in pairs(TAB) do
        table.insert(NEW, k)
    end

    return NEW
end

--[[
    Old Addon Support
--]]

function RDV.AddMoney(ply, currency, amount)
    RDV.LIBRARY.AddMoney(ply, currency, amount)
end

function RDV.CanAfford(ply, currency, amount)
    return RDV.LIBRARY.CanAfford(ply, currency, amount)
end

function RDV.FormatMoney(currency, amount)
    return RDV.LIBRARY.FormatMoney(currency, amount)
end

hook.Add("RDV_LIB_Loaded", "RDV_LIB_MONEY", function()
    local N = {}

    for k, v in pairs(CURRENCIES) do
        table.insert(N, k)
    end

    RDV.LIBRARY.AddConfigOption("SAL_curChoose", {
        TYPE = RDV.LIBRARY.TYPE.SE,
        LIST = N, 
		CATEGORY = "Library", 
        DESCRIPTION = "Currency", 
        DEFAULT = "darkrp",
        SECTION = "Currency",
    })
end )