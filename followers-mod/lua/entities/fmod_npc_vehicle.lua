
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= ""
ENT.Author			= "FiLzO"
ENT.Information		= ""
ENT.Category		= ""

ENT.Spawnable		= false
ENT.AdminOnly		= false

if(SERVER)then

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

self.fakenpc = ents.Create("prop_dynamic")
self.fakenpc:SetModel("models/humans/filzo/chief.mdl")
self.fakenpc:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
self.fakenpc:SetParent(self)
self.fakenpc:Fire("setparentattachment", self:GetAttachments()[1].name)
self.fakenpc:AddEffects(EF_BONEMERGE)
self:SetVisibility(self.fakenpc, false)
self.fakenpc:Spawn()
self:DeleteOnRemove(self.fakenpc)
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

if IsValid(self:GetNWEntity("FMOD_VehEntity")) then
local veh = self:GetNWEntity("FMOD_VehEntity")

if false then -- There was a convar for "Can use vehicles" - disabled for now
for _,npc in pairs(ents.GetAll()) do
if npc and npc:IsNPC() then
local bonecheck = npc:LookupBone("ValveBiped.Bip01_Spine")
if bonecheck then
if (!IsValid(veh:GetDriver())) and (!IsValid(self:GetNWEntity("FMOD_MyUser"))) and (!npc:GetNWBool("FMOD_InVehicle")) and (!npc:GetNWBool("FMOD_SpecialDown")) and IsValid(npc:GetNWEntity("FMOD_MyTarget")) and npc:Visible(npc:GetNWEntity("FMOD_MyTarget")) and npc:GetNWEntity("FMOD_MyTarget"):InVehicle() then
if (!IsValid(npc:GetNWEntity("FMOD_MyVehicle"))) and (!veh:GetNWBool("FMOD_VehicleUsed")) and npc:GetPos():Distance(veh:GetPos()) <= 120 then
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
npc:SetNWEntity("FMOD_MyVehicle", veh)
veh:SetNWBool("FMOD_VehicleUsed",true)
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
self.fakenpc:SetModel(self:GetModel())
self:SetVisibility(self.fakenpc, false)
if (self:CheckLeft(veh, npc, self, self.fakenpc)) then
npc:SetPos(veh:GetPos()+veh:GetRight()*-85)
elseif (self:CheckRight(veh, npc, self, self.fakenpc)) then
npc:SetPos(veh:GetPos()+veh:GetRight()*85)
elseif (self:CheckForward(veh, npc, self, self.fakenpc)) then
npc:SetPos(veh:GetPos()+veh:GetForward()*85)
elseif (self:CheckBack(veh, npc, self, self.fakenpc)) then
npc:SetPos(veh:GetPos()+veh:GetForward()*-85)
elseif (self:CheckUp(veh, npc, self, self.fakenpc)) then
npc:SetPos(veh:GetPos()+veh:GetUp()*85)
else
npc:SetPos(veh:GetPos()+veh:GetUp()*85)
end
npc:SetAngles(Angle(0,0,0))
if IsValid(npc:GetActiveWeapon()) then
local wep = npc:GetActiveWeapon()
self:SetVisibility(wep, true)
end
veh:SetNWBool("FMOD_VehicleUsed",false)
npc:SetNWBool("FMOD_InVehicle",false)
npc:SetNWEntity("FMOD_MyVehicle",nil)
self:SetNWEntity("FMOD_MyUser",nil)
end
end
end
end
end
if (!IsValid(self:GetNWEntity("FMOD_MyUser"))) and veh:GetNWBool("FMOD_VehicleUsed") then
self.fakenpc:SetModel(self:GetModel())
self:SetVisibility(self.fakenpc, false)
veh:SetNWBool("FMOD_VehicleUsed", false)
end
end
end

function ENT:OnRemove()
if IsValid(self:GetNWEntity("FMOD_MyUser")) then
local npc = self:GetNWEntity("FMOD_MyUser")
local veh = self:GetNWEntity("FMOD_VehEntity")
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
if (self:CheckLeft(veh, npc, self, self.fakenpc)) then
npc:SetPos(veh:GetPos()+veh:GetRight()*-85)
elseif (self:CheckRight(veh, npc, self, self.fakenpc)) then
npc:SetPos(veh:GetPos()+veh:GetRight()*85)
elseif (self:CheckForward(veh, npc, self, self.fakenpc)) then
npc:SetPos(veh:GetPos()+veh:GetForward()*85)
elseif (self:CheckBack(veh, npc, self, self.fakenpc)) then
npc:SetPos(veh:GetPos()+veh:GetForward()*-85)
elseif (self:CheckUp(veh, npc, self, self.fakenpc)) then
npc:SetPos(veh:GetPos()+veh:GetUp()*85)
else
npc:SetPos(veh:GetPos()+veh:GetUp()*85)
end
npc:SetAngles(Angle(0,0,0))
if IsValid(npc:GetActiveWeapon()) then
local wep = npc:GetActiveWeapon()
self:SetVisibility(wep, true)
end
veh:SetNWBool("FMOD_VehicleUsed",false)
npc:SetNWBool("FMOD_InVehicle",false)
npc:SetNWEntity("FMOD_MyVehicle",nil)
self:SetNWEntity("FMOD_MyUser",nil)
end
end
end
