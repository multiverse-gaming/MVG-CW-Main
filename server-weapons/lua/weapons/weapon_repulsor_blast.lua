SWEP.Gun							= ("rw_sw_dc15a")
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Base							= "tfa_gun_base"
SWEP.Category = "[MVG] Miscellaneous Equipment"
SWEP.Manufacturer 					= ""
SWEP.Author							= "Tiny Tom"
SWEP.Contact						= ""
SWEP.Spawnable						= true
SWEP.AdminSpawnable					= true
SWEP.DrawCrosshair					= true
SWEP.DrawCrosshairIS 				= true
SWEP.PrintName						= "Repulsor Blast"
SWEP.Type							= "Discharges a short-range shockwave that temporarily disorients enemies and knocks them back."


SWEP.DrawAmmo						= true
SWEP.data 							= {}
SWEP.data.ironsights				= 1
SWEP.Secondary.IronFOV				= 80
SWEP.Slot							= 3
SWEP.SlotPos						= 100

SWEP.FiresUnderwater 				= true

SWEP.IronInSound 					= nil
SWEP.IronOutSound 					= nil
SWEP.CanBeSilenced					= false
SWEP.Silenced 						= false
SWEP.DoMuzzleFlash 					= false
SWEP.SelectiveFire					= false
SWEP.DisableBurstFire				= true
SWEP.OnlyBurstFire					= false
SWEP.DefaultFireMode 				= nil
SWEP.FireModeName 					= nil
SWEP.DisableChambering 				= true

SWEP.Primary.ClipSize				= 1
SWEP.Primary.DefaultClip			= 1
SWEP.Primary.RPM					= 8
SWEP.Primary.Ammo					= "Pistol"
SWEP.Primary.AmmoConsumption 		= 1
SWEP.Primary.Range 					= 50
SWEP.Primary.RangeFalloff 			= -1
SWEP.Primary.NumShots				= 1
SWEP.Primary.Automatic				= false
SWEP.Primary.RPM_Semi				= 150
SWEP.Primary.Delay				    = 0
SWEP.Primary.Sound 					= Sound ("w/dc17m.wav");
SWEP.Primary.ReloadSound 			= Sound ("w/reload_fast.wav");
SWEP.Primary.PenetrationMultiplier 	= 0
SWEP.Primary.Damage					= 150
SWEP.Primary.HullSize 				= 15
SWEP.Primary.Spread					= 0
SWEP.Primary.Cone					= 0
SWEP.AllowSprintAttack             	= true
SWEP.DamageType 					= DMG_BLAST

SWEP.FireModes = {
	"Single",
}


SWEP.IronRecoilMultiplier			= 0.5
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
SWEP.SprintFOVOffset 				= 2
SWEP.ProjectileVelocity 			= 9

SWEP.ProjectileEntity 				= nil
SWEP.ProjectileModel 				= nil

SWEP.ViewModel						= "models/delta/c_wrist_blaster.mdl"
SWEP.WorldModel						= "models/delta/c_wrist_blaster.mdl"
SWEP.ViewModelFOV					= 54
SWEP.ViewModelFlip					= false
SWEP.MaterialTable 					= nil
SWEP.UseHands 						= true
SWEP.HoldType 						= "pistol"
SWEP.ReloadHoldTypeOverride 		= "pistol"

SWEP.ShowWorldModel = false

SWEP.BlowbackEnabled 				= false
SWEP.BlowbackVector 				= Vector(0, -1, .5)
SWEP.BlowbackCurrentRoot			= 0
SWEP.BlowbackCurrent 				= 0.3
SWEP.BlowbackBoneMods 				= nil
SWEP.Blowback_Only_Iron 			= true
SWEP.Blowback_PistolMode 			= false
SWEP.Blowback_Shell_Enabled 		= false
SWEP.Blowback_Shell_Effect 			= "None"

SWEP.Tracer							= 0
SWEP.TracerName 					= nil
SWEP.TracerCount 					= 1
SWEP.TracerLua 						= true
SWEP.TracerDelay					= 0
SWEP.ImpactEffect 					= "impact"

SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)

