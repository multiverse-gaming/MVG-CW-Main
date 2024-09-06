AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:SpawnFunction( ply, tr )
if ( !tr.Hit ) then return end
	
local SpawnPos = tr.HitPos + tr.HitNormal * 6
self.Spawn_angles = ply:GetAngles()
self.Spawn_angles.pitch = 0
self.Spawn_angles.roll = 0
self.Spawn_angles.yaw = self.Spawn_angles.yaw + 180
	
local ent = ents.Create( "fmod_steve_the_bandit" )
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

self.npc = ents.Create( "npc_citizen" )
self.npc:SetPos(self:GetPos())
self.npc:SetAngles(self:GetAngles())
--self.npc:SetKeyValue( "spawnflags", "256" )

self.npc.DefWeapons = {
"weapon_smg1",
"weapon_shotgun",
"weapon_ar2"
}

if self.npc:GetNWString("FiLzO_WeaponType") != nil and string.find( string.lower( self.npc:GetNWString("FiLzO_WeaponType") ), "_") and !string.find( string.lower( self.npc:GetNWString("FiLzO_WeaponType") ), "none") then
self.npc:SetKeyValue("additionalequipment", self.npc:GetNWString("FiLzO_WeaponType"))
elseif self.npc:GetNWString("FiLzO_WeaponType") != nil and !string.find( string.lower( self.npc:GetNWString("FiLzO_WeaponType") ), "none") then
self.npc:SetKeyValue("additionalequipment", table.Random(self.npc.DefWeapons))
end

self.npc:SetSpawnEffect(false)
self.npc:Spawn()
self.npc:Activate()
self:SetParent(self.npc)
self.npc:SetHealth(100)
self.npc:SetMaxHealth(100)
self.npc:SetBloodColor(0)
self.npc:CapabilitiesAdd(CAP_MOVE_JUMP)
self.npc:CapabilitiesAdd(CAP_MOVE_CLIMB)
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

self.npc:SetNWBool("FMOD_Stevetb", true)
self.npc:SetNWBool("FMOD_Special", true)
self.npc:SetNWBool("FMOD_Mortal", true)
self.npc:SetNWString("CustomName", "Steve the Bandit")
self:SetNWEntity("FMOD_BaseNPC", self.npc)
self.npc:SetNWEntity("FMOD_NPCBase", self)
self.npc:SetNWBool("FMOD_FriendlyToPlayer", true)
self.npc:SetNWFloat("FMOD_HelpMe", 0)
self.npc:SetNWFloat("FMOD_HelpMe_", 1.5)
self.npc:SetNWFloat("FMOD_HelpMeCall", 0)
self.npc:SetNWFloat("FMOD_HelpMeCall_", 3)
self.npc:SetNWFloat("FMOD_RegenHP", 0)
self.npc:SetNWFloat("FMOD_RegenHP_", 1.5)
self.npc:SetNWFloat("FMOD_MedkitThrow", 0)
self.npc:SetNWFloat("FMOD_MedkitThrow_", 10)
self.npc:SetNWFloat("FMOD_MaxThrowDist", 500)
self.npc:SetNWString("FMOD_Custom_FollowMe", "FMod_FollowMe.Stevetb")
self.npc:SetNWString("FMOD_Custom_Copy", "FMod_Copy.Stevetb")
self.npc:SetNWString("FMOD_Custom_StayHere", "FMod_StayHere.Stevetb")

local min,max = self.npc:GetCollisionBounds()
local hull = self.npc:GetHullType()
self.npc:SetModel("models/fingerfix_ecitizens/male/male_01.mdl")
self.npc:SetSolid(SOLID_BBOX)
self.npc:SetPos(self.npc:GetPos()+self.npc:GetUp()*16)
self.npc:SetHullType(hull)
self.npc:SetHullSizeNormal()
self.npc:SetCollisionBounds(min,max)
self.npc:DropToFloor()
self.npc:SetModelScale(1)

