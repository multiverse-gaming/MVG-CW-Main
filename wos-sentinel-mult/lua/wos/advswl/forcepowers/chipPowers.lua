wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
		name = "Sound",
		icon = "S",
		description = "Conjure a distracting sound where you look",
		image = "wos/forceicons/icefuse/teleport.png", -- !!! 
		cooldown = 15,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 30 ) then return end

			-- Fold Space code, for location.
			local bFoundEdge = false;
			local hullTrace = util.TraceHull({
				start = self.Owner:EyePos(),
				endpos = self.Owner:EyePos() + self.Owner:EyeAngles():Forward() * 1500,
				filter = self.Owner,
				mins = Vector(-16, -16, 0),
				maxs = Vector(16, 16, 9)
			});

			local groundTrace = util.TraceEntity({
				start = hullTrace.HitPos + Vector(0, 0, 1),
				endpos = hullTrace.HitPos - (self.Owner:EyePos() - self.Owner:GetPos()),
				filter = self.Owner
			}, self.Owner);

			local edgeTrace;
			if (hullTrace.Hit and hullTrace.HitNormal.z <= 0) then
				local ledgeForward = Angle(0, hullTrace.HitNormal:Angle().y, 0):Forward();
				edgeTrace = util.TraceEntity({
					start = hullTrace.HitPos - ledgeForward * 33 + Vector(0, 0, 40),
					endpos = hullTrace.HitPos - ledgeForward * 33,
					filter = self.Owner
				}, self.Owner);
					if (edgeTrace.Hit and !edgeTrace.AllSolid) then
					local clearTrace = util.TraceHull({
						start = hullTrace.HitPos,
						endpos = hullTrace.HitPos + Vector(0, 0, 35),
						mins = Vector(-16, -16, 0),
						maxs = Vector(16, 16, 1),
						filter = self.Owner
					});
					bFoundEdge = !clearTrace.Hit;
				end;
			end;
			local endPos = ( bFoundEdge and edgeTrace.HitPos ) or groundTrace.HitPos;

			-- Instead of moving the player there, play a sound over there. 
			sound.Play("ambient/energy/zap" .. math.random(1, 2) .. ".wav", endPos)
			sound.Play("lightsaber/saber_on1.wav", endPos)

			self:SetForce( self:GetForce() - 30 )
			return true
		end,
})

wOS.ForcePowers:RegisterNewPower({
    name = "Distract",
    icon = "D",
    image = "wos/forceicons/charge.png", -- !!!
    cooldown = 15,
    target = 1,
    manualaim = true,
    description = "Confuse a target with a dangerous sound",
    action = function( self )
		if self:GetForce() < 30 then return end
		local ent = self:SelectTargets( 1 )[ 1 ]
        if !IsValid( ent ) or !ent:IsNPC() then return end
		self:SetForce( self:GetForce() - 30 )
		
		ent:EmitSound("ambient/energy/zap" .. math.random(1, 2) .. ".wav");
		ent:EmitSound("lightsaber/saber_on1.wav");
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
    name = "Jump",
    icon = "J",
    image = "wos/forceicons/charge.png", -- !!!
    cooldown = 20,
    description = "Naturally jump higher for a while",
    action = function( self )
		if self:GetForce() < 40 then return end
		self:SetForce( self:GetForce() - 40 )

		local jedi = self:GetOwner()
		jedi:SetJumpPower(jedi:GetJumpPower() + 150)
		timer.Simple(10, function ()
			jedi:SetJumpPower(jedi:GetJumpPower() - 150)
		end)
		
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
    name = "Lift",
    icon = "L",
    image = "wos/forceicons/charge.png", -- !!!
    target = 1,
    manualaim = true,
    cooldown = 40,
    description = "Lift someone into the air",
    action = function( self )
		if self:GetForce() < 50 then return end
		local ent = self:SelectTargets( 1 )[ 1 ]
        if !IsValid( ent ) or !ent:IsNPC() then return end

		self:SetForce( self:GetForce() - 50 )
		ent:SetVelocity( Vector( 0, 0, 512 ) )

        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
    name = "Direct Dash",
    icon = "DH",
    image = "wos/forceicons/charge.png", -- !!!
    cooldown = 30,
    description = "Dash straight ahead",
    action = function( self )
		if self:GetForce() < 50 then return end
		self:SetForce( self:GetForce() - 50 )
		
		-- Leap Code here. 
		self:GetOwner():SetVelocity( self:GetOwner():GetAimVector() * 256 + Vector( 0, 0, 256 ) )
		
        return true
    end
})