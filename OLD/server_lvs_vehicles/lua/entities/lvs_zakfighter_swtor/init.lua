AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 100

function ENT:OnSpawn( PObj )
	PObj:SetMass( 1000 )

	local DriverSeat = self:AddDriverSeat( Vector(-200,0,68.71), Angle(0,-90,0) )
	DriverSeat.HidePlayer = true

 
	self:AddEngine( Vector(-95,65,7) )
	self:AddEngine( Vector(-95,-65,7) )
	self:AddEngineSound( Vector(0,0,10) )

	self.SNDLeft = self:AddSoundEmitter( Vector(207.65,303.52,-48.35), "ophra/ships/shootsound3.wav", "ophra/ships/shootsound3.wav" )
	self.SNDLeft:SetSoundLevel( 110 )

	self.SNDRight = self:AddSoundEmitter( Vector(207.65,-303.52,-48.35), "ophra/ships/shootsound3.wav", "ophra/ships/shootsound3.wav" )
	self.SNDRight:SetSoundLevel( 110 )

	self.SNDTail = self:AddSoundEmitter( Vector(-171.69,0,45), "ophra/ships/shootsound3.wav", "ophra/ships/shootsound3.wav" )
	self.SNDTail:SetSoundLevel( 110 )

	self:SetMaxThrottle( 1.2 )
end
function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "ophra/ships/shutdown.wav" )
	else
		self:EmitSound( "ophra/ships/shutdown.wav" )
	end
end
 

function ENT:OnTick()
		if self:GetThrottle() < 0.1 then
			self:DisableVehicleSpecific()
		end
	end

  