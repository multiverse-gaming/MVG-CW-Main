/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SpawnFunction(ply, tr)
	local SpawnPos = tr.HitPos + tr.HitNormal * 25
	local ent = ents.Create(self.ClassName)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

	return ent
end

function ENT:Initialize()
	zpn.Candy.Initialize(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

function ENT:StartTouch(other)
	if IsValid(other) and other:IsPlayer() and other:Alive() then
		zpn.Candy.StartTouch(self, other)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

function ENT:AcceptInput(key, ply)
	if ((self.lastUsed or CurTime()) <= CurTime()) and (key == "Use" and IsValid(ply) and ply:IsPlayer() and ply:Alive()) and zclib.util.InDistance(ply:GetPos(), self:GetPos(), 300) then
		self.lastUsed = CurTime() + 1
		zpn.Candy.Collect(self, ply)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4
