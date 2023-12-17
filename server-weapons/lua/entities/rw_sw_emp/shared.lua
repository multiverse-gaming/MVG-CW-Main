ENT.Type 			= "anim"  
ENT.PrintName			= "Ion"  
ENT.Spawnable			= false
ENT.AdminSpawnable		= false

--local rSound = Sound("Missile.Accelerate")

if SERVER then
	AddCSLuaFile( "shared.lua" )

	function ENT:Initialize()   
		self.flightvector = self.Entity:GetForward() * ((90*15.5)/2)
		self.timeleft = CurTime() + 2
		self.Owner = self:GetOwner()
		self.Entity:SetModel( "models/sw_battlefront/weapons/rocketprojectile.mdl" )
		self.Entity:PhysicsInit( SOLID_VPHYSICS )	
		self.Entity:SetMoveType( MOVETYPE_NONE )
		self.Entity:SetSolid( SOLID_VPHYSICS )
		--self.Entity:EmitSound(rSound, 75, 100)
		self.Entity:SetNWBool("smoke", 10, true)
	end   

	function ENT:Think()

			if self.timeleft < CurTime() then
				self:Explosion()
				self.Entity:Remove()
			end

		Table	={} 			//Table name is table name
		Table[1]	=self.Owner 		//The person holding the gat
		Table[2]	=self.Entity 		//The cap

		local trace = {}
			trace.start = self.Entity:GetPos()
			trace.endpos = self.Entity:GetPos() + self.flightvector
			trace.filter = Table
		local tr = util.TraceLine( trace )
		

			if tr.HitSky then
				self:Explosion()
				self.Entity:Remove()
				return true
			end

			local dmg = math.Rand( 250, 275 )
			util.BlastDamage(self.Entity, self:OwnerGet(), tr.HitPos, 10, dmg)
		
			if tr.Hit then
					local effectdata = EffectData()
						effectdata:SetOrigin(tr.HitPos)
						effectdata:SetNormal(tr.HitNormal)
						--effectdata:SetEntity(self.Entity)
						effectdata:SetScale(3)
						effectdata:SetRadius(tr.MatType)
						effectdata:SetMagnitude(18)
						util.Effect( "emp_exp_effect", effectdata )
						--util.BlastDamage(self.Entity, self:OwnerGet(), tr.HitPos, 500, dmg)
						util.Decal("Scorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
						self.Entity:SetNWBool("smoke", false)
				self:Explosion()
				self.Entity:Remove()	
			end
		
		self.Entity:SetPos(self.Entity:GetPos() + self.flightvector)
		self.flightvector = self.flightvector - (self.flightvector/1500)  + Vector(math.Rand(-0.2,0.2), math.Rand(-0.2,0.2),math.Rand(-0.2,0.2)) + Vector(0,0,-0.05)
		self.Entity:SetAngles(self.flightvector:Angle() + Angle(0,0,0))
		self.Entity:NextThink( CurTime() )
		return true
	end
	
	function ENT:Explosion()
		self:EmitSound("BaseExplosionEffect.Sound", 500, 100)	
		for k, v in pairs( ents.FindInSphere( self:GetPos(), 250 ) ) do
			if IsValid( v ) then
				if v.LFS then
					v:StopEngine()
					v:SetShield(0)
					v:SetHP( v:GetHP()/10 )
				end
				if v:IsPlayer() or v:IsNPC() then
					damage = DamageInfo()
					damage:SetDamage( 5000000 )
					damage:SetAttacker( self:GetOwner() )
					damage:SetDamageType( DMG_DISSOLVE )
					v:TakeDamageInfo( damage )
				end
			end 
	end
end

function ENT:OwnerGet()
	if IsValid(self.Owner) then
		return self.Owner
	else
		return self.Entity
	end
end

end

if CLIENT then

    function ENT:Draw()
     pos = self:GetPos()
     render.SetMaterial(Material("particle/particle_glow_04_additive"))
     render.DrawSprite(pos, 30, 30, Color(50, 195, 255))
     render.SetMaterial(Material("particle/particle_glow_04_additive"))
     render.DrawSprite(pos, 15, 15, Color(50, 195, 255))
     render.SetMaterial(Material("particle/particle_glow_04_additive"))
     render.DrawSprite(pos, 5, 5, Color(50, 195, 255))
    end
 
    function ENT:Initialize()
        pos = self:GetPos()
        self.emitter = ParticleEmitter( pos )
    end
 
    function ENT:Think()
    end

end