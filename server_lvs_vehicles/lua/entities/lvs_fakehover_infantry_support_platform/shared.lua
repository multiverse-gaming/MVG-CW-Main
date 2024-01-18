
ENT.Base = "lvs_base_fakehover"

ENT.PrintName = "Infantry Support Platform"
ENT.Author = "Durian"
ENT.Information = "pew pew"
ENT.Category = "[LVS] - Republic Vehicles"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/durian/isp/isp.mdl"
ENT.GibModels = {
	"models/durian/isp/isp.mdl",
}

ENT.AITEAM = 2

ENT.MaxHealth = 1000

ENT.ForceLinearMultiplier = .2
ENT.ForceLinearRate = .2

ENT.ForceAngleMultiplier = 1
ENT.ForceAngleDampingMultiplier = .5

ENT.MaxVelocityX = 500
ENT.MaxVelocityY = 150

ENT.MaxTurnRate = 2

ENT.BoostAddVelocityX = 600
ENT.BoostAddVelocityY = 100

ENT.GroundTraceHitWater = true
ENT.GroundTraceLength = 50
ENT.GroundTraceHull = 100

ENT.LAATC_PICKUPABLE = true
ENT.LAATC_DROP_IN_AIR = true
ENT.LAATC_PICKUP_POS = Vector(-200,0,25)
ENT.LAATC_PICKUP_Angle = Angle(0,0,0)

function ENT:OnSetupDataTables()
	self:AddDT( "Bool", "IsCarried" )
	self:AddDT( "Entity", "GunnerSeat" )
	self:AddDT( "Bool", "BTLFire" )
	self:AddDT( "Bool", "SpotlightToggle" )

	if SERVER then
		self:NetworkVarNotify( "IsCarried", self.OnIsCarried )
	end
end

function ENT:GetAimAngles()
	local trace = self:GetEyeTrace()

	local AimAnglesR = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld( Vector(-60,-51,43) ) ):GetNormalized():Angle() )
	local AimAnglesL = self:WorldToLocalAngles( (trace.HitPos - self:LocalToWorld( Vector(-60,51,43) ) ):GetNormalized():Angle() )

	return AimAnglesR, AimAnglesL
end

function ENT:WeaponsInRange()
	if self:GetIsCarried() then return false end

	local AimAnglesR, AimAnglesL = self:GetAimAngles()

	return not ((AimAnglesR.p >= 55 and AimAnglesL.p >= 55) or (AimAnglesR.p <= -55 and AimAnglesL.p <= -55) or (math.abs(AimAnglesL.y) + math.abs(AimAnglesL.y)) >= 105)
end



