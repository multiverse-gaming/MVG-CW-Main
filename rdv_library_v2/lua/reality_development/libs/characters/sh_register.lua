local CHARACTERS = {}

function RDV.LIBRARY.RegisterCharacter(NAME)
    CHARACTERS[NAME] = {}

    return CHARACTERS[NAME]
end

local HOOKS = {}

function RDV.LIBRARY.AddCharacterHook(hookname, callback)
    if not hookname then return end

    HOOKS = HOOKS or {}

    local position = table.insert(HOOKS, hookname)

    hook.Add(hookname, hookname..".RDV."..position, callback)
end

--[[
    Currency Functions.
--]]

function RDV.LIBRARY.GetCharacterID(player, game_mode)
    if !game_mode then
        game_mode = RDV.LIBRARY.GetConfigOption("SAL_csChoose")
    end

    local TAB = CHARACTERS[game_mode]

    if not TAB or not isfunction(TAB.GetCharacterID) then
        return false
    end
        
    return TAB:GetCharacterID(player)
end

function RDV.LIBRARY.OnCharacterLoaded(game_mode, callback)
    if !game_mode then
        game_mode = RDV.LIBRARY.GetConfigOption("SAL_csChoose")
    end

    local TAB = CHARACTERS[game_mode]

    if not TAB or not isfunction(TAB.OnCharacterLoaded) then
        return false
    end

    TAB:OnCharacterLoaded(function(player, slot)
        callback(player, tonumber(slot))
    end)
end


function RDV.LIBRARY.OnCharacterDeleted(game_mode, callback)
    if !game_mode then
        game_mode = RDV.LIBRARY.GetConfigOption("SAL_csChoose")
    end

    local TAB = CHARACTERS[game_mode]

    if not TAB or not isfunction(TAB.OnCharacterDeleted) then
        return false
    end

    TAB:OnCharacterDeleted(function(player, slot)
        callback(player, tonumber(slot))
    end)
end

function RDV.LIBRARY.OnCharacterChanged(game_mode, callback)
    if !game_mode then
        game_mode = RDV.LIBRARY.GetConfigOption("SAL_csChoose")
    end

    local TAB = CHARACTERS[game_mode]

    if not TAB or not isfunction(TAB.OnCharacterChanged) then
        return false
    end

    TAB:OnCharacterChanged(function(player, new, old)
        callback(player, tonumber(new), tonumber(old))
    end)
end

function RDV.LIBRARY.GetCharacterEnabled()
    return RDV.LIBRARY.GetConfigOption("SAL_csEnabled")
end

hook.Add("RDV_LIB_Loaded", "RDV_LIB_CHARACTER", function()
    local N = {}

    for k, v in pairs(CHARACTERS) do
        table.insert(N, k)
    end

    RDV.LIBRARY.AddConfigOption("SAL_csEnabled", {
        TYPE = RDV.LIBRARY.TYPE.BL,
        DEFAULT = false,
		CATEGORY = "Library", 
        DESCRIPTION = "Character System", 
        SECTION = "Character System",
    })

    RDV.LIBRARY.AddConfigOption("SAL_csChoose", {
        TYPE = RDV.LIBRARY.TYPE.SE,
        LIST = N, 
		CATEGORY = "Library", 
        DESCRIPTION = "Character System", 
        SECTION = "Character System",
        DEFAULT = "helix",
    })
end )