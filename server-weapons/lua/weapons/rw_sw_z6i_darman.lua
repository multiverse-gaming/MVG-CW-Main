SWEP.Gun							= ("gun_base")
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Base							= "tfa_gun_base"
SWEP.Category						= "TFA StarWars Republic Commandos"
SWEP.Manufacturer 					= "Blastech Industries"
SWEP.Author							= "ChanceSphere574"
SWEP.Contact						= ""
SWEP.Spawnable						= true
SWEP.AdminSpawnable					= true
SWEP.DrawCrosshair					= true
SWEP.DrawCrosshairIS 				= false
SWEP.PrintName						= "Z-6I (Darman)"
SWEP.Type							= "Imperial Rotary Canon Blaster"
SWEP.DrawAmmo						= true
SWEP.data 							= {}
SWEP.data.ironsights				= 0
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
SWEP.OnlyBurstFire					= false
SWEP.DefaultFireMode 				= "Automatic"
SWEP.FireModeName 					= nil
SWEP.DisableChambering 				= true

SWEP.Primary.ClipSize				= 250
SWEP.Primary.DefaultClip			= 250*5
SWEP.Primary.RPM 					= 300
SWEP.Primary.RPM_MAX 				= 900
SWEP.Primary.RPM_Burst				= nil
SWEP.Primary.Ammo					= "ar2"
SWEP.Primary.AmmoConsumption 		= 1
SWEP.Primary.Range 					= 40000
SWEP.Primary.RangeFalloff 			= 4000
SWEP.Primary.NumShots				= 1
SWEP.Primary.Automatic				= true
SWEP.Primary.RPM_Semi				= 4
SWEP.Primary.BurstDelay				= 0.2
SWEP.Primary.Sound 					= Sound ("w/z6.wav");
SWEP.Primary.ReloadSound 			= Sound ("w/reload.wav");
SWEP.Primary.PenetrationMultiplier 	= 0
SWEP.Primary.Damage					= 20
SWEP.Primary.HullSize 				= 0
SWEP.DamageType 					= nil

SWEP.DoMuzzleFlash 					= false

SWEP.FireModes = {
	"Automatic",
}


SWEP.IronRecoilMultiplier			= 0.65
SWEP.CrouchRecoilMultiplier			= 0.85
SWEP.JumpRecoilMultiplier			= 2
SWEP.WallRecoilMultiplier			= 1.1
SWEP.ChangeStateRecoilMultiplier	= 1.2
SWEP.CrouchAccuracyMultiplier		= 0.8
SWEP.ChangeStateAccuracyMultiplier	= 1
SWEP.JumpAccuracyMultiplier			= 2.5
SWEP.WalkAccuracyMultiplier			= 1.8
SWEP.NearWallTime 					= 0.5
SWEP.ToCrouchTime 					= 0.25
SWEP.WeaponLength 					= 35
SWEP.SprintFOVOffset 				= 12
SWEP.ProjectileVelocity 			= 9

SWEP.ProjectileEntity 				= nil
SWEP.ProjectileModel 				= nil

SWEP.ViewModel						= "models/bf2017/c_dlt19.mdl"
SWEP.WorldModel						= "models/bf2017/w_dlt19.mdl"
SWEP.ViewModelFOV					= 70
SWEP.ViewModelFlip					= false
SWEP.MaterialTable 					= nil
SWEP.UseHands 						= false
SWEP.HoldType 						= "ar2"
SWEP.ReloadHoldTypeOverride 		= "ar2"

SWEP.ShowWorldModel = false

SWEP.BlowbackEnabled 				= true
SWEP.BlowbackVector 				= Vector(0,-1,-0.035)
SWEP.BlowbackCurrentRoot			= 0
SWEP.BlowbackCurrent 				= 0
SWEP.BlowbackBoneMods 				= nil
SWEP.Blowback_Only_Iron 			= false
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

SWEP.VMPos = Vector(2.02, 0, -4.82)
SWEP.VMAng = Vector(0, 0, 0)

