AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

function ENT:OnSpawn( PObj )
	PObj:SetMass( 5000 )

	local DriverSeat = self:AddDriverSeat( Vector(76.23,-1.23,131.18), Angle(0,-89.62,0) )
	DriverSeat:SetCameraDistance( 0.4 )
	DriverSeat.HidePlayer = true

	self:AddEngine( Vector(-150,0,60) )
	self:AddEngineSound( Vector(-100,0,70) )

	self.PrimarySND = self:AddSoundEmitter( Vector(145,0,22), "lvs/vehicles/arc170/fire_gunner.mp3", "lvs/vehicles/arc170/fire_gunner.mp3" )
	self.PrimarySND:SetSoundLevel( 110 )
end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/start.wav" )
	else
		self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/stop.wav" )
	end
end