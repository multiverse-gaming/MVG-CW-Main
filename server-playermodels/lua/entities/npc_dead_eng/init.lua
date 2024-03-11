AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


ENT.health = 280
ENT.Alerted = false
ENT.Territorial = true
ENT.Bleeds = true
ENT.Chasing = true
ENT.Flinches = true
ENT.FriendlyToPlayer = false
ENT.Damage = 70
ENT.AcidBlood = false
ENT.BleedsRed = true
ENT.LeapSpeed = 1000
ENT.LeapDistance = 300
ENT.MinLeapDistance = 200
ENT.MeleeAttacking = false;
ENT.Leaping = false
ENT.alert1 = Sound("death_trooper/zombie_alert1.wav")
ENT.alert2 = Sound("death_trooper/zombie_alert2.wav")
ENT.alert3 = Sound("death_trooper/zombie_alert3.wav")
ENT.idle1 = Sound("death_trooper/zombie_voice_idle13.wav")
ENT.idle2 = Sound("death_trooper/zombie_voice_idle14.wav")
ENT.idle3 = Sound("death_trooper/zombie_voice_idle7.wav")
ENT.idle4 = Sound("death_trooper/zombie_voice_idle6.wav")
ENT.angryidle1 = Sound("death_trooper/zombie_pain2.wav")
ENT.angryidle2 = Sound("death_trooper/zombie_pain4.wav")
ENT.angryidle3 = Sound("death_trooper/zombie_pain5.wav")
ENT.angryidle4 = Sound("death_trooper/zombie_voice_idle5.wav")
ENT.attack1 = Sound("death_trooper/claw_strike1.wav")
ENT.attack2 = Sound("death_trooper/claw_strike2.wav")
ENT.attack3 = Sound("death_trooper/claw_strike3.wav")
ENT.attackmiss1 = Sound("death_trooper/claw_miss1.wav")
ENT.attackmiss2 = Sound("death_trooper/claw_miss2.wav")
ENT.attackleap = Sound("")
ENT.hurt1 = Sound("death_trooper/zombie_pain1.wav")
ENT.hurt2 = Sound("death_trooper/zombie_pain3.wav")
ENT.hurt3 = Sound("death_trooper/zombie_pain6.wav")
ENT.die1 = Sound("death_trooper/zombie_die1.wav")
ENT.die2 = Sound("death_trooper/zombie_die2.wav")
ENT.die3 = Sound("death_trooper/zombie_die3.wav")
ENT.dead = false

ENT.model1 = "models/dead_eng_npc/dead_eng_npc.mdl"

local schedJump = ai_schedule.New( "Jump" ) 
schedJump:EngTask( "TASK_PLAY_SEQUENCE", ACT_JUMP )

function ENT:Initialize()

	local randommodel = math.random(1)
	if randommodel == 1 then
		self.Model = self.model1
	end
	
	self:SetModel( self.Model )
	self:SetHullType( HULL_MEDIUM )
	self:SetHullSizeNormal()
	self:SetSolid( SOLID_BBOX )
	self:SetMoveType( MOVETYPE_STEP )
	self:CapabilitiesAdd( CAP_MOVE_GROUND )
	self:CapabilitiesAdd( CAP_AUTO_DOORS )
	self:CapabilitiesAdd( CAP_OPEN_DOORS )
	self:CapabilitiesAdd( CAP_USE )
	--self:CapabilitiesAdd( CAP_USE_WEAPONS )
	--self:CapabilitiesAdd( CAP_USE_SHOT_REGULATOR )
	--self:CapabilitiesAdd( CAP_AIM_GUN )
	self:SetMaxYawSpeed( 5000 )
	self:SetHealth(self.health)
	self:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_POOR )
	
	for k, i in pairs(player.GetAll()) do
		self:AddEntityRelationship(i,1,10)
	end
end

