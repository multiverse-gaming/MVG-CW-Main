local allowed_jobs = {}



defcon_level = 5



local function change_defcon(ply, args)


	if args == "" then return "" end



	if not tonumber(args) then

		return ""

	end





	if (not( ( allowed_jobs[ply:Team()] == true) or (ply:IsSuperAdmin()) )) then

		if (not( ( allowed_jobs[ply:Team()] == true))) then
			ply:PrintMessage( HUD_PRINTTALK, "[WARNING]: You changed HUD via superadmin permissions. " )
		end

		return ""

	end




	local level = tonumber(args)

	if level > 0 and level < 6 then

		print(level)

		net.Start("defcon_changeLevel")

		net.WriteUInt(level, 3)

		net.Broadcast()


	end



	return ""

end



hook.Add( "loadCustomDarkRPItems", "Defcon_LoadAfterDarkRP", function()

	DarkRP.declareChatCommand({

		command = "defcon",

		description = "Change Current Defcon",

		delay = 1.5

	})


	if SERVER then
		DarkRP.defineChatCommand("defcon", change_defcon)
	end


	local succ, err = pcall(function()
		allowed_jobs = {

			[TEAM_GRANDADMIRAL] = true,

			[TEAM_FLEETADMIRAL] = true,

			[TEAM_FLEETMEMBERSNR] = true,

			[TEAM_FLEETMEMBER] = true,

			[TEAM_FLEETRECRUIT] = true,

			[TEAM_SUPREMEGENERAL] = true,

			[TEAM_BATTALIONGENERAL] = true,

			[TEAM_ASSISTANTBATTALIONGENERAL] = true,
			
			[TEAM_FLEET_MAVERICK] = true,

			[TEAM_FLEET_SFOFC] = true,

			[TEAM_FLEET_COI] = true, 

			[TEAM_FLEET_IO] = true,

			[TEAM_FLEET_DRD] = true,

			[TEAM_FLEET_RD] = true,

			[TEAM_501STGENERAL] = true,

			[TEAM_212THGENERAL] = true,

			[TEAM_GREENGENERAL] = true,

			[TEAM_CGGENERAL] = true,

			[TEAM_GMGENERAL] = true,

			[TEAM_ARCGENERAL] = true,

			[TEAM_CEGENERAL] = true,

			[TEAM_MEDICALGENERAL] = true,

			[TEAM_SOD] = true,

			[TEAM_EH] = true,

			[TEAM_RCGENERAL] = true,

			[TEAM_501STCOMMANDER] = true,

			[TEAM_212THCOMMANDER] = true,

			[TEAM_GREENCOMMANDER] = true,

			[TEAM_CGCOMMANDER] = true,

			[TEAM_GMCOMMANDER] = true,

			[TEAM_ARCCOMMANDER] = true,

			[TEAM_CECOMMANDER] = true,

			[TEAM_ARCCOLT] = true,

			[TEAM_RCBOSS] = true,

			[TEAM_MEDICALDIRECTOR] = true,

			[TEAM_JEDIGRANDMASTER] = true,
			[TEAM_JEDIGENERALWINDU] = true,
			[TEAM_JEDIGENERALSKYWALKER] = true,
			[TEAM_JEDIGENERALOBI] = true,
			[TEAM_JEDIGENERALTANO] = true,
			[TEAM_JEDIGENERALPLO] = true,
			[TEAM_JEDIGENERALKIT] = true,
			[TEAM_JEDIGENERALAAYLA] = true,
			[TEAM_JEDIGENERALSHAAK] = true,
			[TEAM_JEDIGENERALADI] = true,
			[TEAM_JEDIGENERALVOS] = true,
			[TEAM_501STMCOMMANDER] = true, // 501st MCO
			[TEAM_212THMCOMMANDER] = true, // 212th MCO
			[TEAM_GREENMCOMMANDER] = true, // GC MCO
			[TEAM_CGMCOMMANDER] = true,    // Shock MCO
			[TEAM_GMMCOMMANDER] = true,    // GM MCO
			[TEAM_ARCMCOMMANDER] = true,   // 104th MCO
			[TEAM_CEMCOMMANDER] = true,    // 327th MCO
			[TEAM_ARCMC] = true,           // ARC MCO
			[TEAM_RCMCO] = true,           // RC MCO
			[TEAM_MEDICALMCO] = true     // Medic MCO
		}

	end)

	if not succ then
		print("[SH_Defcon_Command] Failed to load allow_jobs due to the error: ")
		print(err)
	end

end)


if SERVER then
	util.AddNetworkString("defcon_changeLevel")
end


net.Receive("defcon_changeLevel", function(len, ply)
	defcon_level = net.ReadUInt(3)

	print("hiwdwadwa")
end)
