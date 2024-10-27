/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SpawnFunction(ply, tr)
	local SpawnPos = tr.HitPos + tr.HitNormal * 20
	local ent = ents.Create(self.ClassName)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:Initialize()
	self:SetModel(zpn.Theme.Bomb.model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)

	self:SetCustomCollisionCheck(true)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then

		//phys:SetMass(5)
		phys:EnableMotion(true)
		phys:EnableDrag(true)
		phys:Wake()
		if self.FlyDirection then
			phys:ApplyForceCenter(phys:GetMass() * (self.FlyDirection * 2))
			phys:ApplyTorqueCenter(phys:GetMass() * self.FlyDirection)
		end
	end

	self.Destroyd = false
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

	self:PrecacheGibs()

	// Give it some random orange color
	self:SetColor(zpn.Theme.Destructibles.getcolor())


	timer.Simple(zpn.config.Boss.Bombs.ExploDelay, function()
		if IsValid(self) and self.Destroyd == false then
			self:ExplodePumpkin()
		end
	end)
end

function ENT:DestroyPumpkin()
	if self.Destroyd then return end

	zclib.Debug("DestroyPumpkin")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

	self.Destroyd = true

	zclib.NetEvent.Create("zpn_destructable_destroy", {self})

	self:SetNoDraw(true)

	zclib.NetEvent.Create("zpn_bomb_removefuse", {self})

	// Freeze Entity
	timer.Simple(0, function()
		if IsValid(self) then
			local phys = self:GetPhysicsObject()

			if IsValid(phys) then
				phys:Wake()
				phys:EnableMotion(false)
			end

			self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		end
	end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

	SafeRemoveEntityDelayed(self,1)
end

function ENT:ExplodePumpkin()
	if self.Destroyd then return end

	self:DestroyPumpkin()

	zclib.Debug("ExplodePumpkin")
	self.Destroyd = true
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4

	zclib.NetEvent.Create("zpn_bomb_explode", {self})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

	// Make Damage for players in distance
	local exPos = self:GetPos()
	for k, v in pairs(zclib.Player.List) do
		if IsValid(v) and v:Alive() and zclib.util.InDistance(exPos, v:GetPos(), 150) then
			local d = DamageInfo()
			d:SetDamage(zpn.config.Boss.Bombs.Damage)
			if IsValid(self.BombShooter) then
				d:SetAttacker(self.BombShooter)
			elseif IsValid(self) then
				d:SetAttacker(self)
			end
			d:SetDamageType(DMG_GENERIC)
			v:TakeDamageInfo(d)
		end
	end
end

function ENT:OnTakeDamage(dmginfo)
	if dmginfo:GetDamage() > 5 and IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():IsPlayer() then
		self:DestroyPumpkin()
	end
end
