AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Spawnable		= false

function ENT:Initialize()
	if CLIENT then return end

	self:DrawShadow(false)
	self:SetModel("models/hunter/blocks/cube05x105x05.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetAngles(Angle(0, 0, 90))
end

function ENT:OnTakeDamage(dmg)
	if CLIENT then return end

	local ply = self:GetNWEntity("user")
	if ply:IsValid() then 
		ply:SetHealth(ply:Health() - dmg:GetDamage())
		if ply:Health() <= 0 then
			ply:GodDisable()
			ply:TakeDamageInfo(dmg)
		end
	end
end

function ENT:Draw()
	if SERVER then return end
end

