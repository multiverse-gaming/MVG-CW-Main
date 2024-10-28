util.AddNetworkString("OfficerBoost.DrawHUD")
local enemy_teams = {}
timer.Simple(120, function() -- We wait 2 minutes to let darkRP create it's jobs. 
    enemy_teams = {
        [TEAM_BATTLEDROID] = true,
        [TEAM_CQBATTLEDROID] = true,
        [TEAM_ROCKETDROID] = true,
        [TEAM_HEAVYBATTLEDROID] = true,
        [TEAM_RECONBATTLEDROID] = true,
        [TEAM_ENGINEERDROID] = true,
        [TEAM_MEDICALDROID] = true,
        [TEAM_COMMANDERDROID] = true,
        [TEAM_SITH] = true,

        [TEAM_SUPERBATTLEDROID] = true,
        [TEAM_SUPERJUMPDROID] = true,
        [TEAM_DROIDEKA] = true,
        [TEAM_MAGNAGUARD] = true,
        [TEAM_TACTICALDROID] = true,
        [TEAM_TANKERDROID] = true,
        [TEAM_SNIPERDROID] = true,
        [TEAM_TECHNICALDROID] = true,
        [TEAM_BOUNTYHUNTERREINFORCE] = true,

        [TEAM_BXCOMMANDODROID] = true,
        [TEAM_BXASSASSINDROID] = true,
        [TEAM_BXSLUGDROID] = true,
        [TEAM_BXSPLICERDROID] = true,
        [TEAM_BXRECONDROID] = true,
        [TEAM_BXHEAVYDROID] = true,
        [TEAM_BXCOMMANDERDROID] = true,

        [TEAM_UMBARANTROOPER] = true,
        [TEAM_UMBARANHEAVYTROOPER] = true,
        [TEAM_UMBARANSNIPER] = true,
        [TEAM_UMBARANENGINEER] = true,
        [TEAM_UMBARANOFFICER] = true,

        [TEAM_PRISONER] = true,
        [TEAM_UNDEAD] = true,
        [TEAM_CUSTOMENEMY] = true,
        [TEAM_COUNTDOOKU] = true,
        [TEAM_ASAJJVENTRESS] = true,
        [TEAM_DARTHMAUL] = true,
        [TEAM_GENERALGRIEVOUS] = true,
        [TEAM_SAVAGEOPRESS] = true,
        [TEAM_PREVISZLA] = true,
        [TEAM_CADBANE] = true,
        [TEAM_HONDO] = true,
        [TEAM_BOSK] = true,
        [TEAM_DURGE] = true
    }
end)

function OfficerBoost:CreateBoost(ply, type)
    local entities = player.FindInSphere(ply:GetPos(), OfficerBoost.Config[type].Radius)

    for key, ent in pairs(entities) do
        if not IsValid(ent) then continue end
        if not ent:IsPlayer() then continue end
        if ent:GetNWBool("OfficerBoost.Boosted", false) then continue end -- Checks whether the player is already boosted

        -- If Last Stand (the one only enemies have), apply to enemy teams. If not, apply only to friendlies.
        if (type == "LastStand") then
            if (!enemy_teams[ent:Team()]) then continue end
        else
            if (enemy_teams[ent:Team()]) then continue end
        end

        ent:SetNWBool("OfficerBoost.Boosted", true)

        hook.Run("OfficerBoost.OnBoost."..type, ent, ply)

        if (type != "501st") then
            net.Start("OfficerBoost.DrawHUD")
                net.WriteString(ply:SteamID64())
                net.WriteString(type)
            net.Send(ent)
        end
    end
end

hook.Add("PlayerSpawn", "OfficerBoost.ResetValues", function(ply)
    if ply:GetNWBool("OfficerBoost.Boosted", false) then
        if (ply.OBWalkSpeed) then ply:SetWalkSpeed(ply.OBWalkSpeed) end
        if (ply.OBRunSpeed) then ply:SetWalkSpeed(ply.OBRunSpeed) end
        if (ply.OBJumpPower) then ply:SetWalkSpeed(ply.OBJumpPower) end

        ply:SetNWBool("OfficerBoost.Boosted", false)
        --[[if (ply:GetNWString("OfficerBoost.Type", nil)) then
            ply:SetNWString("OfficerBoost.Type", nil)
        end]]-- This is being preserved in the hope that we find a Vampiric Ammo type of attachment
    end
end)

hook.Add("OfficerBoost.OnBoost.Normal", "NormalBoost", function(ply, creator)
    local data = OfficerBoost.Config["Normal"]
    --ply:SetNWString("OfficerBoost.Type", "Normal") -- Only used by BattleFocus

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
    end)
end)

hook.Add( "OfficerBoost.OnBoost.BattleFocus", "BattleFocusBoost", function(ply, creator)
    local data = OfficerBoost.Config["BattleFocus"]
    --ply:SetNWString("OfficerBoost.Type", "BattleFocus") -- Preserved as above.

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
        --ply:SetNWString("OfficerBoost.Type", nil)
        ply:SetNWBool("OfficerBoost.Boosted", false)

        ply:SetWalkSpeed(ply.OBWalkSpeed)
        ply:SetRunSpeed(ply.OBRunSpeed)
        ply:SetJumpPower(ply.OBJumpPower)
    end)
end)

hook.Add("OfficerBoost.OnBoost.LastStand", "LastStandBoost", function(ply, creator)
    local data = OfficerBoost.Config["LastStand"]
    --ply:SetNWString("OfficerBoost.Type", "LastStand")

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

hook.Add("OfficerBoost.OnBoost.501st", "LastStandBoost501st", function(ply, creator)
    if (!IsValid(ply) || ply:getJobTable().category != "501st Legion") then return end

    local data = OfficerBoost.Config["501st"]
    --ply:SetNWString("OfficerBoost.Type", "501st") -- Only used by BattleFocus

    ply.OBWalkSpeed = ply:GetWalkSpeed()
    ply.OBRunSpeed = ply:GetRunSpeed()
    ply.OBLSArmor = ply:Armor()

    local speedBoost = ply:GetWalkSpeed() * data.SpeedBoost

    ply:SetWalkSpeed(speedBoost)
    ply:SetRunSpeed(speedBoost * 1.5)
    ply:SetArmor(ply:Armor() + data.AdditionalArmor)

    timer.Create("OfficerBoost"..ply:SteamID64(), data.Duration, 1, function()
        if not ply:GetNWBool("OfficerBoost.Boosted", false) then return end

        ply:SetNWBool("OfficerBoost.Boosted", false)

        if ply:HasPowerArmor() then
            ply:SetRunSpeed(GAMEMODE.Config.walkspeed * 0.35)
            ply:SetWalkSpeed(GAMEMODE.Config.walkspeed * 0.35)
        else
            ply:SetWalkSpeed(ply.OBWalkSpeed)
            ply:SetRunSpeed(ply.OBRunSpeed)
            ply.OBWalkSpeed = nil
            ply.OBRunSpeed = nil
        end

        if ply:Armor() > ply.OBLSArmor then
            ply:SetArmor(ply.OBLSArmor)
        end
    end)
end)