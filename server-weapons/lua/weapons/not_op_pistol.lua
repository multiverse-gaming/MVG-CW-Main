if ( SERVER ) then

	AddCSLuaFile( "not_op_pistol.lua" )

end



if ( CLIENT ) then

	SWEP.PrintName			= "Old Righteous"

	SWEP.Author				= "Miklus"

	SWEP.ViewModelFOV      	= 50

	SWEP.Slot				= 2

	SWEP.SlotPos			= 3

end



SWEP.Base					= "tfa_swsft_base_servius"



SWEP.Category = "MVG"



SWEP.Spawnable				= true

SWEP.AdminSpawnable			= true



SWEP.HoldType = "pistol"

SWEP.ViewModelFOV = 56

SWEP.ViewModelFlip = true

SWEP.ViewModel = "models/weapons/v_357.mdl"

SWEP.WorldModel = "models/weapons/w_357.mdl"

SWEP.ShowViewModel = true

SWEP.ShowWorldModel = true

SWEP.UseHands = true



SWEP.Primary.Sound = Sound ("Weapon_357.Single");

SWEP.Primary.ReloadSound = Sound ("Weapon_Pistol.Empty");



SWEP.Primary.KickUp			= 0.8



SWEP.Weight					= 5

SWEP.AutoSwitchTo			= false

SWEP.AutoSwitchFrom			= false



SWEP.Primary.Recoil			= 0.2

SWEP.Primary.Damage			= 2000000

SWEP.Primary.NumShots		= 1

SWEP.Primary.Spread			= 0.0125

SWEP.Primary.IronAccuracy = .001	-- Ironsight accuracy, should be the same for shotguns

SWEP.Primary.ClipSize		= 15

SWEP.Primary.RPM = 200

SWEP.Primary.DefaultClip	= 50

SWEP.Primary.Automatic		= false

SWEP.Primary.Ammo			= "ar2"

SWEP.TracerName = "effect_sw_laser_red"



SWEP.SelectiveFire		= false --Allow selecting your firemode?

SWEP.DisableBurstFire	= false --Only auto/single?

SWEP.OnlyBurstFire		= false --No auto, only burst/single?

SWEP.DefaultFireMode 	= "" --Default to auto or whatev

SWEP.FireModeName = nil --Change to a text value to override it



SWEP.Secondary.Automatic	= false

SWEP.Secondary.Ammo			= "none"



SWEP.Secondary.IronFOV = 90



SWEP.IronSightsPos = Vector(-5.65, -2, 2.4)



SWEP.IronSightsAng = Vector(0, 0, 0)



SWEP.BlowbackVector = Vector(0, 0,0)

SWEP.Blowback_Only_Iron  = true



SWEP.Primary.Knockback = 1000



SWEP.DoProceduralReload = true

SWEP.ProceduralReloadTime = 1