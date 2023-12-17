AddCSLuaFile()

ENT.Type 				= "anim"
ENT.Base 				= "base_gmodentity"
ENT.PrintName 			= "Jump Jet Remover"
ENT.Spawnable 			= true
ENT.RenderGroup			= RENDERGROUP_TRANSLUCENT
ENT.Category = "MVG"



function ENT:Initialize()
	if SERVER then
		self:SetUseType( SIMPLE_USE )
	end
	
	self.Entity:SetModel("models/lordtrilobite/starwars/props/crate_yavin01_phys.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
end

function ENT:Use( _, ent )
	if ent:SetNWBool( "HasJumpJet", false ) then
		ents.FindByClass( "jump_jet" ):Remove()
    end
	self.Entity:Remove()
	ent:ChatPrint( "You have unequipped a jump jet!" )

end