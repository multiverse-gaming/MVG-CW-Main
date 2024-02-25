include("shared.lua")

ENT.EngineFXPos = {
	Vector(-122.67,81.21,90.19),
	Vector(-122.27,59.14,90.11),
	Vector(-122.38,59.16,115.51),
	Vector(-122.66,80.93,115.32),
	Vector(-53.2,447.94,98.14),
	Vector(-53.66,-447.62,98.2),
	Vector(-122.67,-81.21,90.19),
	Vector(-122.27,-59.14,90.11),
	Vector(-122.38,-59.16,115.51),
	Vector(-122.66,-80.93,115.32),
}

function ENT:OnSpawn()
	self:RegisterTrail( Vector(-29.75,302.53,160.02), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-29.75,302.53,160.02), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-37.85,-299.28,38.49), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-37.85,299.28,38.49), 0, 20, 2, 1000, 150 )
end

function ENT:OnFrame()
	self:EngineEffects()
end

ENT.EngineGlow = Material( "sprites/light_glow02_add" )

function ENT:PostDrawTranslucent()
	if not self:GetEngineActive() then return end

	local Size = 100 + self:GetThrottle() * 40 + self:GetBoost() * 0.8

	render.SetMaterial( self.EngineGlow )
	render.DrawSprite( self:LocalToWorld( Vector(-122.67,81.21,90.19) ), Size, Size, Color( 238,130,238) )
	render.DrawSprite( self:LocalToWorld( Vector(-122.27,59.14,90.11) ), Size, Size, Color( 238,130,238) )
	render.DrawSprite( self:LocalToWorld( Vector(-122.38,59.16,115.51) ), Size, Size, Color( 238,130,238) )
	render.DrawSprite( self:LocalToWorld( Vector(-122.66,80.93,115.32) ), Size, Size, Color( 238,130,238) )
	render.DrawSprite( self:LocalToWorld( Vector(-53.66,-447.62,98.2) ), Size, Size, Color( 238,130,238) )
	render.DrawSprite( self:LocalToWorld( Vector(-53.2,447.94,98.14) ), Size, Size, Color( 238,130,238) )
	render.DrawSprite( self:LocalToWorld( Vector(-122.67,-81.21,90.19) ), Size, Size, Color( 238,130,238) )
	render.DrawSprite( self:LocalToWorld( Vector(-122.27,-59.14,90.11) ), Size, Size, Color( 238,130,238) )
	render.DrawSprite( self:LocalToWorld( Vector(-122.38,-59.16,115.51) ), Size, Size, Color( 238,130,238) )
	render.DrawSprite( self:LocalToWorld( Vector(-122.66,-80.93,115.32) ), Size, Size, Color( 238,130,238) )
end

function ENT:EngineEffects()
	if not self:GetEngineActive() then return end

	local T = CurTime()

	if (self.nextEFX or 0) > T then return end

	self.nextEFX = T + 0.01

	local THR = self:GetThrottle()

	local emitter = self:GetParticleEmitter( self:GetPos() )

	if not IsValid( emitter ) then return end

	for _, v in pairs( self.EngineFXPos ) do
		local Sub = Mirror and 1 or -1
		local vOffset = self:LocalToWorld( v )
		local vNormal = -self:GetForward()

		vOffset = vOffset + vNormal * 5

		local particle = emitter:Add( "effects/muzzleflash2", vOffset )

		if not particle then continue end

		particle:SetVelocity( vNormal * math.Rand(500,1000) + self:GetVelocity() )
		particle:SetLifeTime( 0 )
		particle:SetDieTime( 0.1 )
		particle:SetStartAlpha( 255 )
		particle:SetEndAlpha( 0 )
		particle:SetStartSize( math.Rand(15,25) )
		particle:SetEndSize( math.Rand(0,50) )
		particle:SetRoll( math.Rand(-1,1) * 100 )
		
		particle:SetColor( 238,130,238 )
	end
end

function ENT:OnStartBoost()
	self:EmitSound( "lvs/vehicles/arc170/boost.wav", 85 )
end

function ENT:OnStopBoost()
	self:EmitSound( "lvs/vehicles/arc170/brake.wav", 85 )
end
