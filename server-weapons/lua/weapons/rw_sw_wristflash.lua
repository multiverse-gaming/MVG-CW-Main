SWEP.Gun							= ("gun_base")
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Base							= "tfa_gun_base"
SWEP.Category						= "TFA StarWars Reworked WristWeapons"
SWEP.Manufacturer 					= "ShadowHawk.inc"
SWEP.Author							= "Monki"
SWEP.Contact						= ""
SWEP.Spawnable						= true
SWEP.AdminSpawnable					= true
SWEP.DrawCrosshair					= true
SWEP.DrawCrosshairIS 				= false
SWEP.PrintName						= "Concussion Rocket"
SWEP.Type							= "Shadowhawks tactical wristmounted flashbang launcher"
SWEP.DrawAmmo						= true
SWEP.data 							= {}
SWEP.data.ironsights				= 0
SWEP.Secondary.IronFOV				= 78
SWEP.Slot							= 2
SWEP.SlotPos						= 2
 
SWEP.FiresUnderwater 				= true
 
SWEP.IronInSound 					= nil
SWEP.IronOutSound 					= nil
SWEP.CanBeSilenced					= false
SWEP.Silenced 						= false
SWEP.SelectiveFire					= false
SWEP.DisableBurstFire				= false
SWEP.OnlyBurstFire					= false
SWEP.DefaultFireMode 				= "Single"
SWEP.FireModeName 					= nil
SWEP.DisableChambering 				= true
 
SWEP.Primary.ClipSize				= 2
SWEP.Primary.DefaultClip			= 6
SWEP.Primary.RPM					= 40
SWEP.Primary.RPM_Burst				= 40
SWEP.Primary.RPM_Semi				= 40
SWEP.Primary.Round 					= ("monki_flash")
SWEP.Primary.AmmoConsumption 		= 1
SWEP.Primary.Range 					= 32000
SWEP.Primary.RangeFalloff 			= 0
SWEP.Primary.NumShots				= 1
SWEP.Primary.Automatic				= true
SWEP.Primary.BurstDelay				= 0.25
SWEP.Primary.Sound 					= Sound ("w/ee3.wav");
SWEP.Primary.ReloadSound 			= Sound ("w/reload_fast.wav");
SWEP.Primary.PenetrationMultiplier 	= 0
SWEP.Primary.Ammo					= "ar2"
SWEP.Primary.Damage					= 1
SWEP.Primary.HullSize 				= 0
SWEP.DamageType 					= nil
SWEP.Primary.Force 					= 0
SWEP.Primary.Knockback 				= 0
 
SWEP.FireModes = {
	"Single"
}
 
 
SWEP.DoMuzzleFlash 					= false
SWEP.CustomMuzzleFlash 				= false
SWEP.MuzzleFlashEffect 				= ""
 
SWEP.IronRecoilMultiplier			= 0.44
SWEP.CrouchRecoilMultiplier			= 0.33
SWEP.JumpRecoilMultiplier			= 1.3
SWEP.WallRecoilMultiplier			= 1.1
SWEP.ChangeStateRecoilMultiplier	= 1.18
SWEP.CrouchAccuracyMultiplier		= 0.7
SWEP.ChangeStateAccuracyMultiplier	= 0.7
SWEP.JumpAccuracyMultiplier			= 0.7
SWEP.WalkAccuracyMultiplier			= 0.7
SWEP.NearWallTime 					= 0.25
SWEP.ToCrouchTime 					= 0.1
SWEP.WeaponLength 					= 35
SWEP.SprintFOVOffset 				= 12
SWEP.ProjectileVelocity 			= 6000
 
SWEP.ProjectileEntity 				= ("monki_flash")
SWEP.ProjectileModel 				= nil
 
SWEP.ViewModel						= "models/delta/c_wrist_blaster.mdl"
SWEP.WorldModel						= "models/weapons/synbf3/w_scoutblaster.mdl"
SWEP.ViewModelFOV					= 65
SWEP.ViewModelFlip					= false
SWEP.MaterialTable 					= nil
SWEP.UseHands 						= true
SWEP.HoldType 						= "pistol"
 
SWEP.ShowWorldModel = false
 
