if ( SERVER ) then
	AddCSLuaFile( "sw_datapad.lua" )
	SWEP.HoldType = "slam"
end

SWEP.PrintName = "Datapad"
SWEP.Author = "Goldermor"
SWEP.Contact = ""
SWEP.Purpose = "Datapad"
SWEP.Instructions = "Datapad"
SWEP.Slot = 1
SWEP.SlotPos = 5
SWEP.DrawAmmo = false					 


SWEP.Category = "MVG - Engineering Gear"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 50
SWEP.ViewModel = "models/joes/c_datapad.mdl" 
SWEP.WorldModel = "models/joes/w_datapad.mdl"
SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false

SWEP.UseHands = true

SWEP.HoldType = "slam" 

SWEP.FiresUnderwater = true

SWEP.DrawCrosshair = true

SWEP.DrawAmmo = false

SWEP.Base = "weapon_base"

SWEP.Primary.Damage = 0
SWEP.Primary.ClipSize = -1 
SWEP.Primary.Delay = 0
SWEP.Primary.DefaultClip = -1 
SWEP.Primary.Automatic = false 
SWEP.Primary.Ammo = "none" 

SWEP.Secondary.ClipSize = -1 
SWEP.Secondary.DefaultClip = -1 
SWEP.Secondary.Damage = 0 
SWEP.Secondary.Automatic = false 	 
SWEP.Secondary.Ammo = "none" 

function SWEP:Initialize() 
    self:SetWeaponHoldType( "slam" )
end 

function SWEP:PrimaryAttack()
	if not SERVER then return end

	net.Start("RDV_DATAPAD_MenuOpen")
	net.Send(self.Owner)

	self:SetNextPrimaryFire(CurTime() + 1)

	return true
end
