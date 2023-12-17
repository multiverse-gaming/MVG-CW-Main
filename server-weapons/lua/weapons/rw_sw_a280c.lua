SWEP.Gun							= ("gun_base")
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Base							= "tfa_3dscoped_base"
SWEP.Category						= "TFA StarWars Wolfpack Weapon Pack"
SWEP.Manufacturer 					= ""
SWEP.Author							= "ChanceSphere574"
SWEP.Contact						= ""
SWEP.Spawnable						= true
SWEP.AdminSpawnable					= true
SWEP.DrawCrosshair					= true
SWEP.DrawCrosshairIS 				= false
SWEP.PrintName						= "DC-15BR"
SWEP.Type							= "Wolfpack Blaster Rifle"
SWEP.DrawAmmo						= true
SWEP.data 							= {}
SWEP.data.ironsights				= 1
SWEP.Secondary.IronFOV				= 75
SWEP.Slot							= 2
SWEP.SlotPos						= 100

SWEP.FiresUnderwater 				= true

SWEP.IronInSound 					= nil
SWEP.IronOutSound 					= nil
SWEP.CanBeSilenced					= false
SWEP.Silenced 						= false
SWEP.DoMuzzleFlash 					= false
SWEP.SelectiveFire					= true
SWEP.DisableBurstFire				= false
SWEP.OnlyBurstFire					= true
SWEP.DefaultFireMode 				= "3Burst"
SWEP.FireModeName 					= nil
SWEP.DisableChambering 				= true

SWEP.Primary.ClipSize				= 24
SWEP.Primary.DefaultClip			= 24*20
SWEP.Primary.RPM					= 1200
SWEP.Primary.RPM_Burst				= 1200
SWEP.Primary.Ammo					= "ar2"
SWEP.Primary.AmmoConsumption 		= 1
SWEP.Primary.Range 					= 40000
SWEP.Primary.RangeFalloff 			= -1
SWEP.Primary.NumShots				= 1
SWEP.Primary.Automatic				= true
SWEP.Primary.RPM_Semi				= nil
SWEP.Primary.BurstDelay				= 0.6
-- SWEP.Primary.Sound 					= Sound ("w/a280.wav");
-- SWEP.Primary.ReloadSound 			= Sound ("w/rifles.wav");
SWEP.Primary.Sound 					= Sound ("w/dc15a.wav");
SWEP.Primary.ReloadSound 			= Sound ("w/heavy.wav");
SWEP.Primary.PenetrationMultiplier 	= 0
SWEP.Primary.Damage					= 30
SWEP.Primary.HullSize 				= 0
SWEP.DamageType 					= nil

SWEP.DoMuzzleFlash 					= false

SWEP.FireModes = {
	"3Burst"
}


SWEP.IronRecoilMultiplier			= 0.65
SWEP.CrouchRecoilMultiplier			= 0.85
SWEP.JumpRecoilMultiplier			= 2
SWEP.WallRecoilMultiplier			= 1.1
SWEP.ChangeStateRecoilMultiplier	= 1.2
SWEP.CrouchAccuracyMultiplier		= 0.5
SWEP.ChangeStateAccuracyMultiplier	= 1
SWEP.JumpAccuracyMultiplier			= 2
SWEP.WalkAccuracyMultiplier			= 2
SWEP.NearWallTime 					= 0.5
SWEP.ToCrouchTime 					= 0.25
SWEP.WeaponLength 					= 35
SWEP.SprintFOVOffset 				= 12
SWEP.ProjectileVelocity 			= 9

SWEP.ProjectileEntity 				= nil
SWEP.ProjectileModel 				= nil

-- SWEP.ViewModel						= "models/weapons/synbf3/c_e11.mdl"
-- SWEP.WorldModel						= "models/weapons/synbf3/w_e11.mdl"
-- SWEP.ViewModelFOV					= 70
-- SWEP.ViewModelFlip					= false
-- SWEP.MaterialTable 					= nil
-- SWEP.UseHands 						= true
-- SWEP.HoldType 						= "ar2"
-- SWEP.ReloadHoldTypeOverride 		= "ar2"
SWEP.ViewModel						= "models/weapons/synbf3/c_dlt19.mdl"
SWEP.WorldModel						= "models/weapons/synbf3/w_dlt19.mdl"
SWEP.ViewModelFOV					= 70
SWEP.ViewModelFlip					= false
SWEP.MaterialTable 					= nil
SWEP.UseHands 						= true
SWEP.HoldType 						= "ar2"

SWEP.ShowWorldModel = false