SWEP.BlowbackEnabled 				= false
SWEP.BlowbackVector 				= Vector(0,-4,0)
SWEP.BlowbackCurrentRoot			= 0
SWEP.BlowbackCurrent 				= 0
SWEP.BlowbackBoneMods 				= nil
SWEP.Blowback_Only_Iron 			= false
SWEP.Blowback_PistolMode 			= false
SWEP.Blowback_Shell_Enabled 		= false
SWEP.Blowback_Shell_Effect 			= "None"
 
SWEP.Tracer							= 0
SWEP.TracerName 					= "rw_sw_laser_aqua"
SWEP.TracerCount 					= 1
SWEP.TracerLua 						= false
SWEP.TracerDelay					= 0.01
SWEP.ImpactEffect 					= "rw_sw_impact_aqua"
SWEP.ImpactDecal 					= "FadingScorch"
 
SWEP.VMPos = Vector(-3,-4,-1)
SWEP.VMAng = Vector(0,0,0)
 
SWEP.IronSightTime 					= 0.1
SWEP.Primary.KickUp					= 0.08
SWEP.Primary.KickDown				= 0.065
SWEP.Primary.KickHorizontal			= 0.065
SWEP.Primary.StaticRecoilFactor 	= 0.5
SWEP.Primary.Spread					= 0.022
SWEP.Primary.IronAccuracy 			= 0.022
SWEP.Primary.SpreadMultiplierMax 	= 1
SWEP.Primary.SpreadIncrement 		= 1
SWEP.Primary.SpreadRecovery 		= 1
SWEP.DisableChambering 				= true
SWEP.MoveSpeed 						= 1
SWEP.IronSightsMoveSpeed 			= 0.85
 
SWEP.IronSightsPos = Vector(-5.9, -8, 1.8)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-20, 0, 0)
SWEP.InspectPos = Vector(8, -2, -3)
SWEP.InspectAng = Vector(15, 45, 0)
 
SWEP.ViewModelBoneMods = { 
	["ValveBiped.Bip01_R_Wrist"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
 
SWEP.VElements = {
	["base"] = { type = "Model", model = "models/cs574/weapons/arc_leftwrist.mdl", bone = "ValveBiped.Bip01_R_Wrist", rel = "", pos = Vector(-6, 0, 02.9), angle = Angle(-03, 0, 175), size = Vector(1.05, 1.05, 1.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["blaster"] = { type = "Model", model = "models/sw_battlefront/weapons/2019/a280c_scope1.mdl", bone = "", rel = "base", pos = Vector(12, -0.4, -0.60), angle = Angle(04.5, 180, 0), size = Vector(1.35, 1.35, 1.35), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["blaster2"] = { type = "Model", model = "models/sw_battlefront/weapons/mods/blurrg_cycler_mod.mdl", bone = "", rel = "blaster", pos = Vector(12.8, 0, 0.9), angle = Angle(0, -90, 0), size = Vector(1.55, 1.55, 1.55), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["blaster3"] = { type = "Model", model = "models/sw_battlefront/weapons/rocketprojectile.mdl", bone = "", rel = "blaster", pos = Vector(8, 0, 05.1), angle = Angle(0, 180, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}
 
SWEP.WElements = {
	["base"] = { type = "Model", model = "models/cs574/weapons/arc_leftwrist.mdl", bone = "ValveBiped.Bip01_R_Wrist", rel = "", pos = Vector(-0.5, -0.25, 3.1), angle = Angle(0, 0, 175), size = Vector(1.05, 1.05, 1.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["blaster"] = { type = "Model", model = "models/sw_battlefront/weapons/2019/a280c_scope1.mdl", bone = "ValveBiped.Bip01_R_Wrist", rel = "base", pos = Vector(12, -0.4, -0.60), angle = Angle(04.5, 180, 0), size = Vector(1.35, 1.35, 1.35), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}
 
SWEP.ProceduralHolsterPos = Vector(0,0,0)
SWEP.ProceduralHolsterAng = Vector(-20,0,0)
SWEP.DoProceduralReload = true
SWEP.ProceduralReloadTime = 6
 
SWEP.ThirdPersonReloadDisable		=false
SWEP.Primary.DamageType 			= DMG_BULLET
SWEP.DamageType 					= DMG_BULLET
SWEP.RTScopeAttachment				= -1
SWEP.Scoped_3D 						= false
SWEP.ScopeReticule 					= "scope/gdcw_elcanreticle" 
SWEP.Secondary.ScopeZoom 			= 4
SWEP.ScopeReticule_Scale 			= {1.09,1.09}
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