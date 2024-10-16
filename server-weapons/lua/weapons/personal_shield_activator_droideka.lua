AddCSLuaFile()

SWEP.ViewModel = Model( "models/weapons/c_arms_animations.mdl" )
SWEP.WorldModel = ""

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.PrintName	= "Personal Shield Activator (Droideka)"
SWEP.Author = "Fox (Modified)"
SWEP.Category = "[MVG] Miscellaneous Equipment"

SWEP.Slot		= 4
SWEP.SlotPos	= 1

SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.Spawnable		= true
SWEP.AdminOnly		= false

if SERVER then
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

function SWEP:Initialize()
	self:SetHoldType('normal')
	if CLIENT then return end
end



function SWEP:Reload() end

function SWEP:PrimaryAttack()
    if CLIENT then return end
    local ply = self.ShieldOwner
    local shield = ply:GetNWEntity('PShield')

    if IsValid(shield) then
        if !shield:GetActive() and !shield:GetDamaged() then
            shield:ToggleShield(true)
        elseif !IsValid(shield) then
            local newShield = ents.Create('personal_shield_droideka')
            newShield:Spawn()
            newShield:Initialize(ply)
        end
    else
        local newShield = ents.Create('personal_shield_droideka')
        newShield:Spawn()
        newShield:Initialize(ply)
    end
end

function SWEP:SecondaryAttack()
	if CLIENT then return end
	local ply = self.ShieldOwner
	local shield = ply:GetNWEntity('PShield')
	if IsValid(shield) and shield:GetActive() then
		shield:ToggleShield(false)
	end
end

function SWEP:Deploy() return true end

function SWEP:Equip(ent)
	self.ShieldOwner = ent
end

function SWEP:ShouldDropOnDie() return false end

function SWEP:OnRemove()
	if CLIENT then return end
	local ply = self.ShieldOwner
	local shield = ply:GetNWEntity('PShield')
	if IsValid(shield) then
		shield.SoundLoop:Stop()
		shield:Remove()
	end
end

function SWEP:OnDrop()
	if CLIENT then return end
	local ply = self.ShieldOwner
	local shield = ply:GetNWEntity('PShield')
	if IsValid(shield) then
		shield.SoundLoop:Stop()
		shield:Remove()
		self:Remove()
	end
end


if SERVER then return end

--function SWEP:DrawHUD() end
--function SWEP:PrintWeaponInfo( x, y, alpha ) end

--function SWEP:HUDShouldDraw( name )
	--if ( name == "CHudWeaponSelection" ) then return true end
	--if ( name == "CHudChat" ) then return true end
	--return false
--end