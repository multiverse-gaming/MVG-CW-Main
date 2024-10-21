if (SERVER) then

	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

if ( CLIENT ) then
	SWEP.PrintName			= "Shock Vibro Knife"
	SWEP.DrawAmmo 			= false
	SWEP.DrawCrosshair 		= false
	SWEP.ViewModelFOV		= 55
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
	SWEP.UseHands			= true
	
	SWEP.Slot				= 2
	SWEP.SlotPos			= 2
	--SWEP.IconLetter			= "j"

	--killicon.AddFont("weapon_knife", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ))
	--surface.CreateFont("CSKillIcons", {font = "csd", size = ScreenScale(30), weight = 500, antialias = true, additive = true})
	--surface.CreateFont("CSSelectIcons", {font = "csd", size = ScreenScale(60), weight = 500, antialias = true, additive = true})
end

SWEP.Base = "baseknife"

SWEP.IconOverride = "materials/entities/base.png"

SWEP.Category			= "[MVG] Vibro Knives"


SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.ViewModel 			= "models/weapons/Shock_knife/Shock_knife_t.mdl"
SWEP.WorldModel 		= "models/weapons/Shock_knife/Shock_knife_v.mdl" 

SWEP.DrawWeaponInfoBox  	= false

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false