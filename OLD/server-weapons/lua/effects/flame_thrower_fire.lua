--Main function
function EFFECT:Init(data)

	--Muzzle and desired position vectors
	local StartPos = self:GetTracerShootPos(self.Position, data:GetEntity(), data:GetAttachment())
	local HitPos = data:GetOrigin()

	--Check if the weapon is still there
	if data:GetEntity():IsValid() && StartPos && HitPos then
		--Create particle emmiter
		local FlameEmitter = ParticleEmitter(StartPos)

			--Amount of particles to create
			for i= 0, 8 do

				--Safeguard
				if !FlameEmitter then return end

				--Pool of flame sprites
				local FlameMat = {}
				FlameMat[1] = "effects/muzzleflash1"
				FlameMat[2] = "effects/muzzleflash2"
				FlameMat[3] = "effects/muzzleflash3"
				FlameMat[4] = "effects/muzzleflash4"

				local FlameParticle = FlameEmitter:Add( FlameMat[math.random(1,4)], StartPos )

				if (FlameParticle) then
					FlameParticle:SetCollide(true)

					FlameParticle:SetVelocity( ((HitPos - StartPos):GetNormal() * math.random(1720,1820)) + (VectorRand() * math.random(142,172)) )

					FlameParticle:SetLifeTime(0)
					FlameParticle:SetDieTime(0.52)

					FlameParticle:SetStartAlpha(math.random(92,132))
					FlameParticle:SetEndAlpha(0)

					FlameParticle:SetStartSize(math.random(10,20))
					FlameParticle:SetEndSize(math.random(32,52))

					FlameParticle:SetRoll(math.Rand(-360, 360))
					FlameParticle:SetRollDelta(math.Rand(-7.2, 7.2))

					FlameParticle:SetAirResistance(math.random(128, 256))


					FlameParticle:SetGravity( Vector(0, 0, 64) )

				end
			end

		--We're done with this emmiter
		FlameEmitter:Finish()
	end
end
        



function EFFECT:Render()
end

