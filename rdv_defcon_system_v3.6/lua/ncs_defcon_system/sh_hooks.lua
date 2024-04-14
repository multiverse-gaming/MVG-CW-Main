if CLIENT then
    hook.Add( "InitPostEntity", "NCS_DEFCON_PlayerReadyForNetworking", function()
        if !IsValid(LocalPlayer()) then return end

        net.Start( "NCS_DEFCON_PlayerReadyForNetworking" )
        net.SendToServer()
    end )
else 
    local NETWORKED = {}

    util.AddNetworkString( "NCS_DEFCON_PlayerReadyForNetworking" )

    net.Receive( "NCS_DEFCON_PlayerReadyForNetworking", function( len, ply )
        if NETWORKED[ply] then
            ply:Kick()
            return
        end

        NETWORKED[ply] = true

        hook.Run("NCS_DEFCON_PlayerReadyForNetworking", ply)
    end )
end