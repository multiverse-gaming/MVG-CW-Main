ENT.Type = "anim"
ENT.Base = "lvs_base_fakehover"

function ENT:WeaponRestoreAmmo()
    local AmmoIsSet = false

    for PodID, data in pairs(self.WEAPONS) do
        for id, weapon in pairs(data) do
            local MaxAmmo = weapon.Ammo or -1
            local CurAmmo = weapon._CurAmmo or -1

            if CurAmmo == MaxAmmo then
                continue
            end

            self.WEAPONS[PodID][id]._CurAmmo = MaxAmmo

            AmmoIsSet = true
        end
    end

	self:ReloadRockets()
	self:SpawnRockets()


    if AmmoIsSet then
        self:SetNWAmmo(self:GetAmmo())

        for _, pod in pairs(self:GetPassengerSeats()) do
            local weapon = pod:lvsGetWeapon()

            if not IsValid(weapon) then
                continue
            end

            weapon:SetNWAmmo(weapon:GetAmmo())
        end
    end

    return AmmoIsSet
end

ENT.PrintName = "IG-227 Hailfire-class"
ENT.Author = "Dec"
ENT.Information = "IG-227 Hailfire-class droid tank"
ENT.Category = "[LVS] - CIS Vehicles"

ENT.Spawnable		= true
ENT.AdminSpawnable	= false

ENT.MDL = "models/kingpommes/starwars/hailfire/hailfire_droid.mdl"
ENT.GibModels = {
	"models/kingpommes/starwars/hailfire/gib1.mdl",
	"models/kingpommes/starwars/hailfire/gib2.mdl",
	"models/kingpommes/starwars/hailfire/gib3.mdl",
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

ENT.MaxTurnRate = 0.8

ENT.GroundTraceLength = 50
ENT.GroundTraceHull = 100

function ENT:OnSpawn()

end

function ENT:OnSetupDataTables()

end

function ENT:InitWeapons()
	
	self.FirePositions = {
		Vector(300,-32,100),
		Vector(300,-42,100),
		Vector(300,59,100), 
		Vector(300,49,100),
	}

	self.RocketPositions = {
		Vector(275,-125,250),
		Vector(275,125,250),
	}

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/missile.png")
	weapon.Ammo = 30
	weapon.Delay = 0.3
	weapon.HeatRateUp = 0.
	weapon.HeatRateDown = 0.5
	weapon.Attack = function( ent )

		ent.NumPrim = ent.NumPrim and ent.NumPrim + 1 or 1
		if ent.NumPrim > #ent.RocketPositions then ent.NumPrim = 1 end

		--if not ent:WeaponsInRange() then return true end
		local veh = ent:GetVehicle()
		local Driver = ent:GetDriver()

		local pod = ent:GetDriverSeat()

		if not IsValid( pod ) then return end

		local dir = ent:GetAimVector()


		if ent:AngleBetweenNormal( dir, ent:GetForward() ) > 100 then return true end

		for i = 1, 1 do
			timer.Simple( (i / 2) * 0.2, function()
				if not IsValid( ent ) then return end

				if ent:GetAmmo() <= 0 then ent:SetHeat( 1 ) return end
	
				ent:TakeAmmo()

				local trace = ent:GetEyeTrace()
				local Dir = (ent:GetEyeTrace().HitPos - self:GetAttachment(self:LookupAttachment("rocket" .. self.rocketnum)).Pos + self:GetForward() * 48):GetNormalized()
				local projectile = ents.Create( "lvs_hail_missile" )
				projectile:SetPos(self:GetAttachment(self:LookupAttachment("rocket" .. self.rocketnum)).Pos + self:GetForward() * 48)
				projectile:SetAngles( Dir:Angle() )
				projectile:SetParent( )
				projectile:Spawn()
				projectile:Activate()
				projectile.GetTarget = function( missile ) return missile end
				projectile.GetTargetPos = function( missile )
					return missile:LocalToWorld( Vector(150,0,0) + VectorRand() * math.random(-10,10) )
				end
				projectile:SetAttacker( IsValid( Driver ) and Driver or self )
				projectile:SetEntityFilter( ent:GetCrosshairFilterEnts() )
				projectile:SetDamage( 800 )
				projectile:SetRadius( 450 )
				projectile:Enable()
				projectile:EmitSound( "KingPommes/starwars/hailfire/rocket.wav" )

				self.Rocket[self.rocketnum]:Remove()
				self.rocketnum = self.rocketnum + 1
			end)
		end
	end
	weapon.HudPaint = function( ent, X, Y, ply )
		local Col = (ent:AngleBetweenNormal( ent:GetAimVector(), ent:GetForward() ) > 30) and COLOR_RED or COLOR_WHITE

		local Pos2D = ent:GetEyeTrace().HitPos:ToScreen() 

		local base = ent:GetVehicle()
		base:PaintCrosshairCenter( Pos2D, Col )
		base:PaintCrosshairOuter( Pos2D, Col )
		base:LVSPaintHitMarker( Pos2D )
	end
	weapon.OnSelect = function( ent )
		ent:EmitSound("weapons/shotgun/shotgun_cock.wav")
		self:SetBodygroup(self:FindBodygroupByName( "rockets" ),1)
	end
	self:AddWeapon( weapon )
	--self:InitTurret()

	local weapon = {}
	weapon.Icon = Material("lvs/weapons/hmg.png")
	weapon.Delay = 0.18
	weapon.Ammo = 3000
	weapon.HeatRateUp = 0.2
	weapon.HeatRateDown = 0.7
	weapon.Attack = function( ent )
		ent.NumPrim = ent.NumPrim and ent.NumPrim + 1 or 1
		if ent.NumPrim > #ent.FirePositions then ent.NumPrim = 1 end
        --if not ent:GetVehicle():WeaponsInRange( ent ) then return true end
		local pod = ent:GetDriverSeat()

		if not IsValid( pod ) then return end

		local dir = ent:GetAimVector()
		
		if ent:AngleBetweenNormal( dir, ent:GetForward() ) > 25 then return true end

		local trace = ent:GetEyeTrace()

		local veh = ent:GetVehicle()

		veh.SNDTail:PlayOnce( 100 + math.Rand(-3,3), 1 )
		
		local canon = self:GetAttachment(self:LookupAttachment("barrel"))

		local bullet = {}
		bullet.Src = canon.Pos
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


end

function ENT:CalcMainActivityPassenger( ply )

end


ENT.EngineSounds = {
	{
		sound = "ambient/machines/train_idle.wav",
		Pitch = 70,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 30,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
		SoundLevel = 110,
	},
	{
		sound = "ambient/machines/train_idle.wav",
		Pitch = 70,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 30,
		FadeIn = 0,
		FadeOut = 1,
		FadeSpeed = 1.5,
		UseDoppler = true,
		SoundLevel = 70,
	},
	{
		sound = "hailfire_droid/engine_on.wav",
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

sound.Add{ {
	name = "LVS.HAIL.FIRE_MISSILE",
	channel = CHAN_WEAPON,
	volume = 6.0,
	level = 3000,
	pitch = 105,
	sound = "KingPommes/starwars/hailfire/rocket.wav"
 } }
