
PrecacheParticleSystem( "[4]electric_beam" )

function EFFECT:Init( data )

	local ent = data:GetEntity()
	local vec = data:GetAngles()
	
	self.Particle = CreateParticleSystem( ent, "[4]electric_beam", PATTACH_POINT, ent:LookupAttachment( "anim_attachment_LH" ) ) 
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
