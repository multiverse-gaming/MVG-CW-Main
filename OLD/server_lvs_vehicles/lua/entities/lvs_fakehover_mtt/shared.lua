
ENT.Base = "lvs_base_fakehover"

ENT.PrintName = "MTT"
ENT.Author = "Heracles421 LFS | Dandy LVS Convert"
ENT.Information = "Trade Federation Hover Transport. Later used in the Droid army of the Separatists"
ENT.Category = "[LVS] - CIS Vehicles"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/heracles421/galactica_vehicles/mtt.mdl"
ENT.GibModels = {
	"models/heracles421/galactica_vehicles/mtt.mdl",
}


ENT.AITEAM = 1

ENT.MaxHealth = 10000

ENT.ForceAngleMultiplier = 2
ENT.ForceAngleDampingMultiplier = 1

ENT.ForceLinearMultiplier = 1
ENT.ForceLinearRate = 0.25

ENT.MaxVelocityX = 100
ENT.MaxVelocityY = 100

ENT.MaxTurnRate = 0.08

ENT.BoostAddVelocityX = 120
ENT.BoostAddVelocityY = 120

ENT.GroundTraceHitWater = true
ENT.GroundTraceLength = 50
ENT.GroundTraceHull = 100


function ENT:OnSetupDataTables()
	self:AddDT( "Bool", "IsCarried" )
	self:AddDT( "Entity", "GunnerSeat" )
	self:AddDT( "Float", "TurretPitch" )
	self:AddDT( "Float", "TurretYaw" )

	if SERVER then
		self:NetworkVarNotify( "IsCarried", self.OnIsCarried )
	end
end

function ENT:GetAimAngles()
	local trace = self:GetEyeTrace()

	local AimAnglesR = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld( Vector(10,-60,81) ) ):GetNormalized():Angle() )
	local AimAnglesL = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld( Vector(10,60,81) ) ):GetNormalized():Angle() )

	return AimAnglesR, AimAnglesL
end

function ENT:WeaponsInRange()
	if self:GetIsCarried() then return false end

	local AimAnglesR, AimAnglesL = self:GetAimAngles()

	return not ((AimAnglesR.p >= 20 and AimAnglesL.p >= 20) or (AimAnglesR.p <= -30 and AimAnglesL.p <= -30) or (math.abs(AimAnglesL.y) + math.abs(AimAnglesL.y)) >= 60)
end

function ENT:InitWeapons()
	local weapon = {}
	weapon.Icon = Material("lvs/weapons/hmg.png")
	weapon.Ammo = 1500
	weapon.Delay = 0.2
	weapon.HeatRateUp = 0.35
	weapon.HeatRateDown = 0.25
	weapon.Attack = function( ent )
		if not ent:WeaponsInRange() then return true end

		local ID_L = self:LookupAttachment( "muzzle_right_top" )
		local ID_R = self:LookupAttachment( "muzzle_left_top" )
		local MuzzleL = self:GetAttachment( ID_L )
		local MuzzleR = self:GetAttachment( ID_R )

		if not MuzzleL or not MuzzleR then return end

		ent.MirrorPrimary = not ent.MirrorPrimary

		local Pos = ent.MirrorPrimary and MuzzleL.Pos or MuzzleR.Pos
		local Dir =  (ent.MirrorPrimary and MuzzleL.Ang or MuzzleR.Ang):Up()

		local bullet = {}
		bullet.Src 	= Pos
		bullet.Dir 	= Dir
		bullet.Spread 	= Vector( 0.01,  0.01, 0 )
		bullet.TracerName = "lvs_laser_red_short"
		bullet.Force	= 100
		bullet.HullSize 	= 1
		bullet.Damage	= 300
		bullet.Velocity = 12000
		bullet.Attacker 	= ent:GetDriver()
		bullet.Callback = function(att, tr, dmginfo)
			local effectdata = EffectData()
				effectdata:SetStart( Vector(255,50,50) ) 
				effectdata:SetOrigin( tr.HitPos )
				effectdata:SetNormal( tr.HitNormal )
			util.Effect( "lvs_laser_impact", effectdata )
		end
		ent:LVSFireBullet( bullet )

		local effectdata = EffectData()
		effectdata:SetStart( Vector(255,50,50) )
		effectdata:SetOrigin( bullet.Src )
		effectdata:SetNormal( Dir )
		effectdata:SetEntity( ent )
		util.Effect( "lvs_muzzle_colorable", effectdata )

		ent:TakeAmmo()

		if ent.MirrorPrimary then
			if not IsValid( ent.SNDLeft ) then return end
	
			ent.SNDLeft:PlayOnce()

			return
		end

		if not IsValid( ent.SNDRight ) then return end

		ent.SNDRight:PlayOnce()
	end
	weapon.OnSelect = function( ent )
		ent:EmitSound("physics/metal/weapon_impact_soft3.wav")
	end
	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	weapon.OnThink = function( ent, active )
		if ent:GetIsCarried() then
			self:SetPoseParameter("cannon_right_pitch", 0 )
			self:SetPoseParameter("cannon_right_yaw", 0 )

			self:SetPoseParameter("cannon_left_pitch", 0 )
			self:SetPoseParameter("cannon_left_yaw", 0 )

			return
		end

		local AimAnglesR, AimAnglesL = ent:GetAimAngles()

		self:SetPoseParameter("right_gun_pitch", AimAnglesR.p )
		self:SetPoseParameter("right_gun_yaw", AimAnglesR.y )
		self:SetPoseParameter("left_gun_pitch", AimAnglesL.p )
		self:SetPoseParameter("left_gun_yaw", AimAnglesL.y )
	end
	self:AddWeapon( weapon )

	//self:InitTurret()
end

ENT.EngineSounds = {
	{
	name = "GALACTICA_MTT_ENGINE",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 120,
	pitch = 85,
	sound = "heracles421/galactica_vehicles/mtt_engine.wav"
	},
}

sound.Add( {
	name = "LVS.AAT.FIRE_MISSILE",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 125,
	pitch = {65, 85},
	sound = "heracles421/galactica_vehicles/mtt_sideguns_fire.mp3"
} )

sound.Add( {
	name = "LVS.AAT.LASER_EXPLOSION",
	channel = CHAN_STATIC,
	volume = 1,
	level = 75,
	pitch = {160, 180},
	sound = "heracles421/galactica_vehicles/mtt_sideguns_fire.mp3"
} )