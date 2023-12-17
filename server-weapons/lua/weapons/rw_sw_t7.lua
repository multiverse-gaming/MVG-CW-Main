SWEP.Gun							= ("evil_sw_t7")
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Base							= "tfa_3dscoped_base"
SWEP.Category						= "TFA StarWars Reworked Explosif"
SWEP.Manufacturer 					= "Secret Factory"
SWEP.Author							= "ChanceSphere574"
SWEP.Contact						= ""
SWEP.Spawnable						= true
SWEP.AdminSpawnable					= true
SWEP.DrawCrosshair					= true
SWEP.DrawCrosshairIS 				= false
SWEP.PrintName						= "T-7 Ion Disruptor"
SWEP.Type							= "Disruptor Ion Rifle"
SWEP.DrawAmmo						= true
SWEP.data 							= {}
SWEP.data.ironsights				= 1
SWEP.Secondary.IronFOV				= 75
SWEP.Slot							= 4
SWEP.SlotPos						= 1

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

SWEP.Primary.ClipSize				= 1
SWEP.Primary.DefaultClip			= 1*15
SWEP.Primary.RPM					= 280
SWEP.Primary.RPM_Burst				= 280
SWEP.Primary.Ammo					= "ar2"
SWEP.Primary.AmmoConsumption 		= 1
SWEP.Primary.Range 					= 40000
SWEP.Primary.RangeFalloff 			= -1
SWEP.Primary.NumShots				= 1
SWEP.Primary.Automatic				= false
SWEP.Primary.RPM_Semi				= nil
SWEP.Primary.BurstDelay				= 3
SWEP.Primary.Sound 					= Sound ("w/t7.wav");
SWEP.Primary.ReloadSound 			= Sound ("w/reload.wav");
SWEP.Primary.PenetrationMultiplier 	= 0
SWEP.Primary.Damage					= 500
SWEP.Primary.HullSize 				= 0
SWEP.DamageType 					= nil
SWEP.Primary.Force 					= 0
SWEP.Primary.Knockback 				= 0

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

SWEP.ProjectileEntity 				= nil
SWEP.ProjectileModel 				= nil

SWEP.ViewModel						= "models/weapons/synbf3/c_dlt19.mdl"
SWEP.WorldModel						= "models/weapons/synbf3/w_dlt19.mdl"
SWEP.ViewModelFOV					= 70
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
SWEP.TracerName 					= "rw_sw_laser_blue"
SWEP.TracerCount 					= 1
SWEP.TracerLua 						= false
SWEP.TracerDelay					= 0.01
SWEP.ImpactEffect 					= "rw_sw_impact_blue"
SWEP.ImpactDecal 					= "FadingScorch"

SWEP.VMPos = Vector(0,-2,-2)
SWEP.VMAng = Vector(0, 0, 0)

SWEP.IronSightTime 					= 0.5
SWEP.Primary.KickUp					= 0.05/2
SWEP.Primary.KickDown				= 0.05/2
SWEP.Primary.KickHorizontal			= 0
SWEP.Primary.StaticRecoilFactor 	= 0.5
SWEP.Primary.Spread					= 0.07
SWEP.Primary.IronAccuracy 			= 0.001
SWEP.Primary.SpreadMultiplierMax 	= 1.5/2
SWEP.Primary.SpreadIncrement 		= 0.35
SWEP.Primary.SpreadRecovery 		= 0.98
SWEP.DisableChambering 				= true
SWEP.MoveSpeed 						= 0.8
SWEP.IronSightsMoveSpeed 			= 0.75

SWEP.IronSightsPos = Vector(-2.85, -7.5, 2.55)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(5.226, -2, 0)
SWEP.RunSightsAng = Vector(-18, 36, -13.5)
SWEP.InspectPos = Vector(8, -4.8, -3)
SWEP.InspectAng = Vector(11.199, 38, 0)

