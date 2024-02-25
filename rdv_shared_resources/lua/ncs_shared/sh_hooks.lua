if CLIENT then
    hook.Add( "InitPostEntity", "NCS_SHARED_PlayerReadyForNetworking", function()
        if !IsValid(LocalPlayer()) then return end

        net.Start( "NCS_SHARED_PlayerReadyForNetworking" )
        net.SendToServer()
    end )
else 
    local NETWORKED = {}

    util.AddNetworkString( "NCS_SHARED_PlayerReadyForNetworking" )

    net.Receive( "NCS_SHARED_PlayerReadyForNetworking", function( len, ply )
        if NETWORKED[ply] then
            ply:Kick()
            return
        end

        NETWORKED[ply] = true

        hook.Run("NCS_SHARED_PlayerReadyForNetworking", ply)
    end )
end