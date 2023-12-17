AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable 	= false

function ENT:Draw()
	if SERVER then return end

	local ply = self:GetNWEntity("user")
	self.GetPlayerColor = function() if ply:IsValid() then return ply:GetPlayerColor() end end
 
	self:DrawModel()
end

function ENT:Initialize()
	if CLIENT then return end
	
	self:DrawShadow(false)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
end

function ENT:OnTakeDamage(dmg)
	local ply = self:GetNWEntity("user")
	if ply:IsValid() then ply:TakeDamageInfo(dmg) end
end

function ENT:Think()
	if CLIENT then return end
	if not self:GetNWEntity("user"):IsValid() then SafeRemoveEntity(self) end
end