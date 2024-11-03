AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_ikfunctions.lua" )
AddCSLuaFile( "cl_camera.lua" )
AddCSLuaFile( "cl_legs.lua" )
AddCSLuaFile( "cl_prediction.lua" )
AddCSLuaFile( "sh_turret.lua" )
AddCSLuaFile( "sh_gunner.lua")
include("shared.lua")
include("sv_ragdoll.lua")
include("sv_controls.lua")
include("sv_contraption.lua")
include("sv_ai.lua")
include("sh_turret.lua")
include("sh_gunner.lua")

ENT.SpawnNormalOffset = 0
ENT.SpawnNormalOffsetSpawner = 0

function ENT:OnSpawn( PObj )
	PObj:SetMass( 5000 )

	self:SetDoorMode(0)
	self.DoorRotate = 0

	local DriverSeat = self:AddDriverSeat( Vector(358,0,138), Angle(0,-90,0) )
	DriverSeat:SetCameraDistance( 0.05 )
	DriverSeat.PlaceBehindVelocity = 1000

	self.SNDPrimary = self:AddSoundEmitter( Vector(280,0,108), "lvs/vehicles/atte/fire.mp3", "lvs/vehicles/atte/fire.mp3" )
	self.SNDPrimary:SetSoundLevel( 110 )

	self.SNDSecondaryPrimary = self:AddSoundEmitter( Vector(-295,0,140), "lvs/vehicles/atte/fire.mp3", "lvs/vehicles/atte/fire.mp3" )
	self.SNDSecondaryPrimary:SetSoundLevel( 110 )

	-- local TurretSeat = self:AddPassengerSeat( Vector(150,0,150), Angle(0,-90,0) )
	-- TurretSeat.HidePlayer = true
	-- TurretSeat.PlaceBehindVelocity = 1000
	-- self:SetTurretSeat( TurretSeat )

	-- local ID = self:LookupAttachment( "driver_turret" )
	-- local Attachment = self:GetAttachment( ID )

	-- if Attachment then
	-- 	local Pos,Ang = LocalToWorld( Vector(0,-5,8), Angle(180,0,-90), Attachment.Pos, Attachment.Ang )

	-- 	TurretSeat:SetParent( NULL )
	-- 	TurretSeat:SetPos( Pos )
	-- 	TurretSeat:SetAngles( Ang )
	-- 	TurretSeat:SetParent( self )
	-- end

	-- self:BecomeRagdoll()

	local BackRamp = ents.Create("prop_physics");
	BackRamp:SetModel("models/hunter/plates/plate075x105.mdl")
	BackRamp:SetPos(self:GetPos() + self:GetAngles():Up()*90 + self:GetAngles():Forward() * -270 + self:GetAngles():Right() * -7 )
	BackRamp:SetAngles(self:GetAngles() + Angle(0,90,135))
	-- BackRamp:SetMoveType( MOVETYPE_NONE ) 
	BackRamp:SetParent(self)
	-- BackRamp:SetNoDraw(true)
	BackRamp:SetRenderMode(RENDERMODE_NONE)-- Nie użyje SetNoDraw ponieważ wciąż musimy networkować kolizje modelu do klientów. W przeciwnym razie widok gracza chodzącego po rampie zapada się pod ziemie
	BackRamp:Spawn();
	BackRamp:Activate()

	self:SetBackRamp(BackRamp)

	self:DeleteOnRemove( BackRamp )
	self:TransferCPPI( BackRamp )

	local rPObj = BackRamp:GetPhysicsObject()

	if IsValid( rPObj ) then 
		rPObj:Sleep()
	else
		self:Remove()

		print("LVS: missing model. Vehicle terminated.")

		return
	end

	rPObj:SetMass( 5000 ) 

	self.BackRamp = BackRamp

	local GunnerSeat = self:AddPassengerSeat( Vector(250,0,150), Angle(0,90,0) )
	GunnerSeat.HidePlayer = true
	self:SetGunnerSeat( GunnerSeat )

	for i=0, 11 do

		local offset = i

		if (i >= 10) then
			offset = offset + 0.2
		elseif (i >= 8) then
			offset = offset + 0.1
		end

		local Seat = self:AddPassengerSeat( Vector(-152 + offset * 26,-18,165  + i * 0.5), Angle(0,180,0) )
		Seat:SetCameraDistance( 0.05 )
		Seat.PlaceBehindVelocity = 1000
		Seat.ExitPos = Vector(-152 + offset * 26,-18,165  + i)

		local Seat = self:AddPassengerSeat( Vector(-152 + offset * 26,18,165  + i * 0.5), Angle(0,0,0) )
		Seat:SetCameraDistance( 0.05 )
		Seat.PlaceBehindVelocity = 1000
		Seat.ExitPos = Vector(-152 + offset * 26,18,165  + i)

	end

	for i =0,4 do
		local Seat = self:AddPassengerSeat( Vector(-115 + i * 25,-60.5,165), Angle(0,0,0) )
		Seat:SetCameraDistance( 0.05 )
		Seat.PlaceBehindVelocity = 1000
		Seat.ExitPos = Vector(-115 + i * 25,-60.5,200)

		local Seat = self:AddPassengerSeat( Vector(-115 + i * 25,60.5,165), Angle(0,180,0) )
		Seat:SetCameraDistance( 1 )
		Seat.PlaceBehindVelocity = 1000
		Seat.ExitPos = Vector(-115 + i * 25,60.5,200)

	end


	for i =0,6 do
		local Seat = self:AddPassengerSeat( Vector(15 + i * 27,-60.5,165 + i * 2), Angle(0,0,0) )
		Seat:SetCameraDistance( 0.05 )
		Seat.PlaceBehindVelocity = 1000
		Seat.ExitPos = Vector(15 + i * 27,-60.5,165 + i * 10)

		local Seat = self:AddPassengerSeat( Vector(15 + i * 27,60.5,165 + i * 2), Angle(0,180,0) )
		Seat:SetCameraDistance( 0.05 )
		Seat.PlaceBehindVelocity = 1000
		Seat.ExitPos = Vector(15 + i * 27,60.5,165 + i * 10)

	end

	-- armor protecting the weakspot
	self:AddDSArmor( {
		pos = Vector(350,0,150),
		ang = Angle(0,0,0),
		mins = Vector(-30,-30,-40),
		maxs =  Vector(80,30,60),
		Callback = function( tbl, ent, dmginfo )
			-- dont do anything, just prevent it from hitting the critical spot
		end
	} )

	self:AddDSArmor( {
		pos = Vector(200,70,150),
		ang = Angle(0,0,0),
		mins = Vector(-480,-10,-20),
		maxs =  Vector(80,30,60),
		Callback = function( tbl, ent, dmginfo )
			-- dont do anything, just prevent it from hitting the critical spot
		end
	} )

	self:AddDSArmor( {
		pos = Vector(200,-90,150),
		ang = Angle(0,0,0),
		mins = Vector(-480,-10,-20),
		maxs =  Vector(80,30,60),
		Callback = function( tbl, ent, dmginfo )
			-- dont do anything, just prevent it from hitting the critical spot
		end
	} )

	-- self:AddDSArmor( {
	-- 	pos = Vector(-100,0,150),
	-- 	ang = Angle(0,0,0),
	-- 	mins = Vector(-80,-70,-80),
	-- 	maxs =  Vector(50,70,60),
	-- 	Callback = function( tbl, ent, dmginfo )
	-- 		-- dont do anything, just prevent it from hitting the critical spot
	-- 	end
	-- } )

	-- weak spots
	self:AddDS( {
		pos = Vector(290,0,150),
		ang = Angle(0,0,0),
		mins = Vector(-25,-25,-50),
		maxs =  Vector(25,25,50),
		Callback = function( tbl, ent, dmginfo )
			if dmginfo:GetDamage() <= 0 then return end

			dmginfo:ScaleDamage( 2 )

			if ent:GetHP() > 4000 or ent:GetIsRagdoll() then return end

			ent:BecomeRagdoll()

			local effectdata = EffectData()
				effectdata:SetOrigin( ent:LocalToWorld( Vector(0,0,80) ) )
			util.Effect( "lvs_explosion_nodebris", effectdata )
		end
	} )

	self:AddDS( {
		pos = Vector(200,0,120),
		ang = Angle(0,0,0),
		mins = Vector(-400,-50,-50),
		maxs =  Vector(25,50,50),
		Callback = function( tbl, ent, dmginfo )
			if dmginfo:GetDamage() <= 0 then return end

			dmginfo:ScaleDamage( 2 )

			if ent:GetHP() > 4000 or ent:GetIsRagdoll() then return end

			ent:BecomeRagdoll()

			local effectdata = EffectData()
				effectdata:SetOrigin( ent:LocalToWorld( Vector(0,0,80) ) )
			util.Effect( "lvs_explosion_nodebris", effectdata )
		end
	} )

	--[[self:AddDS( {
		pos = Vector(215,0,150),
		ang = Angle(0,0,0),
		mins = Vector(-25,-25,-50),
		maxs =  Vector(25,25,50),
		Callback = function( tbl, ent, dmginfo )
			if dmginfo:GetDamage() <= 0 then return end

			dmginfo:ScaleDamage( 1.5 )

			if ent:GetHP() > 4000 or ent:GetIsRagdoll() then return end

			ent:BecomeRagdoll()

			local effectdata = EffectData()
				effectdata:SetOrigin( ent:LocalToWorld( Vector(0,0,80) ) )
			util.Effect( "lvs_explosion_nodebris", effectdata )
		end
	} )--]] 
