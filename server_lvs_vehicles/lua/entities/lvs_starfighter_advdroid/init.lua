AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 100

function ENT:OnSpawn( PObj )
	PObj:SetMass( 1000 )

	self:AddDriverSeat( Vector(10,0,55), Angle(0,-90,0) ).HidePlayer = true

	self:AddEngine( Vector(-70,0,50) )
	self:AddEngineSound( Vector(-28,0,40) )

	self.PrimarySND = self:AddSoundEmitter( Vector(60,0,8), "lvs/vehicles/vulturedroid/fire.mp3", "lvs/vehicles/vulturedroid/fire_interior.mp3" )
	self.PrimarySND:SetSoundLevel( 110 )
end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/start.wav" )
	else
		self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/stop.wav" )
	end
end