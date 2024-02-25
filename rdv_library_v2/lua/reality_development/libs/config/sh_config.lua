local SAVED = {} 

RDV.LIBRARY.CONFIG = RDV.LIBRARY.CONFIG or {
    SOPTIONS = {},
    OPTIONS = {},
    SAVED = {},
    BUTTONS = {},
    SBUTTONS = {},
}

function RDV.LIBRARY.AddConfigButton(ADDON, SECTION, NW, FUNC) -- ADDON NAME, SECTION (Misc, Options, etc), Network (should it be sent to the server.), Callback function.
    RDV.LIBRARY.CONFIG.BUTTONS[ADDON] = RDV.LIBRARY.CONFIG.BUTTONS[ADDON] or {}

    local TAB = {
        ADDON = ADDON,
        SECTION = SECTION,
        NW = NW,
        CB = ( FUNC.Callback or false ),
        CA = ( FUNC.CanAccess or false ),
    }

    table.insert(RDV.LIBRARY.CONFIG.BUTTONS[ADDON], TAB)
    table.insert(RDV.LIBRARY.CONFIG.SBUTTONS, TAB)
end

RDV.LIBRARY.TYPE = {
    BL = "BOOL", -- Bool
    ST = "STRING", -- String
    CO = "COLOR", -- COLOR
    SE = "SELECT", -- Select
    SM = "SELECTMULT", -- Select Multiple
    NM = "NUMBER",
    BN = "BIND",
}

function RDV.LIBRARY.CanChangeConfig(ply)
    if !IsValid(ply) then return false end

    return ply:IsSuperAdmin()
end

function RDV.LIBRARY.SaveConfigOptions()
    local SAVED = {}

    for k, v in pairs(RDV.LIBRARY.CONFIG.OPTIONS) do
        if CLIENT and !v.noNetwork then continue end

        if isbool(v.VALUE) then v.VALUE = tonumber(v.VALUE) end

        if v.VALUE and ( v.DEFAULT and (v.VALUE ~= v.DEFAULT ) or !v.DEFAULT ) then
            table.insert(SAVED, {
                UID = k,
                VALUE = v.VALUE,
            })
        end
    end
    
    local PATH = "rdv/library/config"

    file.CreateDir(PATH)

    if SERVER then
        PATH = PATH.."/config.json"
    else
        PATH = PATH.."/config_"..LocalPlayer():SteamID64()..".json"
    end

    file.Write(PATH, util.TableToJSON(SAVED))
end

function RDV.LIBRARY.AddConfigOption(uid, tab)
    if !tab.TYPE or !tab.CATEGORY then return end

    uid = string.lower(uid)

    local D = tab.DEFAULT

    if isbool(D) then
        tab.DEFAULT = (D and 1) or 0
    end

    local VAL = RDV.LIBRARY.CONFIG.OPTIONS[uid]

    if VAL and VAL.VALUE then
        tab.VALUE = VAL.VALUE
    end

    RDV.LIBRARY.CONFIG.OPTIONS[uid] = tab
    
    --[[
        Make things load in order, good fucking god.
    --]]

    local UPDATE = false

    for k, v in ipairs(RDV.LIBRARY.CONFIG.SOPTIONS) do
        if ( uid ~= v.UID ) then
            continue
        end

        UPDATE = k

        break
    end

    tab.UID = uid

    if UPDATE then
        RDV.LIBRARY.CONFIG.SOPTIONS[UPDATE] = tab
    else
        table.insert(RDV.LIBRARY.CONFIG.SOPTIONS, tab)
    end

    RDV.LIBRARY.LoadConfigOption(uid)
end

function RDV.LIBRARY.GetConfigOption(uid)
    uid = string.lower(uid)

    local TAB = RDV.LIBRARY.CONFIG.OPTIONS

    if !TAB[uid] then return end

    TAB = TAB[uid]

    local VAL

    if TAB.VALUE then 
        VAL = TAB.VALUE
    elseif TAB.DEFAULT then 
        VAL = TAB.DEFAULT 
    end

    if ( TAB.TYPE == RDV.LIBRARY.TYPE.BL ) then
        VAL = tobool(VAL)
    end

    return (VAL and VAL) or false
end

function RDV.LIBRARY.SetConfigOption(uid, val)
    uid = string.lower(uid)

    local TAB = RDV.LIBRARY.CONFIG.OPTIONS

    if !TAB[uid] then return end
    TAB = TAB[uid]

    if isbool(val) then
        val = (val and 1) or 0
    end

    TAB.VALUE = val

    if SERVER then
        net.Start("RDV.LIBRARY.SendConfig")
            net.WriteBool(false)
            net.WriteUInt(1, 16)
            net.WriteString(uid)
            net.WriteType(val)
        net.Broadcast()
    else
        RDV.LIBRARY.SaveConfigOptions()
    end
end

function RDV.LIBRARY.LoadConfigOption(uid)
    uid = string.lower(uid)

    if SAVED[uid] then
        local V = SAVED[uid]

        local TAB = RDV.LIBRARY.CONFIG.OPTIONS[uid]
        if !TAB then return end

        TAB.VALUE = V.VALUE

        hook.Run("RDV_LIB_ConfigOptionLoaded", uid, RDV.LIBRARY.GetConfigOption(uid))
    end
end

local function Load()
    local PATH = "rdv/library/config"

    file.CreateDir(PATH)

    if SERVER then
        PATH = PATH.."/config.json"
    else
        PATH = PATH.."/config_"..LocalPlayer():SteamID64()..".json"
    end

    if file.Exists(PATH, "DATA") then 
        local F = file.Read(PATH, "DATA")
        local T = util.JSONToTable(F)

        for k, v in ipairs(T) do
            SAVED[v.UID] = v

            RDV.LIBRARY.LoadConfigOption(v.UID)
        end
    end
end

if SERVER then
    Load()
else
    hook.Add("InitPostEntity", "RDV.CONFIG.LOAD", Load)
end