AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 25

function ENT:OnSpawn( PObj )
	PObj:SetMass( 5000 )

	local DriverSeat = self:AddDriverSeat( Vector(122.7,0.22,62.72), Angle(0,-89.52,0) )
	DriverSeat:SetCameraDistance( 0.4 )
	DriverSeat.HidePlayer = true

	self:AddEngine( Vector(100,145,30) )
	self:AddEngine( Vector(100,-145,30) )
	self:AddEngineSound( Vector(100,0,0) )

	self.PrimarySND = self:AddSoundEmitter( Vector(118.24,0,49.96), "lvs/vehicles/arc170/fire.mp3", "lvs/vehicles/arc170/fire.mp3" )
	self.PrimarySND:SetSoundLevel( 110 )
end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/start.wav" )
	else
		self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/stop.wav" )
	end
end