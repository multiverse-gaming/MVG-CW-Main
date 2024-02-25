AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 100

function ENT:OnSpawn( PObj )
	PObj:SetMass( 1000 )
	
	local DriverSeat = self:AddDriverSeat( Vector(0,0,420), Angle(0,-90,0) )
	DriverSeat:SetCameraDistance( 4 )
	DriverSeat.HidePlayer = true
	local Pod = self:AddPassengerSeat( Vector(-25,25,420), Angle(0,-90,0) )
	Pod.HidePlayer = true 

   local Pod = self:AddPassengerSeat( Vector(-50,25,420), Angle(0,-90,0) )
	Pod.HidePlayer = true 
	
   local Pod = self:AddPassengerSeat( Vector(-75,25,420), Angle(0,-90,0) )
	Pod.HidePlayer = true 

   local Pod = self:AddPassengerSeat( Vector(-100,25,420), Angle(0,-90,0) )
	Pod.HidePlayer = true 

	local Pod = self:AddPassengerSeat( Vector(-25,0,420), Angle(0,-90,0) )
	Pod.HidePlayer = true 

   local Pod = self:AddPassengerSeat( Vector(-50,0,420), Angle(0,-90,0) )
	Pod.HidePlayer = true 
	
   local Pod = self:AddPassengerSeat( Vector(-75,0,420), Angle(0,-90,0) )
	Pod.HidePlayer = true 

   local Pod = self:AddPassengerSeat( Vector(-100,-25,420), Angle(0,-90,0) )
   Pod.HidePlayer = true 

   local Pod = self:AddPassengerSeat( Vector(-25,-25,420), Angle(0,-90,0) )
	Pod.HidePlayer = true 

   local Pod = self:AddPassengerSeat( Vector(-50,-25,420), Angle(0,-90,0) )
	Pod.HidePlayer = true 
	
   local Pod = self:AddPassengerSeat( Vector(-75,-25,420), Angle(0,-90,0) )
	Pod.HidePlayer = true 

   local Pod = self:AddPassengerSeat( Vector(-100,-25,420), Angle(0,-90,0) )

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
		self:SetFoils( false )
	end
end