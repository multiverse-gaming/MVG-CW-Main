local plyMeta = FindMetaTable("Player")

--[[

	Job Category

--]]

function plyMeta:RD_GetJobCategory()
    if not RPExtraTeams or not RPExtraTeams[self:Team()] then
        return "N/A"
    end
    
    return RPExtraTeams[self:Team()].category
end

function plyMeta:EPS_GetPlayersJobCategory()
	return self:RD_GetJobCategory()
end

--[[

	Cooldowns

--]]

function RD_Cooldown_Get(ID)
    if not ID then
        return
    end

    RD_CoolDowns = RD_CoolDowns or {}

    if RD_CoolDowns[ID] and RD_CoolDowns[ID] > 0 then
        return true, RD_CoolDowns[ID]
    end
end

function RD_Cooldown_Add(ID, TIME)
    if not ID or not TIME then
        return
    end

    RD_CoolDowns = RD_CoolDowns or {}

    RD_CoolDowns[ID] = tonumber(TIME)

    return true
end

local RD_CoolDowns = RD_CoolDowns or {}
local function UpdateCoolDowns()
    for k = #RD_CoolDowns, 1, -1 do
        RD_CoolDowns[k] = RD_CoolDowns[k] - 5
        
        if RD_CoolDowns[k] <= 0 then
            table.remove(RD_CoolDowns, k)
        end
    end
end
timer.Create("RD_CoolDownTimer", 5, 0, UpdateCoolDowns)

--[[

	Get User from String

--]]


function EPS_GetUserFromString(text)
	return RD_GetUserFromString(text)
end

function RD_GetUserFromString(text)
    local target
    local playerCount = 0

    for _, ply in ipairs(player.GetAll()) do
        if string.find(string.lower(ply:Nick()), string.lower(text)) then
            target = ply
            playerCount = playerCount + 1
        end

        if string.find(ply:SteamID(), text) then
            target = ply
            playerCount = playerCount + 1
        end
    end

    if playerCount == 0 then
        return false
    elseif playerCount == 1 then
        return target
    else
        return false
    end

    return false
end

--[[
local INITS = {}
function RDV.LIBRARY.Initialize(callback)
    table.insert(INITS, callback)
end

hook.Add("Initialize", "RDV.LIBRARY.INITIALIZE.CALLBACKS", function()
    for k, v in ipairs(INITS) do
        if !isfunction(v) then continue end

        v()
    end

    INITS = {}
end )
--]]