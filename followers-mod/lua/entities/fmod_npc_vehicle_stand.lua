
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Vehicle Seat (Stand)"
ENT.Author			= "FiLzO"
ENT.Information		= ""
ENT.Category		= "FMod"

ENT.Spawnable		= true
ENT.AdminOnly		= false

if(SERVER)then

function ENT:SpawnFunction( ply, tr )
if ( !tr.Hit ) then return end
	
local SpawnPos = tr.HitPos + tr.HitNormal * 16
self.Spawn_angles = ply:GetAngles()
self.Spawn_angles.pitch = 0
self.Spawn_angles.roll = 0
self.Spawn_angles.yaw = self.Spawn_angles.yaw + 180
	
local ent = ents.Create( "fmod_npc_vehicle_stand" )
ent:SetPos( SpawnPos )
ent:SetAngles( self.Spawn_angles )
ent:Spawn()
ent:Activate()
	
return ent
end

function ENT:Initialize()
self:SetModel("models/hunter/plates/plate025x025.mdl")
self:SetNoDraw(false)
self:DrawShadow(true)
self:SetColor(Color(0,255,0,255))
self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( SOLID_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )

local markpos = self:GetPos() + self:GetForward() * 7 + self:GetUp() * -1.5 + self:GetRight() * 0
self.mark = ents.Create("prop_dynamic")
self.mark:SetModel("models/hunter/plates/plate.mdl")
self.mark:SetPos(markpos)
self.mark:SetAngles(self:GetAngles())
self.mark:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
self.mark:SetParent(self)
self.mark:Spawn()
self.mark:SetNWBool("DontPickMeUpWithPhysGunYouAsshole", true)
self:DeleteOnRemove(self.mark)
self.mark:DeleteOnRemove(self)
local phys = self:GetPhysicsObject()
if (phys:IsValid()) then
phys:Wake()
end
end

function ENT:CheckForward(ent1, ent2, ent3, ent4)
local tr = util.TraceHull
{
start = ent1:GetPos()+ent1:GetForward()*85,
endpos = ent1:GetPos()+ent1:GetForward()*85,
filter = {ent1, ent2, ent3, ent4},
mins = Vector( -16, -16, 0 ),
maxs = Vector( 16, 16, 71 )
}
if tr.Hit then return false
else
return true end
end

function ENT:CheckBack(ent1, ent2, ent3, ent4)
local tr = util.TraceHull
{
start = ent1:GetPos()+ent1:GetForward()*-85,
endpos = ent1:GetPos()+ent1:GetForward()*-85,
filter = {ent1, ent2, ent3, ent4},
mins = Vector( -16, -16, 0 ),
maxs = Vector( 16, 16, 71 )
}
if tr.Hit then return false
else
return true end
end

function ENT:CheckLeft(ent1, ent2, ent3, ent4)
local tr = util.TraceHull
{
start = ent1:GetPos()+ent1:GetRight()*-85,
endpos = ent1:GetPos()+ent1:GetRight()*-85,
filter = {ent1, ent2, ent3, ent4},
mins = Vector( -16, -16, 0 ),
maxs = Vector( 16, 16, 71 )
}
if tr.Hit then return false
else
return true end
end

function ENT:CheckRight(ent1, ent2, ent3, ent4)
local tr = util.TraceHull
{
start = ent1:GetPos()+ent1:GetRight()*85,
endpos = ent1:GetPos()+ent1:GetRight()*85,
filter = {ent1, ent2, ent3, ent4},
mins = Vector( -16, -16, 0 ),
maxs = Vector( 16, 16, 71 )
}
if tr.Hit then return false
else
return true end
end

function ENT:CheckUp(ent1, ent2, ent3, ent4)
local tr = util.TraceHull
{
start = ent1:GetPos()+ent1:GetUp()*85,
endpos = ent1:GetPos()+ent1:GetUp()*85,
filter = {ent1, ent2, ent3, ent4},
mins = Vector( -16, -16, 0 ),
maxs = Vector( 16, 16, 71 )
}
if tr.Hit then return false
else
return true end
end

function ENT:Think()

