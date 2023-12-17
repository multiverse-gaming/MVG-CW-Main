AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

local rSound = Sound("Missile.Accelerate")

function ENT:Draw()
	if SERVER then return end
	self:DrawModel()
end

if CLIENT then return end

function ENT:Initialize()
	self:SetModel("models/weapons/w_missile_closed.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:GetPhysicsObject():EnableDrag(false) 

	self.Entity:EmitSound(rSound, 50)
	
	timer.Create("effedf222s"..self:EntIndex(),0.01,0, function()
		if not IsValid(self) then return end
		local ef = EffectData()
		ef:SetOrigin(self:GetPos())
		ef:SetAttachment(1)
		util.Effect("effect_rocketfly", ef, true, true)	
	end)
	
end


ENT.lvc = 1


function ENT:Think()
self:NextThink(CurTime())

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 200)) do
		if v:IsNPC("npc_combinegunship") or v:IsNPC("npc_helicopter") then
			local ef = EffectData()
			ef:SetOrigin(self:GetPos())
			ef:SetAttachment(1)
			ef:SetEntity(self.Weapon)
			util.Effect("effect_rockboom", ef, true, true)	
			
			self:EmitSound("ambient/explosions/explode_"..math.random(1,4)..".wav", 100, 100)
			
			util.BlastDamage( self, self, self:GetPos(), 500, 200 )
			
			util.ScreenShake(self.Entity:GetPos(), 500, 255, 0.5, 1200)
			
			self:Remove()
		end
	end
	
	if self:WaterLevel() == 3 then
		self.lvc = self.lvc + 1
		
		if self.lvc == 3 then
			local ef = EffectData()
			ef:SetOrigin(self:GetPos())
			ef:SetAttachment(1)
			ef:SetEntity(self.Weapon)
			util.Effect("effect_rockboom", ef, true, true)	
		
			self:EmitSound("ambient/explosions/explode_"..math.random(1,4)..".wav", 50, 100)
		
			util.BlastDamage( self, self, self:GetPos(), 500, 200 )
		
			util.ScreenShake(self.Entity:GetPos(), 500, 255, 0.5, 1200)
		
			self:Remove()
			
			self.lvc = 0
		end
	end
end

function ENT:PhysicsCollide(data,physobj)
	local ef = EffectData()
	ef:SetOrigin(self:GetPos())
	ef:SetAttachment(1)
	ef:SetEntity(self.Weapon)
	util.Effect("effect_rockboom", ef, true, true)	
	
	self:EmitSound("ambient/explosions/explode_"..math.random(1,4)..".wav", 100, 100)
	
	util.BlastDamage( self, self, self:GetPos(), 500, 200 )
	
	util.ScreenShake(self.Entity:GetPos(), 500, 255, 0.5, 1200)
	
	self:Remove()
end

function ENT:OnRemove()
	self.Entity:StopSound(rSound)
end