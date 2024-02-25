util.AddNetworkString("OfficerBoost.DrawHUD")

function OfficerBoost:CreateBoost(ply, type)
    local data = OfficerBoost.Config[type]

    local entities = player.FindInSphere(ply:GetPos(), data.Radius)

    for key, ent in pairs(entities) do
        if not IsValid(ent) then continue end
        if not ent:IsPlayer() then continue end
        if ent:GetNWBool("OfficerBoost.Boosted", false) then continue end -- Checks whether the player is already boosted

        ent:SetNWBool("OfficerBoost.Boosted", true)

        hook.Run("OfficerBoost.OnBoost", ent, type, ply)

        net.Start("OfficerBoost.DrawHUD")
        net.WriteString(ply:SteamID64())
        net.WriteString(type)
        net.Send(ent)
    end
end

hook.Add("PlayerSpawn", "OfficerBoost.ResetValues", function(ply)
    if ply:GetNWBool("OfficerBoost.Boosted", false) then
        ply:SetWalkSpeed(ply.OBWalkSpeed)
        ply:SetRunSpeed(ply.OBRunSpeed)
        ply:SetJumpPower(ply.OBJumpPower)

        ply:SetNWBool("OfficerBoost.Boosted", false)
    end
end)

hook.Add("OfficerBoost.OnBoost", "NormalBoost", function(ply, type, creator)

    if type != "Normal" then return end

    local data = OfficerBoost.Config[type]
    ply:SetNWString("OfficerBoost.Type", type)

    ply.OBWalkSpeed = ply:GetWalkSpeed()
    ply.OBRunSpeed = ply:GetRunSpeed()
    ply.OBJumpPower = ply:GetJumpPower()
    ply.OBLSHealth = ply:Health()

    local speedBoost = ply:GetWalkSpeed() * data.SpeedBoost

    ply:SetWalkSpeed(speedBoost)
    ply:SetRunSpeed(speedBoost * 1.5)
    ply:SetJumpPower(ply:GetJumpPower() * data.JumpBoost)

    ply:SetHealth(ply:Health() + data.AdditionalHealth)


    timer.Create("OfficerBoost"..ply:SteamID64(), data.Duration, 1, function()
        if not ply:GetNWBool("OfficerBoost.Boosted", false) then return end

        ply:SetNWBool("OfficerBoost.Boosted", false)

        ply:SetWalkSpeed(ply.OBWalkSpeed)
        ply:SetRunSpeed(ply.OBRunSpeed)
        ply:SetJumpPower(ply.OBJumpPower)

        if ply:Health() > ply.OBLSHealth then
            ply:SetHealth(ply.OBLSHealth)
        end

        --[[
        if IsValid(wep) then
            wep.Primary_TFA.RPM = wep.Defaults.RPM
            wep:ClearStatCache("Primary.RPM")
        end
        ]]


    end)
end)

hook.Add("OfficerBoost.OnBoost", "LastStandBoost", function(ply, type, creator)

    if type != "LastStand" then return end

    local data = OfficerBoost.Config[type]
    ply:SetNWString("OfficerBoost.Type", type)

    ply.OBWalkSpeed = ply:GetWalkSpeed()
    ply.OBRunSpeed = ply:GetRunSpeed()
    ply.OBJumpPower = ply:GetJumpPower()
    ply.OBLSArmor = ply:Armor()
    ply.OBLSHealth = ply:Health()

    local speedBoost = ply:GetWalkSpeed() * data.SpeedBoost

    ply:SetWalkSpeed(speedBoost)
    ply:SetRunSpeed(speedBoost * 1.5)
    ply:SetJumpPower(ply:GetJumpPower() * data.JumpBoost)

    ply:SetHealth(ply:Health() + data.AdditionalHealth)
    ply:SetArmor(ply:Armor() + data.AdditionalArmor)

    timer.Create("OfficerBoost"..ply:SteamID64(), data.Duration, 1, function()
        if not ply:GetNWBool("OfficerBoost.Boosted", false) then return end

        ply:SetNWBool("OfficerBoost.Boosted", false)

        ply:SetWalkSpeed(ply.OBWalkSpeed)
        ply:SetRunSpeed(ply.OBRunSpeed)
        ply:SetJumpPower(ply.OBJumpPower)

        if ply:Armor() > ply.OBLSArmor then
            ply:SetArmor(ply.OBLSArmor)
        end

        if ply:Health() > ply.OBLSHealth then
            ply:SetHealth(ply.OBLSHealth)
        end
    end)
end)

