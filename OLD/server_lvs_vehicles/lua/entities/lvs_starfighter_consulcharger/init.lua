AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 25

function ENT:OnSpawn( PObj )
	PObj:SetMass( 120000 )

	local DriverSeat = self:AddDriverSeat( Vector(1408.04,-12.75,442.04), Angle(0,-91.6,-0.02) )
	DriverSeat:SetCameraDistance( 2.5 )
	DriverSeat.HidePlayer = true
	DriverSeat.ExitPos = Vector(1529.22,-14.5,22.03)	
	
	local Pod = self:AddPassengerSeat( Vector(426.46,166.42,324.39), Angle(0.17,-1.35,-0.01) )
	self:SetGunnerSeat( Pod )
	Pod.HidePlayer = true
	
	local Pod = self:AddPassengerSeat( Vector(422.8,-168.12,326.89), Angle(0.03,178.66,0.01) )
	self:SetSecondGunnerSeat( Pod )
	Pod.HidePlayer = true
	
	local Pod = self:AddPassengerSeat( Vector(-478.35,8.61,447.39), Angle(0,89.96,0.17) )
	self:SetThirdGunnerSeat( Pod )
	Pod.HidePlayer = true
	
	local Pod = self:AddPassengerSeat( Vector(823.72,188.7,198.25), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(835.71,205.89,24.09)
	
	local Pod = 	self:AddPassengerSeat( Vector(779.11,192.5,198.18), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(779.11,192.5,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(744.08,192.66,198.02), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(744.08,192.66,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(709.61,192.46,197.94), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(709.61,192.46,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(672.92,192.25,197.87), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(672.92,192.25,24.09)
	
	local Pod = 	self:AddPassengerSeat( Vector(648.95,193.2,197.79), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(648.95,193.2,24.09)
	
	local Pod = 	self:AddPassengerSeat( Vector(618.97,194.38,197.72), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(618.97,194.38,24.09)
	
	local Pod = 	self:AddPassengerSeat( Vector(600.97,195.38,197.72), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(600.97,195.38,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(562.03,196.22,197.57), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(562.03,196.22,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(524.55,196.61,197.5), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(524.55,196.61,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(477.71,197.09,197.43), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(477.71,197.09,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(420.78,196.35,197.37), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(420.78,196.35,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(373.94,195.74,197.3), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(373.94,195.74,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(809.43,-162.85,188.83), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(809.43,-162.85,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(762.37,-162.68,188.76), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(762.37,-162.68,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(714.12,-163.13,188.7), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(714.12,-163.13,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(671.87,-163.53,188.63), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(671.87,-163.53,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(632.34,-163.9,188.56), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(632.34,-163.9,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(583.06,-164.36,188.49), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(583.06,-164.36,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(537.43,-164.71,188.43), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(537.43,-164.71,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(537.43,-164.71,188.43), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(537.43,-164.71,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(471.61,-165.71,188.28), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(471.61,-165.71,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(441.84,-166.47,188.2), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(441.84,-166.47,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(410.44,-164.37,188.13), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(410.44,-164.37,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(358.98,-181.73,193.81), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(358.98,-181.73,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(296.35,-161.57,199.88), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(296.35,-161.57,24.09)	
	

	
	
	self:AddEngine( Vector(37.56,-184.6,221.69) )
	self:AddEngine( Vector(37.56,184.6,221.69) )
	self:AddEngine( Vector(1489.63,-12.87,184.55) )
	self:AddEngine( Vector(-164.18,-82.71,419.49) )
	self:AddEngineSound( Vector(303.54,-1.22,325.18) )

	self.PrimarySND = self:AddSoundEmitter( Vector(887.61,-0.5,444.9), "lvs/vehicles/atte/fire_turret.mp3", "lvs/vehicles/atte/fire_turret.mp3" )
	self.PrimarySND:SetSoundLevel( 110 )
	
	self.SNDTail = self:AddSoundEmitter( Vector(200,0,150), "lvs/vehicles/atte/fire.mp3", "lvs/vehicles/atte/fire.mp3" )
	self.SNDTail:SetSoundLevel( 110 )
end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "lvs/vehicles/startup1.wav" )
	else
		self:EmitSound( "lvs/vehicles/frigates/shutoff1.wav" )
	end
end