SWEP.IronSightTime 					= 0.45
SWEP.Primary.KickUp					= 0.10/2
SWEP.Primary.KickDown				= 0.08/2
SWEP.Primary.KickHorizontal			= 0.035/2
SWEP.Primary.StaticRecoilFactor 	= 0.55
SWEP.Primary.Spread					= 0.020
SWEP.Primary.IronAccuracy 			= 0.020
SWEP.Primary.SpreadMultiplierMax 	= 1.2
SWEP.Primary.SpreadIncrement 		= 0.35
SWEP.Primary.SpreadRecovery 		= 0.98
SWEP.DisableChambering 				= true
SWEP.MoveSpeed 						= 1
SWEP.IronSightsMoveSpeed 			= 0.85

SWEP.IronSightsPos = Vector(-5.65, -3.2, 1.8)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(5.226, 0, -3)
SWEP.RunSightsAng = Vector(-22, 35, -22)
SWEP.InspectPos = Vector(8, -4.8, -3)
SWEP.InspectAng = Vector(11.199, 38, 0)

SWEP.ViewModelBoneMods = {
	["v_t21_reference001"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.VElements = {

	["dc17m"] = { type = "Model", model = "models/cs574/dc17m/dc17m_base.mdl", bone = "v_dlt19_reference001", rel = "", pos = Vector(0, 0, 2), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {},},

	["rifle_module"] = { type = "Model", model = "models/cs574/dc17m/dc17m_rifle.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = true  },

	["rifle_mag"] = { type = "Model", model = "models/cs574/dc17m/dc17m_mag.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = true  },

	["rifle_magext"] = { type = "Model", model = "models/cs574/dc17m/dc17m_magext.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["rifle_magdrum"] = { type = "Model", model = "models/cs574/dc17m/dc17m_drummag.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["rocket_module"] = { type = "Model", model = "models/cs574/dc17m/dc17m_rocket.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["shotgun_module"] = { type = "Model", model = "models/cs574/dc17m/dc17m_shotgun.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["sniper_module"] = { type = "Model", model = "models/cs574/dc17m/dc17m_sniper.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["sniper_module_hp1"] = { type = "Model", model = "models/squad/sf_plates/sf_plate1x1.mdl", bone = "", rel = "sniper_module", pos = Vector(-0.62, 17.175, 6.8), angle = Angle(90, -90, 0), size = Vector(0.11, 0.11, 0), color = Color(0, 200, 255, 255), surpresslightning = false, material = "cs574/scopes/dc17msniperret", skin = 0, bodygroup = {}, active = false  },

	["sniper_module_hp2"] = { type = "Model", model = "models/squad/sf_plates/sf_plate1x1.mdl", bone = "", rel = "sniper_module", pos = Vector(-0.62, 08.85, 6.8), angle = Angle(90, -90, 0), size = Vector(0.11, 0.11, 0), color = Color(0, 200, 255, 255), surpresslightning = false, material = "cs574/scopes/dc17msniperret", skin = 0, bodygroup = {}, active = false  },

	["sniper_module_scope"] = { type = "Model", model = "models/rtcircle.mdl", bone = "", rel = "sniper_module_hp2", pos = Vector(0.66, -0.66, 0), angle = Angle(90, 180, 0), size = Vector(0.33, 0.33, 0.33), color = Color(255, 255, 255, 255), surpresslightning = true, material = "!tfa_rtmaterial", skin = 0, bodygroup = {}, active = false  },

	["sniper_mag"] = { type = "Model", model = "models/cs574/dc17m/dc17m_snipermag.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["sniper_magext"] = { type = "Model", model = "models/cs574/dc17m/dc17m_snipermagext.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["dc17m_ironsight"] = { type = "Model", model = "models/cs574/dc17m/dc17m_ironsight.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = true  },

	["dc17m_holosight"] = { type = "Model", model = "models/cs574/dc17m/dc17m_holosights.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["dc17m_holosight_holo"] = { type = "Model", model = "models/squad/sf_plates/sf_plate1x1.mdl", bone = "", rel = "dc17m_holosight", pos = Vector(1.198, 0.5, 5.25), angle = Angle(90, 90, 0), size = Vector(0.2, 0.2, 0.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "cs574/ironsights/sw_ironsight_blue", skin = 0, bodygroup = {}, active = false  },

	["dc17m_laser"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "", rel = "dc17m", pos = Vector(0, 15, -01.8), angle = Angle(0, -90, 0), size = Vector(1.3, 1.3, 1.3), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["dc17m_ammo"] = { type = "Quad", bone = "", rel = "dc17m", pos = Vector(0.8, 06.35, 04.175), angle = Angle(0, -270, 62.5), size = 0.0045, draw_func = nil},

}




SWEP.WElements = {

	["dc17m"] = { type = "Model", model = "models/cs574/dc17m/dc17m_base.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1, -1.5), angle = Angle(0, -90, 165), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {},},

	["rifle_module"] = { type = "Model", model = "models/cs574/dc17m/dc17m_rifle.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = true  },

	["rifle_mag"] = { type = "Model", model = "models/cs574/dc17m/dc17m_mag.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = true  },

	["rifle_magext"] = { type = "Model", model = "models/cs574/dc17m/dc17m_magext.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["rifle_magdrum"] = { type = "Model", model = "models/cs574/dc17m/dc17m_drummag.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["rocket_module"] = { type = "Model", model = "models/cs574/dc17m/dc17m_rocket.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["shotgun_module"] = { type = "Model", model = "models/cs574/dc17m/dc17m_shotgun.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["sniper_module"] = { type = "Model", model = "models/cs574/dc17m/dc17m_sniper.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["sniper_module_hp1"] = { type = "Model", model = "models/squad/sf_plates/sf_plate1x1.mdl", bone = "", rel = "sniper_module", pos = Vector(-0.62, 17.175, 6.8), angle = Angle(90, -90, 0), size = Vector(0.11, 0.11, 0), color = Color(0, 200, 255, 255), surpresslightning = false, material = "cs574/scopes/dc17msniperret", skin = 0, bodygroup = {}, active = false  },

	["sniper_module_hp2"] = { type = "Model", model = "models/squad/sf_plates/sf_plate1x1.mdl", bone = "", rel = "sniper_module", pos = Vector(-0.62, 08.85, 6.8), angle = Angle(90, -90, 0), size = Vector(0.11, 0.11, 0), color = Color(0, 200, 255, 255), surpresslightning = false, material = "cs574/scopes/dc17msniperret", skin = 0, bodygroup = {}, active = false  },

	["sniper_mag"] = { type = "Model", model = "models/cs574/dc17m/dc17m_snipermag.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["sniper_magext"] = { type = "Model", model = "models/cs574/dc17m/dc17m_snipermagext.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["dc17m_ironsight"] = { type = "Model", model = "models/cs574/dc17m/dc17m_ironsight.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = true  },

	["dc17m_holosight"] = { type = "Model", model = "models/cs574/dc17m/dc17m_holosights.mdl", bone = "", rel = "dc17m", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

	["dc17m_laser"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "", rel = "dc17m", pos = Vector(0, 15, -01.8), angle = Angle(0, -90, 0), size = Vector(1.3, 1.3, 1.3), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },

}

SWEP.ProceduralHolsterPos = Vector(0,-3,4)
SWEP.ProceduralHolsterAng = Vector(-30,0,0)
SWEP.DoProceduralReload = true
SWEP.ProceduralReloadTime = 3.2

SWEP.ThirdPersonReloadDisable		=false
SWEP.Primary.DamageType 			= DMG_BULLET
SWEP.DamageType 					= DMG_BULLET
SWEP.RTScopeAttachment				= -1
SWEP.Scoped_3D 						= false
SWEP.ScopeReticule 					= "scope/gdcw_elcanreticle"
SWEP.Secondary.ScopeZoom 			= 3
SWEP.ScopeReticule_Scale 			= {1,1}


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

function SWEP:Initialize(...)
    self.StatCache_Blacklist["Primary.RPM"] = true
    return BaseClass.Initialize(self, ...)
end

function SWEP:PrePrimaryAttack(...)
    if self.Owner:KeyDown(IN_ATTACK) then
		self.Primary_TFA.RPM = math.Approach(self.Primary_TFA.RPM, self.Primary.RPM_MAX, 30)
    end
    return BaseClass.PrePrimaryAttack(self, ...)
end

function SWEP:Think(...)
	if self.Owner:KeyReleased(IN_ATTACK) then
		self.Primary_TFA.RPM = 300
		self:ClearStatCache("Primary.RPM")
	end
	return BaseClass.Think(self, ...)
end