self.npc.custommodel = ents.Create("prop_dynamic")
self.npc.custommodel:SetSpawnEffect(true)
self.npc.custommodel:SetModel("models/player/steve.mdl")
self.npc.custommodel:SetMaterial("")
self.npc.custommodel:SetColor(Color(255,255,255,255))
--self.npc.custommodel:SetBodygroup(1,bftd:GetBodygroup(1))
self.npc.custommodel:SetPos(self.npc:GetPos())
self.npc.custommodel:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
self.npc.custommodel:SetParent(self.npc)
self.npc.custommodel:Fire("setparentattachment", self.npc:GetAttachments()[1].name)
self.npc.custommodel:AddEffects(EF_BONEMERGE)
self.npc.custommodel:Spawn()
self.npc:SetNetworkedEntity("FMOD_CustomModel", self.npc.custommodel)
self.npc:DrawShadow(false)
self.npc:SetNoDraw(true)
self.npc:SetRenderMode(RENDERMODE_TRANSCOLOR)	
self.npc:SetColor(Color(255,255,255,0))
self.npc:DeleteOnRemove(self.npc.custommodel)

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
if (!IsValid(npc:GetNWEntity("FMOD_MyTarget"))) and (!npc:GetNWBool("FMOD_SpecialDown")) and (!npc:GetNWBool("FMOD_InVehicle")) then
if (ent:GetNWBool("FMOD_Special")) or (table.HasValue(npc.allies, ent:GetClass())) then
if IsValid(enemy) and enemy == ent then npc:ClearEnemyMemory() end
if npc:Disposition(ent) != D_LI and npc:Visible(ent) then npc:AddEntityRelationship(ent,D_LI,10) end
if ent:Disposition(npc) != D_LI and ent:Visible(npc) then ent:AddEntityRelationship(npc,D_LI,10) end
elseif (!ent:GetNWBool("FMOD_Special")) and (!table.HasValue(npc.allies, ent:GetClass())) then
if npc:Disposition(ent) != D_HT and npc:Visible(ent) then npc:AddEntityRelationship(ent,D_HT,10) end
if ent:Disposition(npc) != D_HT and ent:Visible(npc) then ent:AddEntityRelationship(npc,D_HT,10) end
end
elseif (IsValid(npc:GetNWEntity("FMOD_MyTarget"))) and (!npc:GetNWBool("FMOD_SpecialDown")) and (!npc:GetNWBool("FMOD_InVehicle")) then
if (ent:GetNWBool("FMOD_Special")) or (ent:Disposition(npc:GetNWEntity("FMOD_MyTarget")) == D_LI or ent:Disposition(npc:GetNWEntity("FMOD_MyTarget")) == D_NU) then
if IsValid(enemy) and enemy == ent then npc:ClearEnemyMemory() end
if npc:Disposition(ent) != D_LI and npc:Visible(ent) then npc:AddEntityRelationship(ent,D_LI,10) end
if ent:Disposition(npc) != D_LI and ent:Visible(npc) then ent:AddEntityRelationship(npc,D_LI,10) end
elseif (!ent:GetNWBool("FMOD_Special")) or (ent:Disposition(npc:GetNWEntity("FMOD_MyTarget")) == D_HT or ent:Disposition(npc:GetNWEntity("FMOD_MyTarget")) == D_FR) then
if npc:Disposition(ent) != D_HT and npc:Visible(ent) then npc:AddEntityRelationship(ent,D_HT,10) end
if ent:Disposition(npc) != D_HT and ent:Visible(npc) then ent:AddEntityRelationship(npc,D_HT,10) end
end
elseif ((!IsValid(npc:GetNWEntity("FMOD_MyTarget"))) or (IsValid(npc:GetNWEntity("FMOD_MyTarget")))) and ((npc:GetNWBool("FMOD_SpecialDown")) or npc:GetNWBool("FMOD_InVehicle")) then
if IsValid(enemy) and enemy == ent then npc:ClearEnemyMemory() end
if npc:Disposition(ent) != D_LI and npc:Visible(ent) then npc:AddEntityRelationship(ent,D_LI,10) end
end
end
end

