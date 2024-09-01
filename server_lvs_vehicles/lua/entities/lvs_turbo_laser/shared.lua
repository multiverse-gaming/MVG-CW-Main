ENT.Type = "anim"
ENT.Base = "lvs_base_fakehover"

ENT.PrintName = "Turbolaser"
ENT.Author = "Dec"
ENT.Information = "Big Turbolasers make things go boom"
ENT.Category = "[LVS] SW-Vehicles"

ENT.Spawnable		= true
ENT.AdminSpawnable	= false


ENT.MDL = "models/starwars/sky/dec_vehicle/turbolaser/turbolaser1.mdl"
ENT.GibModels = {
	"models/gibs/helicopter_brokenpiece_01.mdl",
	"models/gibs/helicopter_brokenpiece_02.mdl",
	"models/gibs/helicopter_brokenpiece_03.mdl",
	"models/combine_apc_destroyed_gib02.mdl",
	"models/combine_apc_destroyed_gib04.mdl",
	"models/combine_apc_destroyed_gib05.mdl",
	"models/props_c17/trappropeller_engine.mdl",
	"models/gibs/airboat_broken_engine.mdl",
}


ENT.AITEAM = 2

ENT.MaxVelocityY = 0
ENT.BoostAddVelocityY = 0

ENT.ForceAngleMultiplier = 0
ENT.ForceAngleDampingMultiplier = 0

ENT.ForceLinearMultiplier = 0
ENT.ForceLinearRate = 0

ENT.MaxVelocityZ = 0
ENT.BoostAddVelocityZ = 0

ENT.MaxHealth = 10000
ENT.MaxShield = 0
ENT.MaxVelocityX = 0
ENT.BoostAddVelocitX = 0
ENT.IgnoreWater = false

ENT.MaxTurnRate = 0

ENT.GroundTraceLength = 0
ENT.GroundTraceHull = 0

function ENT:OnSetupDataTables()
	self:AddDT( "Entity", "GunnerSeat" )
end

function ENT:GetAimAngles( ent )
    local trace = ent:GetEyeTrace()
    local AimAngles = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld( Vector(0,0,115) ) ):GetNormalized():Angle() )

    return AimAngles
end



