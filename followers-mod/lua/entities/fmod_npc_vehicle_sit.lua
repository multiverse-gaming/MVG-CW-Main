
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Vehicle Seat (Sit)"
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
	
local ent = ents.Create( "fmod_npc_vehicle_sit" )
ent:SetPos( SpawnPos )
ent:SetAngles( self.Spawn_angles )
ent:Spawn()
ent:Activate()
	
return ent
end

function ENT:SetVisibility(ent, bool)
if bool == true then
if ent:GetMaterial() == "models/invisible_texture/invisible_mat" then
ent:SetMaterial("")
end
ent:SetNoDraw(false)
ent:DrawShadow(true)
ent:SetRenderMode(RENDERMODE_TRANSCOLOR)	
ent:SetColor(Color(255,255,255,255))
elseif bool == false then
if ent:GetMaterials() != "models/invisible_texture/invisible_mat" then
ent:SetMaterial("models/invisible_texture/invisible_mat")
end
ent:SetNoDraw(true)
ent:DrawShadow(false)
ent:SetRenderMode(RENDERMODE_TRANSCOLOR)	
ent:SetColor(Color(255,255,255,0))
end
end

function ENT:Initialize()
self.AnimList = {
"d1_t02_Plaza_Sit02",
"d1_t01_BreakRoom_Sit01_Idle"
}
self:SetModel("models/humans/filzo/chief.mdl")
self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
self:SetVisibility(self, false)
local spawnanim = self:LookupSequence(table.Random(self.AnimList))
self:SetSequence(spawnanim)
self:SetPlaybackRate(0)

self.phybase = ents.Create("prop_physics")
self.phybase:SetModel("models/hunter/plates/plate025x025.mdl")
self.phybase:SetNoDraw(false)
self.phybase:DrawShadow(true)
self.phybase:SetColor(Color(255,0,0,255))
self.phybase:PhysicsInit( SOLID_VPHYSICS )
self.phybase:SetMoveType( SOLID_VPHYSICS )
self.phybase:SetSolid( SOLID_VPHYSICS )
self.phybase:SetPos(self:GetPos())
self.phybase:SetAngles(self:GetAngles())
local selfpos = self.phybase:GetPos() + self.phybase:GetForward() * 0 + self.phybase:GetUp() * -19 + self.phybase:GetRight() * 1
self:SetPos(selfpos)
self:SetParent(self.phybase)
self.phybase:Spawn()

local markpos = self.phybase:GetPos() + self.phybase:GetForward() * 7 + self.phybase:GetUp() * -1.5 + self.phybase:GetRight() * 0
self.phybase.mark = ents.Create("prop_dynamic")
self.phybase.mark:SetModel("models/hunter/plates/plate.mdl")
self.phybase.mark:SetPos(markpos)
self.phybase.mark:SetAngles(self:GetAngles())
self.phybase.mark:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
self.phybase.mark:SetParent(self)
self.phybase.mark:Spawn()
self.phybase.mark:SetNWBool("DontPickMeUpWithPhysGunYouAsshole", true)
local phys = self.phybase:GetPhysicsObject()
if (phys:IsValid()) then
phys:Wake()
end

