AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
	self:SetModel( "models/kingpommes/starwars/misc/jedi/jedi_holocron_opened.mdl" )
	self:DrawShadow(true)
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	self:SetCollisionGroup( COLLISION_GROUP_NONE )	
end

function ENT:Use(ply)
    local jedi = {
        [TEAM_JEDIPADAWAN] = true,
        [TEAM_JEDIKNIGHT] = true,
        [TEAM_JEDISENTINEL] = true,
        [TEAM_JEDIGUARDIAN] = true,
        [TEAM_JEDICONSULAR] = true,
        [TEAM_JEDICOUNCIL] = true,
        [TEAM_JEDIGENERALADI] = true,
        [TEAM_JEDIGENERALSHAAK] = true,
        [TEAM_JEDIGENERALKIT] = true,
        [TEAM_JEDIGENERALPLO] = true,
        [TEAM_JEDIGENERALTANO] = true,
        [TEAM_JEDIGENERALWINDU] = true,
        [TEAM_JEDIGENERALOBI] = true,
        [TEAM_JEDIGENERALSKYWALKER] = true,
        [TEAM_JEDIGRANDMASTER] = true,
        [TEAM_JEDIGENERALAAYLA] = true,
        [TEAM_JEDIGENERALLUMINARA] = true,
        [TEAM_JEDIGENERALVOS] = true,
        [TEAM_JEDITOURNAMENT] = true,
        }
    if jedi[ply:Team()] then
	ply:AddSkillXP(800)
	hook.Call("WILTOS.ItemUsed", nil, ply, self:GetOwner(), self:GetName(), "XP Holocron")
	self:Remove()
    end
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
	return ent

end