SWEP.BlowbackEnabled 				= true
SWEP.BlowbackVector 				= Vector(0,-1.5,0)
SWEP.BlowbackCurrentRoot			= 0
SWEP.BlowbackCurrent 				= 0
SWEP.BlowbackBoneMods 				= nil
SWEP.Blowback_Only_Iron 			= true
SWEP.Blowback_PistolMode 			= false
SWEP.Blowback_Shell_Enabled 		= false
SWEP.Blowback_Shell_Effect 			= "None"

SWEP.Tracer							= 0
SWEP.TracerName 					= "rw_sw_laser_blue"
SWEP.TracerCount 					= 1
SWEP.TracerLua 						= false
SWEP.TracerDelay					= 0.01
SWEP.ImpactEffect 					= "rw_sw_impact_blue"
SWEP.ImpactDecal 					= "FadingScorch"

SWEP.VMPos = Vector(01, -6, -4)
SWEP.VMAng = Vector(0, 0, 0)

SWEP.IronSightTime 					= 0.4
SWEP.Primary.KickUp					= 0.12
SWEP.Primary.KickDown				= 0.09
SWEP.Primary.KickHorizontal			= 0.055
SWEP.Primary.StaticRecoilFactor 	= 0.65
SWEP.Primary.Spread					= 0.0201
SWEP.Primary.IronAccuracy 			= 0.002
SWEP.Primary.SpreadMultiplierMax 	= 1.5
SWEP.Primary.SpreadIncrement 		= 0.35
SWEP.Primary.SpreadRecovery 		= 0.98
SWEP.DisableChambering 				= true
SWEP.MoveSpeed 						= 1
SWEP.IronSightsMoveSpeed 			= 0.85

SWEP.IronSightsPos = Vector(-4.6, -8.5, 2.35)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(5.226, -2, -1.5)
SWEP.RunSightsAng = Vector(-18, 36, -13.5)
-- SWEP.InspectPos = Vector(8, -4.8, -3)
-- SWEP.InspectAng = Vector(11.199, 38, 0)

-- SWEP.ViewModelBoneMods = {
-- 	["v_e11_reference001"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
-- }

-- SWEP.VElements = {
-- 	["a280c"] = { type = "Model", model = "models/sw_battlefront/weapons/a280_rifle.mdl", bone = "v_e11_reference001", rel = "", pos = Vector(-0.75, -5, -1), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1, [2] = 1, [3] = 0} },
-- 	["scope"] = { type = "Model", model = "models/rtcircle.mdl", bone = "v_e11_reference001", rel = "a280c", pos = Vector(6.2, -0.04, 5.36), angle = Angle(0, 180, 0), size = Vector(0.30, 0.30, 0.30), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {} }
-- }

-- SWEP.WElements = {
-- 	["a280c"] = { type = "Model", model = "models/sw_battlefront/weapons/a280_rifle.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2, 0.4, 0.5), angle = Angle(-13, 0, 180), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1, [2] = 1, [3] = 0} },
-- }

SWEP.InspectPos = Vector(8, -4.8, -3)
SWEP.InspectAng = Vector(11.199, 38, 0)

SWEP.ViewModelBoneMods = {
	["v_dlt19_reference001"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["dc15le"] = { type = "Model", model = "models/sw_battlefront/weapons/dc15a_rifle.mdl", bone = "v_dlt19_reference001", rel = "", pos = Vector(0.75, -1.5, 2.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 0, [2] = 0, [3] = 1} },
	["scope"] = { type = "Model", model = "models/rtcircle.mdl", bone = "v_dlt19_reference001", rel = "dc15le", pos = Vector(8, 2.075, 3.38), angle = Angle(0, 180, 0), size = Vector(0.245, 0.245, 0.245), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["dc15le"] = { type = "Model", model = "models/sw_battlefront/weapons/dc15a_rifle.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 0.4, -2), angle = Angle(-13, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 0, [2] = 0, [3] = 1} },
}

SWEP.ThirdPersonReloadDisable		=false
SWEP.Primary.DamageType 			= DMG_BULLET
SWEP.DamageType 					= DMG_BULLET
SWEP.RTScopeAttachment				= -1
SWEP.Scoped_3D 						= false
SWEP.ScopeReticule 					= "#sw/visor/sw_ret_redux_blue"
SWEP.Secondary.ScopeZoom 			= 7
SWEP.ScopeReticule_Scale 			= {1.13,1.13}
if surface then
	SWEP.Secondary.ScopeTable = nil --[[
		{
			scopetex = surface.GetTextureID("scope/gdcw_closedsight"),
			reticletex = surface.GetTextureID("scope/gdcw_acogchevron"),
			dottex = surface.GetTextureID("scope/gdcw_acogcross")
		}
	]]--
end
DEFINE_BASECLASS( SWEP.Base )