self.fakenpc = ents.Create("prop_dynamic")
self.fakenpc:SetModel("models/humans/filzo/chief.mdl")
self.fakenpc:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
self.fakenpc:SetParent(self)
self.fakenpc:Fire("setparentattachment", self:GetAttachments()[1].name)
self.fakenpc:AddEffects(EF_BONEMERGE)
self:SetVisibility(self.fakenpc, false)
self.fakenpc:Spawn()
self:DeleteOnRemove(self.fakenpc)
self:DeleteOnRemove(self.phybase.mark)
self.phybase.mark:DeleteOnRemove(self)
self.phybase:DeleteOnRemove(self)
self:DeleteOnRemove(self.phybase)
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
local bonecheck = npc:LookupBone("ValveBiped.Bip01_Spine")
if bonecheck then
if (!IsValid(self:GetNWEntity("FMOD_MyUser"))) and (!npc:GetNWBool("FMOD_InVehicle")) and (!npc:GetNWBool("FMOD_SpecialDown")) and IsValid(npc:GetNWEntity("FMOD_MyTarget")) and npc:Visible(npc:GetNWEntity("FMOD_MyTarget")) and npc:GetNWEntity("FMOD_MyTarget"):InVehicle() then
print("luklllaldaldas")
if (!IsValid(npc:GetNWEntity("FMOD_MyVehicle"))) and (!self:GetNWBool("FMOD_VehicleUsed")) and npc:GetPos():Distance(self:GetPos()) <= GetConVarNumber("fmod_vehicle_max_dist") then
local spawnanim = self:LookupSequence(table.Random(self.AnimList))
self:SetSequence(spawnanim)
self:SetPlaybackRate(0)

if npc.custommodel then
self.fakenpc:SetModel(npc.custommodel:GetModel())
self.fakenpc:SetMaterial(npc.custommodel:GetMaterial())
self:SetVisibility(self.fakenpc, true)
self.fakenpc:SetBodygroup(1,npc.custommodel:GetBodygroup(1))
self.fakenpc:SetBodygroup(2,npc.custommodel:GetBodygroup(2))
self.fakenpc:SetBodygroup(3,npc.custommodel:GetBodygroup(3))
self.fakenpc:SetBodygroup(4,npc.custommodel:GetBodygroup(4))
self.fakenpc:SetBodygroup(5,npc.custommodel:GetBodygroup(5))
self.fakenpc:SetBodygroup(6,npc.custommodel:GetBodygroup(6))
self.fakenpc:SetBodygroup(7,npc.custommodel:GetBodygroup(7))
self.fakenpc:SetBodygroup(8,npc.custommodel:GetBodygroup(8))
self.fakenpc:SetBodygroup(9,npc.custommodel:GetBodygroup(9))
self:SetVisibility(npc.custommodel, false)
else
self.fakenpc:SetModel(npc:GetModel())
self.fakenpc:SetModel(npc:GetModel())
self.fakenpc:SetMaterial(npc:GetMaterial())
self:SetVisibility(self.fakenpc, true)
self.fakenpc:SetBodygroup(1,npc:GetBodygroup(1))
self.fakenpc:SetBodygroup(2,npc:GetBodygroup(2))
self.fakenpc:SetBodygroup(3,npc:GetBodygroup(3))
self.fakenpc:SetBodygroup(4,npc:GetBodygroup(4))
self.fakenpc:SetBodygroup(5,npc:GetBodygroup(5))
self.fakenpc:SetBodygroup(6,npc:GetBodygroup(6))
self.fakenpc:SetBodygroup(7,npc:GetBodygroup(7))
self.fakenpc:SetBodygroup(8,npc:GetBodygroup(8))
self.fakenpc:SetBodygroup(9,npc:GetBodygroup(9))
self:SetVisibility(npc, false)
end
npc:SetNWEntity("FMOD_MyVehicle", self)
self:SetNWBool("FMOD_VehicleUsed",true)
npc:SetNWBool("FMOD_InVehicle",true)
self:SetNWEntity("FMOD_MyUser",npc)
npc:SetPos(self:GetPos())
npc:SetAngles(self:GetAngles())
npc:SetParent(self)
if IsValid(npc:GetActiveWeapon()) then
local wep = npc:GetActiveWeapon()
self:SetVisibility(wep, false)
end
npc:SetSchedule(SCHED_NPC_FREEZE)
npc:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
self:EmitSound("FMod_Seat.Enter")
end
elseif (npc:GetNWBool("FMOD_InVehicle")) and (IsValid(self:GetNWEntity("FMOD_MyUser"))) and ((npc:GetNWBool("FMOD_SpecialDown")) or ((!IsValid(npc:GetNWEntity("FMOD_MyTarget"))) or (IsValid(npc:GetNWEntity("FMOD_MyTarget")) and (!npc:GetNWEntity("FMOD_MyTarget"):InVehicle())))) then
if npc.custommodel then
self:SetVisibility(npc.custommodel, true)
else
self:SetVisibility(npc, true)
end
npc:SetCollisionGroup(COLLISION_GROUP_NONE)
npc:SetParent()
npc:SetCondition(68)
self:EmitSound("FMod_Seat.Exit")
self.fakenpc:SetModel(self:GetModel())
self:SetVisibility(self.fakenpc, false)
if (self:CheckLeft(npc, self, self.fakenpc)) then
npc:SetPos(self:GetPos()+self:GetRight()*-85)
elseif (self:CheckRight(npc, self, self.fakenpc)) then
npc:SetPos(self:GetPos()+self:GetRight()*85)
elseif (self:CheckForward(npc, self, self.fakenpc)) then
npc:SetPos(self:GetPos()+self:GetForward()*85)
elseif (self:CheckBack(npc, self, self.fakenpc)) then
npc:SetPos(self:GetPos()+self:GetForward()*-85)
elseif (self:CheckUp(npc, self, self.fakenpc)) then
npc:SetPos(self:GetPos()+self:GetUp()*85)
else
npc:SetPos(self:GetPos()+self:GetUp()*85)
end
npc:SetAngles(Angle(0,0,0))
if IsValid(npc:GetActiveWeapon()) then
local wep = npc:GetActiveWeapon()
self:SetVisibility(wep, true)
end
self:SetNWBool("FMOD_VehicleUsed",false)
npc:SetNWBool("FMOD_InVehicle",false)
npc:SetNWEntity("FMOD_MyVehicle",nil)
self:SetNWEntity("FMOD_MyUser",nil)
end
end
end
end
if (!IsValid(self:GetNWEntity("FMOD_MyUser"))) and self:GetNWBool("FMOD_VehicleUsed") then
self.fakenpc:SetModel(self:GetModel())
self:SetVisibility(self.fakenpc, false)
self:SetNWBool("FMOD_VehicleUsed", false)
end
end
end

