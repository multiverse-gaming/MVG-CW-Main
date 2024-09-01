AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

function ENT:OnSpawn(PObj)

	PObj:SetMass( 250000 )

	self.PrimarySND = self:AddSoundEmitter( Vector(0, 0, 115), "lvs/vehicles/atte/fire_turret.mp3", "lvs/vehicles/atte/fire_turret.mp3" )
	self.PrimarySND:SetSoundLevel( 120 )


	local Pod = self:AddPassengerSeat(Vector(0, 0, 115), Angle(0, -90, 0))
	Pod.HidePlayer = true
	self:SetGunnerSeat( Pod )


end

function ENT:OnTick()
end


