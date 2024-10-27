/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

function ENT:SpawnFunction(ply, tr)
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create(self.ClassName)
	local angle = ply:GetAimVector():Angle()
	angle = Angle(0, angle.yaw, 0)
	angle:RotateAroundAxis(angle:Up(), 180)
	ent:SetAngles(angle)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	ent.TrapOwner = ply
	return ent
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:UseClientSideAnimation()

	self:SetModelScale(0.3,0.001)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(true)
	end

	self.TrapActivated = false

	self.Question = "Who made gmod?"
	self.Answer = "Garry"
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

	timer.Simple(0.5,function()
		if not IsValid(self) then return end
		net.Start("zpn.Beartrap.SnapOpen")
		net.WriteEntity(self)
		net.Broadcast()
	end)
end

function ENT:StartTouch(other)
	if not IsValid(other) then return end
	if not other:IsPlayer() then return end
	if other == self.TrapOwner then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4

	if not self.TrapActivated then return end

	if self.TrapCooldown and self.TrapCooldown > CurTime() then return end

	// Attach beartrap on player head and viewmodel
	zpn.Beartrap.Attach(self,other)
end

function ENT:AcceptInput(input, activator, caller, data)
	if string.lower(input) == "use" and IsValid(activator) and activator:IsPlayer() and activator:Alive() then

		if self.TrapActivated then return end

		if self.TrapOwner ~= activator then return end

		// Open interface to edit the Question / Answer
		zpn.Beartrap.Edit(self,activator)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4