ENT.dd = 0
function ENT:Think()
	--if self:IsOnFire() then
		--self:SetSkin(2)
	--end
	
	--if self:GetActiveWeapon() != nil and self:GetActiveWeapon():GetClass() != "none" then
		--local myWeapon = self:GetActiveWeapon()
		--if myWeapon:GetClass() != "none" and myWeapon:GetClass() != nil and myWeapon:GetClass() != "" then
			--if self:GetCurrentWeaponProficiency() == "WEAPON_PROFICIENCY_POOR" then
				--myWeapon.Primary.Cone = 0.5
			--elseif self:GetCurrentWeaponProficiency() == "WEAPON_PROFICIENCY_POOR" then
				--myWeapon.Primary.Cone = 0.5
			--elseif self:GetCurrentWeaponProficiency() == "WEAPON_PROFICIENCY_AVERAGE" then
				--myWeapon.Primary.Cone = 0.5
			--elseif self:GetCurrentWeaponProficiency() == "WEAPON_PROFICIENCY_GOOD" then
				--myWeapon.Primary.Cone = 0.5
			--elseif self:GetCurrentWeaponProficiency() == "WEAPON_PROFICIENCY_VERY_GOOD" then
				--myWeapon.Primary.Cone = 0.5
			--elseif self:GetCurrentWeaponProficiency() == "WEAPON_PROFICIENCY_PERFECT" then
				--myWeapon.Primary.Cone = 0.0125
			--end
		--end
	--end
	
	if self:Health() < 0 then return end

	if self.dd != GetConVarNumber("ai_ignoreplayers") then
		if GetConVarNumber("ai_ignoreplayers") == 0 then
			for k, i in pairs(player.GetAll()) do
				self:AddEntityRelationship(i,1,10)
			end
			self.dd = 0
		elseif GetConVarNumber("ai_ignoreplayers") == 1 then
			for k, i in pairs(player.GetAll()) do
				self:AddEntityRelationship(i,4,10)
			end
			self.dd = 1
		end
	end
	
        //---------------
	local function setmeleefalse()
		if self:Health() < 0 then return end
		self.MeleeAttacking = false
		self.Leaping = false
		--self:SetSchedule(SCHED_CHASE_ENEMY)
	end
        //---------------
	local function Attack_Melee()
		if self:Health() < 0 then return end
		local entstoattack = ents.FindInSphere(self:GetPos() + self:GetForward()*75,47)
		local hit = false
		if entstoattack != nil then
			for _,v in pairs(entstoattack) do
				if ( (v:IsNPC() or ( v:IsPlayer() and v:Alive() and self:Disposition(v) == 1)) and (v != self) and (v:GetClass() != self:GetClass()) or (v:GetClass() == "prop_physics")) then
					v:TakeDamage( self.Damage, self ) 
					if v:IsPlayer() then
						v:ViewPunch(Angle(math.random(-1,1)*self.Damage,math.random(-1,1)*self.Damage,math.random(-1,1)*self.Damage))
					end
					if v:GetClass() == "prop_physics" then
						local phys = v:GetPhysicsObject()
						if phys != nil && phys != NULL then
							phys:ApplyForceOffset(self:GetForward()*1000,Vector(math.random(-1,1),math.random(-1,1),math.random(-1,1)))
						end
					end
					hit = true
				end
			end
		end
		local randomsound = math.random(1,4)
		if hit == false then
			self:StopSound(self.idle1)
			self:StopSound(self.idle2)
			self:StopSound(self.idle3)
			self:StopSound(self.idle4)
			
			if randomsound == 1 then
	      		self:EmitSound( self.attackmiss1 )
			elseif randomsound == 2 then
	      		self:EmitSound( self.attackmiss2 )
			end
		else
			local randomsound = math.random(1,6)
			//make the sound
			self:StopSound(self.idle1)
			self:StopSound(self.idle2)
			self:StopSound(self.idle3)
			self:StopSound(self.idle4)

			if randomsound == 1 then
	      		self:EmitSound( self.attack1 )
			elseif randomsound == 2 then
	      		self:EmitSound( self.attack2 )
			elseif randomsound == 3 then
	      		self:EmitSound( self.attack3 )
			end
		end
		timer.Create( "melee_done_timer" .. self.Entity:EntIndex( ), 0.8, 1, setmeleefalse )
	end
        //---------------


    //---------------
    if GetConVarNumber("ai_disabled") == 0 then
		if math.random(1,5) == 1 then
			if self:GetEnemy() != nil then
				self:UpdateEnemyMemory(self:GetEnemy(),self:GetEnemy():GetPos())
			end
		end

		//make the sound
		if self.Alerted == true then
		local randomsound = math.random(1,120)
		if randomsound == 1 then
			self:StopSound(self.angryidle1)
			self:StopSound(self.angryidle2)
			self:StopSound(self.angryidle3)
			self:StopSound(self.angryidle4)
	      		self:EmitSound( self.angryidle1 )
		elseif randomsound == 2 then
			self:StopSound(self.angryidle1)
			self:StopSound(self.angryidle2)
			self:StopSound(self.angryidle3)
			self:StopSound(self.angryidle4)
	      		self:EmitSound( self.angryidle2 )
		elseif randomsound == 3 then
			self:StopSound(self.angryidle1)
			self:StopSound(self.angryidle2)
			self:StopSound(self.angryidle3)
			self:StopSound(self.angryidle4)
	      		self:EmitSound( self.angryidle3 )
		elseif randomsound == 4 then
			self:StopSound(self.angryidle1)
			self:StopSound(self.angryidle2)
			self:StopSound(self.angryidle3)
			self:StopSound(self.angryidle4)
	      		self:EmitSound( self.angryidle4 )
		end
		else
		local randomsound = math.random(1,120)
		if randomsound == 1 then
			self:StopSound(self.idle1)
			self:StopSound(self.idle2)
			self:StopSound(self.idle3)
			self:StopSound(self.idle4)
	      		self:EmitSound( self.idle1 )
		elseif randomsound == 2 then
			self:StopSound(self.idle1)
			self:StopSound(self.idle2)
			self:StopSound(self.idle3)
			self:StopSound(self.idle4)
	      		self:EmitSound( self.idle2 )
		elseif randomsound == 3 then
			self:StopSound(self.idle1)
			self:StopSound(self.idle2)
			self:StopSound(self.idle3)
			self:StopSound(self.idle4)
	      		self:EmitSound( self.idle3 )
		elseif randomsound == 4 then
			self:StopSound(self.idle1)
			self:StopSound(self.idle2)
			self:StopSound(self.idle3)
			self:StopSound(self.idle4)
	      		self:EmitSound( self.idle4 )
		end
		end
		if math.random(1,10) == 1 then
			//print( "Think start" );
			//Get all the npc's and other entities.
			local enttable = ents.FindByClass("npc_*")
			local monstertable = ents.FindByClass("monster_*")
			table.Add(monstertable,enttable)//merge

			//sort through each ent.
			for _, x in pairs(monstertable) do
				if (!ents) then print( "No Entities!" ); return end
				if (x:GetClass() != self:GetClass() && x:GetClass() != "npc_grenade_frag" && x:IsNPC()) then
					x:AddEntityRelationship( self, 1, 10 )
				end
			end
			
			local friends = ents.FindByClass("npc_dead_*")
			for _, x in pairs(friends) do
				x:AddEntityRelationship( self, 3, 10 )
			end
		end

		if self.TakingCover == false then
			if(math.random(1,6) == 1) then
			self:FindCloseEnemies()//get guys close to me
			end
		end//Hit them.
		
		if self:GetEnemy() != nil then
				if math.random(1,15) == 1 && self:GetPos():Distance(self:GetEnemy():GetPos()) < self.LeapDistance && self:GetPos():Distance(self:GetEnemy():GetPos()) > self.MinLeapDistance && self.Leaps == true && self.Leaping == false then
					self:SetSchedule(schedJump)
					self.Leaping = true
  					self:SetVelocity( (self:GetEnemy():GetPos()-self:GetPos() + Vector(0,0,50)):Normalize() * self.LeapSpeed )
					timer.Simple(0.25,function() setmeleefalse()end )
				end
				if (self:GetEnemy():GetPos():Distance(self:GetPos()) < 70) || self:HasPropInFrontOfMe() then
					if self.MeleeAttacking == false then
						if self.Leaping == false then
							self:SetSchedule( SCHED_MELEE_ATTACK1 )
						else
							self:EmitSound( self.attackleap)
							self:SetLocalVelocity( Vector( 0, 0, 0 ) )
						end
						timer.Create( "melee_attack_timer" .. self.Entity:EntIndex( ), 0.5, 1, Attack_Melee )
						self.MeleeAttacking = true;
					end
				end
		else
			self:FindEnemyDan()
			self.MeleeAttacking = false
		end
    end
    //---------------
    //print(self:GetEnemy())
    //print(self.Alerted)
    //print(self.Chasing)

