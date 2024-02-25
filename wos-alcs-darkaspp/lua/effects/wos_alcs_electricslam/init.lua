
PrecacheParticleSystem( "[4]arcs_electric_1" )

function EFFECT:Init( data )

	local dir = data:GetStart()
	local ent = data:GetEntity()
	self.EndPos = data:GetOrigin()
	
	self:SetPos( ent:GetPos() )
	
	self.Particle1 = CreateParticleSystem( self, "[4]arcs_electric_1", PATTACH_ABSORIGIN_FOLLOW, 0, dir*-100 )
	self.Particle2 = CreateParticleSystem( self, "[4]arcs_electric_1", PATTACH_ABSORIGIN_FOLLOW, 0, dir*100 )
	self.Particle3 = CreateParticleSystem( self, "[4]arcs_electric_1", PATTACH_ABSORIGIN_FOLLOW )
	self.LifeTime = CurTime() + 0.75

	self.Increments = ( self.EndPos - self:GetPos() ) / ( self.LifeTime - CurTime() )
	
end

function EFFECT:Think()
	self:SetPos( self:GetPos() + self.Increments )
	if self.LifeTime < CurTime() then
		self.Particle1:StopEmission( false, true )
		self.Particle2:StopEmission( false, true )
		self.Particle3:StopEmission( false, true )
		return false
	end
	return true
end

function EFFECT:Render()
end
