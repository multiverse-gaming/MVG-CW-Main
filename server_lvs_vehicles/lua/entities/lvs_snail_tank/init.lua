AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 0
local WheelMass = 25000
local WheelRadius = 20
local WheelPos = {
	Vector(50,-100,18),
	Vector(50,100,18),
	Vector(100,0,18),
	Vector(-250,-0,18),
}

function ENT:OnCollision( data, physobj )
	if self:WorldToLocal( data.HitPos ).z < 0 then return true end

	return false
end

function ENT:OnSpawn( PObj )

	local pos = self:GetPos()
	local posl = self:GetAttachment(self:LookupAttachment("track_left")).Pos
	local posr = self:GetAttachment(self:LookupAttachment("track_right")).Pos
	local ang = self:GetAngles()
	
	local x = ents.Create("prop_dynamic")
	x:SetModel("models/KingPommes/starwars/nr_n99/tracks_middle.mdl")
	x:SetPos(pos)
	x:SetAngles(ang)
	x:SetParent(self)
	x:Spawn()
	x:Activate()
	self.TM = x

	local y = ents.Create("prop_dynamic")
	y:SetModel("models/KingPommes/starwars/nr_n99/tracks_side.mdl")
	y:SetPos(posr)
	y:SetAngles(ang)
	y:SetParent(self)
	y:Spawn()
	y:Activate()
	y:Fire("setparentattachment", "track_right")
	self.TR = y
	
	local z = ents.Create("prop_dynamic")
	z:SetModel("models/KingPommes/starwars/nr_n99/tracks_side.mdl")
	z:SetPos(posl)
	z:SetAngles(ang)
	z:SetParent(self)
	z:Spawn()
	z:Activate()
	z:Fire("setparentattachment", "track_left")
	self.TL = z
	
	self.TL:ResetSequence(self.TL:LookupSequence("move"))
	self.TR:ResetSequence(self.TR:LookupSequence("move"))
	self.TM:ResetSequence(self.TR:LookupSequence("move"))
	self.TL:SetPlaybackRate(0)
	self.TR:SetPlaybackRate(0)
	self.TM:SetPlaybackRate(0)

	PObj:SetMass( 250000 )

	self.SNDTail = self:AddSoundEmitter( Vector(20,-10,100), "lvs/vehicles/aat/fire.mp3", "lvs/vehicles/aat/fire.mp3" )
	self.SNDTail:SetSoundLevel( 80 )

	self.SNDBig = self:AddSoundEmitter( Vector(20,-10,100), "lvs/vehicles/aat/fire_turret.mp3", "lvs/vehicles/aat/fire_turret.mp3" )
	self.SNDBig:SetSoundLevel( 80 )

	local DriverSeat = self:AddDriverSeat( Vector(0,0,200), Angle(0,-90,0) ) 
	DriverSeat.HidePlayer = true
	DriverSeat.ExitPos =  Vector(0,0,350)	

	for _, Pos in pairs( WheelPos ) do 
		self:AddWheel( Pos, WheelRadius, WheelMass, 1 )
	end
	self:AddEngineSound( Vector(0,0,30) )

end

function ENT:OnTick()

	self:AnimGun()

	self:AnimDrive()

	--self:AnimTurn()

	self:AnimTurn2()

	if self.LastColor ~= self:GetColor() then
		self.LastColor = self:GetColor()
		self.TL:SetColor(self.LastColor)
		self.TR:SetColor(self.LastColor)
	end
end

function ENT:AnimDrive()
    if not self:GetEngineActive() then return end

	--local vel1234 = self:GetPos() + self:GetVelocity() / 12000
	local vel1234 = self:GetVelocity()
    local speed1 = vel1234.y / 60
	local speed = speed1 * -1
	self.TL:SetPlaybackRate(speed)
	self.TR:SetPlaybackRate(speed)
	self.TM:SetPlaybackRate(speed)
end

function ENT:AnimTurn2()
	local EyeAngles = self:WorldToLocalAngles(self:GetAimVector():Angle())
	
    EyeAngles:RotateAroundAxis(EyeAngles:Up(), 180)
    local targetHorizontalValue = EyeAngles.y

	if targetHorizontalValue > 170 and targetHorizontalValue < 185 then
		targetHorizontalValue = 0
	elseif targetHorizontalValue > -185 and targetHorizontalValue < -170 then
		targetHorizontalValue = 0
	end
    local smoothingFactor = 0.1

    self.horizontalValue = self.horizontalValue or 0
    self.horizontalValue = self.horizontalValue * (1 - smoothingFactor) + smoothingFactor * targetHorizontalValue

    self:ManipulateBoneAngles(self:LookupBone("steer_right"), Angle(-self.horizontalValue / 6, 0, 0))
    self:ManipulateBoneAngles(self:LookupBone("steer_left"), Angle(-self.horizontalValue / 6, 0, 0))
end

function ENT:AnimTurn()
	local Driver = self:GetDriver()
	if not self:GetEngineActive() then return end
	local yaw = Driver:GetVehicle():WorldToLocalAngles( Driver:EyeAngles() )
	local EyeAngles = self:EyeAngles()
	local dif = math.AngleDifference(yaw.y, EyeAngles.y)
	local unt = math.Clamp( dif,-13,13)
	local Ang = Angle(unt,0,0)
	self:ManipulateBoneAngles(self:LookupBone("steer_left"), Ang)
	self:ManipulateBoneAngles(self:LookupBone("steer_right"), Ang)
end

function ENT:AnimGun()
	local Driver = self:GetDriver()
	if not IsValid( Driver ) then return end
	local aim = math.Clamp(Driver:EyeAngles().x, -35, 12)
	self:ManipulateBoneAngles(self:LookupBone("turret_left"), Angle(0,0,aim))
	self:ManipulateBoneAngles(self:LookupBone("turret_right"), Angle(0,0,aim))
end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "snailtank/engine_on.wav" )
	else
		self:EmitSound( "snailtank/engine_off.wav" )
		self.TL:SetPlaybackRate(0)
		self.TR:SetPlaybackRate(0)
		self.TM:SetPlaybackRate(0)
	end
end