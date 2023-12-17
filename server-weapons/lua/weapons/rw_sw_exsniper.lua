SWEP.Gun							= ("evil_sw_t7")

if (GetConVar(SWEP.Gun.."_allowed")) != nil then

	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end

end

SWEP.Base							= "tfa_3dscoped_base"

SWEP.Category						= "TFA StarWars Reworked Explosif"

SWEP.Manufacturer 					= ""

SWEP.Author							= "ChanceSphere574 | Modified by Fox and Rush"

SWEP.Contact						= ""

SWEP.Spawnable						= true

SWEP.AdminSpawnable					= true

SWEP.DrawCrosshair					= true

SWEP.DrawCrosshairIS 				= false

SWEP.PrintName						= "HVER Mk.II"

SWEP.Type							= "Marksman Rifle"

SWEP.DrawAmmo						= true

SWEP.data 							= {}

SWEP.data.ironsights				= 1

SWEP.Secondary.IronFOV				= 75

SWEP.Slot							= 4

SWEP.SlotPos						= 100



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



SWEP.Primary.ClipSize				= 3

SWEP.Primary.DefaultClip			= 1000

SWEP.Primary.RPM					= 60

SWEP.Primary.RPM_Burst				= nil

SWEP.Primary.Ammo					= "ar2"

SWEP.Primary.AmmoConsumption 		= 1

SWEP.Primary.Range 					= 35000

SWEP.Primary.RangeFalloff 			= -1

SWEP.Primary.NumShots				= 1

SWEP.Primary.Automatic				= false

SWEP.Primary.RPM_Semi				= nil

SWEP.Primary.BurstDelay				= 0.2

SWEP.Primary.Sound 					= Sound ("w/t4.wav");

SWEP.Primary.ReloadSound 			= Sound ("w/reload.wav");

SWEP.Primary.PenetrationMultiplier 	= 0

SWEP.Primary.Damage					= 300

SWEP.Primary.HullSize 				= 0

SWEP.Primary.Force 					= 0

SWEP.Primary.Knockback 				= 0
SWEP.DamageType 					= nil




SWEP.DoMuzzleFlash 					= false



SWEP.FireModes = {

	"Single"

}



SWEP.IronRecoilMultiplier			= 0.65

SWEP.CrouchRecoilMultiplier			= 0.85

SWEP.JumpRecoilMultiplier			= 2

SWEP.WallRecoilMultiplier			= 1.1

SWEP.ChangeStateRecoilMultiplier	= 1.2

SWEP.CrouchAccuracyMultiplier		= 0.8

SWEP.ChangeStateAccuracyMultiplier	= 1

SWEP.JumpAccuracyMultiplier			= 10

SWEP.WalkAccuracyMultiplier			= 1.8

SWEP.NearWallTime 					= 0.5

SWEP.ToCrouchTime 					= 0.25

SWEP.WeaponLength 					= 35

SWEP.SprintFOVOffset 				= 12

SWEP.ProjectileVelocity 			= 9



SWEP.ViewModel						= "models/bf2017/c_dlt19.mdl" --models/weapons/synbf3/c_dlt19.mdl

SWEP.WorldModel						= "models/bf2017/w_dlt19.mdl" --models/weapons/synbf3/w_dlt19.mdl

SWEP.ViewModelFOV					= 75

SWEP.ViewModelFlip					= false

SWEP.MaterialTable 					= nil

SWEP.UseHands 						= true

SWEP.HoldType 						= "smg"

SWEP.ReloadHoldTypeOverride 		= "ar2"



SWEP.ShowWorldModel = false



SWEP.BlowbackEnabled 				= true

SWEP.BlowbackVector 				= Vector(0,-1.5,-0.05)

SWEP.BlowbackCurrentRoot			= 0

SWEP.BlowbackCurrent 				= 0

SWEP.BlowbackBoneMods 				= nil

SWEP.Blowback_Only_Iron 			= true

SWEP.Blowback_PistolMode 			= false

SWEP.Blowback_Shell_Enabled 		= false

SWEP.Blowback_Shell_Effect 			= "None"



SWEP.Tracer							= 0
SWEP.TracerName 					= "rw_sw_laser_purple"
SWEP.TracerCount 					= 1
SWEP.TracerLua 						= false
SWEP.TracerDelay					= 0.01
SWEP.ImpactEffect 					= "rw_sw_impact_purple"
SWEP.ImpactDecal 					= "FadingScorch"


SWEP.VMPos = Vector(0,-4,-3)
SWEP.VMAng = Vector(0, 0, 0)

--SWEP.VMPos = Vector(0,-4,-3)

--SWEP.VMAng = Vector(0, 0, 0)



SWEP.IronSightTime 					= 0.5

SWEP.Primary.KickUp					= 0.05/2

SWEP.Primary.KickDown				= 0.05/2

SWEP.Primary.KickHorizontal			= 0

SWEP.Primary.StaticRecoilFactor 	= 0.5

SWEP.Primary.Spread					= 0.015

SWEP.Primary.IronAccuracy 			= 0.005

SWEP.Primary.SpreadMultiplierMax 	= 1.5/2

SWEP.Primary.SpreadIncrement 		= 0.35

SWEP.Primary.SpreadRecovery 		= 0.98

SWEP.DisableChambering 				= true

SWEP.MoveSpeed 						= 1

SWEP.IronSightsMoveSpeed 			= 0.85

SWEP.IronSightsPos = Vector(-2.485, -7.5, 3.53)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(5.226, -2, 0)
SWEP.RunSightsAng = Vector(-18, 36, -13.5)
SWEP.InspectPos = Vector(8, -4.8, -3)
SWEP.InspectAng = Vector(11.199, 38, 0)

SWEP.ViewModelBoneMods = {
	["v_dlt19_reference001"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["w"] = { type = "Model", model = "models/hauptmann/star wars/weapons/emp_rifle.mdl", bone = "v_dlt19_reference001", rel = "", pos = Vector(0.1, 011, -06.2), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["ret1"] = { type = "Model", model = "models/rtcircle.mdl", bone = "", rel = "w", pos = Vector(-06.88, -01.04, 11.795), angle = Angle(0, 180, 0), size = Vector(0.225, 0.225, 0.225), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {}, active = true  },
}

SWEP.WElements = {
	["w"] = { type = "Model", model = "models/hauptmann/star wars/weapons/emp_rifle.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(13, 0.6, 03.5), angle = Angle(-12, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

SWEP.ThirdPersonReloadDisable		=false
SWEP.Primary.DamageType 			= DMG_BULLET
SWEP.DamageType 					= DMG_BULLET
SWEP.RTScopeAttachment				= -1
SWEP.Scoped_3D 						= false
SWEP.ScopeReticule 					= "cs574/scopes/battlefront_hd/sw_ret_redux_black"
SWEP.Secondary.ScopeZoom 			= 5
SWEP.ScopeReticule_Scale 			= {1.025,1.025}
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