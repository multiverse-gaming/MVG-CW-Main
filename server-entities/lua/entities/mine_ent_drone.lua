AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

function ENT:Draw()
	if SERVER then return end

	self:DrawModel()
end

if CLIENT then return end

function ENT:Initialize()
	self:SetModel("models/props_combine/combine_mine01.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then phys:Wake() end
end

function ENT:Think()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 200)) do
		if (v:IsPlayer() and v != self.Owner) or v:IsNPC() then
			util.BlastDamage(self.Owner, self.Owner, self:GetPos(), 500, 500)

			local ef = EffectData()
			ef:SetOrigin(self:GetPos())
			ef:SetAttachment(1)
			ef:SetEntity(self)
			util.Effect("effect_rockboom", ef, true, true)

			self:EmitSound("ambient/explosions/explode_" .. math.random(1, 4) .. ".wav", 500, 100)

			SafeRemoveEntity(self)
		end
	end

	self:NextThink(CurTime())
	return true
end