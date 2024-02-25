AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_boneposeparemeter.lua" )
include("shared.lua")
include("sv_components.lua")
include("sv_physics.lua")
include("cl_boneposeparemeter.lua")

ENT.SpawnNormalOffset = 75


function ENT:OnDriverChanged( Old, New, VehicleIsActive )
	if VehicleIsActive then
		if not self:GetEngineActive() and self:IsEngineStartAllowed() then
			self:SetEngineActive( false )
		end

		return
	end

	self:SetEngineActive( false )
	self:SetMove( 0, 0 )
end

function ENT:OnSpawn( PObj )
	PObj:SetMass( 5000 )

	local DriverSeat = self:AddDriverSeat( Vector(4,54.5,2), Angle(0,-90,15) )
	DriverSeat.HidePlayer = false

	local GunnerSeat = self:AddPassengerSeat( Vector(4,-54.5,2), Angle(0,-90,15) )
	GunnerSeat.HidePlayer = false
	self:SetGunnerSeat( GunnerSeat )
	
	self.PrimarySND = self:AddSoundEmitter( Vector(153.97,44.04,6.9), "lvs/isp/laser.mp3", "lvs/isp/laser.mp3" )
	self.PrimarySND:SetSoundLevel( 110 )

	self.SecondarySND = self:AddSoundEmitter( Vector(153.97,-44.04,6.9), "lvs/isp/laser.mp3", "lvs/isp/laser.mp3" )
	self.SecondarySND:SetSoundLevel( 110 )

	local WheelMass = 25
	local WheelRadius = 14
	local WheelPos = {
		Vector(-75,0,-42.75),
		Vector(32.5,140,-42.75),
		Vector(32.5,-140,-42.75),
		Vector(140,40,-42.75),
		Vector(140,-40,-42.75),
		Vector(161.5,0,-28.5),
		Vector(169.01,-42.17,-2.64),
		Vector(169.01,42.17,-2.64),
		Vector(113.66,-87.43,-12.27),
		Vector(113.66,87.43,-12.27),
		Vector(-49.43,103.82,-9.23),
		Vector(-49.43,-103.82,-9.23),
		Vector(91.82,-109.36,-42.75),
		Vector(91.82,109.36,-42.75)
	}

	for _, Pos in pairs( WheelPos ) do
		self:AddWheel( Pos, WheelRadius, WheelMass, 10 )
	end

	self:AddEngineSound( Vector(0,0,30) )

	-- weak spots
	self:AddDS( {
		pos = Vector(0,0,0),
		ang = Angle(0,0,0),
		mins = Vector(-18,27,60),
		maxs =  Vector(-68,-24.5,16),
		Callback = function( tbl, ent, dmginfo )
			if dmginfo:GetDamage() <= 0 then return end

			dmginfo:ScaleDamage( 2 )
		end
	} )


	self:SetSpotlightToggle(false)

	self:CreateBonePoseParameter("pleft",1, Angle(0,0,0), Angle(0,1,0), Vector(0,0,0), Vector(0,0,0))
	self:CreateBonePoseParameter("pright",3, Angle(0,0,0), Angle(0,1,0), Vector(0,0,0), Vector(0,0,0))
	self:CreateBonePoseParameter("rleft",2, Angle(0,0,0), Angle(0,0,1), Vector(0,0,0), Vector(0,0,0))
	self:CreateBonePoseParameter("rright",4, Angle(0,0,0), Angle(0,0,1), Vector(0,0,0), Vector(0,0,0))
end

function ENT:OnTick()
end

function ENT:OnCollision( data, physobj )
	if self:WorldToLocal( data.HitPos ).z < 0 then return true end -- dont detect collision  when the lower part of the model touches the ground

	return false
end

function ENT:OnIsCarried( name, old, new)
	if new == old then return end

	if new then
		self:SetBTLFire( false )

		self:SetDisabled( true )
	else
		self:SetDisabled( false )
	end
end

function ENT:OnVehicleSpecificToggled()
	if self:GetSpotlightToggle() == true then
		self:SetSpotlightToggle(false)
	else
		self:SetSpotlightToggle(true)
	end
end

function ENT:OnRemove()
	self:StopSound("siren/siren.wav")
end

function ENT:BallturretDamage( target, attacker, HitPos, HitDir )
	if not IsValid( target ) then return end

	if not IsValid( attacker ) then
		attacker = self
	end

	if target ~= self then
		local dmginfo = DamageInfo()
		dmginfo:SetDamage( 250 * FrameTime() )
		dmginfo:SetAttacker( attacker )
		dmginfo:SetDamageType( DMG_SHOCK + DMG_ENERGYBEAM + DMG_AIRBOAT )
		dmginfo:SetInflictor( self ) 
		dmginfo:SetDamagePosition( HitPos ) 
		dmginfo:SetDamageForce( HitDir * 10000 ) 
		target:TakeDamageInfo( dmginfo )
	end
end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "lvs/isp/engine_on.wav" )
	else
		self:EmitSound( "lvs/isp/engine_off.wav" )
	end
end