for _, ply in pairs( player.GetAll() ) do
if ply and npc:GetNWBool("FMOD_Special") then
if npc:GetNWBool("FMOD_FriendlyToPlayer") and (!npc:GetNWBool("FMOD_SpecialDown")) then
if npc:Disposition(ply) != D_LI then npc:AddEntityRelationship(ply,D_LI,10) end
elseif (!npc:GetNWBool("FMOD_FriendlyToPlayer")) and (!npc:GetNWBool("FMOD_SpecialDown")) then
if npc:Disposition(ply) != D_HT then npc:AddEntityRelationship(ply,D_HT,10) end
elseif (npc:GetNWBool("FMOD_FriendlyToPlayer") or !npc:GetNWBool("FMOD_FriendlyToPlayer")) and (npc:GetNWBool("FMOD_SpecialDown")) then
if npc:Disposition(ply) != D_NU then npc:AddEntityRelationship(ply,D_NU,10) end
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
if (!npc:GetNWBool("FMOD_InVehicle")) and npc:GetNWBool("FMOD_SpecialDown") and (!npc:GetNWBool("FMOD_StevetbDownAnim")) then
npc:SetNWFloat("FMOD_HelpMe", CurTime() + npc:GetNWFloat("FMOD_HelpMe_"))
npc:SetNWFloat("FMOD_HelpMeCall", CurTime() + npc:GetNWFloat("FMOD_HelpMeCall_"))
npc:PlayScene("scenes/fmod_delta_hurtstart.vcd")
npc:EmitSound("FMod_Down.Stevetb")
npc:SetNWBool("FMOD_StevetbDownAnim", true)
elseif (!npc:GetNWBool("FMOD_InVehicle")) and npc:GetNWBool("FMOD_SpecialDown") and npc:Health() >= npc:GetMaxHealth()*0.35 then
npc:PlayScene("scenes/fmod_delta_hurtend.vcd")
npc:SetNWBool("FMOD_SpecialDown", false)
npc:SetNWBool("FMOD_StevetbDownAnim", false)
npc:EmitSound("FMod_Wake.Stevetb")
npc:EmitSound("FMod_Heal.NPC")
npc:RemoveFlags(32768)
npc:RemoveFlags(65536)
npc:ClearCondition(67)
npc:SetCondition(68)
npc:SetKeyValue("sleepstate","0")
end
if npc:GetNWBool("FMOD_SpecialDown") then
npc:StopMoving()
if (npc:GetNWFloat("FMOD_HelpMe") <= CurTime()) then
npc:PlayScene("scenes/fmod_delta_hurtloop.vcd")
npc:SetNWFloat("FMOD_HelpMe", CurTime() + 0.5)
end
end
if npc:GetNWBool("FMOD_SpecialDown") then
if (npc:GetNWFloat("FMOD_HelpMeCall") <= CurTime()) then
npc:EmitSound("FMod_Help.Stevetb")
npc:SetNWFloat("FMOD_HelpMeCall", CurTime() + npc:GetNWFloat("FMOD_HelpMeCall_"))
end
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

function ENT:MeleeAttacks(npc)
if IsValid(npc) and (!npc:GetNWBool("FMOD_InVehicle")) then
local enemy = npc:GetEnemy()
local anim = npc:GetSequenceName(self.npc:GetSequence())
local act = npc:GetActivity()

