ENT.Type = "anim"
ENT.Base = "base_entity"

ENT.PrintName		= "Power Armor"
ENT.Author			= ""
ENT.Contact			= ""
ENT.Category		= "Other"
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.Spawnable		= true

function ENT:Initialize()
	self:SetModel("models/releasepackprops/crate4.mdl")

	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		local phys = self:GetPhysicsObject()
		phys:Wake()
		self:SetUseType( SIMPLE_USE )
	end
end

function ENT:Use(player)
	if SERVER then
		player:GivePowerArmor(player)
		self:Remove()
	end
	self:EmitSound("npc/scanner/cbot_discharge1.wav")
end