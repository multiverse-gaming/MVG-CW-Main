function ENT:OnCollision( data, physobj, wheel, pos, ply)
	return false
end

function ENT:OnSkyCollide( data, physobj )
	return true
end

function ENT:PhysicsCollide( data, physobj, ply, wheel, pos )
	local HitEnt = data.HitEntity

	if not IsValid( data.HitEntity ) and util.GetSurfacePropName( data.TheirSurfaceProps ) == "default_silent" then
		if self:OnSkyCollide( data, physobj ) then return end
	end

	if self:IsDestroyed() then
		self.MarkForDestruction = true
	end

	if self:OnCollision( data, physobj, wheel) then return end

	self:PhysicsStartScrape( self:WorldToLocal( data.HitPos ), data.HitNormal )

	if IsValid( HitEnt ) then
		if HitEnt:IsPlayer() or HitEnt:IsNPC() then
			return
		end
	end

	if self:GetAI() and not self:IsPlayerHolding() then
		if self:WaterLevel() >= self.WaterLevelDestroyAI then
			self:SetDestroyed( true )
			self.MarkForDestruction = true

			return
		end

		self:TakeCollisionDamage( data.OurOldVelocity:Length() - data.OurNewVelocity:Length(), HitEnt )

		return
	end

	if self:WaterLevel() >= self.WaterLevelAutoStop then
		if self:GetAI() then
			self:SetAI( false )
		end

		self:StopEngine()
	end

	if data.Speed > 60 and data.DeltaTime > 0.2 then
		local VelDif = data.OurOldVelocity:Length() - data.OurNewVelocity:Length()

		local effectdata = EffectData()
		effectdata:SetOrigin( data.HitPos )
		util.Effect( "lvs_physics_impact", effectdata, true, true )

		if VelDif > 700 then
			self:EmitSound( "LVS.Physics.Crash", 75, 95 + math.min(VelDif / 1000,1) * 10, math.min(VelDif / 800,1) )

			if not self:IsPlayerHolding() then
				self:TakeCollisionDamage( VelDif, HitEnt )
			end
		else
			self:EmitSound( "LVS.Physics.Impact", 75, 100, math.min(0.1 + VelDif / 700,1) )
		end
	end
end
