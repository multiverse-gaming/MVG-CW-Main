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
	ent:SetAngles(angle)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

	return ent
end

function ENT:Initialize()
	zpn.Destructable.Initialize(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

function ENT:PhysicsCollide(data, phys)
	zpn.Destructable.OnPhysicsCollide(self,data)
end

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

function ENT:OnTakeDamage( dmginfo )
	 zpn.Destructable.OnTakeDamage(self, dmginfo )
end

function ENT:OnRemove()
	zpn.Destructable.OnRemove(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
