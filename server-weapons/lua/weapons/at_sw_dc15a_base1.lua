SWEP.Gun							= ("gun_base")
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end

SWEP.Base							= "tfa_3dscoped_base"
SWEP.Category						= "TFA StarWars [AT] Pack"
SWEP.Manufacturer 					= ""
SWEP.Author							= "ChanceSphere574"
SWEP.Contact						= ""
SWEP.Spawnable						= true
SWEP.AdminSpawnable					= true
SWEP.DrawCrosshair					= true
SWEP.DrawCrosshairIS 				= false
SWEP.PrintName						= "[AT] DC-15A (Base Mk.I)"
SWEP.Type							= "Customisable Republic Heavy Blaster Rifle"
SWEP.DrawAmmo						= true
SWEP.data 							= {}
SWEP.data.ironsights				= 1
SWEP.Secondary.IronFOV				= 70
SWEP.Slot							= 3
SWEP.SlotPos						= 100

SWEP.FiresUnderwater 				= true

SWEP.IronInSound 					= nil
SWEP.IronOutSound 					= nil
SWEP.CanBeSilenced					= true
SWEP.Silenced 						= false
SWEP.DoMuzzleFlash 					= false
SWEP.SelectiveFire					= true
SWEP.DisableBurstFire				= false
SWEP.OnlyBurstFire					= false
SWEP.DefaultFireMode 				= "Automatic"
SWEP.FireModeName 					= nil
SWEP.DisableChambering 				= true

SWEP.Primary.ClipSize				= 45
SWEP.Primary.DefaultClip			= 45*10
SWEP.Primary.RPM					= 450
SWEP.Primary.RPM_Burst				= 450*3.5
SWEP.Primary.Ammo					= "ar2"
SWEP.Primary.AmmoConsumption 		= 1
SWEP.Primary.Range 					= 40000
SWEP.Primary.RangeFalloff 			= -1
SWEP.Primary.NumShots				= 1
SWEP.Primary.Automatic				= true
SWEP.Primary.RPM_Semi				= nil
SWEP.Primary.BurstDelay				= 0.33
SWEP.Primary.Sound 					= Sound ("w/dc15a.wav");
SWEP.Primary.SilencedSound			= Sound ("w/dc19.wav");
SWEP.Primary.ReloadSound 			= Sound ("w/heavy.wav");
SWEP.Primary.PenetrationMultiplier 	= 0
SWEP.Primary.Damage					= 35
SWEP.Primary.HullSize 				= 0
SWEP.DamageType 					= nil

SWEP.DoMuzzleFlash 					= false
SWEP.CustomMuzzleFlash 				= true
SWEP.MuzzleFlashEffect 				= "rw_sw_muzzleflash_blue"
SWEP.MuzzlePosOverride 				= Vector(0, 0, 0)

