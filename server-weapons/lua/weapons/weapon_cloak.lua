AddCSLuaFile()

SWEP.PrintName = "Cloaking Device"
SWEP.Category = "MVG"
SWEP.Instructions = [[
    Fire to cloak or uncloak.
    Flashlight to immediately uncloak.
]]

SWEP.Spawnable = true 
SWEP.Base = "weapon_base"
SWEP.Slot = 4
SWEP.SlotPos = 99

SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.UseHands = true 

SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 4
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 4
SWEP.Secondary.Automatic = false 

local cloakcooldownwhenhit = 15

local enemy_teams = {
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

function SWEP:Initialize()
end

function SWEP:PrimaryAttack()

    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

    if not IsFirstTimePredicted() then return end

    if self:GetOwner():GetNWBool("CloakPlayerCloaked", false) then

        self:EmitSound("npc/turret_floor/active.wav", 100, 50, 0.4, CHAN_AUTO)
        DecloakPlayer(self:GetOwner(), false)
        

    elseif not self:GetOwner():FlashlightIsOn() then

        self:EmitSound("npc/attack_helicopter/aheli_charge_up.wav", 100, 60, 0.4, CHAN_AUTO)
        CloakPlayer(self:GetOwner())


    else
        
        self:SetNextPrimaryFire(CurTime() + 1)

    end

end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function CloakPlayer(ply)

    if CLIENT then return end

    if ply:FlashlightIsOn() then return end

    ply:SetNWBool("CloakPlayerCloaked", true)

    ply:SetNoDraw(true)

    if ply:IsFlagSet(FL_NOTARGET) then
            
        ply:SetNWBool("AlreadyNotarget", true)

    else
        
        ply:SetNWBool("AlreadyNotarget", false)
        ply:SetNoTarget(true)

    end

end

function DecloakPlayer(ply, bad)

    if CLIENT then return end

    ply:SetNWBool("CloakPlayerCloaked", false)

    ply:SetNoDraw(false)

    if (not ply:GetNWBool("AlreadyNotarget", false)) && not (enemy_teams[ply:Team()]) then

        ply:SetNoTarget(false)

    end

    if bad then
        
        sound.Play("ambient/levels/citadel/portal_beam_shoot6.wav", ply:GetPos(), 125, 255)

    end

end

if SERVER then

    hook.Add("PostPlayerDeath", "playerdeath_cloak_device", function(ply)
    
        if ply:GetNWBool("CloakPlayerCloaked", false) then
            
            DecloakPlayer(ply, false)

        end
    
    end)

    hook.Add("EntityTakeDamage", "playertakedamage_cloak_device", function(ply)
    
        if IsValid(ply) and ply:IsPlayer() and ply:GetNWBool("CloakPlayerCloaked", false) then
            
            DecloakPlayer(ply, true)

            weaponId = ply:GetWeapon("weapon_cloak")

            if weaponId then
                
                weaponId:SetNextPrimaryFire(CurTime() + cloakcooldownwhenhit)

            end

        elseif IsValid(ply) and ply:IsPlayer() and ply:HasWeapon("weapon_cloak") then
            
            weaponId = ply:GetWeapon("weapon_cloak")

            if weaponId then
                
                weaponId:SetNextPrimaryFire(CurTime() + cloakcooldownwhenhit)

            end

        end
    
    end)

    hook.Add("PlayerTick", "player_flashlight_cloak_device", function(ply, mv)
    
        if ply:GetNWBool("CloakPlayerCloaked", false) and ply:FlashlightIsOn() or ply:GetNWBool("CloakPlayerCloakAttack", false) then
            
            DecloakPlayer(ply, true)
            if ply:GetNWBool("CloakPlayerCloakAttack", false) then
                
                ply:SetNWBool("CloakPlayerCloakAttack", false)

            end

        end
    
    end)
    
    hook.Add("EntityFireBullets", "firing_weapon_cloak_device", function(ent)
    
        if IsValid(ent) and ent:IsPlayer() and ent:GetNWBool("CloakPlayerCloaked", false) then
            
            DecloakPlayer(ent, true)
    
        end
    
    end)
    
else
    
    hook.Add("HUDDrawTargetID", "hide_cloaked_player_info", function()
    
        local tr = LocalPlayer():GetEyeTrace().Entity
        
        if IsValid(tr) and tr:IsPlayer() and tr:GetNWBool("CloakPlayerCloaked", false) then
            
            return false

        end
    
    end)

    local w, h = ScrW(), ScrH()

    hook.Add("HUDPaintBackground", "paint_cloak_mode_on_screen", function()
    
        if LocalPlayer():GetNWBool("CloakPlayerCloaked", false) then
            
            surface.SetDrawColor(20, 20, 20, 100)
            surface.DrawRect(0, 0, w, h)
            surface.SetDrawColor(0, 0, 0, 125)
            surface.DrawOutlinedRect(0, 0, w, h, math.floor(math.sin(CurTime() * 1) * 10) + 50)
            surface.DrawOutlinedRect(0, 0, w, h, math.floor(math.sin(CurTime() * 3) * 20) + 20)

        end
    
    end)

end

hook.Add("PlayerFootstep", "silence_cloaked_player_footsteps", function(ply)

    if ply:GetNWBool("CloakPlayerCloaked", false) then
        
        return true

    end

end)