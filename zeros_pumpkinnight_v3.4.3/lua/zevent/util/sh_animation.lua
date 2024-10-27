/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

zpn = zpn or {}
zpn.Animation = zpn.Animation or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

if SERVER then
    util.AddNetworkString("zpn_anim_net")
    function zpn.Animation.Play(ent, anim, speed,force)

        zclib.Animation.Play(ent,anim, speed)

        net.Start("zpn_anim_net")
        net.WriteUInt(ent:LookupSequence(anim),16)
        net.WriteUInt(speed,6)
        net.WriteEntity(ent)
		net.WriteBool(force == true)
        net.Broadcast()
    end
end

if CLIENT then
    net.Receive("zpn_anim_net", function(len, ply)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

        local anim = net.ReadUInt(16)
        local speed = net.ReadUInt(6)
        local ent = net.ReadEntity()
		local force = net.ReadBool()

        if not IsValid(ent) then return end
        if anim == nil then return end
        if speed == nil then return end

        // If this animation is currently playing then stop
        local index = ent:GetSequence()
        if not force and index == anim then
            return
        end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

        zclib.Animation.Play(ent,ent:GetSequenceName(anim), speed)
    end)
end
