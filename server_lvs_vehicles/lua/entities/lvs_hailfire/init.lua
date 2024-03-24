AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 0

local WheelMass = 25000
local WheelRadius = 20
local WheelPos = {
	Vector(60,100,20),
	Vector(-60,100,20),
	Vector(60,-100,20),
	Vector(-60,-100,20),
}

function ENT:OnCollision( data, physobj )
	if self:WorldToLocal( data.HitPos ).z < 0 then return true end

	return false
end

function ENT:OnSpawn( PObj )

	self.rocketnum = 1

	local x = ents.Create("prop_dynamic")
	x:SetModel("models/KingPommes/starwars/hailfire/hailfire_wheel_r.mdl")
	x:SetPos(self:GetPos())
	x:SetAngles(self:GetAngles())
	x:SetParent(self)
	x:Spawn()
	x:Activate()
	self.WeRi = x

	local y = ents.Create("prop_dynamic")
	y:SetModel("models/KingPommes/starwars/hailfire/hailfire_wheel_l.mdl")
	y:SetPos(self:GetPos())
	y:SetAngles(self:GetAngles())
	y:SetParent(self)
	y:Spawn()
	y:Activate()
	self.WeLe = y
	
	self.WeLe:ResetSequence(self.WeLe:LookupSequence("idle"))
	self.WeRi:ResetSequence(self.WeRi:LookupSequence("idle"))
	self.WeLe:SetPlaybackRate(0)
	self.WeRi:SetPlaybackRate(0)

	PObj:SetMass( 250000 )

	self.SNDTail = self:AddSoundEmitter( Vector(20,-10,100), "lvs/vehicles/aat/fire.mp3", "lvs/vehicles/aat/fire.mp3" )
	self.SNDTail:SetSoundLevel( 80 )

	local DriverSeat = self:AddDriverSeat( Vector(0,0,100), Angle(0,-90,0) ) 
	DriverSeat.HidePlayer = true
	DriverSeat.ExitPos =  Vector(0,0,250)	

	for _, Pos in pairs( WheelPos ) do 
		self:AddWheel( Pos, WheelRadius, WheelMass, 1 )
	end
	self:AddEngineSound( Vector(0,0,30) )

	self:SpawnRockets()
end

function ENT:SpawnRockets()
	self.Rocket = {}
	for k=1, 30, 1 do
		local rocket = "rocket" .. k
		local i = ents.Create("base_anim")
		i:SetModel("models/KingPommes/starwars/hailfire/hailfire_rocket.mdl")
		i:SetPos(self:GetAttachment(self:LookupAttachment(rocket)).Pos)
		i:SetAngles(self:GetAttachment(self:LookupAttachment(rocket)).Ang)
		i:SetParent(self)
		i:Spawn()
		i:Activate()
		self.Rocket[k] = i
	end
	self.rocketnum = 1
end

function ENT:ReloadRockets()
	local num = 31 - self.rocketnum
	for i = 1, num do
		self.Rocket[self.rocketnum]:Remove()
		self.rocketnum = self.rocketnum + 1
	end
	self.rocketnum = 1
end

function ENT:OnTick()

	self:AnimGun()

	self:AnimDrive()

	--self:AnimTurn()


	if self.LS ~= self:GetSkin() then
		self.LS = self:GetSkin()
		self.WeLe:SetSkin(self.LS)
		self.WeRi:SetSkin(self.LS)
	end

	if self.LC ~= self:GetColor() then
		self.LC = self:GetColor()
		self.WeLe:SetColor(self.LC)
		self.WeRi:SetColor(self.LC)
	end

end

function ENT:AnimDrive()
    if not self:GetEngineActive() then return end

	--local vel1234 = self:GetPos() + self:GetVelocity() / 12000
	local vel1234 = self:GetVelocity()
    local speed1 = vel1234.y / 80
	local speed = speed1 * -1
	self.WeLe:SetPlaybackRate(speed)
	self.WeRi:SetPlaybackRate(speed)
	
end

function ENT:AnimTurn()
	local direk = self:GetVelocity()
	local richt = direk.y

	if richt > 1 and richt < -1 then return end
	local EyeAngles = self:WorldToLocalAngles(self:GetAimVector():Angle())
	
    EyeAngles:RotateAroundAxis(EyeAngles:Up(), 180)
    local targetHorizontalValue = EyeAngles.y

	if targetHorizontalValue < 100 then
		self.WeLe:SetPlaybackRate(-1)
		self.WeRi:SetPlaybackRate(1)
	elseif targetHorizontalValue > -100 then
		self.WeLe:SetPlaybackRate(1)
		self.WeRi:SetPlaybackRate(-1)
	end

end


function ENT:AnimGun()
	local Driver = self:GetDriver()
	if not IsValid( Driver ) then return end
	local aimx = math.Clamp(Driver:EyeAngles().x, -25, 15)
	local yaw = Driver:GetVehicle():WorldToLocalAngles( Driver:EyeAngles() )
	local aimy = math.AngleDifference(yaw.y, self:EyeAngles().y)
	aimy = math.Clamp( aimy,-33,33)
	self:ManipulateBoneAngles(self:LookupBone("bone_turret_2"), Angle(0,0,-aimx))
	self:ManipulateBoneAngles(self:LookupBone("bone_turret_1"), Angle(aimy,0,0))
end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "hailfire_droid/engine_on.wav" )
	else
		self:EmitSound( "hailfire_droid/engine_off.wav" )
		self.WeRi:SetPlaybackRate(0)
		self.WeLe:SetPlaybackRate(0)
	end
end