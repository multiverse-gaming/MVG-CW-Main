/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

function ENT:SpawnFunction(ply, tr)
	local SpawnPos = tr.HitPos + tr.HitNormal * 25
	local ent = ents.Create(self.ClassName)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:Initialize()
	self:SetModel(self.Model)

	local r = 5
	self.PhysObjRadius = r

	self:PhysicsInitSphere(r, "default")
	self:SetCollisionBounds(Vector(-r, -r, -r), Vector(r, r, r))
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(false)
	self.PhysgunDisabled = true
	self:SetSkin(1)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:SetMass(1)
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:Wake()
	else
		self:Remove()

		return
	end

	self:StartMotionController()
	self:SetCustomCollisionCheck(true)

	// This gets set by other system to tell it where to fly
	// but if it doesent then we just fly up
	if self.FlyDir == nil then
		self.FlyDir = self:GetAngles():Up()
	end

	self.HitPlayer = false

	SafeRemoveEntityDelayed(self,self.KillTime or 1)
end

function ENT:GravGunPickupAllowed( ply )
	return false
end

local maxForce = 2 ^ 32
function ENT:PhysicsSimulate(phys, dt)
	if self.zpn_Collided then return end

	if not self.zpn_Increase then
		self.zpn_Increase = 1
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

	self.zpn_Increase = math.Approach(self.zpn_Increase, maxForce, dt * maxForce * 0.01)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

	local force = Vector(0, 0, 0)
	local angForce = Vector(0, 0, 0)

	//local pos = VectorRand() * 5
	//if pos then force = force + pos end

	force = force + self.FlyDir * self.zpn_Increase

	force = force * dt
	angForce = angForce * dt

	return angForce, force, SIM_GLOBAL_ACCELERATION
end



function ENT:PhysicsCollide(data, physobj)
	if not self.zpn_Collided then

		local velPlus = data.OurOldVelocity and data.OurOldVelocity:GetNormal() * 60 or Vector(0,0,0)

		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableMotion(false)
		end

		timer.Simple(FrameTime(), function()
			if not IsValid(self) then return end

			local pos = data.HitPos - data.HitNormal * self.PhysObjRadius
			self:SetPos(pos + velPlus)

			if IsValid(self.Owner) then
				zpn.Partypopper.ProjectileExplosion(self:GetPos(),200,self.Owner)
			end
		end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

		local deltime = FrameTime() * 2
		if not game.SinglePlayer() then deltime = FrameTime() * 6 end

		SafeRemoveEntityDelayed(self,deltime)

		self.zpn_Collided = true
	end
end
