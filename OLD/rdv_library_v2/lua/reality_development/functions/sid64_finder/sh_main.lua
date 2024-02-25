local Players = {}
local SPlayers = {}
local SCOUNT = 0

RDV = RDV or {}

function RDV.GetBySteamID64(SID)
    if not Players[SID] then
        return false
    end

    local PLAYER = Players[SID].Player

    if IsValid(PLAYER) then
        return PLAYER
    else
        return false
    end
end

if SERVER then
    util.AddNetworkString("RDV.PLAYER_SEND_ONLINE_PLAYERS")

    hook.Add("PlayerReadyForNetworking", "RDV.PLAYER_CONNECT_TRACK", function(ply)
        if ply:IsBot() then return end

        local SID64 = ply:SteamID64()
        local INDEX = ply:EntIndex()

        --[[
            Send Currently Connected Players
        --]]

        net.Start("RDV.PLAYER_SEND_ONLINE_PLAYERS")
            net.WriteBool(true)
            net.WriteUInt(SCOUNT, 8)

            for i = 1, SCOUNT do
                if !SPlayers[i] then
                    continue
                end

                net.WriteUInt(SPlayers[i].Index, 8)
            end
        net.Send(ply)

        --[[
            Send Player to Currently Connected Players
        --]]

        net.Start("RDV.PLAYER_SEND_ONLINE_PLAYERS")
            net.WriteBool(false)
            net.WriteUInt(INDEX, 8)
        net.Broadcast()

        local INSERT = table.insert(SPlayers, {
            SteamID64 = SID64,
            Player = ply,
            Index = INDEX,
        })

        Players[SID64] = {
            Player = ply,
            Sequential = INSERT,
        }

        SCOUNT = SCOUNT + 1
    end)

    hook.Add("PlayerDisconnected", "RDV.PLAYER_CONNECT_TRACK", function(ply)
        if ply:IsBot() then return end

        local SID64 = ply:SteamID64()

        local TAB = Players[SID64]

        if TAB then
            if TAB.Sequential then
                table.remove(SPlayers, TAB.Sequential)
            end

            Players[SID64] = nil

            SCOUNT = SCOUNT - 1
        end
    end)
else
    gameevent.Listen( "player_disconnect" )
    hook.Add( "player_disconnect", "RDV.PLAYER.DISCONNECT.SID64", function( data )
        local SID = data.networkid	// Same as Player:SteamID()

        SID = util.SteamIDTo64(SID)

        local TAB = Players[SID]

        if TAB then
            Players[SID] = nil

            SCOUNT = SCOUNT - 1
        end
    end )

    net.Receive("RDV.PLAYER_SEND_ONLINE_PLAYERS", function(len, ply)
        local MULTIPLE = net.ReadBool()
        
        if MULTIPLE then
            local COUNT = net.ReadUInt(8)

            local TAB = {}
            
            for i = 1, COUNT do
                local ENTITY = net.ReadUInt(8)
                ENTITY = Entity(ENTITY)

                if !IsValid(ENTITY) then return end

                if !ENTITY.SteamID64 then
                    continue
                end

                local SID64 = ENTITY:SteamID64()

                TAB[SID64] = ENTITY
            end

            SCOUNT = COUNT
            Players = TAB
        else
            local ENTITY = net.ReadUInt(8)
            ENTITY = Entity(ENTITY)
            
            if !IsValid(ENTITY) then return end

            if !ENTITY.SteamID64 then
                return
            end

            local SID64 = ENTITY:SteamID64()

            Players[SID64] = ENTITY

            SCOUNT = SCOUNT + 1
        end
    end)
end