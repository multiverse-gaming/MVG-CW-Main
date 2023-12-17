SWEP.Gun							= ("773_firepuncher")
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Base							= "tfa_3dscoped_base" // tfa_gun_base
SWEP.Category						= "TFA StarWars Republic Commandos"
SWEP.Manufacturer 					= ""
SWEP.Author							= "Ink and Jack"
SWEP.Contact						= ""
SWEP.Spawnable						= true
SWEP.AdminSpawnable					= true
SWEP.DrawCrosshair					= true
SWEP.DrawCrosshairIS 				= false
SWEP.PrintName						= "773-Firepuncher"
SWEP.Type							= "Precision Blaster Rifle"
SWEP.DrawAmmo						= true
SWEP.data 							= {}
SWEP.data.ironsights				= 1
SWEP.Secondary.IronFOV				= 78
SWEP.Slot							= 3
SWEP.SlotPos						= 5

SWEP.FiresUnderwater 				= true

SWEP.IronInSound 					= nil
SWEP.IronOutSound 					= nil
SWEP.CanBeSilenced					= false
SWEP.Silenced 						= false
SWEP.DoMuzzleFlash 					= false
SWEP.SelectiveFire					= true
SWEP.DisableBurstFire				= false
SWEP.OnlyBurstFire					= false
SWEP.DefaultFireMode 				= "single"
SWEP.FireModeName 					= nil
SWEP.DisableChambering 				= true

SWEP.Primary.ClipSize				= 25
SWEP.Primary.ClipSize				= 20
SWEP.Primary.DefaultClip			= 40
SWEP.Primary.RPM					= 200
SWEP.Primary.RPM_Burst				= 400
SWEP.Primary.Ammo					= "ar2"
SWEP.Primary.AmmoConsumption 		= 1
SWEP.Primary.Range 					= 10000
SWEP.Primary.RangeFalloff 			= -1
SWEP.Primary.NumShots				= 1
SWEP.Primary.Automatic				= false
SWEP.Primary.RPM_Semi				= nil
SWEP.Primary.BurstDelay				= .1
SWEP.Primary.Sound = Sound ("w/dpst.wav");
SWEP.Primary.ReloadSound 			= Sound ("w/heavy.wav");
SWEP.Primary.PenetrationMultiplier 	= 0
SWEP.Primary.Damage					= 65
SWEP.Primary.HullSize 				= 0
SWEP.DamageType 					= nil

SWEP.DoMuzzleFlash 					= true
SWEP.CustomMuzzleFlash 				= true
SWEP.MuzzleFlashEffect 				= "tfa_muzzleflash_incendiary"

SWEP.FireModes = {
	"Single",
	"2Burst",
}

SWEP.IronRecoilMultiplier			= 0.01
SWEP.CrouchRecoilMultiplier			= 0.01
SWEP.JumpRecoilMultiplier			= 0.01
SWEP.WallRecoilMultiplier			= 0.02
SWEP.ChangeStateRecoilMultiplier	= 0.02
SWEP.CrouchAccuracyMultiplier		= 0.8
SWEP.ChangeStateAccuracyMultiplier	= 1
SWEP.JumpAccuracyMultiplier			= 10
SWEP.WalkAccuracyMultiplier			= 1.8
SWEP.NearWallTime 					= 0.5
SWEP.ToCrouchTime 					= 0.25
SWEP.WeaponLength 					= 35
SWEP.SprintFOVOffset 				= 12
SWEP.ProjectileVelocity 			= 9

SWEP.AllowSprintAttack				= true

SWEP.ProjectileEntity 				= nil
SWEP.ProjectileModel 				= nil

SWEP.ViewModel = "models/weapons/synbf3/c_dlt19.mdl"
SWEP.WorldModel = "models/weapons/synbf3/w_dlt19.mdl"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip					= false
SWEP.MaterialTable 					= nil
SWEP.UseHands 						= true
SWEP.HoldType 						= "ar2"

