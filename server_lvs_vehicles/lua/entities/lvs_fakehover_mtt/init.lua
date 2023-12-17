AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_prediction.lua" )
//AddCSLuaFile( "sh_turret.lua" )
include("shared.lua")
//include( "sh_turret.lua" )

ENT.SpawnNormalOffset = 25

function ENT:OnSpawn( PObj )
	self.gearTime = CurTime()


	//self:SetSkin(1) --DANDY CODE

	PObj:SetMass( 2500 )

	local DriverSeat = self:AddDriverSeat( Vector(20,0,400), Angle(0,-90,0) )
	DriverSeat.HidePlayer = true
	DriverSeat:SetCameraDistance( 1)

	for i = 1, 8 do
		local RackPod1 = self:AddPassengerSeat( Vector(0,0,100), Angle(0,-90,0) )
		local RackPod2 = self:AddPassengerSeat( Vector(0,0,100), Angle(0,-90,0) )

		local ID = self:LookupAttachment( "seat_00" .. i )
		local Seat = self:GetAttachment( ID )

		if Seat then
			local Pos,Ang = LocalToWorld( Vector(10,-10,0), Angle(90,0,-90), Seat.Pos, Seat.Ang )
			if i >= 5 then
				Pos,Ang = LocalToWorld( Vector(-10,-10,0), Angle(-90,0,-90), Seat.Pos, Seat.Ang )
			end

			RackPod1:SetParent( NULL )
			RackPod1:SetPos( Pos + Vector(-15,0,0) )
			RackPod1:SetAngles( Ang )
			RackPod1:SetParent( self, ID )

			RackPod2:SetParent( NULL )
			RackPod2:SetPos( Pos + Vector(15,0,0) )
			RackPod2:SetAngles( Ang )
			RackPod2:SetParent( self, ID )
		end
	end

	local WheelMass = 25
	local WheelRadius = 15
	local WheelPos = {
		Vector(0,-50,1),
		Vector(0,50,1),

		Vector(100,-50,1),
		Vector(100,50,1),

		Vector(200,-50,1),
		Vector(200,50,1),

		Vector(300,-50,2),
		Vector(300,50,2),

		Vector(400,-50,2),
		Vector(400,50,2),

		Vector(500,-50,3),
		Vector(500,50,3),

		Vector(600,-50,4),
		Vector(600,50,4),

		Vector(700,-50,5),
		Vector(700,50,5)
	}

	--[[	Vector(0,-30,3),
		Vector(95,-70,4),
		Vector(45,-90,5),
		Vector(120,-40,0),
		Vector(0,30,3),
		Vector(95,70,4),
		Vector(45,90,5),
		Vector(120,40,0), --]]

	for _, Pos in pairs( WheelPos ) do
		self:AddWheel( Pos, WheelRadius, WheelMass, 10 )
	end

	self:AddEngineSound( Vector(11,0,35) )

	local ID = self:LookupAttachment( "muzzle_left_top" )
	local Muzzle = self:GetAttachment( ID )
	self.SNDLeft = self:AddSoundEmitter( self:WorldToLocal( Muzzle.Pos ), "heracles421/galactica_vehicles/mtt_sideguns_fire.mp3", "heracles421/galactica_vehicles/mtt_sideguns_fire.mp3" )
	self.SNDLeft:SetSoundLevel( 110 )
	self.SNDLeft:SetParent( self, ID )

	local ID = self:LookupAttachment( "muzzle_right_top" )
	local Muzzle = self:GetAttachment( ID )
	self.SNDRight = self:AddSoundEmitter( self:WorldToLocal( Muzzle.Pos ), "heracles421/galactica_vehicles/mtt_sideguns_fire.mp3", "heracles421/galactica_vehicles/mtt_sideguns_fire.mp3" )
	self.SNDRight:SetSoundLevel( 110 )
	self.SNDRight:SetParent( self, ID )

	--[[local ID = self:LookupAttachment( "muzzle" )
	local Muzzle = self:GetAttachment( ID )
	self.SNDTurret = self:AddSoundEmitter( self:WorldToLocal( Muzzle.Pos ), "lvs/vehicles/aat/fire_turret.mp3", "lvs/vehicles/aat/fire_turret.mp3" )
	self.SNDTurret:SetSoundLevel( 110 )
	self.SNDTurret:SetParent( self, ID ) --]]

	--Armor spots protecting the weakspots
	self:AddDSArmor( {
		pos = Vector(60,0,45),
		ang = Angle(0,0,0),
		mins = Vector(-30,-28,-30),
		maxs =  Vector(30,28,30),
		Callback = function( tbl, ent, dmginfo )
		end
	} )

	self:AddDSArmor( {
		pos = Vector(-30,0,75),
		ang = Angle(0,0,0),
		mins = Vector(-60,-28,-15),
		maxs =  Vector(60,28,15),
		Callback = function( tbl, ent, dmginfo )
		end
	} )

	self:AddDSArmor( {
		pos = Vector(11,0,45),
		ang = Angle(-55,0,0),
		mins = Vector(-15,-28,-30),
		maxs =  Vector(15,28,40),
		Callback = function( tbl, ent, dmginfo )
		end
	} )

	self:AddDSArmor( {
		pos = Vector(80,0,25),
		ang = Angle(0,0,0),
		mins = Vector(-50,-100,-15),
		maxs =  Vector(50,100,15),
		Callback = function( tbl, ent, dmginfo )
		end
	} )

	-- weak spots
	self:AddDS( {
		pos = Vector(11,40,46),
		ang = Angle(-55,0,0),
		mins = Vector(-12,-12,-12),
		maxs =  Vector(12,12,12),
		Callback = function( tbl, ent, dmginfo )
			if dmginfo:GetDamage() <= 0 then return end

			dmginfo:ScaleDamage( 1.5 )
		end
	} )

	self:AddDS( {
		pos = Vector(11,-40,46),
		ang = Angle(-55,0,0),
		mins = Vector(-12,-12,-12),
		maxs =  Vector(12,12,12),
		Callback = function( tbl, ent, dmginfo )
			if dmginfo:GetDamage() <= 0 then return end

			dmginfo:ScaleDamage( 1.5 )
		end
	} )
end

function ENT:OnTick()
end

function ENT:OnCollision( data, physobj )
	if self:WorldToLocal( data.HitPos ).z < 15 then return true end -- dont detect collision  when the lower part of the model touches the ground

	return false
end

function ENT:OnIsCarried( name, old, new)
	if new == old then return end

	if new then
		self:SetDisabled( true )
	else
		self:SetDisabled( false )
	end
end

function ENT:OnVehicleSpecificToggled( bOn )

	local playbackTime = 1
	self.gearTime = CurTime() + 10 / playbackTime

	if bOn then
		self:PlayAnimation( "deploy_transport", playbackTime )
		self:EmitSound( "vehicles/tank_readyfire1.wav" )
	else
		self:PlayAnimation( "retract_transport", playbackTime )
		self:EmitSound( "vehicles/tank_readyfire1.wav" )
	end

end