end

function ENT:HasPropInFrontOfMe()
	local entstoattack = ents.FindInSphere(self:GetPos() + self:GetForward()*75,47)
	for _,v in pairs(entstoattack) do
		if v:GetClass() == "prop_physics" then
		return true
		end
	end
	return false
end

function ENT:SelectSchedule()
if self:GetEnemy() != nil then
if self:GetEnemy():GetPos():Distance(self:GetPos()) > 5000 then
--self:SetSchedule(SCHED_CHASE_ENEMY )
self:SetEnemy(NULL)
alerted = true
end
end

if self:GetEnemy() != nil then
if self:GetEnemy():GetPos():Distance(self:GetPos()) < 5000 and self:GetActiveWeapon() == nil then
self:UpdateEnemyMemory(self:GetEnemy(),self:GetEnemy():GetPos())
self:SetSchedule(SCHED_CHASE_ENEMY)
self.Chasing = true
elseif self:GetEnemy():GetPos():Distance(self:GetPos()) < 5000 and self:GetActiveWeapon() != nil then
self:SetSchedule(SCHED_ESTABLISH_LINE_OF_FIRE)
elseif self:GetEnemy():GetPos():Distance(self:GetPos()) < 1000 and self:GetActiveWeapon() != nil then
self:SetSchedule(SCHED_RANGE_ATTACK1)
else
self:SetSchedule(SCHED_IDLE_WANDER)
end
elseif self.Alerted == true then
self:SetSchedule(SCHED_IDLE_WANDER)
else
self:SetSchedule(SCHED_IDLE_WANDER)
end
end


