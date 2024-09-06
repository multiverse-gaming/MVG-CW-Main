AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:SpawnFunction( ply, tr )
if ( !tr.Hit ) then return end
	
local SpawnPos = tr.HitPos + tr.HitNormal * 6
self.Spawn_angles = ply:GetAngles()
self.Spawn_angles.pitch = 0
self.Spawn_angles.roll = 0
self.Spawn_angles.yaw = self.Spawn_angles.yaw + 180
	
local ent = ents.Create( "fmod_huntey" )
ent:SetKeyValue( "disableshadows", "1" )
ent:SetPos( SpawnPos )
ent:SetAngles( self.Spawn_angles )
ent:Spawn()
ent:Activate()
	
return ent
end

function ENT:Initialize()
self:SetModel("models/props_lab/huladoll.mdl")
self:SetNoDraw(true)
self:DrawShadow(false)
self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
self:SetName(self.PrintName)
self:SetOwner(self.Owner)

self.npc = ents.Create( "npc_hunter" )
self.npc:SetPos(self:GetPos())
self.npc:SetAngles(self:GetAngles())
--self.npc:SetKeyValue( "spawnflags", "256" )
self.npc:SetSpawnEffect(true)
self.npc:Spawn()
self.npc:Activate()
self:SetParent(self.npc)
self.npc:SetHealth(120)
self.npc:SetMaxHealth(120)
self.npc:SetBloodColor(0)
self.npc:CapabilitiesAdd(CAP_MOVE_JUMP) 
self.npc:CapabilitiesAdd(CAP_USE)
self.npc:CapabilitiesAdd(CAP_AUTO_DOORS)
self.npc:CapabilitiesAdd(CAP_OPEN_DOORS)
self.npc:CapabilitiesAdd(CAP_FRIENDLY_DMG_IMMUNE)
self.npc:CapabilitiesAdd(CAP_DUCK)
self.npc:CapabilitiesAdd(CAP_SQUAD)
self.npc:AddEFlags(134217728)
if IsValid(self.npc) and IsValid(self) then self.npc:DeleteOnRemove(self) end
self:DeleteOnRemove(self.npc)
if(IsValid(self.npc))then

self.npc:SetNWBool("FMOD_Huntey", true)
self.npc:SetNWBool("FMOD_Special", true)
self.npc:SetNWString("CustomName", "Huntey")
self:SetNWEntity("FMOD_BaseNPC", self.npc)
self.npc:SetNWEntity("FMOD_NPCBase", self)
self.npc:SetNWBool("FMOD_FriendlyToPlayer", true)
self.npc:SetNWFloat("FMOD_HelpMe", 0)
self.npc:SetNWFloat("FMOD_HelpMe_", 1.5)
self.npc:SetNWFloat("FMOD_RegenHP", 0)
self.npc:SetNWFloat("FMOD_RegenHP_", 1)

local min,max = self.npc:GetCollisionBounds()
local hull = self.npc:GetHullType()
self.npc:SetModel(self.npc:GetModel())
self.npc:SetSubMaterial(0, "models/huntey/huntey_skin_basecolor.vmt")
self.npc:SetSubMaterial(1, "models/huntey/huntey_armor_basecolor.vmt")
self.npc:SetSolid(SOLID_BBOX)
self.npc:SetPos(self.npc:GetPos()+self.npc:GetUp()*16)
self.npc:SetHullType(hull)
self.npc:SetHullSizeNormal()
self.npc:SetCollisionBounds(min,max)
self.npc:DropToFloor()
self.npc:SetModelScale(0.5)

