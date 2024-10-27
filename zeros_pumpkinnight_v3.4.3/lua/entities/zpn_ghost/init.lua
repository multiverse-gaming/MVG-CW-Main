/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

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
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

	return ent
end

function ENT:Initialize()
	zpn.Ghost.Initialize(self)
end

function ENT:OnTakeDamage(dmginfo)
	zpn.Ghost.OnTakeDamage(self, dmginfo)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

function ENT:OnRemove()
	zpn.Ghost.OnRemove(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

function ENT:GravGunPickupAllowed(ply)
	return false
end

function ENT:GravGunPunt(ply)
	return false
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

function ENT:PhysicsSimulate(phys, deltatime)
	zpn.Ghost.PhysicsSimulate(self, phys, deltatime)
end
