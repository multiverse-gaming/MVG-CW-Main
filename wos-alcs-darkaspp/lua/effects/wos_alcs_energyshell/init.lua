
PrecacheParticleSystem( "[8]magic_portal" )

function EFFECT:Init( data )

	local ent = data:GetEntity()
	local time = data:GetScale()
	
	self.Particle = CreateParticleSystem( ent, "[8]magic_portal", PATTACH_POINT_FOLLOW, ent:LookupAttachment( "eyes" ) ) 
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
