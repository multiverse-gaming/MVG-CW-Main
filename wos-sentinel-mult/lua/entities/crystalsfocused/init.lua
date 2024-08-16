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
    local item1 = wOS:GetItemData( "Focused Crystal ( Green )" )
    local item2 = wOS:GetItemData( "Focused Crystal ( Blue )" )
    local item3 = wOS:GetItemData( "Focused Crystal ( Light Green )" )
    local item4 = wOS:GetItemData( "Focused Crystal ( Cyan )" )
    local item5 = wOS:GetItemData( "Focused Crystal ( Purple )" )
    wOS:HandleItemPickup( ply, item1.Name )
    wOS:HandleItemPickup( ply, item2.Name )
    wOS:HandleItemPickup( ply, item3.Name )
    wOS:HandleItemPickup( ply, item4.Name )
    wOS:HandleItemPickup( ply, item5.Name )
	hook.Call("WILTOS.ItemUsed", nil, ply, "Focused Crystals", "Crystals")
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