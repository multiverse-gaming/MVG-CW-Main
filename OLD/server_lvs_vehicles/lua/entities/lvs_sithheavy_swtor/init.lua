AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 100

function ENT:OnSpawn( PObj )
	PObj:SetMass( 1000 )
	
	local DriverSeat = self:AddDriverSeat( Vector(150,0,200), Angle(0,-90,0) )
	DriverSeat:SetCameraDistance( 4 )
	DriverSeat.HidePlayer = true

	local Pod = self:AddPassengerSeat( Vector(125,0,200), Angle(0,-90,0) )
 	Pod.HidePlayer = true 

	local Pod = self:AddPassengerSeat( Vector(100,0,200), Angle(0,-90,0) )
 	Pod.HidePlayer = true 
	 
    local Pod = self:AddPassengerSeat( Vector(75,0,200), Angle(0,-90,0) )
 	Pod.HidePlayer = true 

	local Pod = self:AddPassengerSeat( Vector(50,0,200), Angle(0,-90,0) )
 	Pod.HidePlayer = true 

	 local Pod = self:AddPassengerSeat( Vector(125,25,200), Angle(0,-90,0) )
 	Pod.HidePlayer = true 

	local Pod = self:AddPassengerSeat( Vector(100,25,200), Angle(0,-90,0) )
 	Pod.HidePlayer = true 
	 
    local Pod = self:AddPassengerSeat( Vector(75,25,200), Angle(0,-90,0) )
 	Pod.HidePlayer = true 

	local Pod = self:AddPassengerSeat( Vector(50,25,200), Angle(0,-90,0) )
 	Pod.HidePlayer = true 

	 local Pod = self:AddPassengerSeat( Vector(50,-25,200), Angle(0,-90,0) )
 	Pod.HidePlayer = true 

	 local Pod = self:AddPassengerSeat( Vector(125,-25,200), Angle(0,-90,0) )
 	Pod.HidePlayer = true 

	local Pod = self:AddPassengerSeat( Vector(100,-25,200), Angle(0,-90,0) )
 	Pod.HidePlayer = true 
	 
    local Pod = self:AddPassengerSeat( Vector(75,-25,200), Angle(0,-90,0) )
 	Pod.HidePlayer = true 

	local Pod = self:AddPassengerSeat( Vector(50,-25,200), Angle(0,-90,0) )
 	Pod.HidePlayer = true 


	self:AddEngine( Vector(-70,0,10) )
	self:AddEngineSound( Vector(-28,0,40) )

	self.PrimarySND = self:AddSoundEmitter( Vector(60,0,8), "ophra/ships/shootsound3.wav", "ophra/ships/shootsound3.wav" )
	self.PrimarySND:SetSoundLevel( 110 )

	self.SecondarySND = self:AddSoundEmitter( Vector(30,0,6.5), "ophra/ships/shootsound3.wav", "ophra/ships/shootsound3.wav" )
	self.SecondarySND:SetSoundLevel( 110 )
end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "ophra/ships/shutdown.wav" )
	else
		self:EmitSound( "ophra/ships/shutdown.wav" )
	end
end