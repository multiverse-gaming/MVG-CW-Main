ENT.Type = "anim"
ENT.Base = "lvs_base_fakehover"
ENT.PrintName = "NR-N99 Snail Tank"
ENT.Author = "Dec"
ENT.Information = "NR-N99 Snail Tank Droid"
ENT.Category = "[LVS] - CIS Vehicles"

ENT.Spawnable		= true
ENT.AdminSpawnable	= false

ENT.MDL = "models/KingPommes/starwars/nr_n99/main.mdl"
ENT.GibModels = {
	"models/KingPommes/starwars/nr_n99/gib01.mdl",
	"models/KingPommes/starwars/nr_n99/gib02a.mdl",
	"models/KingPommes/starwars/nr_n99/gib02b.mdl",
	"models/KingPommes/starwars/nr_n99/gib03a.mdl",
	"models/KingPommes/starwars/nr_n99/gib03b.mdl",
	"models/KingPommes/starwars/nr_n99/gib04a.mdl",
	"models/KingPommes/starwars/nr_n99/gib04b.mdl",
	"models/KingPommes/starwars/nr_n99/gib05.mdl",
	"models/KingPommes/starwars/nr_n99/gib06.mdl",
	"models/KingPommes/starwars/nr_n99/gib07.mdl",
	"models/KingPommes/starwars/nr_n99/gib08.mdl",
	"models/KingPommes/starwars/nr_n99/gib09.mdl",
	"models/KingPommes/starwars/nr_n99/gib10.mdl",


}

ENT.AITEAM = 1

ENT.MaxVelocityY = 0
ENT.BoostAddVelocityY = 0

ENT.ForceAngleMultiplier = 4
ENT.ForceAngleDampingMultiplier = 4

ENT.ForceLinearMultiplier = 2
ENT.ForceLinearRate = 0.8

ENT.MaxVelocityZ = 0
ENT.BoostAddVelocityZ = 0

ENT.MaxHealth = 4500
ENT.MaxVelocityX = 650
ENT.BoostAddVelocitX = 850
ENT.IgnoreWater = false

ENT.MaxTurnRate = 0.65

ENT.GroundTraceLength = 50
ENT.GroundTraceHull = 100

function ENT:OnSpawn()

end

function ENT:OnSetupDataTables()

end

