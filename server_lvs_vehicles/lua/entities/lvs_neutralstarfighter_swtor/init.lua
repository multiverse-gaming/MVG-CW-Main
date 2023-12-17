AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 100

function ENT:OnSpawn( PObj )
	PObj:SetMass( 1000 )

 	
	local DriverSeat = self:AddDriverSeat( Vector(0,0,150), Angle(0,-90,0) )
	DriverSeat.HidePlayer = true
	DriverSeat:SetCameraDistance( 1.2 )
	DriverSeat.HidePlayer = true
	
  
	local Pod = self:AddPassengerSeat( Vector(-350,0,275), Angle(0,-90,0) )
 	Pod.HidePlayer = true 

	local Pod = self:AddPassengerSeat( Vector(-350,0,250), Angle(0,-90,0) )
 	Pod.HidePlayer = true 

	self:AddEngine( Vector(-95,65,7) )
	self:AddEngine( Vector(-95,-65,7) )
	self:AddEngineSound( Vector(0,0,10) )
	self:SetMaxThrottle( 1.2 )
end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "ophra/ships/shutdown.wav" )
	else
		self:EmitSound( "ophra/ships/shutdown.wav" )
	end
end
