if RDV.COMMUNICATIONS and RDV.COMMUNICATIONS.LOADED then return end

util.AddNetworkString("RDV_COMMS_SendPassive")
util.AddNetworkString("RDV_COMMS_Disconnect")
util.AddNetworkString("RDV_COMMS_Connect")
util.AddNetworkString("RDV_COMMS_Sync")
util.AddNetworkString("RDV_COMMS_RemoveChannel")
util.AddNetworkString("RDV_COMMS_SetPassive")
util.AddNetworkString("RDV_COMMS_ClearPassive")
util.AddNetworkString("RDV_COMMS_MUTE")

--
util.AddNetworkString("RDV.COMMUNICATIONS.SendCommsMessage")
util.AddNetworkString("RDV.COMMUNICATIONS.RelayToggled")
util.AddNetworkString("RDV.COMMUNICATIONS.OpenConfig")
util.AddNetworkString("RDV.COMMUNICATIONS.CreateChannel")
util.AddNetworkString("RDV.COMMUNICATIONS.Talk")
--

local function SaveChannels()
    local TAB = RDV.COMMUNICATIONS.TemporaryChannels

    TAB = util.TableToJSON(TAB)

    file.Write("rdv_communications.txt", TAB)
end
hook.Add("ShutDown", "RDV.COMMUNICATIONS.SHUTDOWN.SAVE", SaveChannels)

net.Receive("RDV_COMMS_Disconnect", function(len, ply)
    local CHANNEL = RDV.COMMUNICATIONS.GetActiveChannel(ply)

    local CAN = hook.Run("RDV_COMMS_PreChannelDisconnect", ply, CHANNEL)
    if (CAN == false) then return end

    RDV.COMMUNICATIONS.ExitCurrentChannel(ply, true)

    hook.Run("RDV_COMMS_PostChannelDisconnect", ply, CHANNEL)
end)

net.Receive("RDV_COMMS_MUTE", function(len, ply)
    RDV.COMMUNICATIONS.MUTED[ply] = !RDV.COMMUNICATIONS.MUTED[ply]
end)

net.Receive("RDV_COMMS_RemoveChannel", function(len, ply)
    if !ply:IsAdmin() then return end

    local CID = net.ReadUInt(8)

    local TEMP = RDV.COMMUNICATIONS.TemporaryChannels

    if TEMP and TEMP[CID] then
        local NAME = TEMP[CID].Name

        for _, v in ipairs(RDV.COMMUNICATIONS.Players) do
            if v.Channel == NAME then
                RDV.COMMUNICATIONS.ExitCurrentChannel(v.Client, true)
            end
        end

        for k, v in pairs(RDV.COMMUNICATIONS.PASSIVE) do
            if v[NAME] then
                local P = Entity(k)

                RDV.COMMUNICATIONS.RemovePassiveChannel(P, NAME)
            end
        end

        RDV.COMMUNICATIONS.LIST[NAME] = nil
        RDV.COMMUNICATIONS.TemporaryChannels[CID] = nil

        net.Start("RDV_COMMS_RemoveChannel")
            net.WriteUInt(CID, 8)
        net.Broadcast()

        SaveChannels()
    end
end)

local DELAY = {}

net.Receive("RDV_COMMS_Connect", function(len, ply)
    if DELAY[ply] and DELAY[ply] > CurTime() then
        return
    end

    local CHANNEL = net.ReadString()

    if !RDV.COMMUNICATIONS.CanAccessChannel(ply, CHANNEL) then
        return
    end

    local CAN = RDV.COMMUNICATIONS.SetChannel(ply, CHANNEL)

    if CAN then
        local LChannel = RDV.LIBRARY.GetLang(nil, "COMMS_switchedChannel", {
            CHANNEL,
        })

        SendNotification(ply, LChannel)
    end

    DELAY[ply] = CurTime() + 2
end)


net.Receive("RDV.COMMUNICATIONS.CreateChannel", function(len, ply)
    if !ply:IsAdmin() then return end
    
    local TEAM_C = net.ReadUInt(8)
    local PLAY_C = net.ReadUInt(8)
    local NAME = net.ReadString()

    if !NAME or NAME == "" or RDV.COMMUNICATIONS.LIST[NAME] then
        return
    end
    
    local TEAMS = {}
    local TEAMS_INT = {}
    local PLAYS = {}

    local PLAYS_S = {}

    for i = 1, TEAM_C do
        local TEAM = net.ReadUInt(16)
        local TNAME = team.GetName(TEAM)

        table.insert(TEAMS, TNAME)
        table.insert(TEAMS_INT, TEAM)
    end

    for i = 1, PLAY_C do
        local STRING = net.ReadUInt(31)

        PLAYS[STRING] = true

        table.insert(PLAYS_S, STRING)
    end
    
    local COMMS = RDV.COMMUNICATIONS

    COMMS:RegisterChannel(NAME, {
        Factions = TEAMS,
        Color = Color(255,255,255),
        CustomCheck = function(ply)
            if !table.IsEmpty(PLAYS) and !PLAYS[ply:AccountID()] then
                return false
            end
        end,
    })

    net.Start("RDV.COMMUNICATIONS.CreateChannel")
        net.WriteUInt(TEAM_C, 8)
        net.WriteUInt(PLAY_C, 8)
        net.WriteString(NAME)
        
        for k, v in ipairs(TEAMS_INT) do
            net.WriteUInt(v, 16)
        end

        for k, v in ipairs(PLAYS_S) do
            net.WriteUInt(v, 31)
        end
    net.Broadcast()

    local KEY = table.insert(RDV.COMMUNICATIONS.TemporaryChannels, {
        Name = NAME,
        Factions = TEAMS_INT,
        Players = PLAYS
    })

    SaveChannels()

    hook.Run("RDV_COMMS_ChannelCreated", KEY, ply)
end)

net.Receive("RDV_COMMS_SetPassive", function(_, P)
    if DELAY[P] and DELAY[P] > CurTime() then
        return
    end

    local CHANNEL = net.ReadString()

    if !RDV.COMMUNICATIONS.LIST[CHANNEL] then
        return
    end

    if !RDV.COMMUNICATIONS.CanAccessChannel(P, CHANNEL) then
        return
    end

    local STATUS = net.ReadBool()

    if STATUS then
        if ( table.Count(RDV.COMMUNICATIONS.GetPassiveChannels(P)) ) < RDV.LIBRARY.GetConfigOption("COMMS_passiveChannelCount") then
            RDV.COMMUNICATIONS.AddPassiveChannel(P, CHANNEL)
        end
    else
        RDV.COMMUNICATIONS.RemovePassiveChannel(P, CHANNEL)
    end

    DELAY[P] = CurTime() + 2
end )
