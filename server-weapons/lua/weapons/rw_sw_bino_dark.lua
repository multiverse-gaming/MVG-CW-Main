SWEP.Gun							= ("rw_sw_bino_dark")
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Base							= "tfa_3dscoped_base"
SWEP.Category						= "TFA StarWars Reworked Other"
SWEP.Manufacturer 					= ""
SWEP.Author							= "ChanceSphere574"
SWEP.Contact						= ""
SWEP.Spawnable						= true
SWEP.AdminSpawnable					= true
SWEP.DrawCrosshair					= false
SWEP.DrawCrosshairIS 				= false
SWEP.PrintName						= "Binoculars (Dark)"
SWEP.Type							= "StarWars Dark Binoculars"
SWEP.DrawAmmo						= false
SWEP.data 							= {}
SWEP.data.ironsights				= 0
SWEP.Secondary.IronFOV				= 75

SWEP.FiresUnderwater 				= true

SWEP.IronInSound 					= nil
SWEP.IronOutSound 					= nil
SWEP.CanBeSilenced					= false
SWEP.Silenced 						= false
SWEP.DoMuzzleFlash 					= false
SWEP.SelectiveFire					= false
SWEP.DisableBurstFire				= false
SWEP.OnlyBurstFire					= false
SWEP.DefaultFireMode 				= "auto"
SWEP.FireModeName 					= nil
SWEP.DisableChambering 				= true

SWEP.Primary.ClipSize				= 0
SWEP.Primary.DefaultClip			= 0
SWEP.Primary.RPM					= 0
SWEP.Primary.RPM_Burst				= 0
SWEP.Primary.Ammo					= "bino"
SWEP.Primary.AmmoConsumption 		= 1
SWEP.Primary.Range 					= 0
SWEP.Primary.RangeFalloff 			= 0
SWEP.Primary.NumShots				= 0
SWEP.Primary.Automatic				= 0
SWEP.Primary.RPM_Semi				= 0
SWEP.Primary.BurstDelay				= 0
SWEP.Primary.Sound 					= nil
SWEP.Primary.ReloadSound 			= nil
SWEP.Primary.PenetrationMultiplier 	= 0
SWEP.Primary.Damage					= 0
SWEP.Primary.HullSize 				= 0
SWEP.DamageType 					= 0

SWEP.DoMuzzleFlash 					= false

SWEP.FireModes = {
	"none"
}

SWEP.IronRecoilMultiplier			= 0
SWEP.CrouchRecoilMultiplier			= 0
SWEP.JumpRecoilMultiplier			= 0
SWEP.WallRecoilMultiplier			= 0
SWEP.ChangeStateRecoilMultiplier	= 0
SWEP.CrouchAccuracyMultiplier		= 0
SWEP.ChangeStateAccuracyMultiplier	= 0
SWEP.JumpAccuracyMultiplier			= 0
SWEP.WalkAccuracyMultiplier			= 0
SWEP.NearWallTime 					= 0.25
SWEP.ToCrouchTime 					= 0.1
SWEP.WeaponLength 					= 35
SWEP.SprintFOVOffset 				= 12
SWEP.ProjectileVelocity 			= 9

SWEP.ProjectileEntity 				= nil
SWEP.ProjectileModel 				= nil

SWEP.ViewModel						= "models/bf2017/c_scoutblaster.mdl"
SWEP.WorldModel						= "models/bf2017/w_scoutblaster.mdl"
SWEP.ViewModelFOV					= 75
SWEP.ViewModelFlip					= false
SWEP.MaterialTable 					= nil
SWEP.UseHands 						= true
SWEP.HoldType 						= "slam"

SWEP.ShowWorldModel = false

SWEP.BlowbackEnabled 				= true
SWEP.BlowbackVector 				= Vector(0,-2.5,-0.05)
SWEP.BlowbackCurrentRoot			= 0
SWEP.BlowbackCurrent 				= 0
SWEP.BlowbackBoneMods 				= nil
SWEP.Blowback_Only_Iron 			= true
SWEP.Blowback_PistolMode 			= false
SWEP.Blowback_Shell_Enabled 		= false
SWEP.Blowback_Shell_Effect 			= "None"