function ENT:InitWeapons()
	local weapon = {}
	weapon.Icon = Material("lvs/weapons/dual_mg.png")
	weapon.Delay = 0.85
	weapon.HeatRateUp = .3
	weapon.HeatRateDown = .45
	weapon.Attack = function( ent )
		local base = ent:GetVehicle()

		local trace = ent:GetEyeTrace()


		local ID_1 = self:LookupAttachment( "muzzle_r" )
		local ID_2 = self:LookupAttachment( "muzzle_l" )
		
		local Muzzle1 = self:GetAttachment( ID_1 )
		local Muzzle2 = self:GetAttachment( ID_2 )


		ent.MirrorPrimary = not ent.MirrorPrimary

		local Pos = ent.MirrorPrimary and Muzzle1.Pos or Muzzle2.Pos
		local Dir =  (ent.MirrorPrimary and Muzzle1.Ang or Muzzle2.Ang):Forward()

		local bullet = {}
		bullet.Src 	= Pos
		bullet.Dir 	= Dir
		bullet.Spread 	= Vector( 0.025,  0.025, 0.025 )
		bullet.TracerName = "lvs_laser_blue"
		bullet.Force	= 100
		bullet.HullSize 	= 50
		bullet.Damage	= 500
		bullet.Velocity = 9000
		bullet.SplashDamage	= 450
		bullet.SplashDamageRadius	= 350
		bullet.Attacker 	= ent:GetDriver()
		bullet.Callback = function(att, tr, dmginfo)
			local effectdata = EffectData()
				effectdata:SetStart( Vector(50,50,255) ) 
				effectdata:SetOrigin( tr.HitPos )
				effectdata:SetNormal( tr.HitNormal )
			util.Effect( "lvs_concussion_explosion", effectdata )
		end

		local effectdata = EffectData()
		effectdata:SetStart( Vector(50,50,255) )
		effectdata:SetOrigin( bullet.Src )
		--effectdata:SetNormal( Dir )
		effectdata:SetEntity( ent )
		util.Effect( "lvs_muzzle_colorable", effectdata )

		base.PrimarySND:PlayOnce( 100 + math.Rand(-3,3), 1 )
		ent:LVSFireBullet( bullet )
		
	end
	weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav")end
	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	weapon.OnThink = function( ent )
		if self:GetAI() or IsValid(self:GetGunnerSeat():GetDriver()) then
			local AimAngles = self:GetAimAngles( ent )

			self:SetPoseParameter("turbolaser_aim_pitch", (-AimAngles.p / 3) )
			self:SetPoseParameter("turbolaser_aim_yaw", (AimAngles.y - 90) )
		end
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local Col = (ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > 360) and COLOR_RED or COLOR_WHITE

		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 

		local base = ent:GetVehicle()
		base:PaintCrosshairCenter( Pos2D, Col )
		base:PaintCrosshairOuter( Pos2D, Col )
		base:LVSPaintHitMarker( Pos2D )
	end

	self:AddWeapon( weapon, 2 )

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/dual_mg.png")
	weapon.Delay = 1.05
	weapon.HeatRateUp = .6
	weapon.HeatRateDown = .4
	weapon.Attack = function( ent )
		for i = 1, 2 do
			local base = ent:GetVehicle()
			local ID_1 = self:LookupAttachment( "muzzle_r" )
			local ID_2 = self:LookupAttachment( "muzzle_l" )
			
			local Muzzle1 = self:GetAttachment( ID_1 )
			local Muzzle2 = self:GetAttachment( ID_2 )


			ent.MirrorPrimary = not ent.MirrorPrimary

			local Pos = ent.MirrorPrimary and Muzzle1.Pos or Muzzle2.Pos
			local Dir =  (ent.MirrorPrimary and Muzzle1.Ang or Muzzle2.Ang):Forward()

			local bullet = {}
			bullet.Src 	= Pos
			bullet.Dir 	= Dir
			bullet.Spread 	= Vector( 0.025,  0.025, 0.025 )
			bullet.TracerName = "lvs_laser_blue"
			bullet.Force	= 100
			bullet.HullSize 	= 50
			bullet.Damage	= 800
			bullet.Velocity = 9000
			bullet.SplashDamage	= 1200
			bullet.SplashDamageRadius	= 450
			bullet.Attacker 	= ent:GetDriver()
			bullet.Callback = function(att, tr, dmginfo)
				local effectdata = EffectData()
					effectdata:SetStart( Vector(50,50,255) ) 
					effectdata:SetOrigin( tr.HitPos )
					effectdata:SetNormal( tr.HitNormal )
				util.Effect( "lvs_concussion_explosion", effectdata )
			end

			local effectdata = EffectData()
			effectdata:SetStart( Vector(50,50,255) )
			effectdata:SetOrigin( bullet.Src )
			effectdata:SetNormal( Dir )
			effectdata:SetEntity( ent )
			util.Effect( "lvs_muzzle_colorable", effectdata )

			base.PrimarySND:PlayOnce( 100 + math.Rand(-3,3), 1 )
			ent:LVSFireBullet( bullet )
		end
	end
	weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav")end
	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	weapon.OnThink = function( ent )
		if self:GetAI() or IsValid(self:GetGunnerSeat():GetDriver()) then
			local AimAngles = self:GetAimAngles( ent )

			self:SetPoseParameter("turbolaser_aim_pitch", (-AimAngles.p / 3) )
			self:SetPoseParameter("turbolaser_aim_yaw", (AimAngles.y - 90) )
		end
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local Col = (ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > 360) and COLOR_RED or COLOR_WHITE

		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 

		local base = ent:GetVehicle()
		base:PaintCrosshairCenter( Pos2D, Col )
		base:PaintCrosshairOuter( Pos2D, Col )
		base:LVSPaintHitMarker( Pos2D )
	end
	self:AddWeapon( weapon, 2 )

end