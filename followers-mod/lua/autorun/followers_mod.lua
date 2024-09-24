if (SERVER) then
    -- Adds a follower. Were they extremely busy and couldn't just write "AddFollower"?
    -- In both of these, we might want to get rid of the Custom/Special stuff. Additonally, the logging
    -- to could be changed to "This person is now following you!" if we wanted. Useful for testing though.
    function AddFoll(ent, ply)
        ent:SetNWBool("FMOD_ImAfterSomeone", true)
        if ply then
            ent:SetNWString("FMOD_ImFollowing", ply:Nick()..ply:EntIndex())
            ent:SetNWEntity("FMOD_MyTarget", ply)
            ent:SetName(ply:Nick()..ply:EntIndex())
            ent:Fire("stoppatrolling","",0.5)
            ply:SetNWEntity("FMOD_MyFollower", ent)
        end
        ent.FMODanimsTable = table.ToString(ent:GetSequenceList())
        ent:SetCustomCollisionCheck(true)
        -- Jump, Climb, Use things, open doors, open other doors, and can form squads.
        ent:CapabilitiesAdd(2)
        ent:CapabilitiesAdd(8)
        ent:CapabilitiesAdd(256)
        ent:CapabilitiesAdd(1024)
        ent:CapabilitiesAdd(2048)
        ent:CapabilitiesAdd(67108864)
        ent:Fire("setsquad","playersquad_"..ply:Nick()..ply:EntIndex(),0)
        ent:Fire("EnableArmorRecharge","",0)
    end

    -- Removes a Foll.
    function RemFoll(ent, ply)
        ent:SetNWBool("FMOD_ImAfterSomeone", false)
        ent:SetNWString("FMOD_ImFollowing", nil)
        ent:SetName("")
        if ply then
            ply:SetNWEntity("FMOD_MyFollower", nil)
        end
        ent:SetNWEntity("FMOD_MyTarget", nil)
        ent:SetCustomCollisionCheck(false)
        ent:Fire("setsquad","",0)
        ent:Fire("DisableArmorRecharge","",0)
        ent.CollisionBounds = Vector(13,13,72)
        local hull = ent:GetHullType()
        ent:SetSolid(SOLID_BBOX)
        ent:SetPos(ent:GetPos()+ent:GetUp()*6)
        ent:SetHullType(hull)
        ent:SetHullSizeNormal()
        ent:SetCollisionBounds(ent.CollisionBounds,Vector(ent.CollisionBounds.x *-1,ent.CollisionBounds.y *-1,0))
        ent:DropToFloor()
    end

    -- Removes npc's following you when you die.
    hook.Add("PlayerDeath", "FMOD_PlayerDeath", function(ply, weapon, killer)
        if IsValid(ply.gfoll) then SafeRemoveEntity(ply.gfoll) end
        for _,my_npc in pairs(ents.GetAll()) do
            if my_npc and my_npc:IsNPC() and my_npc:GetNWBool("FMOD_ImAfterSomeone") and my_npc:GetNWString("FMOD_ImFollowing") == ply:Nick()..ply:EntIndex() then
                RemFoll(my_npc, ply)
            end
        end
    end)
end