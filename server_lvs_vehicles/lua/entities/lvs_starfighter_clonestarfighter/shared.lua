
ENT.Base = "lvs_base_starfighter"

ENT.PrintName = "Clone Starfighter"
ENT.Author = "Salty"
ENT.Information = "Clone Starfighter of the Republic"
ENT.Category = "[LVS] - Republic Vehicles"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/salty/clonestarfighter.mdl"

ENT.AITEAM = 2

ENT.MaxVelocity = 4000
ENT.MaxThrust = 3000

ENT.ThrustVtol = 55
ENT.ThrustRateVtol = 3

ENT.TurnRatePitch = 1
ENT.TurnRateYaw = 1
ENT.TurnRateRoll = 1

ENT.ForceLinearMultiplier = 1

ENT.ForceAngleMultiplier = 1
ENT.ForceAngleDampingMultiplier = 1

ENT.MaxHealth = 350
ENT.MaxShield = 150

function ENT:InitWeapons()
	self.FirePositions= {
		Vector(111.75,-108.93,44.21),
		Vector(111.75,108.93,44.21),
		Vector(111.75,-108.85,15.95),
		Vector(111.75,108.85,15.95),
	}	
	local weapon = {}
	weapon.Icon = Material("lvs/weapons/mg.png")
	weapon.Ammo = 1600
	weapon.Delay = 0.10
	weapon.HeatRateUp = 0.34
	weapon.HeatRateDown = 1
	weapon.Attack = function( ent )

		self.NumPrim = self.NumPrim and self.NumPrim + 1 or 1
		if self.NumPrim > 4 then self.NumPrim = 1 end

		local pod = ent:GetDriverSeat()

		if not IsValid( pod ) then return end

		local startpos = pod:LocalToWorld( pod:OBBCenter() )
		local trace = util.TraceHull( {
			start = startpos,
			endpos = (startpos + ent:GetForward() * 50000),
			mins = Vector( -10, -10, -10 ),
			maxs = Vector( 10, 10, 10 ),
			filter = ent:GetCrosshairFilterEnts()
		} )

			local bullet = {}
		bullet.Src 	= ent:LocalToWorld( ent.FirePositions[ent.NumPrim] )
		bullet.Dir 	= (trace.HitPos - bullet.Src):GetNormalized()
			bullet.Spread 	= Vector( 0.02,  0.02, 0.02 )
			bullet.TracerName = "lvs_laser_blue"
			bullet.Force	= 10
			bullet.HullSize	= 25
			bullet.Damage	= 30
			bullet.SplashDamage	= 50
			bullet.SplashDamageRadius = 150
			bullet.Velocity = 50000
			bullet.Attacker 	= ent:GetDriver()
			bullet.Callback = function(att, tr, dmginfo)
				local effectdata = EffectData()
				effectdata:SetStart( Vector(0,0,255) ) 
				effectdata:SetOrigin( tr.HitPos )
				effectdata:SetNormal( tr.HitNormal )
				util.Effect( "lvs_laser_impact", effectdata )
			end

			local effectdata = EffectData()
			effectdata:SetStart( Vector(0,0,255) )
			effectdata:SetOrigin( bullet.Src )
			effectdata:SetNormal( ent:GetForward() )
			effectdata:SetEntity( ent )
			util.Effect( "lvs_muzzle_colorable", effectdata )
			ent:LVSFireBullet( bullet )

		ent:TakeAmmo()

		ent.PrimarySND:PlayOnce( 100 + math.cos( CurTime() + self:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )
	end
	weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	self:AddWeapon( weapon )
	
	local weapon = {}
	weapon.Icon = Material("lvs/weapons/dual_mg.png")
	weapon.Ammo = 200
	weapon.Delay = 0.15
	weapon.HeatRateUp = 0.5
	weapon.HeatRateDown = 1
	weapon.Attack = function( ent )
		local bullet = {}
		bullet.Dir 	= ent:GetForward()
		bullet.Spread 	= Vector( 0.015,  0.015, 0 )
		bullet.TracerName = "lvs_laser_red"
		bullet.Force	= 10
		bullet.HullSize 	= 25
		bullet.Damage	= 35
		bullet.Velocity = 60000
		bullet.Attacker 	= ent:GetDriver()
		bullet.Callback = function(att, tr, dmginfo)
			local effectdata = EffectData()
				effectdata:SetStart( Vector(255,50,50) ) 
				effectdata:SetOrigin( tr.HitPos )
				effectdata:SetNormal( tr.HitNormal )
			util.Effect( "lvs_laser_explosion", effectdata )
		end

		for i = -1,1,2 do
			bullet.Src 	= ent:LocalToWorld( Vector(80, 15.2 * i,23.5) )

			local effectdata = EffectData()
			effectdata:SetStart( Vector(255,50,50) )
			effectdata:SetOrigin( bullet.Src )
			effectdata:SetNormal( ent:GetForward() )
			effectdata:SetEntity( ent )
			util.Effect( "lvs_muzzle_colorable", effectdata )

			ent:LVSFireBullet( bullet )
		end

		ent:TakeAmmo()

		ent.PrimarySND:PlayOnce( 100 + math.cos( CurTime() + ent:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )
	end
	weapon.OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft3.wav") end
	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	self:AddWeapon( weapon )
	
	self:AddWeapon( LVS:GetWeaponPreset( "TURBO" ) )
end

ENT.FlyByAdvance = 0.75
ENT.FlyBySound = "lvs/vehicles/naboo_n1_starfighter/flyby.wav" 
ENT.DeathSound = "lvs/vehicles/generic_starfighter/crash.wav"

ENT.EngineSounds = {
	{
		sound = "lvs/vehicles/vwing/loop.wav",
		Pitch = 80,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 40,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
	},
}