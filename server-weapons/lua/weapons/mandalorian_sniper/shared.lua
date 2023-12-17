if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )

end

if ( CLIENT ) then

	SWEP.PrintName			= "Amban Phase-Pulse Sniper"

	SWEP.Author				= "Sim"

	SWEP.ViewModelFOV      	= 50

	SWEP.Slot				= 2

	SWEP.SlotPos			= 3

end

SWEP.Base					= "tfa_3dscoped_base"

SWEP.Category						= "TFA StarWars Reworked Galactic"

SWEP.Spawnable				= true

SWEP.AdminSpawnable			= true

SWEP.HoldType = "ar2"

SWEP.ViewModelFOV = 70

SWEP.ViewModelFlip = false

SWEP.ViewModel = "models/weapons/cstrike/c_snip_awp.mdl"

SWEP.WorldModel = "models/weapons/w_dc15sa.mdl"

SWEP.ShowViewModel = true

SWEP.ShowWorldModel = false

SWEP.UseHands = true

SWEP.Primary.Sound = Sound ("weapons/1misc_guns/wpn_balnab_rifle_shoot_02.ogg");  -- Change

--SWEP.Primary.ReloadSound = Sound ("weapons/mando_stuff/main_theme.wav");

SWEP.Primary.CritSound  = Sound ("ambient/levels/labs/electric_explosion5.wav")

SWEP.Primary.KickUp			= 5

SWEP.Weight					= 5

SWEP.AutoSwitchTo			= false

SWEP.AutoSwitchFrom			= false

SWEP.Primary.Recoil			= 0.5

SWEP.Primary.Damage			= 100

SWEP.Primary.NumShots		= 1

SWEP.Primary.Spread			= 0.0225

SWEP.Primary.IronAccuracy = .001	-- Ironsight accuracy, should be the same for shotguns

SWEP.Primary.ClipSize		= 1

SWEP.Primary.RPM            = 70

SWEP.Primary.DefaultClip	= 1

SWEP.Primary.Automatic		= false

SWEP.Primary.PenetrationPower = 1

SWEP.Primary.Ammo			= "ar2"

SWEP.SelectiveFire		= true --Allow selecting your firemode?

SWEP.DisableBurstFire	= false --Only auto/single?

SWEP.OnlyBurstFire		= false --No auto, only burst/single?

SWEP.DefaultFireMode 	= "Single" --Default to auto or whatev

SWEP.FireModes = {

"Single",

"2Burst"

}

SWEP.FireModeName = nil --Change to a text value to override it

SWEP.Secondary.Automatic	= false

SWEP.Secondary.Ammo			= "none"

SWEP.Secondary.IronFOV = 70

SWEP.ViewModelBoneMods = {

	["v_weapon.awm_parent"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }

}

SWEP.IronSightsPos = Vector(-5.46, -10, 2.78)

SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.VElements = {

	["element_scope"] = { type = "Model", model = "models/rtcircle.mdl", bone = "v_weapon.awm_parent", rel = "", pos = Vector(-1.95, -6.04 , -1.1), angle = Angle(90, 180, 90), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {} },

	["element_name"] = { type = "Model", model = "models/weapons/twcustom/mando_sniper/mando_sniper.mdl", bone = "v_weapon.awm_parent", rel = "", pos = Vector(-0.519, 2, -10), angle = Angle(-90, 90, 0), size = Vector(1.274, 1.274, 1.274), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }

}

SWEP.WElements = {

	["element_name"] = { type = "Model", model = "models/weapons/twcustom/mando_sniper/mando_sniper.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.3, 0.899, -0.101), angle = Angle(-170, 177, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }

}

SWEP.BlowbackVector = Vector(0,-3,0.025)

SWEP.Blowback_Only_Iron  = false

SWEP.DoProceduralReload = true

SWEP.ProceduralReloadTime = 8

----Swft Base Code

SWEP.TracerCount = 1

SWEP.MuzzleFlashEffect = ""

SWEP.TracerName = "effect_sw_laser_yellow"

SWEP.Secondary.IronFOV = 70

SWEP.Primary.KickUp = 3

SWEP.Primary.KickDown = 0.1

SWEP.Primary.KickHorizontal = 0.1

SWEP.Primary.KickRight = 0.1

SWEP.DisableChambering = true

SWEP.ImpactDecal = "FadingScorch"

SWEP.ImpactEffect = "effect_sw_impact" --Impact Effect

SWEP.RunSightsPos = Vector(2.127, 0, 1.355)

SWEP.RunSightsAng = Vector(-15.775, 10.023, -5.664)

SWEP.BlowbackEnabled = true

SWEP.BlowbackVector = Vector(0,-3,0.1)

SWEP.Blowback_Shell_Enabled = false

SWEP.Blowback_Shell_Effect = ""

SWEP.ThirdPersonReloadDisable=false

SWEP.Primary.DamageType = DMG_SHOCK

SWEP.DamageType = DMG_SHOCK

--3dScopedBase stuff

SWEP.RTMaterialOverride = 0

SWEP.RTScopeAttachment = -1

SWEP.Scoped_3D = true

SWEP.ScopeReticule = "scope/gdcw_green_nobar"

SWEP.Secondary.ScopeZoom = 6

SWEP.ScopeReticule_Scale = {2.5,2.5}

SWEP.Secondary.UseACOG			= false	 --Overlay option

SWEP.Secondary.UseMilDot			= false			 --Overlay option

SWEP.Secondary.UseSVD			= false		 --Overlay option

SWEP.Secondary.UseParabolic		= false		 --Overlay option

SWEP.Secondary.UseElcan			= false	 --Overlay option

SWEP.Secondary.UseGreenDuplex		= false		 --Overlay option

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

--[[

SWEP.HoldType = "ar2"

SWEP.ViewModelFOV = 70

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/cstrike/c_snip_awp.mdl"

SWEP.WorldModel = "models/weapons/w_dc15sa.mdl"

SWEP.ShowViewModel = true

SWEP.ShowWorldModel = false

SWEP.ViewModelBoneMods = {

	["v_weapon.awm_parent"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }

}

SWEP.IronSightsPos = Vector(-6.921, -2.412, 1.2)

SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.VElements = {

	["element_scope"] = { type = "Model", model = "models/rtcircle.mdl", bone = "v_weapon.awm_parent", rel = "", pos = Vector(-0.519, -7.6, 0.518), angle = Angle(90, 180, 0), size = Vector(0.36, 0.36, 0.36), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {} },

	["element_name"] = { type = "Model", model = "models/swbf3/outerrim/weapons/dlt19x.mdl", bone = "v_weapon.awm_parent", rel = "", pos = Vector(-0.519, 2, -10), angle = Angle(-90, 90, 0), size = Vector(1.274, 1.274, 1.274), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }

}

SWEP.WElements = {

	["element_name"] = { type = "Model", model = "models/swbf3/outerrim/weapons/dlt19x.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.3, 0.899, -0.101), angle = Angle(-170, 177, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }

}

]]


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
    if self:Clip1()%5 == 0 then
        self:EmitSound(self:GetStat("Primary.CritSound"))
        damage = damage*3
        TracerName = "effect_sw_laser_red"
        dmgType = DMG_DISSOLVE
    end


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
