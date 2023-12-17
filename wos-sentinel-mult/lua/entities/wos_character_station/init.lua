AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
	self:SetModel( "models/kingpommes/starwars/misc/jedi/jedi_holocron_closed.mdl" )
	self:DrawShadow(true)
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	
	self:SetCollisionGroup( COLLISION_GROUP_NONE )	

end

function ENT:Use( ply )

	net.Start( "wOS.Crafting.GetInventory" )
		net.WriteTable( ply.SaberInventory )
		net.WriteTable( ply.SaberMiscItems )
	net.Send( ply )
	ply:SendLua( [[wOS.ALCS.Skills:OpenSkillsMenu()]] )
	
end

function ENT:UpdateTransmitState()

	return TRANSMIT_ALWAYS 

end

