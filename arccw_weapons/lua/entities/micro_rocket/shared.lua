ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Wrist Rocket"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/star_wars_battlefront/com_weap_missile.mdl"
ENT.FuseTime = 5
ENT.ArmTime = 0

AddCSLuaFile()

function ENT:Initialize()
    if SERVER then
        self:SetModel( self.Model )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetCollisionGroup( COLLISION_GROUP_PROJECTILE )
        self:DrawShadow( true )

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
	phys:SetMass(3)
            phys:SetBuoyancyRatio(0)
            phys:EnableGravity( false )
        end

        self.kt = CurTime() + self.FuseTime
        self.motorsound = CreateSound( self, "weapons/star_wars_battlefront/common/ammo_rocket_lp02.wav")
    end

    self.at = CurTime() + self.ArmTime
    self.Armed = false
end

function ENT:OnRemove()
    if SERVER then
        self.motorsound:Stop()
    end
end


function ENT:PhysicsCollide(data, physobj)
    if self.at <= CurTime() then
        self:Detonate()
    elseif self.at > CurTime() then
        local effectdata = EffectData()
            effectdata:SetOrigin( self:GetPos() )
        util.Effect( "RPGShotDown", effectdata)
        util.Effect( "StunstickImpact", effectdata)
        self:Remove()
    end
end

function ENT:Arm()
    if SERVER then
        self.motorsound:Play()
    end
end

function ENT:Think()

    if CurTime() >= self.at and !self.Armed then
        self:Arm()
        self.Armed = true
    end

    if SERVER then

        if self.Armed then
            local phys = self:GetPhysicsObject()
            phys:ApplyForceCenter( self:GetAngles():Forward() * 500 )
        end

        if CurTime() >= self.kt then
            self:Detonate()
        end
    end

    if CLIENT then
        if self.Armed then
		ParticleEffectAttach( "astw2_swbf_muzzle_reb_shotgun", PATTACH_POINT_FOLLOW, self, 0 )
            local emitter = ParticleEmitter(self:GetPos())

            if !self:IsValid() or self:WaterLevel() > 2 then return end

            local smoke = emitter:Add("effects/swbf/thicksmoke", self:GetPos())
        smoke:SetGravity( Vector(math.Rand(-5, 5), math.Rand(-5, 5), math.Rand(-20, -25)) )
        smoke:SetVelocity( self:GetAngles():Forward() * 100 )
        smoke:SetDieTime( math.Rand(0.5,0.75) )
        smoke:SetStartAlpha( 45 )
        smoke:SetEndAlpha( 0 )
        smoke:SetStartSize( 10 )
        smoke:SetEndSize( 35 )
        smoke:SetRoll( math.Rand(-180, 180) )
        smoke:SetRollDelta( math.Rand(-0.2,0.2) )
        smoke:SetColor( 225, 225, 225 )
        smoke:SetAirResistance( 50 )
        smoke:SetPos( self:GetPos() )
        smoke:SetLighting( true )
        emitter:Finish()
        end
    end
end

function ENT:Detonate()
    if SERVER then
        if !self:IsValid() then return end
        local effectdata = EffectData()
            effectdata:SetOrigin( self:GetPos() )

        if self:WaterLevel() >= 1 then
            util.Effect( "WaterSurfaceExplosion", effectdata )
        else
           ParticleEffect( "astw2_swbf_explosion_concussion_grenade", self:GetPos(), self:GetAngles() )
	sound.Play( "weapons/star_wars_battlefront/jd_oc/explosion_huge" .. math.random(2,3) .. ".mp3",  self:GetPos(), 100, 100 )
        end

        local attacker = self

        if self.Owner:IsValid() then
            attacker = self.Owner
        end

        util.BlastDamage(self, attacker, self:GetPos(), 324, 125)
		util.Decal( "Scorch", self:GetPos(), self:GetPos() - Vector(0, 0, 32), self )
		util.ScreenShake(self:GetPos(),18000,500,1.2,2048)
        self:Remove()
    end
end

function ENT:Draw()
    if CLIENT then
        self:DrawModel()

        if self.Armed then
            cam.Start3D() -- Start the 3D function so we can draw onto the screen.
                render.SetMaterial( Material("effects/blueflare1") ) -- Tell render what material we want, in this case the flash from the gravgun
                render.DrawSprite( self:GetPos(), math.random(16, 32), math.random(16, 32), Color(255, 175, 75) ) -- Draw the sprite in the middle of the map, at 16x16 in it's original colour with full alpha.
            cam.End3D()
        end
    end
end