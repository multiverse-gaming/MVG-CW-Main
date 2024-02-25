AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.SpawnNormalOffset = 25

function ENT:OnSpawn( PObj )
	PObj:SetMass( 1000 )

	self:AddDriverSeat( Vector(-45,0,-4), Angle(0,-90,30) )

	self:AddEngine(  Vector(-110.81,0,-19.055) )
	self:AddEngineSound( Vector(-110.81,0,-19.055) )

	self.SNDLeft = self:AddSoundEmitter( Vector(5,56.3,55), "lfs/eta2/IE_FIGHTER_1.wav", "lfs/eta2/IE_FIGHTER_1.wav" )
	self.SNDLeft:SetSoundLevel( 110 )

	self.SNDRight = self:AddSoundEmitter( Vector(5,-56.3,55), "lfs/eta2/IE_FIGHTER_1.wav", "lfs/eta2/IE_FIGHTER_1.wav" )
	self.SNDRight:SetSoundLevel( 110 )

	self.HSNDLeft = self:AddSoundEmitter( Vector(5,56.3,55), "lfs/eta2/wpn_atst_chinBlaster_fire.wav", "lfs/eta2/wpn_atst_chinBlaster_fire.wav" )
	self.SNDLeft:SetSoundLevel( 110 )

	self.HSNDRight = self:AddSoundEmitter( Vector(5,-56.3,55), "lfs/eta2/wpn_atst_chinBlaster_fire.wav", "lfs/eta2/wpn_atst_chinBlaster_fire.wav" )
	self.SNDRight:SetSoundLevel( 110 )
end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/start.wav" )
	else
		self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/stop.wav" )
		self:SetFoils( false )
	end
end

function ENT:OnTick()
	if self:ForceDisableFoils() then
		if self:GetThrottle() < 0.1 then
			self:DisableVehicleSpecific()
		end
	end
end

function ENT:OnVehicleSpecificToggled( new )
	local cur = self:GetFoils()

	if not cur and self:ForceDisableFoils() then return end

	if cur ~= new then
		self:SetFoils( new )
	end
end

function ENT:ForceDisableFoils()
	local trace = util.TraceLine( {
		start = self:LocalToWorld( Vector(0,0,50) ),
		endpos = self:LocalToWorld( Vector(0,0,-150) ),
		filter = self:GetCrosshairFilterEnts()
	} )
	
	return trace.Hit
end