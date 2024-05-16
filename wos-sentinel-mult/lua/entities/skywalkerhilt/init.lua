AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
	self:SetModel( "models/lt_c/sci_fi/light_spotlight.mdl" )
	self:DrawShadow(true)
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	self:SetCollisionGroup( COLLISION_GROUP_NONE )	
end

function ENT:Use( ply )
	local item1 = wOS:GetItemData( "Anakin Skywalker's Hilt EP2" )
	local item2 = wOS:GetItemData( "Anakin Skywalker's Hilt EP3" )
	local item3 = wOS:GetItemData( "Corrupted Crystal ( Blue )" )
    wOS:HandleItemPickup( ply, item1.Name )
    wOS:HandleItemPickup( ply, item2.Name )
    wOS:HandleItemPickup( ply, item3.Name )
	hook.Call("WILTOS.ItemUsed", nil, ply, "Anakin Prep", "Hilts And Crystal")
    self:Remove()
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS 
end

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 16

	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
    print (SpawnPos)
	return ent

end