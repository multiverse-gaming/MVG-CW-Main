ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "explosive Grenade"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false 

ENT.BounceSound = Sound("TFA_CSGO_SmokeGrenade.Bounce")
ENT.ExplodeSound = Sound("weapons/tfa_starwars/Shock_Explosion_02.wav")

AddCSLuaFile()

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/weapons/tfa_starwars/w_flash.mdl") 
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
			phys:SetBuoyancyRatio(0)
		end
		
		self.Delay = CurTime() + 2
		self.NextParticle = 0
		self.ParticleCount = 0
		self.First = true
		self.IsDetonated = false
	end
	self:EmitSound("weapons/tfa_starwars/Shock_Charge_01.wav")
end

function ENT:PhysicsCollide(data, physobj)
	if SERVER then
		self.HitP = data.HitPos
		self.HitN = data.HitNormal

		if self:GetVelocity():Length() > 60 then
			self:EmitSound(self.BounceSound)
		end
		
		if self:GetVelocity():Length() < 5 then
			self:SetMoveType(MOVETYPE_NONE)
		end
		
	end
end

function ENT:Think()
    if SERVER then    
        if CurTime() > self.Delay then
            if self.IsDetonated == false then
                self:Detonate(self,self:GetPos())
                self.IsDetonated = true
            end
        end
    end
    if self.IsDetonated == true then
			local elec = EffectData()
		elec:SetOrigin(self:GetPos())
		elec:SetMagnitude(3)
		util.Effect("Sparks", elec)
for k, v in pairs( ents.FindInSphere( self:GetPos(), 120 ) ) do
    if v:IsPlayer() then
			FreezePlayer(self)
			v:ScreenFade(SCREENFADE.IN, Color(255, 255, 255, 100), 0.2, 0)
			v:EmitSound("weapons/stunstick/spark"..math.random(1,3)..".wav")
			damage = DamageInfo()
                damage:SetDamage( math.random( 7, 12 ) )
                damage:SetAttacker( self:GetOwner() )
                damage:SetDamageType( DMG_SHOCK )
            v:TakeDamageInfo( damage )
    elseif v:IsValid() && v:IsNPC() then
    			damage = DamageInfo()
                damage:SetDamage( math.random( 20, 50 ) )
                damage:SetAttacker( self:GetOwner() )
                damage:SetDamageType( DMG_SHOCK )
           		v:TakeDamageInfo( damage )
                    end
                end
			end

	
    self:NextThink( CurTime() + 0.3 )
    return true
end

function FreezePlayer(self,pos)
	for k, v in pairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
    if v:IsPlayer() then
	local fx = EffectData()
        fx:SetOrigin( v:GetPos() )
        fx:SetMagnitude(2)
        util.Effect("TeslaHitBoxes",fx)
            v:Freeze( true )
timer.Simple(3, function()
            v:Freeze( false )
			end)
		end
	end
end
	
function ENT:Detonate(self,pos)
	self.ParticleCreated = false
	self.ExtinguishParticleCreated = false
	if SERVER then
		if not self:IsValid() then return end
		self:SetNWBool("IsDetonated",true)
		self:EmitSound(self.ExplodeSound)
	end
	
	self:SetMoveType( MOVETYPE_NONE )
	
	if SERVER then
		SafeRemoveEntityDelayed(self,5)
	end
	
end

function ENT:Draw()
	if CLIENT then
		self:DrawModel()
	end
end