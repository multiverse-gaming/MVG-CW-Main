
PrecacheParticleSystem( "[2]gushing_blood_alien" )

function EFFECT:Init( data )

	local ent = data:GetEntity()
	
	self.Particle = CreateParticleSystem( ent, "[2]gushing_blood_alien", PATTACH_ABSORIGIN_FOLLOW, nil, ent:GetUp()*40 ) 
	self.LifeTime = CurTime() + 0.3
	
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
