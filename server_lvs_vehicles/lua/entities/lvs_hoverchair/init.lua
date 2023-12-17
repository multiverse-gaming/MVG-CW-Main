AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include("shared.lua")
include("sv_components.lua")

ENT.SpawnNormalOffset = 50

function ENT:OnSpawn( PObj )
	PObj:SetMass( 5000 )

	local DriverSeat = self:AddDriverSeat( Vector(-0.20,-0.60,1), Angle(0,-90,0) )

	DriverSeat.HidePlayer = false
	
	self.sndBTL = self:AddSoundEmitter( Vector(0,0,0), "lvs/vehicles/laat/ballturret_loop.wav", "lvs/vehicles/laat/ballturret_loop.wav" )
	self.sndBTL:SetSoundLevel( 110 )

	if Attachment then
		local Pos,Ang = LocalToWorld( Vector(0,-15,0), Angle(180,0,-90), Attachment.Pos, Attachment.Ang )

		self.sndBTL:SetParent( NULL )
		self.sndBTL:SetPos( Pos )
		self.sndBTL:SetAngles( Ang )
		self.sndBTL:SetParent( self )
	end

	local Pod = self:AddDriverSeat( Vector(-0.20,-0.60,1), Angle(0,-90,0) ) -- camera pos
    Pod:SetCameraDistance( -0.8 )
    Pod:SetCameraHeight( -0.1 )
    Pod.ExitPos = Vector(75,0,36)

local WheelMass = 100
    local WheelRadius = 1
    local WheelPos = {
        Vector(-21.25,15,-40),
        Vector(-1.25,15,-40),
        Vector(20,15,-40),
        Vector(-21.25,-15,-40),
        Vector(-1.25,-15,-40),
        Vector(20,-15,-40),
    } -- DO NOT TOUCH THIS ABOVE WHEEL CODE OR IT WILL COLLIDE WITH WALLS! -Wolf

	for _, Pos in pairs( WheelPos ) do
		self:AddWheel( Pos, WheelRadius, WheelMass, 1 )
	end

	self:AddEngineSound( Vector(0,0,30) )
end

function ENT:RunOnSpawn()
end