SWEP.IronSightTime 					= 0.45
SWEP.Primary.KickUp					= 0.9
SWEP.Primary.KickDown				= 0.9
SWEP.Primary.KickHorizontal			= 0.02
SWEP.Primary.StaticRecoilFactor 	= 0.4
SWEP.Primary.Spread					= .1
SWEP.Primary.IronAccuracy 			= 0.05
SWEP.Primary.SpreadMultiplierMax 	= 1.5
SWEP.Primary.SpreadIncrement 		= 0.35
SWEP.Primary.SpreadRecovery 		= 0.98
SWEP.DisableChambering 				= true
SWEP.MoveSpeed 						= 0.9
SWEP.IronSightsMoveSpeed 			= 0.75

SWEP.IronSightsPos = Vector(-7.841, -7.84, 0.28)
SWEP.IronSightsAng = Vector(0, -4.926, 0)
SWEP.RunSightsPos = Vector(5.226, -2, 0)
SWEP.RunSightsAng = Vector(-18, 36, -13.5)
SWEP.InspectPos = Vector(7.034, -6.835, -6.231)
SWEP.InspectAng = Vector(29.548, 36.583, 11.96)

SWEP.Tracer							= 0
SWEP.TracerName 					= "rw_sw_laser_blue"
SWEP.TracerCount 					= 1
SWEP.TracerLua 						= false
SWEP.TracerDelay					= 0.01
SWEP.ImpactEffect 					= "rw_sw_impact_blue"
SWEP.ImpactDecal 					= "FadingScorch"

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_Spine4"] = { scale = Vector(1, 1, 1), pos = Vector(-0.926, -0.556, 0.925), angle = Angle(0, -3.333, 0) }
}

SWEP.VElements = {

}