hook.Add("OfficerBoost.OnBoost", "LastStandBoost501st", function(ply, type, creator)

    if type != "501st" then return end

    local data = OfficerBoost.Config[type]
    ply:SetNWString("OfficerBoost.Type", type)

    ply.OBWalkSpeed = ply:GetWalkSpeed()
    ply.OBRunSpeed = ply:GetRunSpeed()
    ply.OBJumpPower = ply:GetJumpPower()
    ply.OBLSArmor = ply:Armor()
    ply.OBLSHealth = ply:Health()

    local speedBoost = ply:GetWalkSpeed() * data.SpeedBoost

    ply:SetWalkSpeed(speedBoost)
    ply:SetRunSpeed(speedBoost * 1.5)
    ply:SetJumpPower(ply:GetJumpPower() * data.JumpBoost)

    ply:SetHealth(ply:Health() + data.AdditionalHealth)
    ply:SetArmor(ply:Armor() + data.AdditionalArmor)

    timer.Create("OfficerBoost"..ply:SteamID64(), data.Duration, 1, function()
        if not ply:GetNWBool("OfficerBoost.Boosted", false) then return end
    
        ply:SetNWBool("OfficerBoost.Boosted", false)

        if ply:HasPowerArmor() then
            ply:SetRunSpeed(GAMEMODE.Config.walkspeed * 0.35)
            ply:SetWalkSpeed(GAMEMODE.Config.walkspeed * 0.35)
            ply:SetJumpPower(140)
        else
            ply:SetWalkSpeed(ply.OBWalkSpeed)
            ply:SetRunSpeed(ply.OBRunSpeed)
            ply:SetJumpPower(ply.OBJumpPower)
        end

        if ply:Armor() > ply.OBLSArmor then
            ply:SetArmor(ply.OBLSArmor)
        end

        if ply:Health() > ply.OBLSHealth then
            ply:SetHealth(ply.OBLSHealth)
        end
    end)
end)

util.AddNetworkString("OfficerBoost.DrawHUD")



function OfficerBoost:CreateBoost(ply, type)
    local data = OfficerBoost.Config[type]

    local entities = player.FindInSphere(ply:GetPos(), data.Radius)

    for key, ent in pairs(entities) do
        if not IsValid(ent) then continue end
        if not ent:IsPlayer() then continue end
        if ent:GetNWBool("OfficerBoost.Boosted", false) then continue end -- Checks whether the player is already boosted

        ent:SetNWBool("OfficerBoost.Boosted", true)

        hook.Run("OfficerBoost.OnBoost", ent, type, ply)

        net.Start("OfficerBoost.DrawHUD")
        net.WriteString(ply:SteamID64())
        net.WriteString(type)
        net.Send(ent)
    end
end

hook.Add("PlayerSpawn", "OfficerBoost.ResetValues", function(ply)
    if ply:GetNWBool("OfficerBoost.Boosted", false) then
        ply:SetWalkSpeed(ply.OBWalkSpeed)
        ply:SetRunSpeed(ply.OBRunSpeed)
        ply:SetJumpPower(ply.OBJumpPower)

        ply:SetNWBool("OfficerBoost.Boosted", false)
    end
end)

hook.Add("OfficerBoost.OnBoost", "NormalBoost", function(ply, type, creator)

    if type != "Normal" then return end

    local data = OfficerBoost.Config[type]
    ply:SetNWString("OfficerBoost.Type", type)

    ply.OBWalkSpeed = ply:GetWalkSpeed()
    ply.OBRunSpeed = ply:GetRunSpeed()
    ply.OBJumpPower = ply:GetJumpPower()
    ply.OBLSHealth = ply:Health()

    local speedBoost = ply:GetWalkSpeed() * data.SpeedBoost

    ply:SetWalkSpeed(speedBoost)
    ply:SetRunSpeed(speedBoost * 1.5)
    ply:SetJumpPower(ply:GetJumpPower() * data.JumpBoost)

    ply:SetHealth(ply:Health() + data.AdditionalHealth)

    local wep = ply:GetActiveWeapon()
    timer.Simple(0.5, function()
        if wep.Primary_TFA then
            wep.Defaults = {}
            wep.Defaults.RPM = wep.Primary_TFA.RPM
            wep.Primary_TFA.RPM = wep.Primary_TFA.RPM * data.RPMBoost
            wep:ClearStatCache("Primary.RPM")
        else
            wep = nil
        end
    end)

    timer.Create("OfficerBoost"..ply:SteamID64(), data.Duration, 1, function()
        if not ply:GetNWBool("OfficerBoost.Boosted", false) then return end

        ply:SetNWBool("OfficerBoost.Boosted", false)

        ply:SetWalkSpeed(ply.OBWalkSpeed)
        ply:SetRunSpeed(ply.OBRunSpeed)
        ply:SetJumpPower(ply.OBJumpPower)

        if ply:Health() > ply.OBLSHealth then
            ply:SetHealth(ply.OBLSHealth)
        end

        if IsValid(wep) then
            wep.Primary_TFA.RPM = wep.Defaults.RPM
            wep:ClearStatCache("Primary.RPM")
        end
    end)
end)

