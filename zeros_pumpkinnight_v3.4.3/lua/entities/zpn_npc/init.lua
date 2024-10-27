/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SpawnFunction(ply, tr)
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create(self.ClassName)
	local angle = ply:GetAimVector():Angle()
	angle = Angle(0, angle.yaw, 0)
	angle:RotateAroundAxis(angle:Up(),180)
	ent:SetAngles(angle)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:Initialize()
	self:SetModel(zpn.Theme.NPC.model)
	self:SetSolid(SOLID_BBOX)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetHullType(HULL_HUMAN)
	self:SetUseType(SIMPLE_USE)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

	if zpn.config.NPC.Capabilities then
		self:CapabilitiesAdd(CAP_ANIMATEDFACE)
		self:CapabilitiesAdd(CAP_TURN_HEAD)
	end
end

function ENT:AcceptInput(key, ply)
	if ((self.lastUsed or CurTime()) <= CurTime()) and (key == "Use" and IsValid(ply) and ply:IsPlayer() and ply:Alive()) and zclib.util.InDistance(ply:GetPos(), self:GetPos(), 100) then
		self.lastUsed = CurTime() + 1
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

		zpn.NPC.USE(ply, self)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4

function ENT:OnTakeDamage(dmg)
	return 0
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
