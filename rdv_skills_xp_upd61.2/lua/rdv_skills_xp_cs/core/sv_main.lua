local COL_1 = Color(255,255,255)

local function SendNotification(ply, msg)
    local PRE = RDV.LIBRARY.GetConfigOption("SAL_prefix")
    local COL = RDV.LIBRARY.GetConfigOption("SAL_prefixColor")

    RDV.LIBRARY.AddText(ply, COL, "["..PRE.."] ", COL_1, msg)
end

hook.Add("PlayerDisconnected", "RDV.LEVELS.INFO.PlayerDisconnected", function(client)
    RDV.SAL.Save(client)
end)

hook.Add("ShutDown", "RDV.LEVELS.INFO.Shutdown", function()
    for k, v in ipairs(player.GetHumans()) do
        RDV.SAL.Save(v)
    end
end)

local SV_REQ = {}
hook.Add("PlayerTick", "RDV.LEVELS.INFO.AUTO_SAVE", function(client)
    if SV_REQ[client] and SV_REQ[client] > CurTime() then return end

    RDV.SAL.Save(client)
    
    SV_REQ[client] = CurTime() + RDV.LIBRARY.GetConfigOption("SAL_svDelay")
end)

hook.Add("RDV_SAL_PostSetLevel", "RDV.LEVEL.GivePoint", function(ply, level)
    local CAN = RDV.LIBRARY.GetConfigOption("SAL_spLevelEnabled")

    if !CAN then return end
    
    local DIVISIBLE = level % RDV.LIBRARY.GetConfigOption("SAL_spLevel") == 0

    if DIVISIBLE then
        RDV.SAL.GivePoints(ply, 1)

        local LANG = RDV.LIBRARY.GetLang(nil, "SAL_levelGainSkillpoint")

        RDV.LIBRARY.AddText(ply, RDV.LIBRARY.GetConfigOption("SAL_prefixColor"), "["..RDV.LIBRARY.GetConfigOption("SAL_prefix").."] ", COL_1, LANG)
    end
end)

hook.Add("RDV_SAL_PreAddExperience", "RDV.LEVEL.Update30Additions", function(ply, exp)
    if RDV.LIBRARY.GetConfigOption("SAL_mxlvlEnabled") then
        local MAX = RDV.LIBRARY.GetConfigOption("SAL_mxlvl")

        if MAX and RDV.SAL.GetLevel(ply) >= MAX then
            return false
        end
    end

    local BONUS = RDV.SAL.GetActiveBonus()
    if !BONUS then return end
        
    return exp * BONUS
end)

concommand.Add("rdv_sal_dropdb", function(ply)
    if IsValid(ply) then
        ply:ChatPrint("This command can only be ran from server console.")
        return
    end

    local q = RDV_Mysql:Drop("RDV_LEVELS_DB_V1")
    q:Callback(function(data)
        MsgC(RDV.LIBRARY.GetConfigOption("SAL_prefixColor"), "["..RDV.LIBRARY.GetConfigOption("SAL_prefix").."] ", COL_1, "Database Dropped Successfully\n")
    end)
    q:Execute()
end)

if DarkRP and RPExtraTeams then
    hook.Add("playerCanChangeTeam", "RDV.SAL.playerCanChangeTeam", function(ply, job, force)
        if force then return end

        local TAB = RPExtraTeams[job]

        if TAB and TAB.jobLevel then
            if TAB.jobLevel > RDV.SAL.GetLevel(ply) then
                return false, RDV.LIBRARY.GetLang(nil, "SAL_jobLevel", {TAB.jobLevel})
            end
        end
    end)
end