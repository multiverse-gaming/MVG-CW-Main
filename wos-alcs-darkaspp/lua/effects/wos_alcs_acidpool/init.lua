
PrecacheParticleSystem( "[2]acid_ground" )

function EFFECT:Init( data )

	local ent = data:GetEntity()
	
	self.Particle = CreateParticleSystem( ent, "[2]acid_ground", PATTACH_ABSORIGIN_FOLLOW ) 
	self.LifeTime = CurTime() + 3
	
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