self.npc.light1 = ents.Create("huntey_flash")
self.npc.light1.A = -3
self.npc.light1.B = 0
self.npc.light1.C = 0
self.npc.light1.AR = 255
self.npc.light1.BG = 150
self.npc.light1.CB = 0
self.npc.light1.FovA = 25
self.npc.light1.DisA = 650
self.npc.light1.FovB = 8
self.npc.light1.DisB = 30
self.npc.light1:SetPos(self.npc:GetPos())
self.npc.light1:SetAngles(self.npc:GetAngles())
self.npc.light1:SetOwner(self.npc)
self.npc.light1:SetParent(self.npc)
self.npc.light1:Fire("setparentattachment", self.npc:GetAttachments()[5].name)
self.npc.light1:Spawn()
self.npc.light1:Activate()
self.npc:DeleteOnRemove(self.npc.light1)

self.npc.light2 = ents.Create("huntey_flash")
self.npc.light2.A = -3
self.npc.light2.B = 0
self.npc.light2.C = 0
self.npc.light2.AR = 255
self.npc.light2.BG = 150
self.npc.light2.CB = 0
self.npc.light2.FovA = 25
self.npc.light2.DisA = 650
self.npc.light2.FovB = 8
self.npc.light2.DisB = 30
self.npc.light2:SetPos(self.npc:GetPos())
self.npc.light2:SetAngles(self.npc:GetAngles())
self.npc.light2:SetOwner(self.npc)
self.npc.light2:SetParent(self.npc)
self.npc.light2:Fire("setparentattachment", self.npc:GetAttachments()[4].name)
self.npc.light2:Spawn()
self.npc.light2:Activate()
self.npc:DeleteOnRemove(self.npc.light2)

self.npc.allies = {
"npc_monk",
"npc_alyx",
"npc_barney",
"npc_citizen",
"npc_dog",
"npc_kleiner",
"npc_magnusson",
"npc_mossman",
"npc_eli",
"npc_gman",
"npc_fisherman",
"npc_vortigaunt",
"npc_crow",
"npc_pigeon",
"npc_bullseye"
}

end
end

function ENT:Relations(npc)
if IsValid(npc) then
local enemy = npc:GetEnemy()
local anim = npc:GetSequenceName(npc:GetSequence())
local act = npc:GetActivity()

for _, ent in pairs( ents.GetAll() ) do
if ent and ent:IsNPC() and ent != npc then
if (!IsValid(npc:GetNWEntity("FMOD_MyTarget"))) and (!npc:GetNWBool("FMOD_SpecialDown")) then
if (ent:GetNWBool("FMOD_Special")) or (table.HasValue(npc.allies, ent:GetClass())) then
if IsValid(enemy) and enemy == ent then npc:ClearEnemyMemory() end
if npc:Disposition(ent) != D_LI and npc:Visible(ent) then npc:AddEntityRelationship(ent,D_LI,10) end
if ent:Disposition(npc) != D_LI and ent:Visible(npc) then ent:AddEntityRelationship(npc,D_LI,10) end
elseif (!ent:GetNWBool("FMOD_Special")) and (!table.HasValue(npc.allies, ent:GetClass())) then
if npc:Disposition(ent) != D_HT and npc:Visible(ent) then npc:AddEntityRelationship(ent,D_HT,10) end
if ent:Disposition(npc) != D_HT and ent:Visible(npc) then ent:AddEntityRelationship(npc,D_HT,10) end
end
elseif (IsValid(npc:GetNWEntity("FMOD_MyTarget"))) and (!npc:GetNWBool("FMOD_SpecialDown")) then
if (ent:GetNWBool("FMOD_Special")) or (ent:Disposition(npc:GetNWEntity("FMOD_MyTarget")) == D_LI or ent:Disposition(npc:GetNWEntity("FMOD_MyTarget")) == D_NU) then
if IsValid(enemy) and enemy == ent then npc:ClearEnemyMemory() end
if npc:Disposition(ent) != D_LI and npc:Visible(ent) then npc:AddEntityRelationship(ent,D_LI,10) end
if ent:Disposition(npc) != D_LI and ent:Visible(npc) then ent:AddEntityRelationship(npc,D_LI,10) end
elseif (!ent:GetNWBool("FMOD_Special")) or (ent:Disposition(npc:GetNWEntity("FMOD_MyTarget")) == D_HT or ent:Disposition(npc:GetNWEntity("FMOD_MyTarget")) == D_FR) then
if npc:Disposition(ent) != D_HT and npc:Visible(ent) then npc:AddEntityRelationship(ent,D_HT,10) end
if ent:Disposition(npc) != D_HT and ent:Visible(npc) then ent:AddEntityRelationship(npc,D_HT,10) end
end
elseif ((!IsValid(npc:GetNWEntity("FMOD_MyTarget"))) or (IsValid(npc:GetNWEntity("FMOD_MyTarget")))) and (npc:GetNWBool("FMOD_SpecialDown")) then
if IsValid(enemy) and enemy == ent then npc:ClearEnemyMemory() end
if npc:Disposition(ent) != D_LI and npc:Visible(ent) then npc:AddEntityRelationship(ent,D_LI,10) end
end
end
end

