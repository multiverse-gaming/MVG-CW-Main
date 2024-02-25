AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
include('shared.lua')
function ENT:Initialize()
	self:SetModel( "models/starwars_bomb/starwars_bomb_cable.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetUseType(SIMPLE_USE)

	self.phys = self:GetPhysicsObject()
	self.phys:EnableMotion(false)
	if (self.phys:IsValid()) then
		self.phys:Wake()
	end
	self.iscut = false
end

function ENT:OnTakeDamage()
	if self.iscut then return end
	local random = math.random(1, 4)
	if random == 1 then
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() )
		effectdata:SetMagnitude(2)
		util.Effect("ElectricSpark", effectdata)
		self:SetModel("models/starwars_bomb/starwars_bomb_cable_cut.mdl")

		timer.Simple(1, function() 
			self.bomb:Explode() 
		end)
	else
		self.iscut = true
		self:SetModel("models/starwars_bomb/starwars_bomb_cable_cut.mdl")
		self.bomb:CableCut(self)
	end
end

function ENT:Use(ply)
	self.bomb:Use(ply)
end