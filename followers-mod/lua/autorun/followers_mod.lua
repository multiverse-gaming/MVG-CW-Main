if !ConVarExists("fmod_enable") then
   CreateConVar("fmod_enable", '1', (FCVAR_ARCHIVE), "Enable or Disable followers mod.", 0, 1)
end
if !ConVarExists("fmod_min_call_dist") then
   CreateConVar("fmod_min_call_dist", '80', (FCVAR_ARCHIVE), "Minimal distance to call for follower.", 0, 9999)
end
if !ConVarExists("fmod_min_spot_dist") then
   CreateConVar("fmod_min_spot_dist", '2000', (FCVAR_ARCHIVE), "Minimal distance to spot enemies for your followers.", 0, -1)
end
--
if !ConVarExists("fmod_allow_collisions") then
   CreateConVar("fmod_allow_collisions", '1', (FCVAR_ARCHIVE), "If 0, following you NPCs will not collide with you.", 0, 1)
end
--
if !ConVarExists("fmod_allow_ff") then
   CreateConVar("fmod_allow_ff", '1', (FCVAR_ARCHIVE), "If 1, it will prevent the friendly fire.", 0, 1)
end
if !ConVarExists("fmod_buff_damage") then
   CreateConVar("fmod_buff_damage", '0', (FCVAR_ARCHIVE), "Set damage of your followers.", 0, 1)
end
if !ConVarExists("fmod_buff_resistance") then
   CreateConVar("fmod_buff_resistance", '0', (FCVAR_ARCHIVE), "Set resistance of your followers.", 0, -1)
end
if !ConVarExists("fmod_buff_proficiency") then
   CreateConVar("fmod_buff_proficiency", '2', (FCVAR_ARCHIVE), "Set weapon proficiency of your followers.", 0, 10)
end
if !ConVarExists("fmod_auto_teleport") then
   CreateConVar("fmod_auto_teleport", '0', (FCVAR_ARCHIVE), "If your followers can't reach you, they will teleport at your position (behind you).", 0, 1)
end
if !ConVarExists("fmod_followers_enter_vehicles") then
   CreateConVar("fmod_followers_enter_vehicles", '1', (FCVAR_ARCHIVE), "Allow Your followers to enter vehicles.", 0, 1)
end
if !ConVarExists("fmod_vehicle_max_dist") then
   CreateConVar("fmod_vehicle_max_dist", '120', (FCVAR_ARCHIVE), "How close Your followers has to be to enter a vehicle/seat.", 0, -1)
end

hook.Add("OnEntityCreated", "FMOD_GiveWeapons", function(ent)
ent:SetNWString("FiLzO_WeaponType", GetConVarString("gmod_npcweapon"))
end)

if(CLIENT)then
	if !ConVarExists("fmod_chat_support") then	
	   CreateClientConVar("fmod_chat_support", '1', (FCVAR_ARCHIVE), "Enable additional informations in chat.", 0, 1)
	end

	-- This is what's outputting the various messages into your chat.
	net.Receive("FMOD.Message", function()
		if GetConVarNumber("fmod_chat_support") > 0 then
			local ColorR = net.ReadFloat()
			local ColorG = net.ReadFloat()
			local ColorB = net.ReadFloat()
			local Text = net.ReadString()
			chat.AddText(Color(ColorR, ColorG, ColorB), Text)
		end
	end)
end
 