SWEP.FireModes = {
	"Automatic",
	"3Burst",
	"Single"
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

SWEP.ViewModel						= "models/weapons/synbf3/c_dlt19.mdl"
SWEP.WorldModel						= "models/weapons/synbf3/w_dlt19.mdl"
SWEP.ViewModelFOV					= 70
SWEP.ViewModelFlip					= false
SWEP.MaterialTable 					= nil
SWEP.UseHands 						= true
SWEP.HoldType 						= "ar2"
SWEP.ReloadHoldTypeOverride 		= "ar2"

SWEP.ShowWorldModel = false

SWEP.BlowbackEnabled 				= true
SWEP.BlowbackVector 				= Vector(0,-2,0)
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

SWEP.VMPos = Vector(0,-3,-3.95)
SWEP.VMAng = Vector(0, 0, 0)

SWEP.IronSightTime 					= 0.3
SWEP.Primary.KickUp					= 0.05
SWEP.Primary.KickDown				= 0.05
SWEP.Primary.KickHorizontal			= 0.01
SWEP.Primary.StaticRecoilFactor 	= 0.5
SWEP.Primary.Spread					= 0.015
SWEP.Primary.IronAccuracy 			= 0.005
SWEP.Primary.SpreadMultiplierMax 	= 1.5
SWEP.Primary.SpreadIncrement 		= 0.4
SWEP.Primary.SpreadRecovery 		= 0.8
SWEP.DisableChambering 				= true
SWEP.MoveSpeed 						= 1
SWEP.IronSightsMoveSpeed 			= 0.85

SWEP.RunSightsPos = Vector(5.226, -2, 0)
SWEP.RunSightsAng = Vector(-18, 36, -13.5)

SWEP.InspectPos = Vector(8, -4.8, -3)
SWEP.InspectAng = Vector(11.199, 38, 0)

SWEP.ViewModelBoneMods = {
	["v_dlt19_reference001"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["dlt19"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.IronSightsPos = Vector(-2.885, -6, 2.05)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.Scope1Pos = Vector(-2.882, -1.2, 2.905)
SWEP.Scope1Ang = Vector(0, 0, 0)

SWEP.Scope2Pos = Vector(-2.882, -3.5, 2.995)
SWEP.Scope2Ang = Vector(0, 0, 0)

SWEP.Scope3Pos = Vector(-2.882, -3, 3.11)
SWEP.Scope3Ang = Vector(0, 0, 0)

SWEP.Scope4Pos = Vector(-2.8425, -2.5, 3.42)
SWEP.Scope4Ang = Vector(0, 0, 0)

SWEP.Scope5Pos = Vector(-2.882, -3, 3.25)
SWEP.Scope5Ang = Vector(0, 0, 0)

SWEP.Scope6Pos = Vector(-2.881, -3, 3.382)
SWEP.Scope6Ang = Vector(0, 0, 0)

SWEP.Scope7Pos = Vector(-2.882, -3.5, 3.46)
SWEP.Scope7Ang = Vector(0, 0, 0)

SWEP.Scope8Pos = Vector(-2.882, -5, 3.575)
SWEP.Scope8Ang = Vector(0, 0, 0)

SWEP.Attachments = {
	[1] = {
		header = "Modes",
		atts = {"training_mod"},
	},
	[2] = {
		header = "Scopes",
		atts = {"dc15_s3","dc15_s4"},
	},
	[3] = {
		header = "Muzzles",
		atts = {"dc15_muzzle1"},
	},
    [4] = {
		header = "Laser",
		atts = {"dc15_laser_off","dc15_laser_on"},
	},
	[5] = {
		header = "Ammo Indicator",
		atts = {"ammo_indicator"},
	},
}

SWEP.AttachmentExclusions = {
	["stun_mod"] = { [4] = "dc15_dm","dc15_mxl" },
	["dc15_dm"] = { [1] = "stun_mod"},
	["dc15_mxl"] = { [1] = "stun_mod"},
}

SWEP.VElements = {
	["dc15"] = { type = "Model", model = "models/sw_battlefront/weapons/dc15a_rifle.mdl", bone = "v_dlt19_reference001", rel = "", pos = Vector(0.75, -1.5, 2.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["iron"] = { type = "Model", model = "models/sw_battlefront/weapons/2019/e11_carbine_rearsight.mdl", bone = "", rel = "dc15", pos = Vector(1.95, 0, 2.8), angle = Angle(0, 0, 0), size = Vector(1, 1, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = true  },
	["laser"] = { type = "Model", model = "models/sw_battlefront/weapons/2019/a280cfe_laser.mdl", bone = "", rel = "dc15", pos = Vector(14, 2, 3), angle = Angle(0, 0, -110), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "", rel = "laser", pos = Vector(16, 1, 3.2), angle = Angle(0, 0, 0), size = Vector(1.144, 1.144, 1.144), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["muzzle1"] = { type = "Model", model = "models/sw_battlefront/weapons/2019/dc15_mod_muzzle.mdl", bone = "", rel = "dc15", pos = Vector(-0.6, 0, -0.5), angle = Angle(-90, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["muzzle2"] = { type = "Model", model = "models/sw_battlefront/weapons/2019/dlt19_heavyrifle_muzzle1.mdl", bone = "", rel = "dc15", pos = Vector(-2, 0, -0.6), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["muzzle4"] = { type = "Model", model = "models/sw_battlefront/weapons/cr2_pistol_barrel_default.mdl", bone = "", rel = "dc15", pos = Vector(18.5, 0, 0.45), angle = Angle(0, 0, 0), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["scope_base"] = { type = "Model", model = "models/sw_battlefront/weapons/2019/e11_carbine_top1.mdl", bone = "", rel = "dc15", pos = Vector(3.5, 0, -1.85), angle = Angle(0, 0, 0), size = Vector(1, 1, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["scope3"] = { type = "Model", model = "models/sw_battlefront/weapons/valken_scope.mdl", bone = "", rel = "scope_base", pos = Vector(-1.2, 0, 2.88), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["scope3_ret"] = { type = "Model", model = "models/rtcircle.mdl", bone = "", rel = "scope3", pos = Vector(-1.05, 0, 3.488), angle = Angle(180, 0, 180), size = Vector(0.23, 0.23, 0.23), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {}, active = false  },
	["scope4"] = { type = "Model", model = "models/sw_battlefront/weapons/e11_scope.mdl", bone = "", rel = "scope_base", pos = Vector(3.85, 0, -2.45), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["scope4_ret"] = { type = "Model", model = "models/rtcircle.mdl", bone = "", rel = "scope4", pos = Vector(-6.85, -0.036, 8.51), angle = Angle(180, 0, 180), size = Vector(0.26, 0.26, 0.26), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {}, active = false  },

	["indic"] = { type = "Model", model = "models/cs574/objects/indicateur.mdl", bone = "", rel = "dc15", pos = Vector(12.1, -0.54, 03.5), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["ammo1"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "", rel = "indic", pos = Vector(0.485, -0.65, 0.12), angle = Angle(0, 0, 0), size = Vector(0.05, 0.1, 0.05), color = Color(0, 0, 0, 255), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {}, active = false },
	["ammo2"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "", rel = "ammo1", pos = Vector(0, 0, 0.15), angle = Angle(0, 0, 0), size = Vector(0.05, 0.1, 0.05), color = Color(0, 0, 0, 255), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {}, active = false },
	["ammo3"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "", rel = "ammo2", pos = Vector(0, 0, 0.15), angle = Angle(0, 0, 0), size = Vector(0.05, 0.1, 0.05), color = Color(0, 0, 0, 255), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {}, active = false },
	["ammo4"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "", rel = "ammo3", pos = Vector(0, 0, 0.15), angle = Angle(0, 0, 0), size = Vector(0.05, 0.1, 0.05), color = Color(0, 0, 0, 255), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {}, active = false },
	["txt_ammo"] = { type = "Quad", bone = "", rel = "indic", pos = Vector(0.565, 0.16, 0.65), angle = Angle(0, 90, 90), size = 0.00115, draw_func = nil, active = false},
	["txt_mod"] = { type = "Quad", bone = "", rel = "indic", pos = Vector(0.565, 0.16, 0.4), angle = Angle(0, 90, 90), size = 0.00115, draw_func = nil, active = false},
}



SWEP.WElements = {
	["dc15"] = { type = "Model", model = "models/sw_battlefront/weapons/dc15a_rifle.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 0.4, -2), angle = Angle(-13, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["iron"] = { type = "Model", model = "models/sw_battlefront/weapons/2019/e11_carbine_rearsight.mdl", bone = "", rel = "dc15", pos = Vector(1.95, 0, 2.8), angle = Angle(0, 0, 0), size = Vector(1, 1, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = true  },
	["laser"] = { type = "Model", model = "models/sw_battlefront/weapons/2019/a280cfe_laser.mdl", bone = "", rel = "dc15", pos = Vector(14, 2, 3), angle = Angle(0, 0, -110), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "", rel = "laser", pos = Vector(16, 1, 3.2), angle = Angle(0, 0, 0), size = Vector(1.144, 1.144, 1.144), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["muzzle1"] = { type = "Model", model = "models/sw_battlefront/weapons/2019/dc15_mod_muzzle.mdl", bone = "", rel = "dc15", pos = Vector(-0.6, 0, -0.5), angle = Angle(-90, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["muzzle2"] = { type = "Model", model = "models/sw_battlefront/weapons/2019/dlt19_heavyrifle_muzzle1.mdl", bone = "", rel = "dc15", pos = Vector(-2, 0, -0.6), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["muzzle4"] = { type = "Model", model = "models/sw_battlefront/weapons/cr2_pistol_barrel_default.mdl", bone = "", rel = "dc15", pos = Vector(18.5, 0, 0.45), angle = Angle(0, 0, 0), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["scope_base"] = { type = "Model", model = "models/sw_battlefront/weapons/2019/e11_carbine_top1.mdl", bone = "", rel = "dc15", pos = Vector(3.5, 0, -1.85), angle = Angle(0, 0, 0), size = Vector(1, 1, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["scope3"] = { type = "Model", model = "models/sw_battlefront/weapons/valken_scope.mdl", bone = "", rel = "scope_base", pos = Vector(-1.2, 0, 2.88), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["scope4"] = { type = "Model", model = "models/sw_battlefront/weapons/e11_scope.mdl", bone = "", rel = "scope_base", pos = Vector(3.85, 0, -2.45), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
	["indic"] = { type = "Model", model = "models/cs574/objects/indicateur.mdl", bone = "", rel = "dc15", pos = Vector(12.1, -0.54, 03.5), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false  },
}

SWEP.IronSightsSensitivity 			= 0.8
SWEP.ThirdPersonReloadDisable		= false
SWEP.Primary.DamageType 			= DMG_BULLET
SWEP.DamageType 					= DMG_BULLET
SWEP.RTScopeAttachment				= -1
SWEP.Scoped_3D 						= false
SWEP.ScopeReticule 					= "#sw/visor/sw_ret_redux_blue" 
SWEP.Secondary.ScopeZoom 			= 9
SWEP.ScopeReticule_Scale 			= {1.1,1.1}

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

function SWEP:Think(...)
	BaseClass.Think(self, ...)
	if CLIENT then
		if self:Clip1() > 99 then
			self.VElements["txt_ammo"].draw_func = function( weapon )
				draw.SimpleText(""..weapon:Clip1().."/"..self.Primary.ClipSize, "Test", 0, 0, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end
		if self:Clip1() <= 99 then
			self.VElements["txt_ammo"].draw_func = function( weapon )
				draw.SimpleText(""..weapon:Clip1().."/"..self.Primary.ClipSize, "Test", 0, 0, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end
		if self:Clip1() <= 9 then
			self.VElements["txt_ammo"].draw_func = function( weapon )
				draw.SimpleText("0"..weapon:Clip1().."/"..self.Primary.ClipSize, "Test", 0, 0, Color(255, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end
		if self:Clip1() == 0 then
			self.VElements["txt_ammo"].draw_func = function( weapon )
				draw.SimpleText("00/"..self.Primary.ClipSize, "Test", 0, 0, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end
		if self:IsAttached("dc15le") then
			self.VElements["txt_mod"].draw_func = function( weapon )
				draw.SimpleText("LE-M", "Test", 0, 0, Color(160, 160, 160, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end
		if self:IsAttached("dc15x") then
			self.VElements["txt_mod"].draw_func = function( weapon )
				draw.SimpleText("X-M", "Test", 0, 0, Color(160, 160, 160, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end
		if self:IsAttached("training_mod") then
			self.VElements["txt_mod"].draw_func = function( weapon )
				draw.SimpleText("T-M", "Test", 0, 0, Color(255, 110, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end
		if self:IsAttached("destabilized_mod") then
			self.VElements["txt_mod"].draw_func = function( weapon )
				draw.SimpleText("D-M", "Test", 0, 0, Color(0, 255, 185, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end
		if self:IsAttached("explosive_mod") then
			self.VElements["txt_mod"].draw_func = function( weapon )
				draw.SimpleText("E-M", "Test", 0, 0, Color(255, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end
		if self:IsAttached("stun_mod") then
			self.VElements["txt_mod"].draw_func = function( weapon )
				draw.SimpleText("S-M", "Test", 0, 0, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end
		if !self:IsAttached("stun_mod") && !self:IsAttached("explosive_mod") && !self:IsAttached("destabilized_mod") && !self:IsAttached("training_mod") && !self:IsAttached("dc15le") && !self:IsAttached("dc15x") then
			self.VElements["txt_mod"].draw_func = function( weapon )
				draw.SimpleText("A-M", "Test", 0, 0, Color(160, 160, 160, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end
	end
	local color1 = 255
	local color2 = (self.Weapon:Clip1()/self.Primary.ClipSize)*250
	local color3 = 0
	if( self.Weapon:Clip1() >= self.Primary.ClipSize ) then 
		self.VElements["ammo4"].color = Color(0, 255, 0, 255)
		self.VElements["ammo3"].color = Color(0, 255, 0, 255)
		self.VElements["ammo2"].color = Color(0, 255, 0, 255)
		self.VElements["ammo1"].color = Color(0, 255, 0, 255)
	end
	if( self.Weapon:Clip1() < self.Primary.ClipSize && self.Weapon:Clip1() >= (self.Primary.ClipSize/4)*3) then
		self.VElements["ammo4"].color = Color(color1, color2, color3, 255)
		self.VElements["ammo3"].color = Color(color1, color2, color3, 255)
		self.VElements["ammo2"].color = Color(color1, color2, color3, 255)
		self.VElements["ammo1"].color = Color(color1, color2, color3, 255)
	end
	if( self.Weapon:Clip1() <= (self.Primary.ClipSize/4)*3 && self.Weapon:Clip1() >= (self.Primary.ClipSize/4)*2) then 
		self.VElements["ammo4"].color = Color(50, 50, 50, 255)
		self.VElements["ammo3"].color = Color(color1, color2, color3, 255)
		self.VElements["ammo2"].color = Color(color1, color2, color3, 255)
		self.VElements["ammo1"].color = Color(color1, color2, color3, 255)
	end
	if( self.Weapon:Clip1() <= (self.Primary.ClipSize/4)*2 && self.Weapon:Clip1() >= self.Primary.ClipSize/4) then 
		self.VElements["ammo4"].color = Color(50, 50, 50, 255)
		self.VElements["ammo3"].color = Color(50, 50, 50, 255)
		self.VElements["ammo2"].color = Color(color1, color2, color3, 255)
		self.VElements["ammo1"].color = Color(color1, color2, color3, 255)
	end
	if( self.Weapon:Clip1() <= self.Primary.ClipSize/4 ) then 
		self.VElements["ammo4"].color = Color(50, 50, 50, 255)
		self.VElements["ammo3"].color = Color(50, 50, 50, 255)
		self.VElements["ammo2"].color = Color(50, 50, 50, 255)
		self.VElements["ammo1"].color = Color(color1, color2, color3, 255)
	end
	if( self.Weapon:Clip1() == 0 ) then 
		self.VElements["ammo4"].color = Color(50, 50, 50, 255)
		self.VElements["ammo3"].color = Color(50, 50, 50, 255)
		self.VElements["ammo2"].color = Color(50, 50, 50, 255)
		self.VElements["ammo1"].color = Color(50, 50, 50, 255)
	end
end