
function ENT:StartWindSounds()
	if not LVS.ShowEffects then return end

	self:StopWindSounds()

	if LocalPlayer():lvsGetVehicle() ~= self then return end

	self._WindSFX = CreateSound( self, "LVS.Physics.Wind" )
	self._WindSFX:PlayEx(0,100)

	self._WaterSFX = CreateSound( self, "LVS.Physics.Water" )
	self._WaterSFX:PlayEx(0,100)
end

function ENT:StopWindSounds()
	if self._WindSFX then
		self._WindSFX:Stop()
		self._WindSFX = nil
	end

	if self._WaterSFX then
		self._WaterSFX:Stop()
		self._WaterSFX = nil
	end
end

ENT.DustEffectSurfaces = {
	["sand"] = true,
	["dirt"] = true,
	["grass"] = true,
}

ENT.GroundEffectsMultiplier = 1

function ENT:DoVehicleFX()
	if self.GroundEffectsMultiplier <= 0 or not LVS.ShowEffects then self:StopWindSounds() return end

	local Vel = self:GetVelocity():Length() * self.GroundEffectsMultiplier

	if self._WindSFX then self._WindSFX:ChangeVolume( math.Clamp( (Vel - 1200) / 2800,0,1 ), 0.25 ) end

	if Vel < 1500 then
		if self._WaterSFX then self._WaterSFX:ChangeVolume( 0, 0.25 ) end

		return
	end

	if (self.nextFX or 0) < CurTime() then
		self.nextFX = CurTime() + 0.05

		local LCenter = self:OBBCenter()
		LCenter.z = self:OBBMins().z

		local CenterPos = self:LocalToWorld( LCenter )

		local trace = util.TraceLine( {
			start = CenterPos + Vector(0,0,25),
			endpos = CenterPos - Vector(0,0,450),
			filter = self:GetCrosshairFilterEnts(),
		} )

		local traceWater = util.TraceLine( {
			start = CenterPos + Vector(0,0,25),
			endpos = CenterPos - Vector(0,0,450),
			filter = self:GetCrosshairFilterEnts(),
			mask = MASK_WATER,
		} )

		if self._WaterSFX then self._WaterSFX:ChangePitch( math.Clamp((Vel / 1000) * 50,80,150), 0.5 ) end

		if traceWater.Hit and trace.HitPos.z < traceWater.HitPos.z then 
			local effectdata = EffectData()
				effectdata:SetOrigin( traceWater.HitPos )
				effectdata:SetEntity( self )
			util.Effect( "lvs_physics_water", effectdata )

			if self._WaterSFX then self._WaterSFX:ChangeVolume( 1 - math.Clamp(traceWater.Fraction,0,1), 0.5 ) end
		else
			if self._WaterSFX then self._WaterSFX:ChangeVolume( 0, 0.25 ) end
		end

		if trace.Hit and self.DustEffectSurfaces[ util.GetSurfacePropName( trace.SurfaceProps ) ] then
			local effectdata = EffectData()
				effectdata:SetOrigin( trace.HitPos )
				effectdata:SetEntity( self )
			util.Effect( "lvs_physics_dust", effectdata )
		end
	end
end

function ENT:GetParticleEmitter( Pos )
	local T = CurTime()

	if IsValid( self.Emitter ) and (self.EmitterTime or 0) > T then
		return self.Emitter
	end

	self:StopEmitter()

	self.Emitter = ParticleEmitter( Pos, false )
	self.EmitterTime = T + 2

	return self.Emitter
end

function ENT:StopEmitter()
	if IsValid( self.Emitter ) then
		self.Emitter:Finish()
	end
end