for _, ply in pairs( player.GetAll() ) do
if ply and npc:GetNWBool("FMOD_Huntey") then
if npc:GetNWBool("FMOD_FriendlyToPlayer") then
if npc:Disposition(ply) != D_LI then npc:AddEntityRelationship(ply,D_LI,10) end
elseif !npc:GetNWBool("FMOD_FriendlyToPlayer") then
if npc:Disposition(ply) != D_HT then npc:AddEntityRelationship(ply,D_HT,10) end
end
end
end

end
end

function ENT:ImDown(npc)
if IsValid(npc) then
local enemy = npc:GetEnemy()
local anim = npc:GetSequenceName(self.npc:GetSequence())
local act = npc:GetActivity()
if npc:GetNWBool("FMOD_SpecialDown") and (!npc:GetNWBool("FMOD_SpecialDownAnim")) then
npc:SetNWFloat("FMOD_HelpMe", CurTime() + npc:GetNWFloat("FMOD_HelpMe_"))
self:ActNPC(npc, "stagger_all", false, true, nil, nil, nil, nil, nil, nil, nil, nil)
npc:EmitSound("FMod_Huntey.Down")
npc:SetNWBool("FMOD_SpecialDownAnim", true)
elseif npc:GetNWBool("FMOD_SpecialDown") and npc:Health() >= npc:GetMaxHealth()*0.35 then
self:ActNPC(npc, "shakeoff", false, true, nil, nil, nil, nil, nil, nil, nil, nil)
npc:SetNWBool("FMOD_SpecialDown", false)
npc:SetNWBool("FMOD_SpecialDownAnim", false)
npc:EmitSound("FMod_Huntey.Wake")
npc:RemoveFlags(32768)
npc:RemoveFlags(65536)
npc:ClearCondition(67)
npc:SetCondition(68)
npc:SetKeyValue("sleepstate","0")
end
if npc:GetNWBool("FMOD_SpecialDown") then
if (npc:GetNWFloat("FMOD_HelpMe") > CurTime()) then return false end
self:ActNPC(npc, "hunter_call_1", true, true, nil, nil, nil, nil, nil, nil, nil, nil)
end
end
end

function ENT:HPRegen(npc)
if IsValid(npc) then
local enemy = npc:GetEnemy()
local anim = npc:GetSequenceName(self.npc:GetSequence())
local act = npc:GetActivity()
if (npc:GetNWFloat("FMOD_RegenHP") <= CurTime()) and (npc:Health() < npc:GetMaxHealth()) then
npc:SetNWFloat("FMOD_RegenHP", CurTime() + npc:GetNWFloat("FMOD_RegenHP_"))
local regenAmount = math.min(npc:GetMaxHealth() - npc:Health(), 2)
npc:SetHealth(math.min(npc:GetMaxHealth(), npc:Health() + regenAmount))
end
end
end

