
function ENT:OnFrame()
	self:PredictPoseParamaters()
	self:DamageFX()

	local RearEnt = self:GetRearEntity()

	if not IsValid( RearEnt ) then return end

	if self:GetIsRagdoll() then 
		self:LegClearAll()
		RearEnt:LegClearAll()

		return
	end

	local Up = self:GetUp()
	local Forward = self:GetForward()
	local Vel = self:GetVelocity()
	
	local Stride = 20
	local Lift = 20
	
	local FT = math.min(FrameTime(),0.08) -- if fps lower than 12, clamp the frametime to avoid spazzing.

	local Rate = FT * 20

	if Vel:Length() < 10 then -- sync with server animation when not moving
		self.Move = self:GetMove()
	else
		self.Move = self.Move and self.Move + self:WorldToLocal( self:GetPos() + Vel ).x * FT * 1.8 or 0
	end
	
	local Cycl1 = self.Move
	local Cycl2 = self.Move + 180
	local Cycl3 = self.Move + 90
	local Cycl4 = self.Move + 270
	local Cycl5 = self.Move
	local Cycl6 = self.Move + 180
	local Cycl7 = self.Move + 270
	local Cycl8 = self.Move

	local IsMoving = self:GetIsMoving()
	
	if self:GetIsCarried() then
		self.TRACEPOS1 = self:LocalToWorld( Vector(200,100,80) )
		self.TRACEPOS2 = self:LocalToWorld( Vector(200,-70,80) )
		self.TRACEPOS3 = self:LocalToWorld( Vector(-160,-70,-480) )
		self.TRACEPOS4 = self:LocalToWorld( Vector(-160,70,-480) )
		self.TRACEPOS5 = self:LocalToWorld( Vector(0,-140,150) )
		self.TRACEPOS6 = self:LocalToWorld( Vector(0,140,150) )
		self.TRACEPOS7 = self:LocalToWorld( Vector(200,70,-580) )
		self.TRACEPOS8 = self:LocalToWorld( Vector(200,-70,-580) )
		Cycl1 = 0
		Cycl2 = 0
		Cycl3 = 0
		Cycl4 = 0
		Cycl5 = 0
		Cycl6 = 0
		Cycl7 = 0
		Cycl8 = 0
		IsMoving = true
	end

	-- local MoveRoll = math.cos( math.rad(self:GetMove()) ) * 2

	-- local STARTPOS = RearEnt:LocalToWorld( Vector( -65.13, -145, 165 ) )
	-- local X = 30 + math.cos( math.rad(Cycl3) ) * Stride
	-- local Z = math.max( math.sin( math.rad(-Cycl3) ), 0) * Lift
	-- self.TRACEPOS5 = self.TRACEPOS5 and self.TRACEPOS5 or STARTPOS
	-- if Z > 0 or not IsMoving then 
	-- 	self.TRACEPOS5 = self.TRACEPOS5 + (STARTPOS + Forward * X + Right * 90 - self.TRACEPOS5) * Rate
	-- 	self.FSOG5 = false
	-- else
	-- 	self.FSOG5 = true
	-- end
	-- local ENDPOS = util.TraceLine( { start = self.TRACEPOS5 - Up * 50, endpos = self.TRACEPOS5 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end, } ).HitPos + Up * (60+Z)
	-- if self.FSOG5 ~= self.oldFSOG5 then
	-- 	self.oldFSOG5 = self.FSOG5
	-- 	if self.FSOG5 then
	-- 		sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4)..".ogg" ), ENDPOS, SNDLVL_100dB )
	-- 		local effectdata = EffectData()
	-- 			effectdata:SetOrigin( ENDPOS - Vector(0,0,65) )
	-- 		util.Effect( "lvs_walker_stomp", effectdata )
	-- 	else
	-- 		sound.Play( Sound( "lvs/vehicles/atte/lift"..math.random(1,4)..".ogg" ), ENDPOS, SNDLVL_100dB )
	-- 	end
	-- end--]] 

	 -- FRONT LEFT
	local X = 30 + math.cos( math.rad(Cycl1) ) * Stride
	local Z = math.max( math.sin( math.rad(-Cycl1) ), 0) * Lift
	local STARTPOS = self:LocalToWorld( Vector(220,100,165.76) )
	self.TRACEPOS1 = self.TRACEPOS1 and self.TRACEPOS1 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS1 = self.TRACEPOS1 + (STARTPOS + Forward * X - self:GetRight() * 30 - self.TRACEPOS1) * Rate
		self.FSOG1 = false
	else
		self.FSOG1 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS1 - Up * 50, endpos = self.TRACEPOS1 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end,} ).HitPos + Up * (40+Z)
	if self.FSOG1 ~= self.oldFSOG1 then
		self.oldFSOG1 = self.FSOG1
		if self.FSOG1 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4).."_light.ogg" ), ENDPOS, SNDLVL_70dB)
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,45) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/hydraulic"..math.random(1,7)..".ogg" ), ENDPOS, SNDLVL_70dB)
		end
	end
	
	local ATTACHMENTS = {
		Leg2 = {MDL = "models/blu/atte_bigleg.mdl", Ang = Angle(-90,180,0), Pos = Vector(0,0,10)},
		Foot = {MDL = "models/blu/atte_bigfoot.mdl", Ang = Angle(0,0,0), Pos = Vector(16,-3,0)}
	}
	self:GetLegEnts( 1, 10, 110, self:LocalToWorldAngles( Angle(135,-100,0) ), STARTPOS, ENDPOS, ATTACHMENTS )
		-- RearEnt:GetLegEnts( 5, 60, 94, RearEnt:LocalToWorldAngles( Angle(135,100,0) ), STARTPOS, ENDPOS, ATTACHMENTS )
	
	
 	-- FRONT RIGHT
	
	local X = 30 + math.cos( math.rad(Cycl2) ) * Stride
	local Z = math.max( math.sin( math.rad(-Cycl2) ), 0) * Lift
	local STARTPOS = self:LocalToWorld( Vector(220,-100,165.76) )
	self.TRACEPOS2 = self.TRACEPOS2 and self.TRACEPOS2 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS2 = self.TRACEPOS2 + (STARTPOS + Forward * X - self:GetRight() * -30 - self.TRACEPOS2) * Rate
		self.FSOG2 = false
	else
		self.FSOG2 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS2 - Up * 50, endpos = self.TRACEPOS2 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end,} ).HitPos + Up * (40+Z)
	if self.FSOG2 ~= self.oldFSOG2 then
		self.oldFSOG2 = self.FSOG2
		if self.FSOG2 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4).."_light.ogg" ), ENDPOS, SNDLVL_70dB)
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,45) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/hydraulic"..math.random(1,7)..".ogg" ), ENDPOS, SNDLVL_70dB)
		end
	end
	
	local ATTACHMENTS = {
		Leg2 = {MDL = "models/blu/atte_bigleg.mdl", Ang = Angle(-90,180,0), Pos = Vector(0,0,10)},
		Foot = {MDL = "models/blu/atte_bigfoot.mdl", Ang = Angle(0,180,0), Pos = Vector(-16,3,0)}
	}
	self:GetLegEnts( 2, 10, 110, self:LocalToWorldAngles( Angle(135,100,0) ), STARTPOS, ENDPOS, ATTACHMENTS )


	-- FRONT 2 LEFT
	local X = 30 + math.cos( math.rad(Cycl3) ) * Stride
	local Z = math.max( math.sin( math.rad(-Cycl3) ), 0) * Lift
	local STARTPOS = self:LocalToWorld( Vector(80,100,165.76) )
	self.TRACEPOS3 = self.TRACEPOS3 and self.TRACEPOS3 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS3 = self.TRACEPOS3 + (STARTPOS + Forward * X - self:GetRight() * 30 - self.TRACEPOS3) * Rate
		self.FSOG3 = false
	else
		self.FSOG3 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS3 - Up * 50, endpos = self.TRACEPOS3 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end,} ).HitPos + Up * (40+Z)
	if self.FSOG3 ~= self.oldFSOG3 then
		self.oldFSOG3 = self.FSOG3
		if self.FSOG3 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4).."_light.ogg" ), ENDPOS, SNDLVL_70dB)
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,45) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/hydraulic"..math.random(1,7)..".ogg" ), ENDPOS, SNDLVL_70dB)
		end
	end
	
	local ATTACHMENTS = {
		Leg2 = {MDL = "models/blu/atte_bigleg.mdl", Ang = Angle(-90,180,0), Pos = Vector(0,0,10)},
		Foot = {MDL = "models/blu/atte_bigfoot.mdl", Ang = Angle(0,0,0), Pos = Vector(16,-3,0)}
	}
	self:GetLegEnts( 3, 10, 110, self:LocalToWorldAngles( Angle(135,-100,0) ), STARTPOS, ENDPOS, ATTACHMENTS )
	

	-- FRONT 2 RIGHT

	local X = 30 + math.cos( math.rad(Cycl4) ) * Stride
	local Z = math.max( math.sin( math.rad(-Cycl4) ), 0) * Lift
	local STARTPOS = self:LocalToWorld( Vector(80,-100,165.76) )
	self.TRACEPOS4 = self.TRACEPOS4 and self.TRACEPOS4 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS4 = self.TRACEPOS4 + (STARTPOS + Forward * X - self:GetRight() * -30 - self.TRACEPOS4) * Rate
		self.FSOG4 = false
	else
		self.FSOG4 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS4 - Up * 50, endpos = self.TRACEPOS4 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end,} ).HitPos + Up * (40+Z)
	if self.FSOG4 ~= self.oldFSOG4 then
		self.oldFSOG4 = self.FSOG4
		if self.FSOG4 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4).."_light.ogg" ), ENDPOS, SNDLVL_70dB)
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,45) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/hydraulic"..math.random(1,7)..".ogg" ), ENDPOS, SNDLVL_70dB)
		end
	end
	
	local ATTACHMENTS = {
		Leg2 = {MDL = "models/blu/atte_bigleg.mdl", Ang = Angle(-90,180,0), Pos = Vector(0,0,10)},
		Foot = {MDL = "models/blu/atte_bigfoot.mdl", Ang = Angle(0,180,0), Pos = Vector(-16,3,0)}
	}
	self:GetLegEnts( 4, 10, 110, self:LocalToWorldAngles( Angle(135,100,0) ), STARTPOS, ENDPOS, ATTACHMENTS )


	-- MID LEFT
	local X = 30 + math.cos( math.rad(Cycl5) ) * Stride
	local Z = math.max( math.sin( math.rad(-Cycl5) ), 0) * Lift
	local STARTPOS = self:LocalToWorld( Vector(-60,100,165.76) )
	self.TRACEPOS5 = self.TRACEPOS5 and self.TRACEPOS5 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS5 = self.TRACEPOS5 + (STARTPOS + Forward * X - self:GetRight() * 30 - self.TRACEPOS5) * Rate
		self.FSOG5 = false
	else
		self.FSOG5 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS5 - Up * 50, endpos = self.TRACEPOS5 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end,} ).HitPos + Up * (40+Z)
	if self.FSOG5 ~= self.oldFSOG5 then
		self.oldFSOG5 = self.FSOG5
		if self.FSOG5 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4).."_light.ogg" ), ENDPOS, SNDLVL_70dB)
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,45) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/hydraulic"..math.random(1,7)..".ogg" ), ENDPOS, SNDLVL_70dB)
		end
	end
	
	local ATTACHMENTS = {
		Leg2 = {MDL = "models/blu/atte_bigleg.mdl", Ang = Angle(-90,180,0), Pos = Vector(0,0,10)},
		Foot = {MDL = "models/blu/atte_bigfoot.mdl", Ang = Angle(0,0,0), Pos = Vector(16,-3,0)}
	}
	self:GetLegEnts( 5, 10, 110, self:LocalToWorldAngles( Angle(135,-100,0) ), STARTPOS, ENDPOS, ATTACHMENTS )


	-- MID RIGHT

	local X = 30 + math.cos( math.rad(Cycl6) ) * Stride
	local Z = math.max( math.sin( math.rad(-Cycl6) ), 0) * Lift
	local STARTPOS = self:LocalToWorld( Vector(-60,-100,165.76) )
	self.TRACEPOS6 = self.TRACEPOS6 and self.TRACEPOS6 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS6 = self.TRACEPOS6 + (STARTPOS + Forward * X - self:GetRight() * -30 - self.TRACEPOS6) * Rate
		self.FSOG6 = false
	else
		self.FSOG6 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS6 - Up * 50, endpos = self.TRACEPOS6 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end,} ).HitPos + Up * (40+Z)
	if self.FSOG6 ~= self.oldFSOG6 then
		self.oldFSOG6 = self.FSOG6
		if self.FSOG6 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4).."_light.ogg" ), ENDPOS, SNDLVL_70dB)
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,45) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/hydraulic"..math.random(1,7)..".ogg" ), ENDPOS, SNDLVL_70dB)
		end
	end
	
	local ATTACHMENTS = {
		Leg2 = {MDL = "models/blu/atte_bigleg.mdl", Ang = Angle(-90,180,0), Pos = Vector(0,0,10)},
		Foot = {MDL = "models/blu/atte_bigfoot.mdl", Ang = Angle(0,180,0), Pos = Vector(-16,3,0)}
	}
	self:GetLegEnts( 6, 10, 110, self:LocalToWorldAngles( Angle(135,100,0) ), STARTPOS, ENDPOS, ATTACHMENTS )


	-- Back LEFT
	local X = 30 + math.cos( math.rad(Cycl7) ) * Stride
	local Z = math.max( math.sin( math.rad(-Cycl7) ), 0) * Lift
	local STARTPOS = self:LocalToWorld( Vector(-200,100,165) )
	self.TRACEPOS7 = self.TRACEPOS7 and self.TRACEPOS7 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS7 = self.TRACEPOS7 + (STARTPOS + Forward * X - self:GetRight() * 30 - self.TRACEPOS7) * Rate
		self.FSOG7 = false
	else
		self.FSOG7 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS7 - Up * 50, endpos = self.TRACEPOS7 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or ent == self:GetBackRamp() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end,} ).HitPos + Up * (40+Z)
	if self.FSOG7 ~= self.oldFSOG7 then
		self.oldFSOG7 = self.FSOG7
		if self.FSOG7 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4).."_light.ogg" ), ENDPOS, SNDLVL_70dB)
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,45) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/hydraulic"..math.random(1,7)..".ogg" ), ENDPOS, SNDLVL_70dB)
		end
	end
	
	local ATTACHMENTS = {
		Leg2 = {MDL = "models/blu/atte_bigleg.mdl", Ang = Angle(-90,180,0), Pos = Vector(0,0,10)},
		Foot = {MDL = "models/blu/atte_bigfoot.mdl", Ang = Angle(0,0,0), Pos = Vector(16,-3,0)}
	}
	self:GetLegEnts( 7, 5, 110, self:LocalToWorldAngles( Angle(135,-100,0) ), STARTPOS, ENDPOS, ATTACHMENTS )

	-- Back Right

	local X = 30 + math.cos( math.rad(Cycl8) ) * Stride
	local Z = math.max( math.sin( math.rad(-Cycl8) ), 0) * Lift
	local STARTPOS = self:LocalToWorld( Vector(-200,-100,165) )
	self.TRACEPOS8 = self.TRACEPOS8 and self.TRACEPOS8 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS8 = self.TRACEPOS8 + (STARTPOS + Forward * X - self:GetRight() * -30 - self.TRACEPOS8) * Rate
		self.FSOG8 = false
	else
		self.FSOG8 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS8 - Up * 50, endpos = self.TRACEPOS8 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or ent == self:GetBackRamp() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end,} ).HitPos + Up * (40+Z)
	if self.FSOG8 ~= self.oldFSOG8 then
		self.oldFSOG8 = self.FSOG8
		if self.FSOG8 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4).."_light.ogg" ), ENDPOS, SNDLVL_70dB)
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,45) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/hydraulic"..math.random(1,7)..".ogg" ), ENDPOS, SNDLVL_70dB)
		end
	end
	
	local ATTACHMENTS = {
		Leg2 = {MDL = "models/blu/atte_bigleg.mdl", Ang = Angle(-90,180,0), Pos = Vector(0,0,10)},
		Foot = {MDL = "models/blu/atte_bigfoot.mdl", Ang = Angle(0,180,0), Pos = Vector(-16,3,0)}
	}
	self:GetLegEnts( 8, 5, 110, self:LocalToWorldAngles( Angle(135,100,0) ), STARTPOS, ENDPOS, ATTACHMENTS )

	--[[
	-- REAR RIGHT
	local STARTPOS = self:LocalToWorld( Vector(80,-100,155) )
	local X = -30 + math.cos( math.rad(Cycl5) ) * Stride
	local Z = math.max( math.sin( math.rad(-Cycl5) ), 0) * Lift
	self.TRACEPOS3 = self.TRACEPOS3 and self.TRACEPOS3 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS3 = self.TRACEPOS3 + (STARTPOS + Forward * X - self.TRACEPOS3) * Rate
		self.FSOG3 = false
	else
		self.FSOG3 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS3 - Up * 50, endpos = self.TRACEPOS3 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end, } ).HitPos + Up * (58+Z)
	if self.FSOG3 ~= self.oldFSOG3 then
		self.oldFSOG3 = self.FSOG3
		if self.FSOG3 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4).."_light.ogg" ), ENDPOS, SNDLVL_70dB)
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,45) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/hydraulic"..math.random(1,7)..".ogg" ), ENDPOS, SNDLVL_70dB)
		end
	end
	
	local ATTACHMENTS = {
		Leg2 = {MDL = "models/blu/atte_bigleg.mdl", Ang = Angle(-90,-220,0), Pos = Vector(0,0,0)},
		Foot = {MDL = "models/blu/atte_bigfoot.mdl", Ang = Angle(0,180,0), Pos = Vector(-15.5,5,-5)}
	}
	
	self:GetLegEnts( 3, 10, 95, self:LocalToWorldAngles( Angle(140,50,0) ), STARTPOS, ENDPOS, ATTACHMENTS )
	
	
	-- REAR LEFT
	local STARTPOS = self:LocalToWorld( Vector(80,100,155) )
	local X = -10 + math.cos( math.rad(Cycl6) ) * Stride
	local Z = math.max( math.sin( math.rad(-Cycl6) ), 0) * Lift
	self.TRACEPOS4 = self.TRACEPOS4 and self.TRACEPOS4 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS4 = self.TRACEPOS4 + (STARTPOS + Forward * X - self.TRACEPOS4) * Rate
		self.FSOG4 = false
	else
		self.FSOG4 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS4 - Up * 50, endpos = self.TRACEPOS4 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end, } ).HitPos + Up * (60+Z)
	if self.FSOG4 ~= self.oldFSOG4 then
		self.oldFSOG4 = self.FSOG4
		if self.FSOG4 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4).."_light.ogg" ), ENDPOS, SNDLVL_70dB)
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,45) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/hydraulic"..math.random(1,7)..".ogg" ), ENDPOS, SNDLVL_70dB)
		end
	end
	
	local ATTACHMENTS = {
		Leg2 = {MDL = "models/blu/atte_bigleg.mdl", Ang = Angle(-90,200,0), Pos = Vector(0,0,0)},
		Foot = {MDL = "models/blu/atte_bigfoot.mdl", Ang = Angle(0,0,0), Pos = Vector(17,-4,0)}
	}
	
	self:GetLegEnts( 4, 10, 95, self:LocalToWorldAngles( Angle(140,-80,0) ), STARTPOS, ENDPOS, ATTACHMENTS )


	local Right = self:GetRight()

	-- MID RIGHT
	local STARTPOS = self:LocalToWorld( Vector( -80.13, -100, 145 ) )
	local X = -20 + math.cos( math.rad(Cycl3) ) * Stride
	local Z = math.max( math.sin( math.rad(-Cycl3) ), 0) * Lift
	self.TRACEPOS5 = self.TRACEPOS5 and self.TRACEPOS5 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS5 = self.TRACEPOS5 + (STARTPOS + Forward * X - self.TRACEPOS5) * Rate
		self.FSOG5 = false
	else
		self.FSOG5 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS5 - Up * 50, endpos = self.TRACEPOS5 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end, } ).HitPos + Up * (60+Z)
	if self.FSOG5 ~= self.oldFSOG5 then
		self.oldFSOG5 = self.FSOG5
		if self.FSOG5 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4)..".ogg" ), ENDPOS, SNDLVL_100dB )
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,65) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/lift"..math.random(1,4)..".ogg" ), ENDPOS, SNDLVL_100dB )
		end
	end
	
	local ATTACHMENTS = {
		Leg2 = {MDL = "models/blu/atte_bigleg.mdl", Ang = Angle(-90,160,0), Pos = Vector(0,0,0)},
		Foot = {MDL = "models/blu/atte_bigfoot.mdl", Ang = Angle(0,180,0), Pos = Vector(-16,3,0)}
	}
	
	self:GetLegEnts( 5, 10, 95, self:LocalToWorldAngles( Angle(140,80,0) ), STARTPOS, ENDPOS, ATTACHMENTS )
	
	
	
	-- -- MID LEFT
	local STARTPOS = self:LocalToWorld( Vector(-80.13,100,145) )
	local X = 10 + math.cos( math.rad(Cycl4) ) * Stride
	local Z = math.max( math.sin( math.rad(-Cycl4) ), 0) * Lift
	self.TRACEPOS6 = self.TRACEPOS6 and self.TRACEPOS6 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS6 = self.TRACEPOS6 + (STARTPOS + Forward * X - self.TRACEPOS6) * Rate
		self.FSOG6 = false
	else
		self.FSOG6 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS6 - Up * 50, endpos = self.TRACEPOS6 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end } ).HitPos + Up * (60+Z)
	if self.FSOG6 ~= self.oldFSOG6 then
		self.oldFSOG6 = self.FSOG6
		if self.FSOG6 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4)..".ogg" ), ENDPOS, SNDLVL_100dB )
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,65) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/lift"..math.random(1,4)..".ogg" ), ENDPOS, SNDLVL_100dB )
		end
	end
	
	local ATTACHMENTS = {
		Leg2 = {MDL = "models/blu/atte_bigleg.mdl", Ang = Angle(-90,180,0), Pos = Vector(0,0,0)},
		Foot = {MDL = "models/blu/atte_bigfoot.mdl", Ang = Angle(0,0,0), Pos = Vector(16,-3,0)}
	}
	
	self:GetLegEnts( 6, 10, 95, self:LocalToWorldAngles( Angle(135,-80,0) ), STARTPOS, ENDPOS, ATTACHMENTS )

	-- Back LEFT
	local X = 0 + math.cos( math.rad(Cycl5) ) * Stride
	local Z = math.max( math.sin( math.rad(-Cycl5) ), 0) * Lift
	local STARTPOS = self:LocalToWorld( Vector(-220,100,145) )
	self.TRACEPOS7 = self.TRACEPOS7 and self.TRACEPOS7 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS7 = self.TRACEPOS7 + (STARTPOS + Forward * X - self.TRACEPOS7) * Rate
		self.FSOG7 = false
	else
		self.FSOG7 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS7 - Up * 50, endpos = self.TRACEPOS7 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end,} ).HitPos + Up * (60+Z)
	if self.FSOG7 ~= self.oldFSOG7 then
		self.oldFSOG7 = self.FSOG7
		if self.FSOG7 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4).."_light.ogg" ), ENDPOS, SNDLVL_70dB)
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,45) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/hydraulic"..math.random(1,7)..".ogg" ), ENDPOS, SNDLVL_70dB)
		end
	end
	
	local ATTACHMENTS = {
		Leg2 = {MDL = "models/blu/atte_bigleg.mdl", Ang = Angle(-90,-160,0), Pos = Vector(0,0,0)},
		Foot = {MDL = "models/blu/atte_bigfoot.mdl", Ang = Angle(0,0,0), Pos = Vector(19.5,-3,-4)}
	}
	self:GetLegEnts( 7, 10, 95, self:LocalToWorldAngles( Angle(135,-50,0) ), STARTPOS, ENDPOS, ATTACHMENTS )

	-- Back RIGHT
	local X = 0 + math.cos( math.rad(Cycl6) ) * Stride
	local Z = math.max( math.sin( math.rad(-Cycl6) ), 0) * Lift
	local STARTPOS = self:LocalToWorld( Vector(-220,-100,145) )
	self.TRACEPOS8 = self.TRACEPOS8 and self.TRACEPOS8 or STARTPOS
	if Z > 0 or not IsMoving then 
		self.TRACEPOS8 = self.TRACEPOS8 + (STARTPOS + Forward * X - self.TRACEPOS8) * Rate
		self.FSOG8 = false
	else
		self.FSOG8 = true
	end
	local ENDPOS = util.TraceLine( { start = self.TRACEPOS8 - Up * 50, endpos = self.TRACEPOS8 - Up * 160, filter = function( ent ) if ent == self or ent == self:GetRearEntity() or self.HoverCollisionFilter[ ent:GetCollisionGroup() ] then return false end return true end,} ).HitPos + Up * (60+Z)
	if self.FSOG8 ~= self.oldFSOG8 then
		self.oldFSOG8 = self.FSOG8
		if self.FSOG8 then
			sound.Play( Sound( "lvs/vehicles/atte/stomp"..math.random(1,4).."_light.ogg" ), ENDPOS, SNDLVL_70dB)
			local effectdata = EffectData()
				effectdata:SetOrigin( ENDPOS - Vector(0,0,45) )
			util.Effect( "lvs_walker_stomp", effectdata )
		else
			sound.Play( Sound( "lvs/vehicles/atte/hydraulic"..math.random(1,7)..".ogg" ), ENDPOS, SNDLVL_70dB)
		end
	end
	
	local ATTACHMENTS = {
		Leg2 = {MDL = "models/blu/atte_bigleg.mdl", Ang = Angle(-90,150,0), Pos = Vector(0,0,0)},
		Foot = {MDL = "models/blu/atte_bigfoot.mdl", Ang = Angle(0,180,0), Pos = Vector(-17,3,0)}
	}
	self:GetLegEnts( 8, 10, 95, self:LocalToWorldAngles( Angle(135,80,0) ), STARTPOS, ENDPOS, ATTACHMENTS )
	 
--]] 
end