hook.Add("OfficerBoost.OnBoost", "LastStandBoost", function(ply, type, creator)

    if type != "LastStand" then return end

    local data = OfficerBoost.Config[type]
    ply:SetNWString("OfficerBoost.Type", type)

    ply.OBWalkSpeed = ply:GetWalkSpeed()
    ply.OBRunSpeed = ply:GetRunSpeed()
    ply.OBJumpPower = ply:GetJumpPower()
    ply.OBLSArmor = ply:Armor()
    ply.OBLSHealth = ply:Health()

    local speedBoost = ply:GetWalkSpeed() * data.SpeedBoost

    ply:SetWalkSpeed(speedBoost)
    ply:SetRunSpeed(speedBoost * 1.5)
    ply:SetJumpPower(ply:GetJumpPower() * data.JumpBoost)

    ply:SetHealth(ply:Health() + data.AdditionalHealth)
    ply:SetArmor(ply:Armor() + data.AdditionalArmor)

    timer.Create("OfficerBoost"..ply:SteamID64(), data.Duration, 1, function()
        if not ply:GetNWBool("OfficerBoost.Boosted", false) then return end

        ply:SetNWBool("OfficerBoost.Boosted", false)

        ply:SetWalkSpeed(ply.OBWalkSpeed)
        ply:SetRunSpeed(ply.OBRunSpeed)
        ply:SetJumpPower(ply.OBJumpPower)

        if ply:Armor() > ply.OBLSArmor then
            ply:SetArmor(ply.OBLSArmor)
        end

        if ply:Health() > ply.OBLSHealth then
            ply:SetHealth(ply.OBLSHealth)
        end
    end)
end)

hook.Add( "OfficerBoost.OnBoost", "BattleFocusBoost", function(ply, type, creator)
	if type ~= "BattleFocus" then return end

    local data = OfficerBoost.Config[type]
    ply:SetNWString("OfficerBoost.Type", type)

    ply.OBWalkSpeed = ply:GetWalkSpeed()
    ply.OBRunSpeed = ply:GetRunSpeed()
    ply.OBJumpPower = ply:GetJumpPower()
    ply.OBLSArmor = ply:Armor()
    ply.OBLSHealth = ply:Health()

    local speedBoost = ply:GetWalkSpeed() * data.SpeedBoost

    ply:SetWalkSpeed(speedBoost)
    ply:SetRunSpeed(speedBoost)
    ply:SetJumpPower(ply:GetJumpPower() * data.JumpBoost)

    ply:SetHealth(ply:Health() + data.AdditionalHealth)
    ply:SetArmor(math.min(ply:Armor() + data.AdditionalArmor, 150)) -- Cap Armour Gain

    timer.Create("OfficerBoost"..ply:SteamID64(), data.Duration, 1, function()
        if not ply:GetNWBool("OfficerBoost.Boosted", false) then return end

        ply:SetNWBool("OfficerBoost.Boosted", false)

        ply:SetWalkSpeed(ply.OBWalkSpeed)
        ply:SetRunSpeed(ply.OBRunSpeed)
        ply:SetJumpPower(ply.OBJumpPower)
    end)
end )

hook.Add("EntityTakeDamage", "EntityTookDamage", function(target, dmgInfo)
    local attacker = dmgInfo:GetAttacker()

    if IsValid(attacker) and (attacker:IsPlayer() or attacker:IsNPC()) then
        if attacker:GetNWBool("OfficerBoost.Boosted", false) then
            local targetClass = target:GetClass()

            if target:IsPlayer() or target:IsNPC() then
                local boostType = attacker:GetNWString("OfficerBoost.Type", "")
                if boostType == "BattleFocus" then
                    attacker:SetHealth(attacker:Health() + 10)
                    if attacker:Health() > 1000 then
                        attacker:SetHealth(995)
                    end
                    return
                end
            end
        end
    end
end)

