AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 25

function ENT:OnSpawn( PObj )
	PObj:SetMass( 120000 )

	local DriverSeat = self:AddDriverSeat( Vector(-499.45,0.54,1040.98), Angle(0,-91.12,0.15) )
	DriverSeat:SetCameraDistance( 2.5 )
	DriverSeat.HidePlayer = true
	DriverSeat.ExitPos = Vector(2079.81,29.22,24.09)	
	
	local Pod = self:AddPassengerSeat( Vector(313.4,3.07,664.48), Angle(-0.07,-90.56,0.45) )
	self:SetGunnerSeat( Pod )
	Pod.ExitPos = Vector(293.55,2.98,24.09)
	Pod.HidePlayer = true
	
	local Pod = self:AddPassengerSeat( Vector(-799.28,-531.3,694.38), Angle(0.01,-92.41,0.15) )
	self:SetSecondGunnerSeat( Pod )
	Pod.ExitPos = Vector(-799.28,-531.3,24.09)
	Pod.HidePlayer = true
	
	local Pod = self:AddPassengerSeat( Vector(-799.28,531.3,694.38), Angle(0.01,-92.41,0.15) )
	self:SetThirdGunnerSeat( Pod )
	Pod.ExitPos = Vector(-799.28,531.3,24.09)
	Pod.HidePlayer = true
	
	local Pod = self:AddPassengerSeat( Vector(-1124.7,-3.6,675.25), Angle(0,91.94,-0.16) )
	self:SetFourthGunnerSeat( Pod )
	Pod.ExitPos = Vector(-1279.6,-5.85,24.09)
	Pod.HidePlayer = true
	
	-- passenger seats
	
	local Pod = 	self:AddPassengerSeat( Vector(1790.83,392.41,437.01), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1790.83,392.41,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(1713.34,390.64,436.64), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1713.34,390.64,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(1640.54,393.17,436.13), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1640.54,393.17,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(1545.44,390.77,435.7), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1545.44,390.77,24.09)
	
	local Pod = 	self:AddPassengerSeat( Vector(1467.29,389.96,435.34), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1467.29,389.96,24.09)
	
	local Pod = 	self:AddPassengerSeat( Vector(1390.54,388.61,434.97), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1390.54,388.61,24.09)
	
	local Pod = 	self:AddPassengerSeat( Vector(1308.54,388.57,434.58), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1308.54,388.57,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(1308.54,388.57,434.58), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1308.54,388.57,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(1139.78,390.06,433.31), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1139.78,390.06,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(1067.53,388.98,432.96), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1067.53,388.98,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(989.68,386.33,432.59), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(989.68,386.33,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(909.41,386.29,432.2), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(909.41,386.29,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(848.31,385.48,431.89), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(848.31,385.48,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(770.05,384.43,431.52), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(770.05,384.43,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(704.58,383.04,431.19), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(704.58,383.04,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(624.58,382.52,430.8), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(624.58,382.52,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(553.85,383.82,430.47), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(553.85,383.82,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(454.61,386.01,429.93), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(454.61,386.01,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(406.73,385.29,429.67), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(406.73,385.29,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(344.99,386.62,429.35), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(344.99,386.62,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(276.72,386.48,429.02), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(276.72,386.48,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(203.98,387.21,428.66), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(203.98,387.21,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(129.09,387.95,428.3), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(129.09,387.95,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(75.09,386.2,428.02), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(75.09,386.2,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(0.6,387.92,427.66), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(0.6,387.92,24.09)	
	
	-- Right Side 
	local Pod = 	self:AddPassengerSeat( Vector(1790.83,-392.41,437.01), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1790.83,-392.41,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(1713.34,-390.64,436.64), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1713.34,-390.64,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(1640.54,-393.17,436.13), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1640.54,-393.17,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(1545.44,-390.77,435.7), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1545.44,-390.77,24.09)
	
	local Pod = 	self:AddPassengerSeat( Vector(1467.29,-389.96,435.34), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1467.29,-389.96,24.09)
	
	local Pod = 	self:AddPassengerSeat( Vector(1390.54,-388.61,434.97), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1390.54,-388.61,24.09)
	
	local Pod = 	self:AddPassengerSeat( Vector(1308.54,-388.57,434.58), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1308.54,-388.57,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(1308.54,-388.57,434.58), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1308.54,-388.57,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(1139.78,-390.06,433.31), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1139.78,-390.06,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(1067.53,-388.98,432.96), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(1067.53,-388.98,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(989.68,-386.33,432.59), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(989.68,-386.33,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(909.41,-386.29,432.2), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(909.41,-386.29,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(848.31,-385.48,431.89), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(848.31,-385.48,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(770.05,-384.43,431.52), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(770.05,-384.43,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(704.58,-383.04,431.19), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(704.58,-383.04,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(624.58,-382.52,430.8), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(624.58,-382.52,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(553.85,-383.82,430.47), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(553.85,-383.82,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(454.61,-386.01,429.93), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(454.61,-386.01,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(406.73,-385.29,429.67), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(406.73,-385.29,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(344.99,-386.62,429.35), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(344.99,-386.62,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(276.72,-386.48,429.02), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(276.72,-386.48,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(203.98,-387.21,428.66), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(203.98,-387.21,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(129.09,-387.95,428.3), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(129.09,-387.95,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(75.09,-386.2,428.02), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(75.09,-386.2,24.09)	
	
	local Pod = 	self:AddPassengerSeat( Vector(0.6,-387.92,427.66), Angle(0,-92.62,-0.03) )
	Pod.ExitPos = Vector(0.6,-387.92,24.09)	
	
	
	self:AddEngine( Vector(72.02,-474.09,425.78) )
	self:AddEngine( Vector(72.02,474.09,425.789) )
	self:AddEngine( Vector(-1293.9,-3.77,427.92) )
	self:AddEngine( Vector(745.22,4.41,646.5) )
	self:AddEngineSound( Vector(8.5,-0.6,590.15) )

	self.PrimarySND = self:AddSoundEmitter( Vector(887.61,-0.5,444.9), "lvs/vehicles/atte/fire_turret.mp3", "lvs/vehicles/atte/fire_turret.mp3" )
	self.PrimarySND:SetSoundLevel( 150 )
	
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