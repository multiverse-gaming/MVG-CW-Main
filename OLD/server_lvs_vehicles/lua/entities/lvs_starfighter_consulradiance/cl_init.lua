include("shared.lua")


ENT.EngineFXPos = {
	Vector(-1003.18,-588.23,233.03),
	Vector(-990.07,16.88,232.96),
	Vector(-976.98,620.49,232.9),
}

function ENT:OnSpawn()
	self:RegisterTrail( Vector(833.19,-307.46,232.38), 0, 20, 2, 2500, 150 )
	self:RegisterTrail( Vector(833.19,307.46,232.38), 0, 20, 2, 2500, 150 )
	self:RegisterTrail( Vector(833.69,-307.43,196.78), 0, 20, 2, 2500, 150 )
	self:RegisterTrail( Vector(833.69,307.43,196.78), 0, 20, 2, 2500, 150 )
end

function ENT:OnFrame()
	self:EngineEffects()
end

ENT.EngineGlow = Material( "sprites/light_glow02_add" )

function ENT:PostDrawTranslucent()
	if not self:GetEngineActive() then return end

	local Size = 2000 + self:GetThrottle() * 40 + self:GetBoost() * 0.8

	render.SetMaterial( self.EngineGlow )
	render.DrawSprite( self:LocalToWorld( Vector(-1003.18,-588.23,233.03) ), Size, Size, Color( 255,255,0) )
	render.DrawSprite( self:LocalToWorld( Vector(-990.07,16.88,232.96) ), Size, Size, Color(255,255,0) )
	render.DrawSprite( self:LocalToWorld( Vector(-976.98,620.49,232.9) ), Size, Size, Color( 255,255,0) )
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
		particle:SetStartSize( math.Rand(20,25) )
		particle:SetEndSize( math.Rand(0,50) )
		particle:SetRoll( math.Rand(-1,1) * 100 )
		
		particle:SetColor( 255, 172, 28 )
	end
end
function ENT:OnStartBoost()
	self:EmitSound( "lvs/vehicles/frigates/takeoff2.mp3", 500 )
end

function ENT:OnStopBoost()
	self:EmitSound( "lvs/vehicles/vwing/brake.wav", 120 )
end
