wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
		name = "Spook",
		icon = "S",
		description = "Conjure a distracting sound where you look",
		image = "wos/forceicons/icefuse/teleport.png",
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

util.AddNetworkString( "wiltOS-JumpscarePlayer" )
wOS.ForcePowers:RegisterNewPower({
		name = "Jumpscare",
		icon = "J",
		image = "wos/forceicons/icefuse/blind.png",
		cooldown = 60,
		target = 1,
		distance = 1200,
		manualaim = true,
		description = "Scare someone with a horrifying visage",
		action = function( self )
			if ( self:GetForce() < 25 ) then return end
			local target = self:SelectTargets( 1 )[ 1 ]
			if not IsValid( target ) or not target:IsPlayer() or not target:Alive() then return end
	
			-- Send a network message to the specific player
			net.Start("wiltOS-JumpscarePlayer")
			net.Send(target)
	
			self:SetForce( self:GetForce() - 25 )
			return true
		end
})