function ENT:OnTakeDamage(dmg)
   if (self.TakingCover == false) && self.Flinches == true then
   	self:SetSchedule(SCHED_SMALL_FLINCH)//
   end 
   if self.Bleeds == true then
	self:SpawnBlood(dmg)
   end
   self:SetHealth(self:Health() - dmg:GetDamage())
   if math.random(4) == 1 then
	self:StopSound(self.idle1)
	self:StopSound(self.idle2)
	self:StopSound(self.idle3)
	self:StopSound(self.idle4)
	local sound_seed = math.random(1,7)
	if sound_seed == 1 then
	self:EmitSound( self.hurt1 )
	elseif sound_seed == 2 then
	self:EmitSound( self.hurt2 )
	elseif sound_seed == 3 then
	self:EmitSound( self.hurt3 )
	end	
   end
   if dmg:GetAttacker():GetClass() != self:GetClass() && math.random(1,7) == 1 then
   	self:ResetEnemy()
   	self:AddEntityRelationship( dmg:GetAttacker(), 1, 10 )
   	self:SetEnemy(dmg:GetAttacker())
	--self:SetSchedule(SCHED_CHASE_ENEMY)
	self.Chasing = true
	self.Alerted = true
   end
   if self:Health() <= 0 && self.dead == false then //run on death	
	self.dead = true;
	//print("DIED!!!")
	self:KilledDan()
   end
end

function ENT:FindEnemyDan()
	local MyNearbyTargets = ents.FindInCone(self:GetPos(),self:GetForward(),4000,45)
	if (!MyNearbyTargets) then print( "No Targets!" ); return end
	for k,v in pairs(MyNearbyTargets) do
	    if self:Disposition(v) == 1 then --if v:Disposition(self) == 1 or (v:IsPlayer() and self:Disposition(v) == 1) then
		self:ResetEnemy()
   		self:AddEntityRelationship( v, 1, 10 )
			self:SetEnemy(v)
		self:UpdateEnemyMemory(v,v:GetPos())
		local distance = self:GetPos():Distance(v:GetPos())
	      	local randomsound = math.random(1,5)
		if self.Alerted == false then
			if randomsound == 1 then
	      		self:EmitSound( self.alert1)
			elseif randomsound == 2 then
	      		self:EmitSound( self.alert2)
			elseif randomsound == 3 then
	      		self:EmitSound( self.alert3)
			end
		end
		self.Alerted = true
	      	return
	    end
	end
	//if ClosestDistance == 4000 then
	//self:SetEnemy(NULL)
	//end
end


function ENT:ResetEnemy()
	local enttable = ents.FindByClass("npc_*")
	local monstertable = ents.FindByClass("monster_*")
	table.Add(monstertable,enttable)//merge

	//sort through each ent.
	for _, x in pairs(monstertable) do
		//print(x)
		if (!ents) then print( "No Entities!" ); return end
		if (x:GetClass() != self:GetClass()) then
			self:AddEntityRelationship( x, 2, 10 )
		end
	end
	
	local friends = ents.FindByClass("npc_dead_*")
	for _, x in pairs(friends) do
		self:AddEntityRelationship( x, 3, 10 )
	end
	self:AddRelationship("player D_NU 10")
