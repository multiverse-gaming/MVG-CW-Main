include("shared.lua")

function ENT:OnSpawn()
	self:RegisterTrail( Vector(-151,87,15), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-151,-87,15), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-151,87,-15), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-151,-87,-15), 0, 20, 2, 1000, 150 )
end

ENT.EngineColor = Color( 255, 174, 0)
ENT.EngineGlow = Material( "sprites/light_glow02_add" )
ENT.EnginePos = {
	Vector(-299.79,244.61,103.28),
	Vector(-299.79,-244.61,103.28),
	Vector(-288.98,266.67,159.5),
	Vector(-288.98,-266.67,159.5),
}

function ENT:OnFrame()
	self:EngineEffects()
end


function ENT:CalcViewOverride( ply, pos, angles, fov, pod )
	if ply == self:GetDriver() and not pod:GetThirdPersonMode() then
		return pos + self:GetForward() * 240 - self:GetUp() * 30, angles, fov
	end

	return pos, angles, fov
end

ENT.EngineGlow = Material( "sprites/light_glow02_add" )
ENT.EngineFXColor = Color( 255,0,0, 255)
ENT.EngineFxPos = {
	Vector(-77,321,43),
	Vector(-76,-321,43),
}

function ENT:PostDraw()
	if not self:GetEngineActive() then return end
 
 
end

function ENT:EngineEffects()
	if not self:GetEngineActive() then return end

	local T = CurTime()

	if (self.nextEFX or 0) > T then return end

	self.nextEFX = T + 0.01

	local THR = self:GetThrottle()

	local emitter = self:GetParticleEmitter( self:GetPos() )

	if not IsValid( emitter ) then return end

	for _, pos in pairs( self.EnginePos ) do
		local vOffset = self:LocalToWorld( pos )
		local vNormal = -self:GetForward()

		vOffset = vOffset + vNormal * 5

		local particle = emitter:Add( "effects/muzzleflash2", vOffset )

		if not particle then continue end

		particle:SetVelocity( vNormal * (math.Rand(500,1000) + self:GetBoost() * 10) + self:GetVelocity() )
		particle:SetLifeTime( 0 )
		particle:SetDieTime( 0.6)
		particle:SetStartAlpha( 255 )
		particle:SetEndAlpha( 0 )
		particle:SetStartSize( math.Rand(15,25) )
		particle:SetEndSize( math.Rand(0,10) )
		particle:SetRoll( math.Rand(-1,1) * 100 )
		particle:SetColor( 187, 255, 0)
	end
end

function ENT:PostDrawTranslucent()
	if not self:GetEngineActive() then return end

	local Size = 30 + self:GetThrottle() * 15 + self:GetBoost() * 0.4

	render.SetMaterial( self.EngineGlow )

	for _, v in pairs( self.EngineFxPos ) do
		local pos = self:LocalToWorld( v )
		render.DrawSprite( pos, Size, Size, self.EngineFXColor )
	end
end

function ENT:OnStartBoost()
	self:EmitSound( "ophra/ships/powerstart3.wav", 85 )
end

function ENT:OnStopBoost()
	self:EmitSound( "ophra/ships/shutdown.wav", 85 )
end