SWEP.Tracer							= 0
SWEP.TracerName 					= nil
SWEP.TracerCount 					= 1
SWEP.TracerLua 						= false
SWEP.TracerDelay					= 0.01
SWEP.ImpactEffect 					= nil
SWEP.ImpactDecal 					= nil

SWEP.VMPos = Vector(6, -5, 0)
SWEP.VMAng = Vector(0,0,0)

SWEP.IronSightTime 					= 0.5
SWEP.Primary.KickUp					= 0
SWEP.Primary.KickDown				= 0
SWEP.Primary.KickHorizontal			= 0
SWEP.Primary.StaticRecoilFactor 	= 0
SWEP.Primary.Spread					= 0
SWEP.Primary.IronAccuracy 			= 0
SWEP.Primary.SpreadMultiplierMax 	= 0
SWEP.Primary.SpreadIncrement 		= 0
SWEP.Primary.SpreadRecovery 		= 0
SWEP.DisableChambering 				= true
SWEP.MoveSpeed 						= 1
SWEP.IronSightsMoveSpeed 			= 0.5

SWEP.IronSightsPos = Vector(-6.85, -6, 4.8332)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-40, 0, 0)
SWEP.InspectPos = Vector(-5, 0, 3)
SWEP.InspectAng = Vector(0, 0, 0)

