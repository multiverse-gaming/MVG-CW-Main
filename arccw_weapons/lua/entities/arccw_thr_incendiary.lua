AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "arccw_thr"
ENT.PrintName = "Fragnade"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE

ENT.Model = "models/weapons/tfa_starwars/w_incendiary.mdl"
ENT.TrailColor = Color(79, 18, 0)
ENT.TrailTexture = "sprites/bluelaser1" -- this is exactly the one hl2 frag uses. Why blue? idk blame gaben

local regenInterval = 0.125 -- Regeneration interval in seconds
local regenDuration = 3 -- Regeneration duration in seconds
local playersInRegenRange = {} -- Store players in regeneration range

-- Function to create fire entities

local function makeFire(self)
    if SERVER then
        local molotovfire = ents.Create( "tfa_csgo_fire_2" )
        molotovfire:SetPos( self:GetPos() )
        molotovfire:SetOwner( self.Owner )
        molotovfire:Spawn()
        timer.Simple( 8, function()
            if IsValid( molotovfire ) then
                molotovfire:Remove()
            end
        end )
        
        local molotovfire = ents.Create( "tfa_csgo_fire_1" )
        local pos = self:GetPos()
        molotovfire:SetPos( self:GetPos() )
        molotovfire:SetOwner( self.Owner )
        molotovfire:SetCreator( self )
        molotovfire:Spawn()
        timer.Simple( 8, function()
            if IsValid( molotovfire ) then
                molotovfire:Remove()
            end
        end )
        
        self:SetMoveType( MOVETYPE_NONE )
        self:SetSolid( SOLID_NONE )
        self:PhysicsInit( SOLID_NONE )
        self:SetCollisionGroup( COLLISION_GROUP_NONE )
        self:SetRenderMode( RENDERMODE_TRANSALPHA )
        self:SetColor( Color( 255, 255, 255, 0 ) )
        self:DrawShadow( false )
        self:StopParticles()
    end
end

-- Hook to start player health regeneration
function ENT:Initialize()
	if SERVER then
		self:SetModel("models/weapons/tfa_starwars/w_incendiary.mdl") 
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
			phys:SetBuoyancyRatio(0)
		end
		
		self.Delay = CurTime() + 1.7
		self.NextParticle = 0
		self.ParticleCount = 0
		self.First = true
		self.IsDetonated = false
		self.HasBounced = false

        self.SpawnTime = CurTime()
        self.Trail = util.SpriteTrail(self, 0, self.TrailColor, false, 4, 0, 0.5, 4, self.TrailTexture or "sprites/bluelaser1")
        if IsValid(self.Trail) then
            self.Trail:SetRenderMode(RENDERMODE_TRANSADD)
            self.Trail:SetRenderFX(kRenderFxNone)
        end
        self:SetPhysicsAttacker(self:GetOwner(), 10)
	end
    util.PrecacheSound("misc/BEEPTimer_Anticipation Beeps_08.wav")

    -- Play the sound when the entity is spawned
    self:EmitSound("misc/BEEPTimer_Anticipation Beeps_08.wav")
end

function ENT:PhysicsCollide(data, physobj)
	if SERVER then
		self.HasBounced = true
	end
end

function ENT:Think()
    if SERVER then
		if self.HasBounced == true then
            if self.IsDetonated == false then
				self:Detonate(self:GetPos())
				self.IsDetonated = true
				makeFire(self)
			end
		elseif CurTime() > self.Delay then
            if self.IsDetonated == false then
                self:Detonate(self:GetPos())
                self.IsDetonated = true

                makeFire(self)
            end
        end
    end
end

function ENT:Detonate(pos)
	self.ParticleCreated = false
	self.ExtinguishParticleCreated = false
	if SERVER then
		if not self:IsValid() then return end
		self:SetNWBool("IsDetonated",true)
		self:EmitSound("misc/EXPLDsgn_Implode_02.wav", 120, 100, 1, CHAN_AUTO)
		local gas = EffectData()
		gas:SetOrigin(pos)
		gas:SetEntity(self.Owner)
		//util.Effect("tfa_csgo_poisonade", gas)
	end
	
	self:SetMoveType( MOVETYPE_NONE )
	
	if SERVER then
		SafeRemoveEntityDelayed(self,0.5)
	end
end

function ENT:DrawTranslucent()
    self:Draw()
end

function ENT:Draw()
    self:DrawModel()
end