if CLIENT then
	SWEP.PrintName = "Follower Controller"
	SWEP.Author = "Jota"
	SWEP.Slot = 4
	SWEP.SlotPos = 10
	SWEP.Description = "This tool allows your to assign followers to yourself, and have them protect and move with you."
	SWEP.Contact = ""
	SWEP.Purpose = "Assign and control followers"
	SWEP.Instructions = "Left Click: Add/Remove followers. Right Click: Hold Position / Recall"
end

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "MVG"

SWEP.HoldType = "normal"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_crowbar_frame.mdl"
SWEP.WorldModel = ""
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {}

SWEP.Primary.Ammo = "none"
SWEP.Secondary.Ammo = "none"

-- Adds and removes followers
function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 0.1)
	if (CLIENT) then return end
	
	if (!IsValid(self.Owner.gfoll)) and self.Owner:Alive() then
		self.Owner:SetName(self.Owner:Nick())
		self.Owner.gfoll = ents.Create("ai_goal_follow")
		self.Owner.gfoll:SetPos(self.Owner:GetPos())
		self.Owner.gfoll:SetAngles(self.Owner:GetAngles())
		self.Owner.gfoll:SetKeyValue( "actor", self.Owner:Nick()..self.Owner:EntIndex() )
		self.Owner.gfoll:SetKeyValue( "goal", self.Owner:GetName() )
		self.Owner.gfoll:SetKeyValue( "SearchType", "0" )
		self.Owner.gfoll:SetKeyValue( "Formation", "0" )
		self.Owner.gfoll:Fire("Deactivate", "", 0)
		self.Owner.gfoll:Spawn()
		self.Owner.gfoll:Activate()
	end

	local ent = self.Owner:GetEyeTrace().Entity
	if IsValid(ent) and ent:IsNPC() and (self.Owner:GetPos():Distance(ent:GetPos()) <= 80) then
		if !ent:GetNWBool("FMOD_ImAfterSomeone") and (ent:Disposition(self.Owner) != D_HT and ent:Disposition(self.Owner) != D_FR) then
			-- Add Follower.
			AddFoll(ent, self.Owner)
			if IsValid(self.Owner.gfoll) then
				self.Owner.gfoll:Fire("Deactivate", "", 0)
				self.Owner.gfoll:Fire("Activate", "", 0.1)
			end

		elseif ent:GetNWBool("FMOD_ImAfterSomeone") and ent:GetNWString("FMOD_ImFollowing") == self.Owner:Nick()..self.Owner:EntIndex() then
			-- Remove Follower.
			RemFoll(ent, self.Owner)
			if IsValid(self.Owner.gfoll) then
				self.Owner.gfoll:Fire("Deactivate", "", 0)
				self.Owner.gfoll:Fire("Activate", "", 0.1)
			end
		end
	end
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + 0.1)
	if (CLIENT) then return end

	local tr = self.Owner:GetEyeTrace()
	local ent = self.Owner:GetEyeTrace().Entity

	-- This code sends someone somewhere.
	if !(self.SendNPCs) then
		local npcFound = false
		for _,my_npc in pairs(ents.GetAll()) do
			if my_npc and my_npc:IsNPC() and my_npc:GetNWBool("FMOD_ImAfterSomeone") and my_npc:GetNWString("FMOD_ImFollowing") == self.Owner:Nick()..self.Owner:EntIndex() then
				npcFound = true
				my_npc:SetName("")
				my_npc:ClearEnemyMemory() 
				my_npc:Fire("stoppatrolling","",0.5)
				my_npc:SetSaveValue("m_vecLastPosition", tr.HitPos)
				if IsValid(self.Owner.gfoll) then self.Owner.gfoll:Fire("Deactivate", "", 0) end
				my_npc:SetSchedule(SCHED_FORCED_GO_RUN)
			end
		end
		self.SendNPCs = true

	-- This code makes them return to you.
	elseif (self.SendNPCs) then
		local npcFound = false
		for _,my_npc in pairs(ents.GetAll()) do
			if my_npc and my_npc:IsNPC() and my_npc:GetNWBool("FMOD_ImAfterSomeone") and my_npc:GetNWString("FMOD_ImFollowing") == self.Owner:Nick()..self.Owner:EntIndex() then
				npcFound = true
				my_npc:SetName(my_npc:GetNWString("FMOD_ImFollowing"))
				my_npc:ClearEnemyMemory() 
				my_npc:Fire("stoppatrolling","",0.5)
				if IsValid(self.Owner.gfoll) then 
					self.Owner.gfoll:Fire("Deactivate", "", 0)
					self.Owner.gfoll:Fire("Activate", "", 0.1)
				end
			end
		end
		self.SendNPCs = false
	end
end

function SWEP:Reload()
	return false
end

function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
end

function SWEP:Holster()
	return true
end

function SWEP:OnRemove()
	self:Holster()
end