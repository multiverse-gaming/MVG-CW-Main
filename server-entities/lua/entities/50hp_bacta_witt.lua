AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "50 HP Bacta"
ENT.Category = "MVG - Medical Support"
ENT.Author = "Syntax_Error752 | Modified by Fox"
ENT.Editable = true
ENT.Spawnable = true
ENT.AdminOnly = false

function ENT:SpawnFunction( ply, tr, ClassName )
	if (!tr.Hit) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create(ClassName)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Draw()
    self.Entity:DrawModel()
end

function ENT:Initialize()
	self.Entity:SetModel("models/starwars/items/medpack.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end

end

function ENT:Use( activator, caller )
	if (activator:IsPlayer()) then
		local heal = 50
		if (activator:Health() >= activator:GetMaxHealth()) then -- If overhealed dont do anything
			activator:PrintMessage( HUD_PRINTTALK, "[Medical Support] No effect, used 50 HP Bacta")

		elseif (activator:Health() + heal > activator:GetMaxHealth()) then -- If will overheal set MAX HP.
			activator:SetHealth(activator:GetMaxHealth())
			activator:PrintMessage( HUD_PRINTTALK, "[Medical Support] Healed PARTIALLY using 50 HP Bacta")
		else
			activator:SetHealth(activator:Health()+heal)
			activator:PrintMessage( HUD_PRINTTALK, "[Medical Support] Healed using 50 HP Bacta")
		end
		self.Entity:Remove()
		self.Entity:EmitSound("starwars/items/bacta.wav")

		
	end
end

function ENT:PhysicsCollide( data, phys )
    if (data.Speed > 80 and data.DeltaTime > 0.2) then
		self.Entity:EmitSound("Default.ImpactSoft")
	end
end

function ENT:OnTakeDamage(dmginfo)

	self.Entity:TakePhysicsDamage(dmginfo)
end