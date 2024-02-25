include("shared.lua")

function ENT:OnSpawn()
	self:RegisterTrail( Vector(-151,87,15), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-151,-87,15), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-151,87,-15), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-151,-87,-15), 0, 20, 2, 1000, 150 )
end
 
-- Engine Particles start

ENT.EngineColor = Color( 255, 0, 0)
ENT.EngineGlow = Material( "sprites/light_glow02_add" )
ENT.EnginePos = {
	Vector(-745.52,242.78,-29.65),
	Vector(-745.52,-242.78,-29.65),
}

function ENT:OnSpawn()
	self:RegisterTrail( Vector(-34,326,-13), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-34,-326,-13), 0, 20, 2, 1000, 150 )
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
		particle:SetDieTime( 0.3)
		particle:SetStartAlpha( 255 )
		particle:SetEndAlpha( 0 )
		particle:SetStartSize( math.Rand(100,200) )
		particle:SetEndSize( math.Rand(0,10) )
		particle:SetRoll( math.Rand(-1,1) * 100 )
		particle:SetColor( 255, 0, 0)
	end
end

function ENT:OnFrame()
	self:EngineEffects()
end


-- Engine Particles End

function ENT:PostDraw()
	if not self:GetEngineActive() then return end
end

function ENT:OnStartBoost()
	self:EmitSound( "ophra/ships/powerstart3.wav", 85 )
end

function ENT:OnStopBoost()
	self:EmitSound( "ophra/ships/shutdown.wav", 85 )
end