function ENT:OnRemove()
if IsValid(self:GetNWEntity("FMOD_MyUser")) then
local npc = self:GetNWEntity("FMOD_MyUser")
if npc.custommodel then
self:SetVisibility(npc.custommodel, true)
else
self:SetVisibility(npc, true)
end
self.fakenpc:SetModel(self:GetModel())
self:SetVisibility(self.fakenpc, false)
npc:SetCollisionGroup(COLLISION_GROUP_NONE)
npc:SetParent()
npc:SetCondition(68)
if (self:CheckLeft(npc, self, self.fakenpc)) then
npc:SetPos(self:GetPos()+self:GetRight()*-85)
elseif (self:CheckRight(npc, self, self.fakenpc)) then
npc:SetPos(self:GetPos()+self:GetRight()*85)
elseif (self:CheckForward(npc, self, self.fakenpc)) then
npc:SetPos(self:GetPos()+self:GetForward()*85)
elseif (self:CheckBack(npc, self, self.fakenpc)) then
npc:SetPos(self:GetPos()+self:GetForward()*-85)
elseif (self:CheckUp(npc, self, self.fakenpc)) then
npc:SetPos(self:GetPos()+self:GetUp()*85)
else
npc:SetPos(self:GetPos()+self:GetUp()*85)
end
npc:SetAngles(Angle(0,0,0))
if IsValid(npc:GetActiveWeapon()) then
local wep = npc:GetActiveWeapon()
self:SetVisibility(wep, true)
end
self:SetNWBool("FMOD_VehicleUsed",false)
npc:SetNWBool("FMOD_InVehicle",false)
npc:SetNWEntity("FMOD_MyVehicle",nil)
self:SetNWEntity("FMOD_MyUser",nil)
end
end
end