end

function ENT:InitRear()
	if IsValid( self:GetRearEntity() ) then return end

	local ent = ents.Create( "lvs_walker_atte_rear" )

	if not IsValid( ent ) then
		self:Remove()

		print("LVS: couldn't create 'lvs_atte_rear'. Vehicle terminated.")

		return
	end

	self:SetRearEntity( ent )

	ent:SetPos( self:GetPos() )
	ent:SetAngles( self:GetAngles() )
	ent:SetBase( self )
	ent:Spawn()
	ent:Activate()
	ent:DeleteOnRemove( self )
	ent:SetNoDraw(true)
	ent:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	self:DeleteOnRemove( ent )
	self:TransferCPPI( ent )

	local rPObj = ent:GetPhysicsObject()

	if not IsValid( rPObj ) then 
		self:Remove()

		print("LVS: missing model. Vehicle terminated.")

		return
	end

	rPObj:SetMass( 5000 ) 

	local Friction = 0
	local ballsocket = constraint.AdvBallsocket(ent, self,0,0,Vector(35,0,128),Vector(35,0,128),0,0, -20, -20, -20, 20, 20, 20, Friction, Friction, Friction, 0, 1)
	ballsocket:DeleteOnRemove( self )
	ballsocket:DeleteOnRemove( ent )
	self:TransferCPPI( ballsocket )

	self:AddToMotionController( rPObj )

	self.SNDRear = self:AddSoundEmitter( Vector(0,0,0), "lvs/vehicles/atte/fire.mp3", "lvs/vehicles/atte/fire.mp3" )
	self.SNDRear:SetSoundLevel( 110 )

	self.SNDRear:SetParent( NULL )
	self.SNDRear:SetPos( ent:LocalToWorld( Vector(-245,0,165) ) )
	self.SNDRear:SetParent( ent )

	-- clear the filters, because they might have been build by now
	self.CrosshairFilterEnts = nil
	self._EntityLookUp = nil