SWEP.ShowWorldModel = false

SWEP.BlowbackEnabled 				= true
SWEP.BlowbackVector 				= Vector(0,-1,-0.00)
SWEP.BlowbackCurrentRoot			= 0
SWEP.BlowbackCurrent 				= 0
SWEP.BlowbackBoneMods 				= nil
SWEP.Blowback_Only_Iron 			= true
SWEP.Blowback_PistolMode 			= false
SWEP.Blowback_Shell_Enabled 		= false
SWEP.Blowback_Shell_Effect 			= "None"

SWEP.Tracer							= 0
SWEP.TracerName 					= "effect_sw_laser_blue"
SWEP.TracerCount 					= 1
SWEP.TracerLua 						= false
SWEP.TracerDelay					= 0.01
SWEP.ImpactEffect 					= "effect_sw_impact"
SWEP.ImpactDecal 					= "FadingScorch"

--SWEP.VMPos = Vector(0.5, -2, .5)
--SWEP.VMAng = Vector(0,0,0)

SWEP.IronSightTime 					= 0.5
SWEP.Primary.KickUp					= 0.03
SWEP.Primary.KickDown				= 0.01
SWEP.Primary.KickHorizontal			= 0.055
SWEP.Primary.StaticRecoilFactor 	= 0.01
SWEP.Primary.Spread					= .02
SWEP.Primary.IronAccuracy 			= .001
SWEP.Primary.SpreadMultiplierMax 	= 1.5
SWEP.Primary.SpreadIncrement 		= 0.35
SWEP.Primary.SpreadRecovery 		= 0.98
SWEP.DisableChambering 				= true
SWEP.MoveSpeed 						= 1
SWEP.IronSightsMoveSpeed 			= 0.75

SWEP.IronSightsPos = Vector(-3, -5.5, 01.5) //across //close //up&down
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.RunSightsPos = Vector(4, -2, 1.5)
SWEP.RunSightsAng = Vector(-28, 42, -25)
SWEP.InspectPos = Vector(8, -5, -3)
SWEP.InspectAng = Vector(14, 48, 0)


SWEP.ViewModelBoneMods = {
	["v_dlt19_reference001"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-3, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["valken"] = { type = "Model", model = "models/ink/weapons/firepuncher.mdl", bone = "v_dlt19_reference001", rel = "", pos = Vector(0.5, 13.5, -1.3), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["scope"] = { type = "Model", model = "models/rtcircle.mdl", bone = "v_dlt19_reference001", rel = "", pos = Vector(0.52, 5, 5.2), angle = Angle(0, 90, 0), size = Vector(0.48, 0.48, 0.48), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {} },

}	

SWEP.WElements = {
	["valken"] = { type = "Model", model = "models/ink/weapons/firepuncher.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(14.5, 1, -1.3), angle = Angle(-13, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}
--]]

SWEP.Attachments = {
	[1] = { offset = { 0, 0 }, atts = { "yellow_ammo_crosshair"}, order = 1 },
    [2] = { offset = { 0, 0 }, atts = { "thermal_vision"}, order = 2 },
	[3] = {header="Ricochet",atts={"ricoche_attachment_crosshair"}, order = 3 },
	[4]={header="Barrel",atts={"raid_grapple" },},
}

SWEP.DoProceduralReload = true
SWEP.ProceduralReloadTime = 2

SWEP.ThirdPersonReloadDisable		=false
SWEP.Primary.DamageType 			= DMG_BULLET
SWEP.DamageType 					= DMG_BULLET
SWEP.RTScopeAttachment				= -1
SWEP.Scoped_3D 						= false
SWEP.ScopeReticule 					= "#sw/visor/sw_ret_redux_blue" 
SWEP.Secondary.ScopeZoom 			= 10
SWEP.ScopeReticule_Scale 			= {1.12,1.12}
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