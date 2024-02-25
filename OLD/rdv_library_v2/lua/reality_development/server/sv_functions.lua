util.AddNetworkString("RDV.LIBRARY.RemoveHUD")

local plyMeta = FindMetaTable("Player")

--[[---------------------------------]]--
--  Old AddText support.
--[[---------------------------------]]--

function plyMeta:EPS_AddText(...)
    RDV.LIBRARY.AddText(self, ...)
end

--[[---------------------------------]]--
--  Old playsound support
--[[---------------------------------]]--

function plyMeta:EPS_PlaySound(snd)
    RDV.LIBRARY.PlaySound(self, snd)
end

--[[---------------------------------]]--
--  HUD Removal
--[[---------------------------------]]--

function plyMeta:EPS_RemoveHUD(time)
    net.Start("RDV.LIBRARY.RemoveHUD")
        net.WriteInt(time, 32)
    net.Send(self)
end

--[[---------------------------------]]--
--  Networking Ready
--[[---------------------------------]]--

util.AddNetworkString( "RDV.LIBRARY.PlayerReadyForNetworking" )

net.Receive( "RDV.LIBRARY.PlayerReadyForNetworking", function( len, ply )
    if ply.RDVReadyForNetworking then
        ply:Kick()
        return
    end

    ply.RDV = ply.RDV or {}
    ply.RDVReadyForNetworking = true

    hook.Run("EPS_PlayerReadyForNetworking", ply)

    hook.Run("PlayerReadyForNetworking", ply)
end )
