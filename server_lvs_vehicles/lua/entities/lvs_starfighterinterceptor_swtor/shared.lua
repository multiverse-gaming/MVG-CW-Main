
ENT.Base = "lvs_base_starfighter"

ENT.PrintName = "Sith Interceptor"
ENT.Author = "Ophra"
ENT.Information = "Interceptor of the Sith Empire"
ENT.Category = "[LVS] - Miscellaneous Vehicles"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/ophra/ships/veh_imp_starfighter_interceptor.mdl"


ENT.AITEAM = 2

ENT.MaxVelocity = 2150
ENT.MaxThrust = 2150

ENT.ThrustVtol = 55
ENT.ThrustRateVtol = 3

ENT.TurnRatePitch = 2
ENT.TurnRateYaw = 2
ENT.TurnRateRoll = 0.6

ENT.ForceLinearMultiplier = 1

ENT.ForceAngleMultiplier = 1
ENT.ForceAngleDampingMultiplier = 1

ENT.MaxHealth = 250

function ENT:InitWeapons()
	self.FirePositions = {
		Vector(55.87,18.66,-24.15),
		Vector(55.87,-18.66,-24.15),
		Vector(55.87,18.66,-24.15),
		Vector(55.87,-18.66,-24.15),
	}

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/mg.png")
	weapon.Ammo = 1200
	weapon.Delay = 0.1
	weapon.HeatRateUp = 0.25
	weapon.HeatRateDown = 1
	weapon.Attack = function( ent )
		ent.NumPrim = ent.NumPrim and ent.NumPrim + 1 or 1
		if ent.NumPrim > #ent.FirePositions then ent.NumPrim = 1 end

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
		bullet.Spread 	= Vector( 0.02,  0.02, 0 )
		bullet.TracerName = "lvs_laser_red"
		bullet.Force	= 10
		bullet.HullSize 	= 40
		bullet.Damage	= 10
		bullet.Velocity = 60000
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
		effectdata:SetNormal( ent:GetForward() )
		effectdata:SetEntity( ent )
		util.Effect( "lvs_muzzle_colorable", effectdata )

		ent:TakeAmmo()

		ent.PrimarySND:PlayOnce( 100 + math.cos( CurTime() + ent:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )
	end
	weapon.OnSelect = function( ent ) ent:EmitSound("ophra/ships/weaponswitch.wav") end
	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	self:AddWeapon( weapon )





	local weapon = {}
	weapon.Icon = Material("lvs/weapons/dual_mg.png")
	weapon.Ammo = 400
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
		bullet.Damage	= 20
		bullet.Velocity = 60000
		bullet.Attacker 	= ent:GetDriver()
		bullet.Callback = function(att, tr, dmginfo)
			local effectdata = EffectData()
				effectdata:SetStart( Vector(255,50,50) ) 
				effectdata:SetOrigin( tr.HitPos )
				effectdata:SetNormal( tr.HitNormal )
			util.Effect( "lvs_laser_impact", effectdata )
		end

		for i = -1,1,2 do
			bullet.Src 	= ent:LocalToWorld( Vector(55.87,-18.66*i,-24.15)
		)

			local effectdata = EffectData()
			effectdata:SetStart( Vector(255,50,50) )
			effectdata:SetOrigin( bullet.Src )
			effectdata:SetNormal( ent:GetForward() )
			effectdata:SetEntity( ent )
			util.Effect( "lvs_muzzle_colorable", effectdata )

			ent:LVSFireBullet( bullet )
		end

		ent:TakeAmmo()

		ent.SecondarySND:PlayOnce( 100 + math.cos( CurTime() + ent:EntIndex() * 1337 ) * 5 + math.Rand(-1,1), 1 )
	end
	weapon.OnSelect = function( ent ) ent:EmitSound("ophra/ships/weaponswitch.wav") end
	weapon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	self:AddWeapon( weapon )
end

sound.Add( {
	name = "LVS.VULTURE.FLYBY",
	sound = {"lvs/vehicles/vulturedroid/flyby.wav","lvs/vehicles/vulturedroid/flyby_a.wav","lvs/vehicles/vulturedroid/flyby_b.wav","lvs/vehicles/vulturedroid/flyby_c.wav"}
} )

ENT.FlyByAdvance = 0
ENT.FlyBySound = "LVS.VULTURE.FLYBY" 
ENT.DeathSound = "lvs/vehicles/generic_starfighter/crash.wav"

ENT.EngineSounds = {
	{
		sound = "ophra/ships/flysound5.wav",
		Volume = 3000,
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
