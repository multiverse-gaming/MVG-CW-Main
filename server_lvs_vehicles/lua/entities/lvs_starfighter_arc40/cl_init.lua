include("shared.lua")

ENT.EngineFXPos = {
	Vector(-203.04,65.75,64.11),
	Vector(-203.04,-65.75,64.11),
}

function ENT:OnSpawn()
	self:RegisterTrail( Vector(-157.1,140.48,118.87), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-157.1,-140.48,118.87), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-163.47,140.89,1.67), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-163.47,-140.89,1.67), 0, 20, 2, 1000, 150 )
end

function ENT:OnFrame()
	self:EngineEffects()
end

ENT.EngineGlow = Material( "sprites/light_glow02_add" )

function ENT:PostDrawTranslucent()
	if not self:GetEngineActive() then return end

	local Size = 130 + self:GetThrottle() * 40 + self:GetBoost() * 0.8

	render.SetMaterial( self.EngineGlow )
	render.DrawSprite( self:LocalToWorld( Vector(-203.04,65.75,64.11) ), Size, Size, Color( 137, 207, 240) )
	render.DrawSprite( self:LocalToWorld( Vector(-203.04,-65.75,64.11) ), Size, Size, Color( 137, 207, 240) )

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
		
		particle:SetColor( 137, 207, 240 )
	end
end
function ENT:OnStartBoost()
	self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/boost.wav", 85 )
end

function ENT:OnStopBoost()
	self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/brake.wav", 85 )
end
