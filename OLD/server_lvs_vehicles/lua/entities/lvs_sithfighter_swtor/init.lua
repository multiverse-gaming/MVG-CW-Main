AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 100

function ENT:OnSpawn( PObj )
	PObj:SetMass( 1000 )

	local DriverSeat = self:AddDriverSeat( Vector(100,0,125), Angle(0,-90,0) )
	DriverSeat:SetCameraDistance( 2 )
	DriverSeat.HidePlayer = true
 
	local Pod = self:AddPassengerSeat( Vector(75,0,125), Angle(0,-90,0) )
 	Pod.HidePlayer = true 

	local Pod = self:AddPassengerSeat( Vector(50,0,125), Angle(0,-90,0) )
 	Pod.HidePlayer = true 


	self:AddEngine( Vector(-95,65,7) )
	self:AddEngine( Vector(-95,-65,7) )
	self:AddEngineSound( Vector(0,0,10) )


	self.PrimarySND = self:AddSoundEmitter( Vector(60,0,8), "ophra/ships/shootsound3.wav", "ophra/ships/shootsound3.wav" )
	self.PrimarySND:SetSoundLevel( 110 )

	self.SecondarySND = self:AddSoundEmitter( Vector(30,0,6.5), "ophra/ships/shootsound3.wav", "ophra/ships/shootsound3.wav" )
	self.SecondarySND:SetSoundLevel( 110 )

	self:SetMaxThrottle( 1.2 )
end
function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "ophra/ships/shutdown.wav" )
	else
		self:EmitSound( "ophra/ships/shutdown.wav" )
	end
end

 
function ENT:OnTick()		if self:GetThrottle() < 0.1 then
			self:DisableVehicleSpecific()
		end
	end


  