SWEP.WElements = {
	["world"] = { type = "Model", model = "models/cs574/weapons/arc_leftwrist.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(6, 0, 2.7), angle = Angle(180, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


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

function SWEP:PrimaryAttack()
	self:PrePrimaryAttack()
	if self.Owner:IsNPC() then
		if self:Clip1() <= 0 then
			if SERVER then
				self.Owner:SetSchedule(SCHED_RELOAD)
			end

			return
		end

		if SERVER and CurTime() < self:GetNextPrimaryFire() then return false end

		local times_to_fire = 2

		if self.OnlyBurstFire then
			times_to_fire = 3
		end

		if self.Primary.Automatic then
			times_to_fire = math.random(5, 8)
		end

		self:SetNextPrimaryFire(CurTime() + (((self.Primary.RPM / 60) / 100) * times_to_fire) + math.random(0.2, 0.6))

		timer.Create("GunTimer" .. tostring(self:GetOwner():EntIndex()), (self.Primary.RPM / 60) / 100, times_to_fire, function()
			if not IsValid(self) then return end
			if not IsValid(self.Owner) then return end
			if not self:GetOwner().GetShootPos then return end
			self:EmitGunfireSound(self.Primary.Sound)
			self:TakePrimaryAmmo(1)
			local damage_to_do = self.Primary.Damage * npc_ar2_damage_cv:GetFloat() / 16
			local bullet = {}
			bullet.Num = self.Primary.NumShots
			bullet.Src = self.Owner:GetShootPos()
			bullet.Dir = self.Owner:GetAimVector()
			bullet.Tracer = 1
			bullet.Damage = damage_to_do
			bullet.AmmoType = self.Primary.Ammo
			self.Owner:FireBullets(bullet)
		end)

		return
	end

	if not IsValid(self) then return end
	if not self:VMIV() then return end
	if not self:CanPrimaryAttack() then return end
	if hook.Run("TFA_PrimaryAttack",self) then return end

	if self.CanBeSilenced and self:GetOwner():KeyDown(IN_USE) and (SERVER or not sp) then
		self:ChooseSilenceAnim(not self:GetSilenced())
		local _, tanim = self:SetStatus(TFA.Enum.STATUS_SILENCER_TOGGLE)
		self:SetStatusEnd(l_CT() + self:GetActivityLength(tanim, true))

		return
	end

	self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())

	if self:GetMaxBurst() > 1 then
		self:SetBurstCount(math.max(1, self:GetBurstCount() + 1))
	end

	if self:GetStat("PumpAction") and self:GetShotgunCancel() then return end
	self:SetStatus(TFA.Enum.STATUS_SHOOTING)
	self:SetStatusEnd(self:GetNextPrimaryFire())
	self:ToggleAkimbo()
	local _, tanim = self:ChooseShootAnim()

	if (not sp) or (not self:IsFirstPerson()) then
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	end

	if self:GetStat("Primary.Sound") and IsFirstTimePredicted() and not (sp and CLIENT) then
		if self:GetOwner():IsPlayer() and self:GetStat("Primary.LoopSound") and (not self:GetStat("Primary.LoopSoundAutoOnly", false) or self.Primary.Automatic) then
			self:EmitGunfireLoop()
		elseif self:GetStat("Primary.SilencedSound") and self:GetSilenced() then
			self:EmitGunfireSound(self:GetStat("Primary.SilencedSound"))
		else
			self:EmitGunfireSound(self:GetStat("Primary.Sound"))
		end
	end

	self:TakePrimaryAmmo(self:GetStat("Primary.AmmoConsumption"))

	if self:Clip1() == 0 and self:GetStat("Primary.ClipSize") > 0 then
		self:SetNextPrimaryFire(math.max(self:GetNextPrimaryFire(), CurTime() + (self.Primary.DryFireDelay or self:GetActivityLength(tanim, true))))
	end

	--self:ShootBulletInformation()
	self:ShootTractor()
	self:UpdateJamFactor()
	local _, CurrentRecoil = self:CalculateConeRecoil()
	self:Recoil(CurrentRecoil, IsFirstTimePredicted())

	if sp and SERVER then
		self:CallOnClient("Recoil", "")
	end

	if self.MuzzleFlashEnabled and (not self:IsFirstPerson() or not self.AutoDetectMuzzleAttachment) then
		self:ShootEffectsCustom()
	end

	if self.EjectionSmoke and CLIENT and self:GetOwner() == LocalPlayer() and IsFirstTimePredicted() and not self.LuaShellEject then
		self:EjectionSmoke()
	end

	self:DoAmmoCheck()

	if self:GetStatus() == TFA.GetStatus("shooting") and self:GetStat("PumpAction") then
		if self:Clip1() == 0 and self:GetStat("PumpAction").value_empty then
			--finalstat = TFA.GetStatus("pump_ready")
			self:SetShotgunCancel(true)
		elseif (self:GetStat("Primary.ClipSize") < 0 or self:Clip1() > 0) and self:GetStat("PumpAction").value then
			--finalstat = TFA.GetStatus("pump_ready")
			self:SetShotgunCancel(true)
		end
	end

	if IsFirstTimePredicted() then
		self:RollJamChance()
	end

	self:PostPrimaryAttack()
	hook.Run("TFA_PostPrimaryAttack",self)
end

function SWEP:ShootTractor()
	local aim = self.Owner:GetAimVector()
	local force  = (self.Owner:GetUp()*math.random(10, 15)) + (self.Owner:GetForward()*math.random(50, 60))

	ParticleEffectAttach("tractor_cannon_muzzle", 4, self.OwnerViewModel, self.OwnerViewModel:LookupAttachment("muzzle"))
	ParticleEffectAttach("tractor_cannon_muzzle", 4, self.OwnerViewModel, self.OwnerViewModel:LookupAttachment("muzzle"))
	//print(self.OwnerViewModel:LookupAttachment("muzzle"))
	if SERVER then
		for k,v in pairs (ents.FindInCone(self.Owner:GetPos(), self.Owner:GetAimVector(), 250, math.cos(math.rad(60)))) do --AOE
			if v ~= self.Owner then
				if self.Owner:IsLineOfSightClear( v ) then
					if (v:IsNPC() || v:IsPlayer()) then
						v:SetVelocity(force*math.random(40, 25)) --knockback
						v:TakeDamage( 75, self.Owner, self ) --damage
					end
				end
			end
		end
	end
end
