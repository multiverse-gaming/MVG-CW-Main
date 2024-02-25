ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Heal = 500
ENT.Radius = 200


ENT.PrintName = "Impulse Grenade RC" 
ENT.Author = "randomscripter"
ENT.Contact = "..."
ENT.Purpose = "..."
ENT.Instructions = "you shouldnt be reading this"

ENT.Spawnable			= false
ENT.AdminSpawnable		= false


AddCSLuaFile()


function ENT:Initialize()
	if SERVER then
		-- Set up the entity
		self.Entity:SetModel( "models/riddickstuff/bactagrenade/bactanade.mdl" )
		self.Entity:PhysicsInit( SOLID_BSP )
		self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
		self.Entity:SetSolid( SOLID_BSP )
		self.Index = self.Entity:EntIndex()
		local phys = self.Entity:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
	end
end

function ENT:PhysicsCollide( data, physobj )

	local tobeblasted = ents.FindInSphere( self.Entity:GetPos(), self.Radius )
	for k, v in pairs( tobeblasted ) do
		if v:IsPlayer() then
			if ( SERVER ) then
				v:SetHealth( math.min( v:Health() + 50, v:GetMaxHealth() ) ) --math.min( v:Health() + v:GetMaxHealth() * 0.5, v:GetMaxHealth() )
			end
		end
	end
	self.Entity:EmitSound("bacta/bactapop.wav", 75, 50)
	local effectdata = EffectData()
	effectdata:SetOrigin( self.Entity:GetPos() )
	util.Effect("effect_bactanade_rc",effectdata)
	self.Entity:Remove()
end
