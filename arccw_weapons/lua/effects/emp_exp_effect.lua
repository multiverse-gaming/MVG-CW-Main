if SERVER then AddCSLuaFile() end

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.size = data:GetScale()
	self.Emitter = ParticleEmitter(self.Start)
	for i = 1, math.random(20, 50) do
		local p = self.Emitter:Add("effects/muzzleflash"..math.random(1,4), self.Start)
		p:SetDieTime(math.Rand(0.1*3, 0.25*3))
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(50, 150) * self.size)
		p:SetEndSize(50 * self.size)
		p:SetRoll(math.Rand(-50, 50))
		p:SetRollDelta(math.Rand(-10, 10))
		p:SetCollide(true)
		p:SetVelocity(VectorRand():GetNormal() * math.random(25, 75) * self.size)
		p:SetColor(0, 180, 255)
	end
	for i = 1, 400 do
		local vec = VectorRand():GetNormal()
		vec.z = 0
		local pos = (self.Start + vec * 50)
		local p = self.Emitter:Add("sprites/orangeflare1", self.Start + vec * 10)
		p:SetDieTime(math.Rand(0.9, 1.1))
		p:SetStartAlpha(255)
		p:SetEndAlpha(35)
		p:SetStartSize(18)
		p:SetEndSize(12)
		p:SetVelocity(((pos - self.Start):GetNormal() * math.random(250, 285)) + Vector(0, 0, math.random(-80, 80)) * self.size)
		p:SetGravity( Vector( 0, 0, 0 ) );
		p:SetColor(0, 180, 255)
		p:SetCollide(false)
	end

	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end