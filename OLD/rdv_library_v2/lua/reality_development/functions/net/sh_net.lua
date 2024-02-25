hook.Add("Initialize", "RDV.LIBRARY.NetPlayer", function()
    if net.ReadPlayer or net.WritePlayer then
        return
    end

    function net.ReadPlayer()
        local VALID = net.ReadBool()

        if VALID then
            return Entity(net.ReadUInt(8))
        else
            return NULL
        end
    end

    function net.WritePlayer(ply)
        if !ply then return end

        if IsValid(ply) and ply:IsPlayer() then
            net.WriteBool(true)
            net.WriteUInt(ply:EntIndex(), 8)
        else
            net.WriteBool(false)
        end
    end
end)