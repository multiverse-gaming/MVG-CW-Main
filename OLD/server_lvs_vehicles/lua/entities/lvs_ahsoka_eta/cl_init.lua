include("shared.lua")

ENT.EngineColor = Color( 150, 250, 250, 255)
ENT.EngineGlow = Material( "sprites/light_glow02_add" )
ENT.EngineCenter = Material( "vgui/circle" )
ENT.EnginePos = {
	[1] = Vector(-110.81,15.8727,-19.055),
	[2] = Vector(-110.81,-15.8727,-19.055),
}

function ENT:CalcViewOverride( ply, pos, angles, fov, pod )
	if self:GetDriver() == ply then
		local newpos = pos + self:GetForward() * 37 + self:GetUp() * 8

		return newpos, angles, fov
	else
		return pos, angles, fov
	end
end

function ENT:OnSpawn()
	self:RegisterTrail( Vector(-152,55,55), 0, 20, 2, 1000, 150 )
	self:RegisterTrail( Vector(-152,-55,55), 0, 20, 2, 1000, 150 )
end

function ENT:OnFrame()
	self:EngineEffects()
	self:AnimWings()
	self:AnimAstromech()
	self:AnimCockpit()
end

function ENT:AnimWings()
	self.SMLG = self.SMLG and self.SMLG + (70 * (self:GetFoils() and 0 or 1) - self.SMLG) * FrameTime() * 2.1 or 0
	
	local Ang = 70 - self.SMLG
	self:ManipulateBoneAngles( 6, Angle(0,Ang,0) )
	self:ManipulateBoneAngles( 3, Angle(0,Ang,0) )
	self:ManipulateBoneAngles( 4, Angle(0,-Ang,0) )
	self:ManipulateBoneAngles( 5, Angle(0,-Ang,0) )
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

		particle:SetVelocity( vNormal * math.Rand(500,1000) + self:GetVelocity() )
		particle:SetLifeTime( 0 )
		particle:SetDieTime( 0.1 )
		particle:SetStartAlpha( 255 )
		particle:SetEndAlpha( 0 )
		particle:SetStartSize( math.Rand(15,25) )
		particle:SetEndSize( math.Rand(0,10) )
		particle:SetRoll( math.Rand(-1,1) * 100 )
		particle:SetColor( 150, 250, 250 )
	end
end

function ENT:PostDraw()
	if not self:GetEngineActive() then return end

	cam.Start3D2D( self:LocalToWorld( Vector(-110.81,15.8727,-19.055) ), self:LocalToWorldAngles( Angle(-90,0,0) ), 1 )
		surface.SetDrawColor( self.EngineColor )
		surface.SetMaterial( self.EngineCenter )
		surface.DrawTexturedRectRotated( 0, 0, 15, 15 , 0 )
		surface.SetDrawColor( color_white )
		surface.SetMaterial( self.EngineGlow )
		surface.DrawTexturedRectRotated( 0, 0, 15, 15 , 0 )
	cam.End3D2D()
	
	cam.Start3D2D( self:LocalToWorld( Vector(-110.81,-15.8727,-19.055) ), self:LocalToWorldAngles( Angle(-90,0,0) ), 1 )
		surface.SetDrawColor( self.EngineColor )
		surface.SetMaterial( self.EngineCenter )
		surface.DrawTexturedRectRotated( 0, 0, 15, 15 , 0 )
		surface.SetDrawColor( color_white )
		surface.SetMaterial( self.EngineGlow )
		surface.DrawTexturedRectRotated( 0, 0, 15, 15 , 0 )
	cam.End3D2D()
end

function ENT:PostDrawTranslucent()
	if not self:GetEngineActive() then return end

	local Size = 60 + self:GetThrottle() * 60 + self:GetBoost()

	render.SetMaterial( self.EngineGlow )

	for _, pos in pairs( self.EnginePos ) do
		render.DrawSprite(  self:LocalToWorld( pos ), Size, Size, self.EngineColor )
	end
end

function ENT:AnimAstromech()
	local T = CurTime()

	if (self.nextAstro or 0) < T then
		self.nextAstro = T + math.Rand(0.5,2)
		self.AstroAng = math.Rand(-180,180)

		local HasShield = self:GetShield() > 0

		if self.OldShield == true and not HasShield then
			self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/astromech/shieldsdown"..math.random(1,2)..".ogg", 100 )
		else
			if math.random(0,4) == 3 then
				self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/astromech/"..math.random(1,11)..".ogg", 70 )
			end
		end
		
		self.OldShield = HasShield
	end

	self.smastro = self.smastro and (self.smastro + ((self.AstroAng or 0) - self.smastro) * RealFrameTime() * 10) or 0

	self:ManipulateBoneAngles( 2, Angle(self.smastro,0,0) )
end

function ENT:AnimCockpit()
	local bOn = self:GetActive()

	local TVal = bOn and 0 or 1

	local Speed = FrameTime() * 4

	self.SMcOpen = self.SMcOpen and self.SMcOpen + math.Clamp(TVal - self.SMcOpen,-Speed,Speed) or 0

	self:ManipulateBonePosition( 1, Vector(0,0,0) ) 	
	self:ManipulateBoneAngles( 1, Angle(0,0,self.SMcOpen *-80) ) 
end

function ENT:OnStartBoost()
	self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/boost.wav", 85 )
end

function ENT:OnStopBoost()
	self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/brake.wav", 85 )
end