end


function ENT:FindCloseEnemies()
	local MyNearbyTargets = ents.FindInCone(self:GetPos(),self:GetForward(),250,45)
	//local ClosestDistance = 3000
	if (!MyNearbyTargets) then print( "No Targets!" ); return end
	for k,v in pairs(MyNearbyTargets) do
		if v:Disposition(self) == 1 || (v:IsPlayer() and self:Disposition(v) == 1) then
		print(v:GetClass())

		self:ResetEnemy()
   		self:AddEntityRelationship( v, 1, 10 )
	      	self:SetEnemy(v)
		
		self.Alerted = true
	      	return
	    end
	   
	end
end


function ENT:HasLOS()
	if self:GetEnemy() != nil then
	//local shootpos = self:GetAimVector()*(self:GetPos():Distance(self:GetEnemy():GetPos())) + self:GetPos()
	//local shootpos = self:GetEnemy():GetPos()
	local tracedata = {}

	tracedata.start = self:GetPos()
	tracedata.endpos = self:GetEnemy():GetPos()
	tracedata.filter = self

	local trace = util.TraceLine(tracedata)
	if trace.HitWorld == false then
		print("returned true!")
		return true
	else 
		return false
	end
	end
	print ("no enemy!")
	return false
end


function ENT:SpawnBlood(dmg)
   if self.AcidBlood then
	local entstoattack = ents.FindInSphere(self:GetPos(),75)
	for _,v in pairs(entstoattack) do
		if ( (v:IsNPC() || ( v:IsPlayer() && v:Alive())) && (v != self) && (v:GetClass() != self:GetClass()) || (v:GetClass() == "prop_physics")) then
			v:TakeDamage( 3, self ) 
		end
	self:EmitSound( "alien/alien_acid.wav" )
	end
   end
   if (self.Bleeds == true) then
   	local bloodeffect = ents.Create( "info_particle_system" )
	if self.BleedsRed == true then
   		bloodeffect:SetKeyValue( "effect_name", "blood_impact_red_01" )
	else
		bloodeffect:SetKeyValue( "effect_name", "blood_impact_yellow_01")
	end
        bloodeffect:SetPos( dmg:GetDamagePosition() ) 
	bloodeffect:Spawn()
	bloodeffect:Activate() 
	bloodeffect:Fire( "Start", "", 0 )
	bloodeffect:Fire( "Kill", "", 0.1 )
   end
   
end

function ENT:KilledDan()
	/*The following is some of Silverlan's code for ragdolling*/
	//emit cry of death
	self:StopSound(self.idle1)
	self:StopSound(self.idle2)
	self:StopSound(self.idle3)
	self:StopSound(self.idle4)

	local deathseed = math.random(1,3)
	if     deathseed == 1 then
	  self:EmitSound( self.die1 )
	elseif deathseed == 2 then
	  self:EmitSound( self.die2 )
	elseif deathseed == 3 then
	  self:EmitSound( self.die3 )
	end

local ragdoll = ents.Create( "prop_ragdoll" )
ragdoll:SetModel( self:GetModel() )
ragdoll:SetPos( self:GetPos() )
ragdoll:SetAngles( self:GetAngles() )
ragdoll:Spawn()
ragdoll:SetSkin( self:GetSkin() )
ragdoll:SetColor( self:GetColor() )
ragdoll:SetMaterial( self:GetMaterial() )

undo.ReplaceEntity(self,ragdoll)
cleanup.ReplaceEntity(self,ragdoll)

if self:IsOnFire() then ragdoll:Ignite( math.Rand( 8, 10 ), 0 ) end


for i=1,128 do
local bone = ragdoll:GetPhysicsObjectNum( i )
if IsValid( bone ) then
local bonepos, boneang = self:GetBonePosition( ragdoll:TranslatePhysBoneToBone( i ) )
bone:SetPos( bonepos )
end
end
if( GetConVarNumber("ai_serverragdolls") == 0 ) then
ragdoll:SetCollisionGroup( 1 )
ragdoll:Fire( "FadeAndRemove", "", 2 )
end
self:Remove()
end

function ENT:OnRemove()
timer.Remove("melee_attack_timer" .. self.Entity:EntIndex( ))
timer.Remove("melee_done_timer" .. self.Entity:EntIndex( ))
end
