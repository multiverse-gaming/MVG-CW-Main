AddCSLuaFile()

ENT.Base = "base_anim"
ENT.Spawnable = false

if CLIENT then
    function ENT:Draw()
     pos = self:GetPos()
     render.SetMaterial(Material("particle/particle_glow_04_additive"))
     render.DrawSprite(pos, 20, 20, Color(50, 195, 255))
     render.SetMaterial(Material("particle/particle_glow_04_additive"))
     render.DrawSprite(pos, 10, 10, Color(50, 195, 255))
     render.SetMaterial(Material("particle/particle_glow_04_additive"))
     render.DrawSprite(pos, 5, 5, Color(50, 195, 255))
    end
    function ENT:Initialize()
        pos = self:GetPos()
        self.emitter = ParticleEmitter( pos )
    end
end
function ENT:Initialize()
    self.Entity:SetNWBool("smoke", 10, true)
    if SERVER then
        self:SetModel( "models/rising/w_shock.mdl" )
        self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if (IsValid(phys)) then
        phys:SetMass(1)
    end
        self:DrawShadow( true )
    end
    self.ExplodeTimer = CurTime() + 100000
    if CLIENT then
        self.emitter = ParticleEmitter( self:GetPos() , 0 )
    end
end
function ENT:PhysicsCollide( data, phys )
    if  (20 < data.Speed and 0.25 < data.DeltaTime) then
    self.ExplodeTimer = 0
    end
end
function ENT:Think()
    if SERVER and (self.ExplodeTimer and self.ExplodeTimer <= CurTime()) then
        self:Explode()
    end
    self:NextThink(CurTime())
    if CLIENT then
        local pos = self:GetPos() + self:GetForward()
        local emitter = ParticleEmitter( self:GetPos() , 0 )
        local particle = emitter:Add("particle/smokesprites_000"..math.random(1,9), pos )
        for i=1, (1) do
            if (particle) then
                particle:SetVelocity((self:GetForward() * -400)+(VectorRand()* 0) )
                particle:SetDieTime( math.Rand( 0.05, 0.15 ) )
                particle:SetStartAlpha( math.Rand( 25, 50 ) )
                particle:SetEndAlpha( 0 )
                particle:SetStartSize( math.Rand( 5, 5 ) )
                particle:SetEndSize( math.Rand( 15, 15 ) )
                particle:SetRoll( math.Rand(0, 360) )
                particle:SetRollDelta( math.Rand(-1, 1) )
                particle:SetColor(50,195,255) 
                particle:SetAirResistance( 2500 ) 
                particle:SetGravity( Vector( 0, 0, 0 ) )
            end
        end
    end
    return true
end
function ENT:Explode()
	local effectdata = EffectData()
    effectdata:SetOrigin( self:GetPos() )
    util.Effect("stw48_plasmanade_effect", effectdata)
	util.BlastDamage( self, self.Owner, self:GetPos(), 225, 110 )
	self:EmitSound("masita/explosions/ion/destruction_explosions_modular_medium_bigion_discharge_close_var_01.mp3", 500, 100)
    self:Remove()
end