if IsValid(enemy) and npc:Visible(enemy) and enemy:GetPos():Distance(npc:GetPos()) <= 50 then
timer.Simple(1.2, function()
if (!IsValid(npc)) or (!IsValid(enemy)) then return end
if IsValid(enemy) and enemy:GetPos():Distance(npc:GetPos()) > 50 then return end
if (npc:GetNWFloat("FMOD_MeleeAttack") > CurTime()) then return false end

self:ActNPC(npc, "swing", false, true, nil, nil, nil, nil, nil, nil, nil, nil)

local pos = npc:GetShootPos()
local ang = npc:GetAimVector()
local damagedice = math.Rand(0.9,1.10)
local primdamage = math.random(8,12)
local pain = primdamage * damagedice

local slash = {}
slash.start = pos
slash.endpos = pos+(ang*50)
slash.filter = npc
slash.mins = Vector(-5,-5,0)
slash.maxs = Vector(5,5,5)
local slashtrace = util.TraceHull(slash)
if slashtrace.Hit then
local targ = slashtrace.Entity
if npc:Disposition(targ) == D_LI or npc:Disposition(targ) == D_NU then return end
if IsValid(npc:GetActiveWeapon()) then
npc:EmitSound("FMod_MeleeHit.Weapon")
else
npc:EmitSound("FMod_MeleeHit.Hand")
end
local paininfo = DamageInfo()
paininfo:SetDamage(pain)
paininfo:SetDamageType(DMG_CLUB)
paininfo:SetAttacker(npc)
if IsValid(npc:GetActiveWeapon()) then
paininfo:SetInflictor(npc:GetActiveWeapon())
else
paininfo:SetInflictor(npc)
end
local RandomForce = math.random(1000,20000)
paininfo:SetDamageForce(slashtrace.Normal * RandomForce)
targ:SetVelocity(npc:GetForward()*500+npc:GetUp()*150)
if targ:IsNPC() then
targ:StopMoving()
end
if targ:IsPlayer() then
targ:ViewPunch(Angle(-20,math.random(-50,50),math.random(-15,15)))
end
if targ:IsPlayer() or targ:IsNPC() then
local blood = targ:GetBloodColor()	
local fleshimpact = EffectData()
fleshimpact:SetEntity(self.Weapon)
fleshimpact:SetOrigin(slashtrace.HitPos)
fleshimpact:SetNormal(slashtrace.HitPos)
if blood >= 0 then
fleshimpact:SetColor(blood)
util.Effect("BloodImpact", fleshimpact)
end
end
targ:TakeDamageInfo(paininfo)
else
if IsValid(npc:GetActiveWeapon()) then
npc:EmitSound("FMod_MeleeMiss.Weapon")
else
npc:EmitSound("FMod_MeleeMiss.Hand")
end
end
npc:SetNWFloat("FMOD_MeleeAttack", CurTime() + 1)
end)
end
end
end

function ENT:JumpEffects(npc)
if IsValid(npc) then
local enemy = npc:GetEnemy()
local anim = npc:GetSequenceName(self.npc:GetSequence())
local act = npc:GetActivity()

if ((act == 30)) and (!npc:GetNWBool("FMOD_Jump")) then
npc:SetNWBool("FMOD_Jump", true)
npc:EmitSound("FMod_Jump.Delta")
end

if(npc:GetNWBool("FMOD_Jump")) and (npc:IsOnGround()) then
npc:SetNWBool("FMOD_Jump", false)
npc:EmitSound("FMod_Land.Delta")
--util.ScreenShake(npc:GetPos(), 40, 0.1, 0.5, 200)
local land = EffectData()
land:SetEntity(npc)
land:SetStart(npc:GetPos())
land:SetOrigin(npc:GetPos())
land:SetStart(npc:GetPos())
land:SetNormal(npc:GetPos())
land:SetMagnitude(10)
land:SetScale(10)
util.Effect("RagdollImpact", land)
end

end
end

function ENT:Spotting(npc)
if IsValid(npc) and IsValid(npc:GetNWEntity("FMOD_MyTarget")) then
local enemy = npc:GetEnemy()
local anim = npc:GetSequenceName(self.npc:GetSequence())
local act = npc:GetActivity()
if IsValid(enemy) and (!npc:GetNWEntity("FMOD_MyTarget"):Visible(enemy)) then
enemy:SetNWBool("FMOD_Spotted",true)
elseif IsValid(enemy) and npc:GetNWEntity("FMOD_MyTarget"):Visible(enemy) then
enemy:SetNWBool("FMOD_Spotted",false)
end
end
end

function ENT:RadioConnection(npc)
if IsValid(npc) then
local enemy = npc:GetEnemy()
local anim = npc:GetSequenceName(self.npc:GetSequence())
local act = npc:GetActivity()
if (npc:GetNWBool("FMOD_ImAfterSomeone")) and (!npc:GetNWBool("FMOD_RadioEnabled")) then
npc:EmitSound("npc/metropolice/vo/on1.wav")
npc:SetNWBool("FMOD_RadioEnabled",true)
elseif (!npc:GetNWBool("FMOD_ImAfterSomeone")) and (npc:GetNWBool("FMOD_RadioEnabled")) then
npc:EmitSound("npc/metropolice/vo/off1.wav")
npc:SetNWBool("FMOD_RadioEnabled",false)
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
self:JumpEffects(npc)
self:MeleeAttacks(npc)
self:RadioConnection(npc)
self:Spotting(npc)

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
if IsValid(self.npc) then
self.npc:Remove()
end
end