function ENT:FlashLight(npc)
if IsValid(npc) and IsValid(npc.light1) and IsValid(npc.light2) then
local enemy = npc:GetEnemy()
local anim = npc:GetSequenceName(self.npc:GetSequence())
local act = npc:GetActivity()
if IsValid(npc:GetNWEntity("FMOD_MyTarget")) and npc:GetNWEntity("FMOD_MyTarget"):FlashlightIsOn() and (!npc:GetNWBool("FMOD_Huntey_LightOn")) then
npc.light1.fa:Fire("TurnOn", "", 0)
npc.light1.fb:Fire("LightOn", "", 0)
npc.light2.fa:Fire("TurnOn", "", 0)
npc.light2.fb:Fire("LightOn", "", 0)
npc:SetNWBool("FMOD_Huntey_LightOn", true)
npc:EmitSound("FMod_Special.LightOn")
elseif ((!IsValid(npc:GetNWEntity("FMOD_MyTarget"))) or (IsValid(npc:GetNWEntity("FMOD_MyTarget")) and !npc:GetNWEntity("FMOD_MyTarget"):FlashlightIsOn())) and (npc:GetNWBool("FMOD_Huntey_LightOn")) then
npc.light1.fa:Fire("TurnOff", "", 0)
npc.light1.fb:Fire("LightOff", "", 0)
npc.light2.fa:Fire("TurnOff", "", 0)
npc.light2.fb:Fire("LightOff", "", 0)
npc:SetNWBool("FMOD_Huntey_LightOn", false)
npc:EmitSound("FMod_Special.LightOff")
end
end
end

function ENT:JumpEffects(npc)
if IsValid(npc) then
local enemy = npc:GetEnemy()
local anim = npc:GetSequenceName(self.npc:GetSequence())
local act = npc:GetActivity()

if ((act == 30) or (act == 34) or (act == 35)) and (!npc:GetNWBool("FMOD_Jump")) then
npc:SetNWBool("FMOD_Jump", true)
npc:EmitSound("FMod_HunteyJump.Active")

npc.jetbase = ents.Create("prop_dynamic")
npc.jetbase:SetModel("models/props_junk/PopCan01a.mdl")
npc.jetbase:SetModelScale(0.1)
npc.jetbase:SetPos(npc:GetPos())
npc.jetbase:SetAngles(npc:GetAngles())
npc.jetbase:SetParent(npc)
npc.jetbase:Fire("setparentattachment", "head_radius_measure")
npc.jetbase:Spawn()
npc.jetbase:Activate()
npc.jetbase:SetNoDraw(false)
npc.jetbase:DrawShadow(false)
npc.jetbase:EmitSound("FMod_HunteyJump.On")
if IsValid(npc) and IsValid(npc.jetbase) then npc:DeleteOnRemove(npc.jetbase) end

local jetpos = npc.jetbase:GetPos() + npc.jetbase:GetForward() * 0 + npc.jetbase:GetUp() * 0 + npc.jetbase:GetRight() * 0
npc.jet = ents.Create("env_rockettrail")
npc.jet:SetPos(jetpos)
npc.jet:SetParent(npc.jetbase)
npc.jet:SetOwner(npc)
npc.jet:SetAngles(npc.jetbase:GetAngles()+Angle(0,90,0))
npc.jet:SetKeyValue("scale", "0.1")
npc.jet:Spawn()
if IsValid(npc) and IsValid(npc.jet) then npc:DeleteOnRemove(npc.jet) end

local effectdata = EffectData()
effectdata:SetStart(npc.jet:GetPos())
effectdata:SetEntity(npc.jet)
effectdata:SetOrigin(npc.jet:GetPos())
util.Effect("CrossbowLoad", effectdata)

end
if(npc:GetNWBool("FMOD_Jump")) and (npc:IsOnGround()) then
npc:SetNWBool("FMOD_Jump", false)
npc:StopSound("FMod_HunteyJump.Active")
if IsValid(npc.jetbase) then SafeRemoveEntity(npc.jetbase) end
end
end
end

