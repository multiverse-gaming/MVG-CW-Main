AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

function ENT:SpawnFunction( ply, tr, ClassName )
	if not tr.Hit then return end

	local ent = ents.Create( ClassName )
	ent.dOwnerEntLFS = ply
	ent:SetPos( tr.HitPos + tr.HitNormal )
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:RunOnSpawn()
	
	self:GetChildren()[1]:SetVehicleClass("phx_seat3")
	self:SetAutomaticFrameAdvance(true)

	self:SetSequence(self:LookupSequence( "turnoff" ))
	self:SetPlaybackRate(1)
	
	self.c = false
	self.j = CurTime()
	self:GetDriverSeat():Fire("setparentattachmentmaintainoffset", "driver", 0)
	self.jum = false
end


function ENT:OnTick()
	local Pod = self:GetDriverSeat()
	if not IsValid( Pod ) then return end
	
	local Driver = Pod:GetDriver()
	
	local FT = FrameTime()
	
	local MassCenterL = Vector(-13.919, 0, 93.0126)	
	local MassCenter = self:LocalToWorld( MassCenterL )
	self:SetMassCenter( MassCenter )
	
	local Forward = self:GetForward()
	local Right = self:GetRight()
	local Up = self:GetUp()
	
	self:DoTrace()
	
	local Trace = self.GroundTrace
	if self.WaterTrace.Fraction <= Trace.Fraction and !self.IgnoreWater and self:GetEngineActive() then
		Trace = self.WaterTrace
	end
	
	local EyeAngles = Angle(0,0,0)
	local KeyForward = false
	local KeyBack = false
	local KeyLeft = false
	local KeyRight = false
	
	local Sprint = true
	
	if IsValid( Driver ) then
		if self:GetForwardVelocity() < 10 then
			Driver.LFS_KEYDOWN["-THROTTLE"] = false
		end
		EyeAngles = Driver:EyeAngles()
		KeyForward = Driver:lfsGetInput( "+THROTTLE" ) or self.IsTurnMove
		KeyBack = Driver:lfsGetInput( "-THROTTLE" )
		if self.CanMoveSideways then
			KeyLeft = Driver:lfsGetInput( "+ROLL" )
			KeyRight = Driver:lfsGetInput( "-ROLL" )
		end
		
		if KeyBack then
			KeyForward = false
		end
		
		if KeyLeft then
			KeyRight = false
		end
		
		Sprint = Driver:lfsGetInput( "VSPEC" ) or Driver:lfsGetInput( "+PITCH" ) or Driver:lfsGetInput( "-PITCH" )
		
		self:MainGunPoser( Pod:WorldToLocalAngles( EyeAngles ) )
	end
	local MoveSpeed = Sprint and self.BoostSpeed or self.MoveSpeed
	
	local IsOnGround
	
	if IsValid( Driver ) then
		if self.jum and self.j > CurTime() then
			IsOnGround = false
		elseif Driver:KeyDown( IN_JUMP ) and self.j < CurTime() and self.onG then
			self.jum = false
			self.j = CurTime() + 0.5
			IsOnGround = false
			self:GetPhysicsObject():ApplyForceCenter( self:GetUp() * 666666)
		else
			IsOnGround = Trace.Hit and math.deg( math.acos( math.Clamp( Trace.HitNormal:Dot( Vector(0,0,1) ) ,-1,1) ) ) < 70
			self.jum = false
		end
	else
		IsOnGround = Trace.Hit and math.deg( math.acos( math.Clamp( Trace.HitNormal:Dot( Vector(0,0,1) ) ,-1,1) ) ) < 70
		self.jum = false
	end

	local PObj = self:GetPhysicsObject()
	PObj:EnableGravity( not IsOnGround )
	self.onG = IsOnGround
	
	if (IsOnGround) then
		local pos = Vector( self:GetPos().x, self:GetPos().y, Trace.HitPos.z)
		local speedVector = Vector(0,0,0)
		
		if IsValid( Driver ) && !Driver:lfsGetInput( "FREELOOK" ) && self:GetEngineActive() then
			local lookAt = Vector(0,-1,0)
			lookAt:Rotate(Angle(0,Pod:WorldToLocalAngles( EyeAngles ).y,0))
			self.StoredForwardVector = lookAt
		else
			local lookAt = Vector(0,-1,0)
			lookAt:Rotate(Angle(0,self:GetAngles().y,0))
			self.StoredForwardVector = lookAt
		end
		
		local ang = self:LookRotation( self.StoredForwardVector, Trace.HitNormal ) - Angle(0,0,90)
		if self:GetEngineActive() then
			speedVector = Forward * ((KeyForward and MoveSpeed or 0) - (KeyBack and MoveSpeed or 0)) + Right * ((KeyLeft and MoveSpeed or 0) - (KeyRight and MoveSpeed or 0))
		end
		
		self.deltaV = LerpVector( self.LerpMultiplier * FT, self.deltaV, speedVector )
		self:SetDeltaV( self.deltaV )
		pos = pos + self.deltaV
		self:SetIsMoving(pos != self:GetPos())
		
		self.ShadowParams.pos = pos
		self.ShadowParams.angle = ang
		PObj:ComputeShadowControl( self.ShadowParams )
	end
	
	local GunnerPod = self:GetGunnerSeat()
	if IsValid( GunnerPod ) then
		local Gunner = GunnerPod:GetDriver()
		if Gunner ~= self:GetGunner() then
			self:SetTurretDriver( Gunner )
		end
	end
	
	local TurretPod = self:GetTurretSeat()
	if IsValid( TurretPod ) then
		local TurretDriver = TurretPod:GetDriver()
		if TurretDriver ~= self:GetTurretDriver() then
			self:SetTurretDriver( TurretDriver )
		end
	end
	self:Gunner( self:GetGunner(), GunnerPod )
	self:Turret( self:GetTurretDriver(), TurretPod )
	
	if self.LastSkin ~= self:GetSkin() then
		self.LastSkin = self:GetSkin()
	end
	
	if self.LastColor ~= self:GetColor() then
		self.LastColor = self:GetColor()
	end
	
	if not self:GetEngineActive() then
		if self.h then
			self:EmitSound( "sentinel/sitdown.wav" )
			self:SetSequence(self:LookupSequence( "turnoff" ))
			self:SetPlaybackRate(1)
			self:ResetSequenceInfo()
			self.h = false
		end
		return
	end
	self.h = true
	
	if self:GetForwardVelocity() <= 5 then
		self:SetSequence(self:LookupSequence( "idle" ))
		self:SetPlaybackRate(0)
	end
	if self:GetForwardVelocity() <= 500  and self:GetForwardVelocity() > 5 then
		self:ResetSequence(self:LookupSequence( "walking" ))
		self:SetPlaybackRate(self:GetForwardVelocity()/75)
	end
	
	if self:GetForwardVelocity() > 500 then
		self:ResetSequence(self:LookupSequence("walking"))
		self:SetPlaybackRate(self:GetForwardVelocity()/75)
	end
	
	if not IsValid( Driver ) then return end
	
	if Driver:KeyDown( IN_SPEED ) and self:GetForwardVelocity() > 10 then
		self.MoveSpeed = 96
	else
		self.MoveSpeed = 96
	end
	self.BoostSpeed = self.MoveSpeed	

	
	local pi = Driver:GetVehicle():WorldToLocalAngles( Driver:EyeAngles() )
	local aimy = math.AngleDifference(pi.y, self:EyeAngles().y)
	aimy = math.Clamp( -aimy,-25,25)
	
	local yaw = Driver:GetVehicle():WorldToLocalAngles( Driver:EyeAngles() )
	local aimx = math.AngleDifference(yaw.x, self:EyeAngles().x)
	aimx = math.Clamp( aimx,-60,60)

	self:ManipulateBoneAngles(self:LookupBone("tete_2"), Angle(0,0,aimy))
	self:ManipulateBoneAngles(self:LookupBone("Cannon"), Angle(0,aimx,0))

	if not util.QuickTrace( self:GetPos(), Vector(0,0,-100), nil ).Hit then
	end
