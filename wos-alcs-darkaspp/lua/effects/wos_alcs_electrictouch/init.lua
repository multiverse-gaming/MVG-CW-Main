
PrecacheParticleSystem( "[4]arcs_electric_1_small" )

function EFFECT:Init( data )

	local ent = data:GetEntity()
	local time = data:GetRadius()
	
	self.Particle = CreateParticleSystem( ent, "[4]arcs_electric_1_small", PATTACH_ABSORIGIN_FOLLOW, nil, ent:GetUp()*30 ) 
	self.LifeTime = CurTime() + time
	
end

function EFFECT:Think()
	if self.LifeTime < CurTime() then
		self.Particle:StopEmission( false, true )
		return false
	end
	return true
end

function EFFECT:Render()
end