function ENT:Think()
if IsValid(self) and IsValid(self.npc) then
local npc = self.npc
local enemy = self.npc:GetEnemy()
local anim = self.npc:GetSequenceName(self.npc:GetSequence())
local act = self.npc:GetActivity()

self:Relations(npc)
self:ImDown(npc)
self:HPRegen(npc)
self:FlashLight(npc)
self:JumpEffects(npc)

end
end

function ENT:ScriptedSequencePlay(npc, parent, npc_name, moveto, pos, ang, replay, pre_anim, main_anim, post_anim, sound1, sound2, sound3)
self.seq = ents.Create("scripted_sequence")
if(parent)then
self.seq:SetParent(parent)
end
self.seq:SetPos(pos)		
self.seq:SetAngles(ang)
if(pre_anim)then
self.seq:SetKeyValue("m_iszIdle", pre_anim) -- Pre Anim
end
if(main_anim)then
self.seq:SetKeyValue("m_iszPlay", main_anim) -- Anim
end
if(post_anim)then
self.seq:SetKeyValue("m_iszPostIdle", post_anim) -- Post Anim
end
self.seq:SetKeyValue("m_iszEntity", npc_name)
self.seq:SetKeyValue("spawnflags", "16" + "32" + "64" + "128")
self.seq:SetKeyValue("m_fMoveTo", moveto)
self.seq:SetKeyValue("m_flRepeat", replay)
self.seq:Spawn()
self.seq:Fire("beginsequence")
if(sound1)then npc:EmitSound(sound1) end
if(sound2)then npc:EmitSound(sound2) end
if(sound3)then npc:EmitSound(sound3) end
if IsValid(self.seq) and IsValid(self) then self:DeleteOnRemove(self.seq) end
end

function ENT:ActNPC(npc, name, override, stationary, time, kill, killer, killerwep, faceent, sound1, sound2, sound3)
if(!IsValid(npc))or(IsValid(npc) and npc:GetNWBool("ActSequencePlay") and !override)then return end
if npc.ActDelay==nil then npc.ActDelay=0 end
local seq, dur = npc:LookupSequence(name)
if time==nil or time<=0 then time=dur end
if (npc.ActDelay > CurTime()) then return false end
npc.ActDelay = CurTime() + dur
local act=npc:GetSequenceInfo(seq).activity
npc:RestartGesture(act)
if(sound1)then npc:EmitSound(sound1) end
if(sound2)then npc:EmitSound(sound2) end
if(sound3)then npc:EmitSound(sound3) end
timer.Simple(dur,function()
if IsValid(npc) and kill then
npc:SetHealth(1)
npc:TakeDamage(npc:Health(),killer,killerwep)
end
end)
if(stationary)then
npc:StopMoving()
npc:SetNWBool("ActSequencePlay", true)
npc:ClearCondition(68)
npc:SetCondition(67)
timer.Create("ActSequenceFaceTarget"..npc:EntIndex(),0.1,math.Round(time*10),function()
if(IsValid(npc))and(IsValid(faceent))then
local ang = (faceent:GetPos()-npc:GetPos()):Angle()
local ang2 = npc:GetAngles()
npc:SetAngles(Angle(ang2.p,ang.y,ang2.r))
end
end)
timer.Create("ActSequenceForceStop"..npc:EntIndex(),0.1,math.Round(time*10),function()
if(IsValid(npc))then
npc:StopMoving()
end
end)
timer.Create("ActSequenceForceMove"..npc:EntIndex(),time,1,function()
if(IsValid(npc))then
npc:SetNWBool("ActSequencePlay", false)
npc:ClearCondition(67)
npc:SetCondition(68)
end
end)
end
end

function ENT:OnRemove()
if IsValid( self.npc ) then
self.npc:Remove()
self.npc:StopSound("FMod_HunteyJump.Active")	
end
end