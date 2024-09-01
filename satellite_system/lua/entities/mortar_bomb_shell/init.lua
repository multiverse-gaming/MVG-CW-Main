AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/dolunity/starwars/mortar/shell.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)

	self:PhysWake()



end

function ENT:PhysicsCollide(colData, collider)

	local getHEShellDamage = GetConVar("kmortar_he_damagevalue"):GetInt()
	local getHEDmgRadius = GetConVar("kmortar_he_splash_radius"):GetInt()
	collider:EnableMotion(false)

	net.Start("kaito_net_sound_new_he")
		net.WriteVector(colData.HitPos)
	net.Broadcast()

	timer.Simple(5, function()
		local cx,cy,cz = colData.HitPos:Unpack()
		pos = Vector(cx,cy,cz)
	    ParticleEffect("full_explode", Vector(cx,cy,cz), Angle(0,0,0), nil)
		util.BlastDamage(colData.PhysObject:GetEntity(), colData.PhysObject:GetEntity(), Vector(cx,cy,cz), getHEDmgRadius, getHEShellDamage)
		util.Decal("Scorch", Vector(cx,cy,cz),pos-Vector(0, 0, 30))
	end)

	timer.Simple(6, function() 
		colData.PhysObject:GetEntity():Remove()
	end)

end