function ENT:InitWeapons()
	local weapon = {}
		weapon.Icon = Material("lvs/weapons/hmg.png")
		weapon.Ammo = -1
		weapon.Delay = 0.2
		weapon.HeatRateUp = 0.2
		weapon.HeatRateDown = 0.3
		weapon.Attack = function( ent )

			if ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) >= 55 then return true end

			ent:TakeAmmo()

			local trace = ent:GetEyeTrace()

			local mrr = self:LookupAttachment( "turret_muzzle_r_r" ) 
			local RightMuzzleRight = self:GetAttachment(mrr)
			local mrl = self:LookupAttachment( "turret_muzzle_r_l" ) 
			local RightMuzzleLeft = self:GetAttachment(mrl)

			local mlr = self:LookupAttachment( "turret_muzzle_l_r" ) 
			local LeftMuzzleRight = self:GetAttachment(mlr)
			local mll = self:LookupAttachment( "turret_muzzle_l_l" ) 
			local LeftMuzzleLeft = self:GetAttachment(mll)

			local muzzles = { RightMuzzleRight, RightMuzzleLeft }
			
			
			
			for i, muzzle in ipairs( muzzles ) do
				local bullet = {}
				bullet.Src 	= muzzle.Pos
				bullet.Dir 	= (trace.HitPos - muzzle.Pos):GetNormalized()
				bullet.Spread 	= Vector( 0.02,  0.02, 0.02 )
				bullet.TracerName = "lvs_laser_green"
				bullet.Force	= 10
				bullet.HullSize 	= 25
				bullet.Damage	= 20
				//bullet.SplashDamage = 200
				//bullet.SplashDamageRadius = 200
				bullet.Velocity = 40000
				bullet.Attacker 	= ent:GetDriver()
				bullet.Callback = function(att, tr, dmginfo)
					local effectdata = EffectData()
						effectdata:SetStart( Vector(50,255,50) ) 
						effectdata:SetOrigin( tr.HitPos )
						effectdata:SetNormal( tr.HitNormal )
					util.Effect( "lvs_laser_impact", effectdata )
				end
				ent:LVSFireBullet( bullet )
				ent:TakeAmmo()

				self.PrimarySND:PlayOnce( 100 + math.cos( CurTime() + self:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )
			end
		end

		weapon.OnThink = function( ent, active )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		local trace = ent:GetEyeTrace()

        local _,AimAnglesR = WorldToLocal(Vector(0,0,0),(trace.HitPos - self:LocalToWorld( Vector( 0,-20,0)) ):GetNormalized():Angle(), Vector(0,-20,0), self:LocalToWorldAngles( Angle(0,0,0) ) )

		base:SetBonePoseParameter( "!rleft", AimAnglesR.x)
		base:SetBonePoseParameter( "!pleft", -AimAnglesR.y )
		-- base:SetBonePoseParameter( "!pright", -AimAnglesR.y )
		-- base:SetBonePoseParameter( "!pright", -AimAnglesR.y )

		end

		weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
		weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/vehicles/imperial/overheat.wav") end
	self:AddWeapon( weapon )

	local weapon = {}
		weapon.Icon = Material("lvs/weapons/mg.png")
		weapon.Ammo = -1
		weapon.Delay = 0.075
		weapon.HeatRateUp = 0.6
		weapon.HeatRateDown = 0.3
		weapon.Attack = function( ent )

			if ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) >= 35 then return true end

			ent:TakeAmmo()

			local trace = ent:GetEyeTrace()

			local mrr = self:LookupAttachment( "turret_muzzle_r_r" ) 
			local RightMuzzleRight = self:GetAttachment(mrr)
			local mrl = self:LookupAttachment( "turret_muzzle_r_l" ) 
			local RightMuzzleLeft = self:GetAttachment(mrl)

			local mlr = self:LookupAttachment( "turret_muzzle_l_r" ) 
			local LeftMuzzleRight = self:GetAttachment(mlr)
			local mll = self:LookupAttachment( "turret_muzzle_l_l" ) 
			local LeftMuzzleLeft = self:GetAttachment(mll)

			local muzzles = { RightMuzzleRight, RightMuzzleLeft }
			
			
			
			for i, muzzle in ipairs( muzzles ) do
				local bullet = {}
				bullet.Src 	= muzzle.Pos
				bullet.Dir 	= (trace.HitPos - muzzle.Pos):GetNormalized()
				bullet.Spread 	= Vector( 0.035,  0.1, 0.035 )
				bullet.TracerName = "lvs_laser_green"
				bullet.Force	= 10
				bullet.HullSize 	= 25
				bullet.Damage	= 20
				//bullet.SplashDamage = 200
				//bullet.SplashDamageRadius = 300
				bullet.Velocity = 40000
				bullet.Attacker 	= ent:GetDriver()
				bullet.Callback = function(att, tr, dmginfo)
					local effectdata = EffectData()
						effectdata:SetStart( Vector(50,255,50) ) 
						effectdata:SetOrigin( tr.HitPos )
						effectdata:SetNormal( tr.HitNormal )
					util.Effect( "lvs_laser_impact", effectdata )
				end
				ent:LVSFireBullet( bullet )
				ent:TakeAmmo()

				self.PrimarySND:PlayOnce( 100 + math.cos( CurTime() + self:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )
			end
		end

		weapon.OnThink = function( ent, active )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		local trace = ent:GetEyeTrace()

        local _,AimAnglesR = WorldToLocal(Vector(0,0,0),(trace.HitPos - self:LocalToWorld( Vector( 0,-20,0)) ):GetNormalized():Angle(), Vector(0,-20,0), self:LocalToWorldAngles( Angle(0,0,0) ) )

		base:SetBonePoseParameter( "!rleft", AimAnglesR.x)
		base:SetBonePoseParameter( "!pleft", -AimAnglesR.y )
		-- base:SetBonePoseParameter( "!pright", -AimAnglesR.y )
		-- base:SetBonePoseParameter( "!pright", -AimAnglesR.y )

		end

		weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
		weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/vehicles/imperial/overheat.wav") end
	self:AddWeapon( weapon )

	local weapon = {}
		weapon.Icon = Material("lvs/weapons/mg.png")
		weapon.Ammo = -1
		weapon.Delay = 0.1
		weapon.HeatRateUp = 0.6
		weapon.HeatRateDown = 0.3
		weapon.Attack = function( ent )

			if ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) >= 35 then return true end

			ent:TakeAmmo()

			local trace = ent:GetEyeTrace()

			local mrr = self:LookupAttachment( "turret_muzzle_r_r" ) 
			local RightMuzzleRight = self:GetAttachment(mrr)
			local mrl = self:LookupAttachment( "turret_muzzle_r_l" ) 
			local RightMuzzleLeft = self:GetAttachment(mrl)

			local mlr = self:LookupAttachment( "turret_muzzle_l_r" ) 
			local LeftMuzzleRight = self:GetAttachment(mlr)
			local mll = self:LookupAttachment( "turret_muzzle_l_l" ) 
			local LeftMuzzleLeft = self:GetAttachment(mll)

			local muzzles = { LeftMuzzleRight, LeftMuzzleLeft }
			
			
			
			for i, muzzle in ipairs( muzzles ) do
				local bullet = {}
				bullet.Src 	= muzzle.Pos
				bullet.Dir 	= (trace.HitPos - muzzle.Pos):GetNormalized()
				bullet.Spread 	= Vector( 0.01,  0.01, 0.01 )
				bullet.TracerName = "lvs_laser_green"
				bullet.Force	= 10
				bullet.HullSize 	= 25
				bullet.Damage	= 20
			//	bullet.SplashDamage = 200
			//	bullet.SplashDamageRadius = 300
				bullet.Velocity = 40000
				bullet.Attacker 	= ent:GetDriver()
				bullet.Callback = function(att, tr, dmginfo)
					local effectdata = EffectData()
						effectdata:SetStart( Vector(50,255,50) ) 
						effectdata:SetOrigin( tr.HitPos )
						effectdata:SetNormal( tr.HitNormal )
					util.Effect( "lvs_laser_impact", effectdata )
				end
				ent:LVSFireBullet( bullet )
				ent:TakeAmmo()

				self.SecondarySND:PlayOnce( 100 + math.cos( CurTime() + self:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )
			end
		end

		weapon.OnThink = function( ent, active )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		local trace = ent:GetEyeTrace()

        local _,AimAnglesR = WorldToLocal(Vector(0,0,0),(trace.HitPos - self:LocalToWorld( Vector( 0,-20,0)) ):GetNormalized():Angle(), Vector(0,-20,0), self:LocalToWorldAngles( Angle(0,0,0) ) )

		-- base:SetBonePoseParameter( "!rleft", AimAnglesR.x)
		-- base:SetBonePoseParameter( "!pleft", -AimAnglesR.y )
		base:SetBonePoseParameter( "!rright", AimAnglesR.x)
		base:SetBonePoseParameter( "!pright", -AimAnglesR.y )

		end

		weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
		weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/vehicles/imperial/overheat.wav") end
	self:AddWeapon( weapon, 2 )


	local weapon = {}
		weapon.Icon = Material("lvs/weapons/dual_mg.png")
		weapon.Ammo = 3000
		weapon.Delay = 0.05
		weapon.HeatRateUp = 0.6
		weapon.HeatRateDown = 0.6
		weapon.Attack = function( ent )

			if ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) >= 55 then return true end

			ent:TakeAmmo()

			local trace = ent:GetEyeTrace()

			local mrr = self:LookupAttachment( "turret_muzzle_r_r" ) 
			local RightMuzzleRight = self:GetAttachment(mrr)
			local mrl = self:LookupAttachment( "turret_muzzle_r_l" ) 
			local RightMuzzleLeft = self:GetAttachment(mrl)

			local mlr = self:LookupAttachment( "turret_muzzle_l_r" ) 
			local LeftMuzzleRight = self:GetAttachment(mlr)
			local mll = self:LookupAttachment( "turret_muzzle_l_l" ) 
			local LeftMuzzleLeft = self:GetAttachment(mll)

			local muzzles = { LeftMuzzleRight, LeftMuzzleLeft }
			
			
			
			for i, muzzle in ipairs( muzzles ) do
				local bullet = {}
				bullet.Src 	= muzzle.Pos
				bullet.Dir 	= (trace.HitPos - muzzle.Pos):GetNormalized()
				bullet.Spread 	= Vector( 0.02,  0.02, 0.02 )
				bullet.TracerName = "lvs_laser_blue"
				bullet.Force	= 10
				bullet.HullSize 	= 25
				bullet.Damage	= 10
			//	bullet.SplashDamage = 1
			//	bullet.SplashDamageRadius = 5
				bullet.Velocity = 60000
				bullet.Attacker 	= ent:GetDriver()
				bullet.Callback = function(att, tr, dmginfo)
					local effectdata = EffectData()
						effectdata:SetStart( Vector(50,50,255) ) 
						effectdata:SetOrigin( tr.HitPos )
						effectdata:SetNormal( tr.HitNormal )
					util.Effect( "lvs_laser_impact", effectdata )
				end
				ent:LVSFireBullet( bullet )
				ent:TakeAmmo()

				self.SecondarySND:PlayOnce( 100 + math.cos( CurTime() + self:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )
			end
		end

		weapon.OnThink = function( ent, active )
		local base = ent:GetVehicle()

		if not IsValid( base ) then return end

		local trace = ent:GetEyeTrace()

        local _,AimAnglesR = WorldToLocal(Vector(0,0,0),(trace.HitPos - self:LocalToWorld( Vector( 0,-20,0)) ):GetNormalized():Angle(), Vector(0,-20,0), self:LocalToWorldAngles( Angle(0,0,0) ) )

		-- base:SetBonePoseParameter( "!rleft", AimAnglesR.x)
		-- base:SetBonePoseParameter( "!pleft", -AimAnglesR.y )
		base:SetBonePoseParameter( "!rright", AimAnglesR.x )
		base:SetBonePoseParameter( "!pright", -AimAnglesR.y )

		end

		weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
		weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/vehicles/imperial/overheat.wav") end
	self:AddWeapon( weapon, 2 )

		local weapon = {}
		weapon.Icon = Material("lvs/weapons/missile.png")
		weapon.Ammo = 60
		weapon.Delay = 0 -- this will turn weapon.Attack to a somewhat think function
		weapon.HeatRateUp = -0.1 -- cool down when attack key is held. This system fires on key-release.
		weapon.HeatRateDown = 0.3
		weapon.Attack = function( ent )
			local T = CurTime()

			if IsValid( ent._ConcussionMissile ) then
				if (ent._nextMissleTracking or 0) > T then return end
				return
			end

			if (ent._nextMissle or 0) > T then return end

			ent._nextMissle = T + 0.1

			ent._swapMissile = not ent._swapMissile

			local Pos = Vector( 156.25, (ent._swapMissile and -9 or 9), -7.25)

			local Driver = self:GetDriver()

			local projectile = ents.Create( "lvs_missile" )
			projectile:SetPos( ent:LocalToWorld( Pos ) )
			projectile:SetAngles( ent:GetAngles() )
			projectile:SetParent( ent )
			projectile:Spawn()
			projectile:Activate()
			projectile.GetTarget = function( missile ) return missile end
			projectile.GetTargetPos = function( missile )
				return missile:LocalToWorld( Vector(150,0,0) + VectorRand() * math.random(-7.5,7.5) )
			end
			projectile:SetAttacker( IsValid( Driver ) and Driver or self )
			projectile:SetEntityFilter( ent:GetCrosshairFilterEnts() )
			projectile:SetSpeed( ent:GetVelocity():Length() + 2000 )
			projectile:SetDamage( 200 )
			projectile:SetRadius( 600 )

			ent._ConcussionMissile = projectile

			ent:SetNextAttack( CurTime() + 0.1 ) -- wait 0.1 second before starting to track
		end
		weapon.FinishAttack = function( ent )
			if not IsValid( ent._ConcussionMissile ) then return end

			local projectile = ent._ConcussionMissile

			projectile:Enable()
			projectile:EmitSound( "lvs/vehicles/iftx/fire_missile.mp3", 125 )
			ent:TakeAmmo()

			ent._ConcussionMissile = nil

			local NewHeat = ent:GetHeat() + 0.2

			ent:SetHeat( NewHeat )
			if NewHeat >= 1 then
				ent:SetOverheated( true )
			end
		end
		weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
		weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/vehicles/imperial/overheat.wav") end
	self:AddWeapon( weapon )
	
end

ENT.EngineSounds = {
	{
		sound = "lvs/isp/engine.wav",
		Pitch = 50,
		PitchMin = 50,
		PitchMax = 150,
		PitchMul = 30,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
		SoundLevel = 90,
	},
}
