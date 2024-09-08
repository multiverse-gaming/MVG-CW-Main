if CLIENT then
	SWEP.PrintName = "Follower Controller"
	SWEP.Author = "Jota"
	SWEP.Slot = 4
	SWEP.SlotPos = 0
	SWEP.Description = "This tool allows your to assign followers to yourself, and have them protect and move with you."
	SWEP.Contact = ""
	SWEP.Purpose = "Assign and control followers"
	SWEP.Instructions = "Left Click: Add/Remove followers. Right Click: Order Followers"
end

if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "MVG"

SWEP.HoldType = "normal"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_crowbar_frame.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {}

SWEP.Primary.Ammo = "none"
SWEP.Secondary.Ammo = "none"

-- Adds and removes followers
function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 0.1)
	if (CLIENT) then return end

	local tr = self.Owner:GetEyeTrace()
	local ent = self.Owner:GetEyeTrace().Entity

	if IsValid(ent) and ent:IsNPC() and self.Owner:GetPos():Distance(ent:GetPos()) <= GetConVarNumber("fmod_min_call_dist") and (!ent:GetNWBool("FMOD_ImAfterSomeone")) then
		if (ent:Disposition(self.Owner) != D_HT and ent:Disposition(self.Owner) != D_FR) then
			-- Add Follower.
			AddFoll(ent, self.Owner)
			if GetConVarNumber("fmod_followers_speak") > 0 then
				NPCFollRespond(ent)
			end
			if IsValid(self.Owner.gfoll) then
				self.Owner.gfoll:Fire("Deactivate", "", 0)
				self.Owner.gfoll:Fire("Activate", "", 0.1)
			end

		elseif ent:GetNWBool("FMOD_ImAfterSomeone") and ent:GetNWString("FMOD_ImFollowing") == self.Owner:Nick()..self.Owner:EntIndex() then
			-- Remove Follower.
			RemFoll(ent, self.Owner)
			if GetConVarNumber("fmod_followers_speak") > 0 then
				NPCStayRespond(ent)
			end
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
	if self.Owner:KeyDown(IN_WALK) and (key == IN_RELOAD) and (!((IsValid(tr.Entity)) and (tr.Entity:IsNPC() or tr.Entity:IsWeapon() or tr.Entity:GetClass()=="item_healthkit" or tr.Entity:GetClass()=="item_healthvial"))) then
		for _,my_npc in pairs(ents.GetAll()) do
			if my_npc and my_npc:IsNPC() and my_npc:GetNWBool("FMOD_ImAfterSomeone") and my_npc:GetNWString("FMOD_ImFollowing") == self.Owner:Nick()..self.Owner:EntIndex() then
				my_npc:SetName("")
				my_npc:ClearEnemyMemory() 
				my_npc:Fire("stoppatrolling","",0.5)
				util.AddNetworkString("FMOD.Message")
				net.Start("FMOD.Message")
					net.WriteFloat(255)
					net.WriteFloat(255)
					net.WriteFloat(0)
					if my_npc:GetNWString("CustomName")!="" then
						net.WriteString("|FMod|: "..my_npc:GetNWString("CustomName").." take this position!")
					else
						net.WriteString("|FMod|: "..my_npc:GetClass().." take this position!")
					end
				net.Send(self.Owner)
				my_npc:SetSaveValue("m_vecLastPosition", tr.HitPos)
				if IsValid(self.Owner.gfoll) then self.Owner.gfoll:Fire("Deactivate", "", 0) end
				my_npc:SetSchedule(SCHED_FORCED_GO_RUN)
				if GetConVarNumber("fmod_followers_speak") > 0 then
					NPCCopyRespond(my_npc)
				end
			end
		end

	-- This code makes them return to you.
	elseif self.Owner:KeyDown(IN_RELOAD) and (key == IN_WALK) and (!((IsValid(tr.Entity)) and (tr.Entity:IsNPC() or tr.Entity:IsWeapon() or tr.Entity:GetClass()=="item_healthkit" or tr.Entity:GetClass()=="item_healthvial"))) then
		for _,my_npc in pairs(ents.GetAll()) do
			if my_npc and my_npc:IsNPC() and my_npc:GetNWBool("FMOD_ImAfterSomeone") and my_npc:GetNWString("FMOD_ImFollowing") == self.Owner:Nick()..plself.Ownery:EntIndex() then
				my_npc:SetName(my_npc:GetNWString("FMOD_ImFollowing"))
				my_npc:ClearEnemyMemory() 
				my_npc:Fire("stoppatrolling","",0.5)
				util.AddNetworkString("FMOD.Message")
				net.Start("FMOD.Message")
					net.WriteFloat(255)
					net.WriteFloat(255)
					net.WriteFloat(0)
					if my_npc:GetNWString("CustomName")!="" then
						net.WriteString("|FMod|: "..my_npc:GetNWString("CustomName").." follow me!")
					else
						net.WriteString("|FMod|: "..my_npc:GetClass().." follow me!")
					end
				net.Send(self.Owner)
				if IsValid(self.Owner.gfoll) then 
					self.Owner.gfoll:Fire("Deactivate", "", 0)
					self.Owner.gfoll:Fire("Activate", "", 0.1)
				end
				if GetConVarNumber("fmod_followers_speak") > 0 then
					NPCFollRespond(my_npc)
				end
			end
		end
	end

	-- This code keeps someone at one spot.
	if self.Owner:KeyDown(IN_WALK) and (key == IN_RELOAD) and IsValid(tr.Entity) and tr.Entity:IsNPC() and tr.Entity:GetNWBool("FMOD_ImAfterSomeone") and tr.Entity:GetNWString("FMOD_ImFollowing") == self.Owner:Nick()..self.Owner:EntIndex() and tr.Entity:GetName() == self.Owner:Nick()..self.Owner:EntIndex() then
		tr.Entity:SetName("")
		tr.Entity:ClearEnemyMemory() 
		tr.Entity:Fire("stoppatrolling","",0.5) 
		util.AddNetworkString("FMOD.Message")
		net.Start("FMOD.Message")
			net.WriteFloat(255)
			net.WriteFloat(255)
			net.WriteFloat(0)
			if tr.Entity:GetNWString("CustomName")!="" then
				net.WriteString("|FMod|: "..tr.Entity:GetNWString("CustomName").." will hold this spot.")
			else
				net.WriteString("|FMod|: "..tr.Entity:GetClass().." will hold this spot.")
			end
		net.Send(self.Owner)
		if GetConVarNumber("fmod_followers_speak") > 0 then
			NPCStayRespond(tr.Entity)
		end
		if IsValid(self.Owner.gfoll) then
			self.Owner.gfoll:Fire("Deactivate", "", 0)
			self.Owner.gfoll:Fire("Activate", "", 0.1)
		end

	-- This code recalls someone.
	elseif self.Owner:KeyDown(IN_WALK) and (key == IN_RELOAD) and IsValid(tr.Entity) and tr.Entity:IsNPC() and tr.Entity:GetNWBool("FMOD_ImAfterSomeone") and tr.Entity:GetNWString("FMOD_ImFollowing") == self.Owner:Nick()..self.Owner:EntIndex() and tr.Entity:GetName() != self.Owner:Nick()..self.Owner:EntIndex() then
		tr.Entity:SetName(tr.Entity:GetNWString("FMOD_ImFollowing"))
		tr.Entity:ClearEnemyMemory() 
		tr.Entity:Fire("stoppatrolling","",0.5)
		util.AddNetworkString("FMOD.Message")
		net.Start("FMOD.Message")
			net.WriteFloat(255)
			net.WriteFloat(255)
			net.WriteFloat(0)
			if tr.Entity:GetNWString("CustomName")!="" then
				net.WriteString("|FMod|: "..tr.Entity:GetNWString("CustomName").." will follow You now.")
			else
				net.WriteString("|FMod|: "..tr.Entity:GetClass().." will follow You now.")
			end
		net.Send(self.Owner)
		if GetConVarNumber("fmod_followers_speak") > 0 then
			NPCFollRespond(tr.Entity)
		end
		if IsValid(self.Owner.gfoll) then
			self.Owner.gfoll:Fire("Deactivate", "", 0)
			self.Owner.gfoll:Fire("Activate", "", 0.1)
		end
	end
end

function SWEP:Reload()
	-- Does this need to be here?
end

function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
	local vm = self.Owner:GetViewModel()
	if CLIENT && IsValid(vm) then
		self:ResetBonePositions(vm)
		vm:SetColor(Color(255,255,255,1))
		vm:SetMaterial("Debug/hsv")
	end
end

function SWEP:Holster()
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	return true
end

function SWEP:OnRemove()
	self:Holster()
end