function ENT:InitWeapons()
	local weapon = {}
	weapon.Icon = Material("lvs/weapons/hmg.png")
	weapon.Delay = 0.18
	weapon.Ammo = 3000
	weapon.HeatRateUp = 0.2
	weapon.HeatRateDown = 0.4
	weapon.Attack = function( ent )

        --if not ent:GetVehicle():WeaponsInRange( ent ) then return true end
		local pod = ent:GetDriverSeat()

		if not IsValid( pod ) then return end

		local dir = ent:GetAimVector()
		
		if ent:AngleBetweenNormal( dir, ent:GetForward() ) > 25 then return true end

		local trace = ent:GetEyeTrace()

		local veh = ent:GetVehicle()

		veh.SNDTail:PlayOnce( 100 + math.Rand(-3,3), 1 )
		
		local gun1 = self:GetAttachment(self:LookupAttachment("barrel_small_left"))
		local gun2 = self:GetAttachment(self:LookupAttachment("barrel_small_right"))

		local fP = { gun1.Pos, gun2.Pos }

		self.NumPrim = self.NumPrim and self.NumPrim + 1 or 1
		if self.NumPrim > 2 then self.NumPrim = 1 end

		local bullet = {}
		bullet.Src = fP[self.NumPrim]
		bullet.Dir = (trace.HitPos - bullet.Src):GetNormalized()
		bullet.Spread 	= Vector( 0.01,  0.01, 0.01 )
		bullet.TracerName = "lvs_laser_red_short"
		bullet.Force	= 10
		bullet.HullSize 	= 25
		bullet.Damage	= 100
		bullet.Velocity = 12000
		bullet.Attacker 	= ent:GetDriver()
		bullet.Callback = function(att, tr, dmginfo)
			local effectdata = EffectData()
				effectdata:SetStart( Vector(255,0,0) ) 
				effectdata:SetOrigin( tr.HitPos )
			util.Effect( "lvs_laser_explosion", effectdata )
		end
		ent:TakeAmmo()
		ent:LVSFireBullet( bullet )
	end
	weapon.OnSelect = function( ent )
		ent:EmitSound("physics/metal/weapon_impact_soft3.wav")
	end
	weapon.OnOverheat = function( ent )
		ent:EmitSound("lvs/overheat.wav")
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local Col = (ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > 25) and COLOR_RED or COLOR_WHITE

		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 

		local base = ent:GetVehicle()
		base:PaintCrosshairCenter( Pos2D, Col )
		base:PaintCrosshairOuter( Pos2D, Col )
		base:LVSPaintHitMarker( Pos2D )
	end
	self:AddWeapon( weapon )

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/hmg.png")
	weapon.Delay = 0.25
	weapon.Ammo = 250
	weapon.HeatRateUp = 0.8
	weapon.HeatRateDown = 0.1
	weapon.Attack = function( ent )
        --if not ent:GetVehicle():WeaponsInRange( ent ) then return true end
		local pod = ent:GetDriverSeat()

		if not IsValid( pod ) then return end

		local dir = ent:GetAimVector()
		
		if ent:AngleBetweenNormal( dir, ent:GetForward() ) > 25 then return true end

		local trace = ent:GetEyeTrace()

		local veh = ent:GetVehicle()

		veh.SNDBig:PlayOnce( 100 + math.Rand(-3,3), 1 )
		
		local gun1 = self:GetAttachment(self:LookupAttachment("barrel_small_left"))
		local gun2 = self:GetAttachment(self:LookupAttachment("barrel_small_right"))

		local fP = { gun1.Pos, gun2.Pos }

		self.NumPrim = self.NumPrim and self.NumPrim + 1 or 1
		if self.NumPrim > 2 then self.NumPrim = 1 end

		local bullet = {}
		bullet.Src = fP[self.NumPrim]
		bullet.Dir = (trace.HitPos - bullet.Src):GetNormalized()
		bullet.Spread 	= Vector( 0.01,  0.01, 0.01 )
		bullet.TracerName = "lvs_laser_red_aat"
		bullet.Force	= 10
		bullet.HullSize 	= 25
		bullet.Damage	= 350
		bullet.SplashDamage	= 150
		bullet.SplashDamageRadius	= 250
		bullet.Velocity = 12000
		bullet.Attacker 	= ent:GetDriver()
		bullet.Callback = function(att, tr, dmginfo)
			local effectdata = EffectData()
				effectdata:SetStart( Vector(255,0,0) ) 
				effectdata:SetOrigin( tr.HitPos )
			util.Effect( "lvs_laser_explosion_aat", effectdata )
		end
		ent:TakeAmmo()
		ent:LVSFireBullet( bullet )
	end
	weapon.OnSelect = function( ent )
		ent:EmitSound("physics/metal/weapon_impact_soft3.wav")
	end
	weapon.OnOverheat = function( ent )
		ent:EmitSound("lvs/overheat.wav")
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local Col = (ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > 25) and COLOR_RED or COLOR_WHITE

		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 

		local base = ent:GetVehicle()
		base:PaintCrosshairCenter( Pos2D, Col )
		base:PaintCrosshairOuter( Pos2D, Col )
		base:LVSPaintHitMarker( Pos2D )
	end
	self:AddWeapon( weapon )
end

function ENT:CalcMainActivityPassenger( ply )

end


ENT.EngineSounds = {
	{
		sound = "snailtank/engine_loop.wav",
		Pitch = 70,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 30,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
		SoundLevel = 200,
	},
	{
		sound = "snailtank/engine_loop.wav",
		Pitch = 70,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 30,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
		SoundLevel = 150,
	},
	{
		sound = "snailtank/engine_on.wav",
		Pitch = 40,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 30,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
		SoundLevel = 40,
	},
}