end

function ENT:OnTick()
	self:InitRear() -- this fixes a gmod bug
	self:ContraptionThink()

	local DoorMode = self:GetDoorMode()
	local TargetValue = (DoorMode == 1 and 1) or -1

	-- if (TargetValue == 1) and (self:GetManipulateBoneAngles(1) == Angle(0,0,120)) then 
	-- 	return
	-- elseif (TargetValue == -1) and (self:GetManipulateBoneAngles(1) == Angle(0,0,0)) then 
	-- 	return
	-- end

	self.DoorRotate = math.Clamp(self.DoorRotate + TargetValue * FrameTime(), 0, 1)

	self:ManipulateBoneAngles( 5, Angle(0,0,self.DoorRotate * 120))

	-- if (TargetValue == 1) and (self.DoorRotate < 1)
		
	-- elseif
	-- 	self:ManipulateBoneAngles( 1, Angle(0,0,self.DoorRotate * 120))
	-- end


end

function ENT:OnDoorsChanged()
	local DoorMode = self:GetDoorMode()

	if (DoorMode == 1) then
		self.BackRamp:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	else
		self.BackRamp:SetCollisionGroup(COLLISION_GROUP_NONE)
	end
	
end

function ENT:OnMaintenance()
	self:UnRagdoll()
end

function ENT:AlignView( ply, SetZero )
	if not IsValid( ply ) then return end

	timer.Simple( 0, function()
		if not IsValid( ply ) or not IsValid( self ) then return end

		ply:SetEyeAngles( Angle(0,90,0) )
	end)
end
