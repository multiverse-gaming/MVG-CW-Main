
PrecacheParticleSystem( "[4]b1_m" )

function EFFECT:Init( data )

	local ent = data:GetEntity()
	local vec = data:GetAngles()
	
	self.Particle = CreateParticleSystem( ent, "[4]b1_m", PATTACH_POINT, ent:LookupAttachment( "anim_attachment_RH" ) ) 
	self.Particle:SetControlPointOrientation( 0, vec:Forward(), vec:Right(), vec:Up() )
	self.LifeTime = CurTime() + 0.25
	
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
