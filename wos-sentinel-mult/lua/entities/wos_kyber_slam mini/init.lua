
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )


function ENT:Initialize()

	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_OBB )

	self.BuildingSound = CreateSound( self.Entity, "ambient/machines/combine_shield_loop3.wav" )
	self.BuildingSound:Play()

	self.Entity:SetCollisionGroup( COLLISION_GROUP_BREAKABLE_GLASS )
	self.Entity:SetTrigger( true )
	self.Entity:SetNotSolid( true )
	self.Entity:DrawShadow( false )

	self.Entity:Activate()

	local length = 500
	local width = 500
	local height = 400

	self.LifeSpan = CurTime() + 1

	local maxref = Vector( length/2, width/2, height )
	local minref = Vector( length/-2, width/-2, 0 )

	self.Entity:SetCollisionBounds( minref, maxref )

end

function ENT:Think()
	local lightning = ents.Create( "point_tesla" )
	lightning:SetPos(entpos)
	lightning:SetKeyValue("m_SoundName", "")
	lightning:SetKeyValue("texture", "sprites/bluelight1.spr")
	lightning:SetKeyValue("m_Color", "255 255 150")
	lightning:SetKeyValue("m_flRadius", "350")
	lightning:SetKeyValue("beamcount_max", "15")
	lightning:SetKeyValue("thick_min", "15")
	lightning:SetKeyValue("thick_max", "30")
	lightning:SetKeyValue("lifetime_min", "0.3")
	lightning:SetKeyValue("lifetime_max", "0.4")
	lightning:SetKeyValue("interval_min", "0.15")
	lightning:SetKeyValue("interval_max", "0.25")
	lightning:Spawn()
	lightning:Fire("DoSpark", "", 0)
	lightning:Fire("kill", "", 0.2)
	self:EmitSound( "ambient/levels/citadel/portal_beam_shoot" .. math.random( 1, 6 ) .. ".wav" )

	if self.LifeSpan < CurTime() then
		self.Entity:Remove()
	end
end

function ENT:StartTouch( ent )
	if ent == self.Owner then return end
	if not ent:IsNPC() and not ent:IsPlayer() and not ent:IsNextBot() then return end
	local dmginfo = DamageInfo()
	dmginfo:SetDamage( 800 )
	dmginfo:SetAttacker( self.Owner )
	dmginfo:SetInflictor( self.Owner:GetActiveWeapon() )
	dmginfo:SetDamageType( DMG_DISSOLVE )
	ent:TakeDamageInfo( dmginfo )
end 

function ENT:OnRemove()
	if self.BuildingSound then
		self.BuildingSound:Stop()
		self.BuildingSound = nil
	end
end