end

function ENT:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	local Driver = self:GetDriver()
	if not IsValid( Driver ) then return end
	if not self:GetEngineActive() then return end
	if not self.onG then return end
	
	local canon = self:GetAttachment(self:LookupAttachment("turret"))
	
	if not canon then return end
	
	self:EmitSound( "sentinel/fire.wav" )
	
	self:SetNextPrimary( 0.35 )
	
	local bullet = {}
	bullet.Num 	= 2
	bullet.Src 	= canon.Pos
	bullet.Dir 	= (canon.Ang - Angle(-2.15, -0.37, 0)):Forward()
	bullet.Spread 	= Vector( 0.01,  0.01, 0.01 )
	bullet.Tracer	= 1
	bullet.TracerName	= "lfs_laser_blue"
	bullet.Force	= 100
	bullet.HullSize 	= 50
	bullet.Damage	= 45
	bullet.Attacker 	= self:GetDriver()
	bullet.AmmoType = "SMG"
	bullet.Callback = function(att, tr, dmginfo)
	dmginfo:SetDamageType(DMG_AIRBOAT)
	end
	self:FireBullets( bullet )
	self:TakePrimaryAmmo()
end

function ENT:SecondaryAttack()
	if not self:CanSecondaryAttack() then return end
	
	self:SetNextSecondary( 0.001 )

	local Driver = self:GetDriver()
	if not IsValid( Driver ) then return end
	if not self:GetEngineActive() then return end
	if not self.onG then return end
	
	local canon = self:GetAttachment(self:LookupAttachment("turret"))
	
	if not canon then return end
	
	self:EmitSound( "sentinel/fire.wav" )
	
	self:SetNextPrimary( 0.2 )
	
	local bullet = {}
	bullet.Num 	= 5
	bullet.Src 	= canon.Pos
	bullet.Dir 	= (canon.Ang - Angle(-2.15, -0.37, 0)):Forward()
	bullet.Spread 	= Vector( 0.05,  0.05, 0.05 )
	bullet.Tracer	= 2
	bullet.TracerName	= "lfs_laser_green"
	bullet.Force	= 100
	bullet.HullSize 	= 50
	bullet.Damage	= 30
	bullet.Attacker 	= self:GetDriver()
	bullet.AmmoType = "SHOTGUN"
	bullet.Callback = function(att, tr, dmginfo)
	dmginfo:SetDamageType(DMG_DISSOLVE)
	end
	self:FireBullets( bullet )
	self:TakeSecondaryAmmo()
end

function ENT:OnLandingGearToggled( bOn )
	if not self:GetEngineActive() then return end
end

function ENT:OnEngineStarted()
	self:EmitSound( "sentinel/standup.wav" )
	self:SetSequence(self:LookupSequence( "turnon" ))
	self:SetPlaybackRate(1)
	self:ResetSequenceInfo()
end

function ENT:OnEngineStopped()
	self:EmitSound( "sentinel/sitdown.wav" )
	self:SetSequence(self:LookupSequence( "turnoff" ))
	self:SetPlaybackRate(1)
	self:ResetSequenceInfo()
end

function ENT:OnRemove()
end