if GetConVarNumber("fmod_followers_enter_vehicles") > 0 then
for _,npc in pairs(ents.GetAll()) do
if npc and npc:IsNPC() then
if (!IsValid(self:GetNWEntity("FMOD_MyUser"))) and (!npc:GetNWBool("FMOD_InVehicle")) and (!npc:GetNWBool("FMOD_SpecialDown")) and IsValid(npc:GetNWEntity("FMOD_MyTarget")) and npc:Visible(npc:GetNWEntity("FMOD_MyTarget")) and npc:GetNWEntity("FMOD_MyTarget"):InVehicle() then
if (!IsValid(npc:GetNWEntity("FMOD_MyVehicle"))) and (!self:GetNWBool("FMOD_VehicleUsed")) and npc:GetPos():Distance(self:GetPos()) <= GetConVarNumber("fmod_vehicle_max_dist") then

npc:SetNWEntity("FMOD_MyVehicle", self)
self:SetNWBool("FMOD_VehicleUsed",true)
npc:SetNWBool("FMOD_InVehicle",true)
self:SetNWEntity("FMOD_MyUser",npc)
npc:SetPos(self:GetPos())
npc:SetAngles(self:GetAngles())
npc:SetParent(self)
npc:CapabilitiesRemove(CAP_MOVE_GROUND)
npc:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
self:EmitSound("FMod_SeatStand.Effect")
end
elseif (npc:GetNWBool("FMOD_InVehicle")) and (IsValid(self:GetNWEntity("FMOD_MyUser"))) and ((npc:GetNWBool("FMOD_SpecialDown")) or ((!IsValid(npc:GetNWEntity("FMOD_MyTarget"))) or (IsValid(npc:GetNWEntity("FMOD_MyTarget")) and (!npc:GetNWEntity("FMOD_MyTarget"):InVehicle())))) then
npc:SetCollisionGroup(COLLISION_GROUP_NONE)
npc:SetParent()
npc:CapabilitiesAdd(CAP_MOVE_GROUND)
self:EmitSound("FMod_SeatStand.Effect")
if (self:CheckLeft(self, npc)) then
npc:SetPos(self:GetPos()+self:GetRight()*-85)
elseif (self:CheckRight(self, npc)) then
npc:SetPos(self:GetPos()+self:GetRight()*85)
elseif (self:CheckForward(self, npc)) then
npc:SetPos(self:GetPos()+self:GetForward()*85)
elseif (self:CheckBack(self, npc)) then
npc:SetPos(self:GetPos()+self:GetForward()*-85)
elseif (self:CheckUp(self, npc)) then
npc:SetPos(self:GetPos()+self:GetUp()*85)
else
npc:SetPos(self:GetPos()+self:GetUp()*85)
end
npc:SetAngles(Angle(0,0,0))
self:SetNWBool("FMOD_VehicleUsed",false)
npc:SetNWBool("FMOD_InVehicle",false)
npc:SetNWEntity("FMOD_MyVehicle",nil)
self:SetNWEntity("FMOD_MyUser",nil)
end
end
end
end
if (!IsValid(self:GetNWEntity("FMOD_MyUser"))) and self:GetNWBool("FMOD_VehicleUsed") then
self:SetNWBool("FMOD_VehicleUsed", false)
end
end

function ENT:OnRemove()
if IsValid(self:GetNWEntity("FMOD_MyUser")) then
local npc = self:GetNWEntity("FMOD_MyUser")
npc:SetCollisionGroup(COLLISION_GROUP_NONE)
npc:SetParent()
npc:CapabilitiesAdd(CAP_MOVE_GROUND)
if (self:CheckLeft(npc, self)) then
npc:SetPos(self:GetPos()+self:GetRight()*-85)
elseif (self:CheckRight(self, npc)) then
npc:SetPos(self:GetPos()+self:GetRight()*85)
elseif (self:CheckForward(self, npc)) then
npc:SetPos(self:GetPos()+self:GetForward()*85)
elseif (self:CheckBack(self, npc)) then
npc:SetPos(self:GetPos()+self:GetForward()*-85)
elseif (self:CheckUp(self, npc)) then
npc:SetPos(self:GetPos()+self:GetUp()*85)
else
npc:SetPos(self:GetPos()+self:GetUp()*85)
end
npc:SetAngles(Angle(0,0,0))
self:SetNWBool("FMOD_VehicleUsed",false)
npc:SetNWBool("FMOD_InVehicle",false)
npc:SetNWEntity("FMOD_MyVehicle",nil)
self:SetNWEntity("FMOD_MyUser",nil)
end
end
end