SWEP.ViewModelBoneMods = {
	["v_scoutblaster_reference001"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, -0.3, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["bino"] = { type = "Model", model = "models/nate159/swbf2015/pewpew/electrobinocular.mdl", bone = "v_scoutblaster_reference001", rel = "", pos = Vector(-5, 2, 0), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "anthonyfuller/macrobinoculars/t_electrobinocularstd23_c_dark", skin = 0, bodygroup = {}},
	["scope1"] = { type = "Model", model = "models/rtcircle.mdl", bone = "v_scoutblaster_reference001", rel = "bino", pos = Vector(-5.5, 1.6, 0.36), angle = Angle(0, 180, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = true, material = "!tfa_rtmaterial", skin = 0, bodygroup = {}, active = false   },
	["scope2"] = { type = "Model", model = "models/rtcircle.mdl", bone = "v_scoutblaster_reference001", rel = "bino", pos = Vector(-5.5, -1.6, 0.36), angle = Angle(0, 180, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = true, material = "!tfa_rtmaterial", skin = 0, bodygroup = {}, active = false   },
	--["b1"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "v_scoutblaster_reference001", rel = "bino", pos = Vector(-3.83, -0.025, -0.352), angle = Angle(0, 0, 0), size = Vector(0.16, 0.16, 0.175), color = Color(0, 255, 0, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {}, active = false   },
	--["b2"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "v_scoutblaster_reference001", rel = "bino", pos = Vector(-3.85, -0.350, -1.236), angle = Angle(0, 0, 0), size = Vector(0.16, 0.168, 0.16), color = Color(0, 255, 0, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {}, active = false   },
	--["b3"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "v_scoutblaster_reference001", rel = "bino", pos = Vector(-3.85, 0.33, -1.236), angle = Angle(0, 0, 0), size = Vector(0.16, 0.16, 0.16), color = Color(0, 255, 0, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {}, active = false   },

	["txt_range_m"] = { type = "Quad", bone = "", rel = "scope1", pos = Vector(0.01, 0.72, 0.085), angle = Angle(0, 90, 90), size = 0.00045, draw_func = nil, active = true },
	["txt_range_wu"] = { type = "Quad", bone = "", rel = "scope1", pos = Vector(0.01, 0.72, -0.01), angle = Angle(0, 90, 90), size = 0.00045, draw_func = nil, active = true },
	["txt_mod"] = { type = "Quad", bone = "", rel = "scope1", pos = Vector(0.01, -0.6, 0.10), angle = Angle(0, 90, 90), size = 0.0005, draw_func = nil, active = true },
}

SWEP.WElements = {
	["bino"] = { type = "Model", model = "models/nate159/swbf2015/pewpew/electrobinocular.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9, 6.2, -2.6), angle = Angle(15, -6, 193), size = Vector(1.25, 1.25, 1.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "anthonyfuller/macrobinoculars/t_electrobinocularstd23_c_dark", skin = 0, bodygroup = {} }
}

SWEP.Attachments = {
	[1] = { 
		offset = { 0, 0 }, 
		atts = {
			"bino_zoom_2",
			"bino_zoom_4",
			"bino_zoom_6",
			"bino_zoom_8",
			"bino_zoom_10",
			"bino_zoom_12"
		}, 
		order = 1,
		sel = 1,
	},
}

if CLIENT then
	surface.CreateFont( "Test", {
		font = "Aurebesh",extended = false,size = 200,weight = 0,blursize = 0,scanlines = 0,
		antialias = false,underline = false,italic = false,strikeout = false,symbol = false,
		rotary = false,shadow = false,additive = false,outline = false,
	})
end

SWEP.ThirdPersonReloadDisable		= false
SWEP.Primary.DamageType 			= nil
SWEP.DamageType 					= nil
SWEP.RTScopeAttachment				= -1
SWEP.Scoped_3D 						= false
SWEP.ScopeReticule 					= "scope/gdcw_white_nobar"
SWEP.Secondary.ScopeZoom 			= 15
SWEP.ScopeReticule_Scale 			= {0.5,0.5}

if surface then
	SWEP.Secondary.ScopeTable = nil
end

DEFINE_BASECLASS( SWEP.Base )

function SWEP:Think(...)
	BaseClass.Think(self, ...)
	if CLIENT then
		if self:IronSights() then

			local o = self.Owner
			local oGSP = o:GetShootPos()
			local oGET = o:GetEyeTrace()
			local wu = oGSP:Distance( oGET.HitPos )
			wu = math.Round( wu, 0 )	
			local m = wu / 52.49
			m = math.Round( m, 0 )
			
			self.VElements["txt_range_m"].draw_func = function( weapon )
				draw.SimpleText(""..m.." M", "Test", 0, 0, Color(255, 255, 255, 81), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end		

			self.VElements["txt_range_wu"].draw_func = function( weapon )
				draw.SimpleText(""..wu.." WU", "Test", 0, 0, Color(255, 255, 255, 81), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end

			if self:IsAttached("bino_zoom_2") then
				self.VElements["txt_mod"].draw_func = function( weapon )
					draw.SimpleText("x2", "Test", 0, 0, Color(255, 255, 255, 81), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
				end 
			end
			if self:IsAttached("bino_zoom_4") then
				self.VElements["txt_mod"].draw_func = function( weapon )
					draw.SimpleText("x4", "Test", 0, 0, Color(255, 255, 255, 81), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
				end 
			end
			if self:IsAttached("bino_zoom_6") then
				self.VElements["txt_mod"].draw_func = function( weapon )
					draw.SimpleText("x6", "Test", 0, 0, Color(255, 255, 255, 81), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
				end 
			end
			if self:IsAttached("bino_zoom_8") then
				self.VElements["txt_mod"].draw_func = function( weapon )
					draw.SimpleText("x8", "Test", 0, 0, Color(255, 255, 255, 81), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
				end 
			end
			if self:IsAttached("bino_zoom_10") then
				self.VElements["txt_mod"].draw_func = function( weapon )
					draw.SimpleText("x10", "Test", 0, 0, Color(255, 255, 255, 81), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
				end 
			end
			if self:IsAttached("bino_zoom_12") then
				self.VElements["txt_mod"].draw_func = function( weapon )
					draw.SimpleText("x12", "Test", 0, 0, Color(255, 255, 255, 81), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
				end
			end
		else
			self.VElements["txt_mod"].draw_func = function( weapon )
				draw.SimpleText("", "Test", 0, 0, Color(255, 255, 255, 81), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			self.VElements["txt_range_m"].draw_func = function( weapon )
				draw.SimpleText("", "Test", 0, 0, Color(255, 255, 255, 81), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			self.VElements["txt_range_wu"].draw_func = function( weapon )
				draw.SimpleText("", "Test", 0, 0, Color(255, 255, 255, 81), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end
	end
end