SWEP.ViewModelBoneMods = {
	["v_dlt19_reference001"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["w"] = { type = "Model", model = "models/hauptmann/star wars/weapons/ion_disruptor.mdl", bone = "v_dlt19_reference001", rel = "", pos = Vector(0.1, 9.5, -06.2), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["ret1"] = { type = "Model", model = "models/rtcircle.mdl", bone = "", rel = "w", pos = Vector(-05.05, -0.663, 11.787), angle = Angle(0, 180, 0), size = Vector(0.26, 0.26, 0.26), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {}, active = true  },
}	

SWEP.WElements = {
	["w"] = { type = "Model", model = "models/hauptmann/star wars/weapons/ion_disruptor.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11, 0.75, 02.5), angle = Angle(-12, 0, 180), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

SWEP.ThirdPersonReloadDisable		=false
SWEP.RTScopeAttachment				= -1
SWEP.Scoped_3D 						= false
SWEP.ScopeReticule 					= "cs574/scopes/battlefront_hd/sw_ret_redux_black" 
SWEP.Secondary.ScopeZoom 			= 10
SWEP.ScopeReticule_Scale 			= {1.12,1.12}

if surface then
	SWEP.Secondary.ScopeTable = {
		["ScopeMaterial"] =  Material("#sw/visor/sw_ret_redux_white.png", "smooth"),
		["ScopeBorder"] = color_black,
		["ScopeCrosshair"] = { ["r"] = 0, ["g"]  = 0, ["b"] = 0, ["a"] = 0, ["s"] = 1 }
	}
end
DEFINE_BASECLASS( SWEP.Base )

function SWEP:ShootBullet(damage, recoil, num_bullets, aimcone, disablericochet, bulletoverride)
	if not IsFirstTimePredicted() and not game.SinglePlayer() then return end
	local num_bullets = num_bullets or 1
	local aimcone = aimcone or 0

    if self.TracerName and self.TracerName ~= "" then
        if self.TracerPCF then
            TracerName = nil
            self.MainBullet.PCFTracer = self.TracerName
            self.MainBullet.Tracer = 0
        else
            TracerName = self.TracerName
        end
    end
    local dmgType = self:GetStat("Primary.DamageType")
    TracerName = "effect_sw_laser_blue"
    dmgType = DMG_DISSOLVE


    self.MainBullet.Attacker = self:GetOwner()
    self.MainBullet.Inflictor = self
    self.MainBullet.Num = num_bullets
    self.MainBullet.Src = self:GetOwner():GetShootPos()
    self.MainBullet.Dir = self:GetOwner():GetAimVector()
    self.MainBullet.HullSize = self:GetStat("Primary.HullSize") or 0
    self.MainBullet.Spread.x = aimcone
    self.MainBullet.Spread.y = aimcone
    if self.TracerPCF then
        self.MainBullet.Tracer = 0
    else
        self.MainBullet.Tracer = self.TracerCount and self.TracerCount or 3
    end
    self.MainBullet.TracerName = TracerName
    self.MainBullet.PenetrationCount = 0
    self.MainBullet.AmmoType = self:GetPrimaryAmmoType()
    self.MainBullet.Force = damage / 6 * math.sqrt(self:GetStat("Primary.KickUp") + self:GetStat("Primary.KickDown") + self:GetStat("Primary.KickHorizontal")) 
    self.MainBullet.Damage = damage
    self.MainBullet.HasAppliedRange = false

    if self.CustomBulletCallback then
        self.MainBullet.Callback2 = self.CustomBulletCallback
    end

    self.MainBullet.Callback = function(a, b, c)
        if IsValid(self) then
            c:SetInflictor(self)
            if self.MainBullet.Callback2 then
                self.MainBullet.Callback2(a, b, c)
            end

            self.MainBullet:Penetrate(a, b, c, self)

            self:PCFTracer( self.MainBullet, b.HitPos or vector_origin )

            c:SetDamageType(dmgType)
        end
    end

    self:GetOwner():FireBullets(self.MainBullet)
end

if CLIENT then
	time = CurTime()
	scopecvar = false
end

function SWEP:Think(...)
	BaseClass.Think(self, ...)
	if CLIENT then
		if time <= CurTime() + 1 then 
			local scopecvar = GetConVar("cl_tfa_3dscope"):GetBool()
			time = CurTime() + 5
		end

		if scopecvar == true then
			
			self.Secondary.ScopeTable["ScopeMaterial"] =  Material("#sw/visor/sw_ret_redux_yellow.png", "smooth")

			

		else
			self.Secondary.ScopeTable["ScopeMaterial"] =  Material("scope/gdcw_svdsight.png", "smooth")
			self.Secondary.ScopeTable["ScopeBorder"] = nil

		end
	end
end