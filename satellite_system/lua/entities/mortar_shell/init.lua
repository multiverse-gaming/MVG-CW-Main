AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	--self:SetModel("models/maxofs2d/cube_tool.mdl")
	self:SetModel("models/dolunity/starwars/mortar/shell.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)

	self:PhysWake()
end

function ENT:PhysicsCollide()

	self:EmitSound("weapons/mortarimpact.mp3",510,100)
	
	ParticleEffect("full_explode", self:GetPos(), Angle(0,0,0), nil)
	util.BlastDamage(self, self, self:GetPos(), 750, 250)
	self:Remove()
end