/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SpawnFunction(ply, tr)
	local SpawnPos = tr.HitPos + tr.HitNormal * 0
	local ent = ents.Create(self.ClassName)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

	return ent
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

function ENT:Initialize()
	self:SetModel("models/hunter/misc/sphere2x2.mdl")
	self:SetModelScale(2)
	//local r = 400
	//self.PhysObjRadius = r

	//self:PhysicsInitSphere(r, "default")
	//self:SetCollisionBounds(Vector(-r, -r, -r), Vector(r, r, r))

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	self:DrawShadow(false)
	self.PhysgunDisabled = true
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:SetMass(100)
		phys:EnableMotion(false)
		phys:Wake()
	else
		self:Remove()

		return
	end

	self:SetTrigger(true)
	self:SetCustomCollisionCheck(true)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

	SafeRemoveEntityDelayed(self,zpn.config.Boss.FireRain.Firepit_Duration)
end

function ENT:GravGunPickupAllowed( ply )
	return false
end

function ENT:Touch(other)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

	if IsValid(other) and other:IsPlayer() and other:Alive() and (other.zpn_LastFireDamage == nil or other.zpn_LastFireDamage < CurTime()) then

		// Give the player some damage
		local d = DamageInfo()
		d:SetDamage(1)
		if IsValid(self.FireAreaSpawner) then
			d:SetAttacker(self.FireAreaSpawner)
		elseif IsValid(self) then
			d:SetAttacker(self)
		end
		d:SetDamageType(zpn.Theme.FireArea.damagetype)
		other:TakeDamageInfo(d)

		other.zpn_LastFireDamage = CurTime() + 0.75
	end
end