if(SERVER)then
	-- Adds a follower. Were they extremely busy and couldn't just write "AddFollower"?
	-- In both of these, we might want to get rid of the Custom/Special stuff. Additonally, the logging
	-- to could be changed to "This person is now following you!" if we wanted. Useful for testing though.
	function AddFoll(ent, ply)
		ent:SetNWBool("FMOD_ImAfterSomeone", true)
		if ply then
			ent:SetNWString("FMOD_ImFollowing", ply:Nick()..ply:EntIndex())
			ent:SetNWEntity("FMOD_MyTarget", ply)
			ent:SetName(ply:Nick()..ply:EntIndex())
			ent:Fire("stoppatrolling","",0.5)
			ply:SetNWEntity("FMOD_MyFollower", ent)
			util.AddNetworkString("FMOD.Message")
			net.Start("FMOD.Message")
				net.WriteFloat(100)
				net.WriteFloat(255)
				net.WriteFloat(0)
				if ent:GetNWString("CustomName")!="" then
					net.WriteString(ent:GetNWString("CustomName").." has joined your squad.")
				else
					net.WriteString("Friendly has joined your squad.")
				end
			net.Send(ply)
		end
		ent.FMODanimsTable = table.ToString(ent:GetSequenceList())
		ent:SetCustomCollisionCheck(true)
		-- Jump, Climb, Use things, open doors, open other doors, and can form squads.
		ent:CapabilitiesAdd(2)
		ent:CapabilitiesAdd(8)
		ent:CapabilitiesAdd(256)
		ent:CapabilitiesAdd(1024)
		ent:CapabilitiesAdd(2048)
		ent:CapabilitiesAdd(67108864)
		ent:Fire("setsquad","playersquad_"..ply:Nick()..ply:EntIndex(),0)
		ent:Fire("EnableArmorRecharge","",0)
	end

	-- Removes a Foll.
	function RemFoll(ent, ply)
		ent:SetNWBool("FMOD_ImAfterSomeone", false)
		ent:SetNWString("FMOD_ImFollowing", nil)
		ent:SetName("")
		if ply then
			ply:SetNWEntity("FMOD_MyFollower", nil)
			util.AddNetworkString("FMOD.Message")
			net.Start("FMOD.Message")
				net.WriteFloat(255)
				net.WriteFloat(100)
				net.WriteFloat(0)
				if ent:GetNWString("CustomName")!="" then
					net.WriteString(ent:GetNWString("CustomName").." has left your squad.")
				else
					net.WriteString("Friendly has left your squad.")
				end
			net.Send(ply)
		end
		ent:SetNWEntity("FMOD_MyTarget", nil)
		ent:SetCustomCollisionCheck(false)
		ent:Fire("setsquad","",0)
		ent:Fire("DisableArmorRecharge","",0)
		ent.CollisionBounds = Vector(13,13,72)
		local hull = ent:GetHullType()
		ent:SetSolid(SOLID_BBOX)
		ent:SetPos(ent:GetPos()+ent:GetUp()*6)
		ent:SetHullType(hull)
		ent:SetHullSizeNormal()
		ent:SetCollisionBounds(ent.CollisionBounds,Vector(ent.CollisionBounds.x *-1,ent.CollisionBounds.y *-1,0))
		ent:DropToFloor()
	end

	-- This has the follower respond to you. Seeing as we have droids/clones+civs as CP/citizens, how about we don't?
	function NPCFollRespond(ent)
		local class = ent:GetClass()
		if ent:GetNWString("FMOD_Custom_FollowMe") != "" then
			ent:EmitSound(ent:GetNWString("FMOD_Custom_FollowMe"))
		else
			if class == "npc_combine_s" then
				ent:EmitSound("FMod_FollowMe.CombineSoldier")
			elseif class == "npc_metropolice" then
				ent:EmitSound("FMod_FollowMe.Metropolice")
			elseif class == "npc_alyx" then
				print("kek")
				ent:EmitSound("FMod_FollowMe.Alyx")
			elseif class == "npc_barney" then
				ent:EmitSound("FMod_FollowMe.Barney")
			elseif class == "npc_citizen" then
				if string.find( string.lower( ent:GetModel() ), "female") then
					ent:EmitSound("FMod_FollowMe.CitizenFemale")
				else
					ent:EmitSound("FMod_FollowMe.CitizenMale")
				end
			elseif class == "npc_vortigaunt" then
				ent:EmitSound("FMod_FollowMe.Vort")
			elseif class == "npc_hunter" and ent:GetNWBool("FMOD_Huntey") then
				ent:EmitSound("FMod_FollowMe.Huntey")
			else
				ent:EmitSound("FMod_FollowMe.Other")
			end
		end
	end

	-- Different voice line.
	function NPCCopyRespond(ent)
		if ent:GetNWString("FMOD_Custom_Copy") != "" then
			ent:EmitSound(ent:GetNWString("FMOD_Custom_Copy"))
		else
			local class = ent:GetClass()
			if class == "npc_combine_s" then
				ent:EmitSound("FMod_Copy.CombineSoldier")
			elseif class == "npc_metropolice" then
				ent:EmitSound("FMod_Copy.Metropolice")
			elseif class == "npc_alyx" then
				ent:EmitSound("FMod_Copy.Alyx")
			elseif class == "npc_barney" then
				ent:EmitSound("FMod_Copy.Barney")
			elseif class == "npc_citizen" then
				if string.find( string.lower( ent:GetModel() ), "female") then
					ent:EmitSound("FMod_Copy.CitizenFemale")
				else
					ent:EmitSound("FMod_Copy.CitizenMale")
				end
			elseif class == "npc_vortigaunt" then
				ent:EmitSound("FMod_Copy.Vort")
			elseif class == "npc_hunter" and ent:GetNWBool("FMOD_Huntey") then
				ent:EmitSound("FMod_Copy.Huntey")
			else
				ent:EmitSound("FMod_Copy.Other")
			end
		end
	end

	-- Different voice line.
	function NPCStayRespond(ent)
		if ent:GetNWString("FMOD_Custom_StayHere") != "" then
			ent:EmitSound(ent:GetNWString("FMOD_Custom_StayHere"))
		else
			local class = ent:GetClass()
			if class == "npc_combine_s" then
				ent:EmitSound("FMod_StayHere.CombineSoldier")
			elseif class == "npc_metropolice" then
				ent:EmitSound("FMod_StayHere.Metropolice")
			elseif class == "npc_alyx" then
				ent:EmitSound("FMod_StayHere.Alyx")
			elseif class == "npc_barney" then
				ent:EmitSound("FMod_StayHere.Barney")
			elseif class == "npc_citizen" then
				if string.find( string.lower( ent:GetModel() ), "female") then
					ent:EmitSound("FMod_StayHere.CitizenFemale")
				else
					ent:EmitSound("FMod_StayHere.CitizenMale")
				end
			elseif class == "npc_vortigaunt" then
				ent:EmitSound("FMod_StayHere.Vort")
			elseif class == "npc_hunter" and ent:GetNWBool("FMOD_Huntey") then
				ent:EmitSound("FMod_StayHere.Huntey")
			else
			ent:EmitSound("FMod_StayHere.Other")
			end
		end
	end

	-- Removes npc's following you when you die.
	hook.Add("PlayerDeath", "FMOD_PlayerDeath", function(ply, weapon, killer)
		if IsValid(ply.gfoll) then SafeRemoveEntity(ply.gfoll) end
		for _,my_npc in pairs(ents.GetAll()) do
			if my_npc and my_npc:IsNPC() and my_npc:GetNWBool("FMOD_ImAfterSomeone") and my_npc:GetNWString("FMOD_ImFollowing") == ply:Nick()..ply:EntIndex() then
				RemFoll(my_npc, ply)
			end
		end
	end)
end