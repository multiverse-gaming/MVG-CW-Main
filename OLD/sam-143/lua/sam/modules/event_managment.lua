if SAM_LOADED then return end



local sam, command, language = sam, sam.command, sam.language



command.set_category("Event Managment")



command.new("nt")

	:DisallowConsole()

	:SetPermission("nt", "admin")



	:AddArg("player")



	:Help(language.get("nottarget_help"))



	:OnExecute(function(ply, targets)

		for i = 1, #targets do

			local v = targets[i]

			if not v:sam_get_exclusive(ply) then

				v:SetNoTarget(true)

				v:SetNWBool("notarget_mode", true)

				v:SetNWEntity("notarget_mode_player_caused", ply)

			end

		end



		if sam.is_command_silent then return end

		sam.player.send_message(nil, "nottarget", {

			A = ply, T = targets

		})

	end)

:End()



command.new("unnt")

	:DisallowConsole()

	:SetPermission("unnt", "admin")



	:AddArg("player")



	:Help(language.get("un_nottarget_help"))



	:OnExecute(function(ply, targets)

		for i = 1, #targets do

			local v = targets[i]

			if not v:sam_get_exclusive(ply) then

				v:SetNoTarget(false)

				v:SetNWBool("notarget_mode", false)

			end

		end



		if sam.is_command_silent then return end

		sam.player.send_message(nil, "un_nottarget", {

			A = ply, T = targets

		})

	end)

:End()

command.new("eventprimary")

	:Aliases("eventpw")



	:SetPermission("eventprimary", "superadmin")



	:AddArg("player")

	:AddArg("text", {hint = "weapon/entity"})



	:Help(language.get("eventprimary_help"))



	:OnExecute(function(ply, targets, weapon)
		for i = 1, #targets do

			targets[i]:Give(weapon)

			targets[i]:SetNWString("EventPrimary", weapon)

		end


		if sam.is_command_silent then return end
			sam.player.send_message(nil, "eventprimary", {
				A = ply, T = targets, V = weapon
			})
		end
	)
:End()

command.new("eventsecondary")

	:Aliases("eventsw")



	:SetPermission("eventsecondary", "superadmin")



	:AddArg("player")

	:AddArg("text", {hint = "weapon/entity"})



	:Help(language.get("eventsecondary_help"))



	:OnExecute(function(ply, targets, weapon)
		for i = 1, #targets do

			targets[i]:Give(weapon)

			targets[i]:SetNWString("EventSecondary", weapon)

		end


		if sam.is_command_silent then return end
			sam.player.send_message(nil, "eventsecondary", {
				A = ply, T = targets, V = weapon
			})
		end
	)
:End()

command.new("eventhealth")

	:Aliases("eventhp")



	:SetPermission("eventhealth", "superadmin")



	:AddArg("player")

	:AddArg("text", {hint = "amount = 100"})



	:Help(language.get("eventhealth_help"))



	:OnExecute(function(ply, targets, hp)
		for i = 1, #targets do

			targets[i]:SetHealth(hp)
			
			targets[i]:SetMaxHealth(hp)

			targets[i]:SetNWString("EventHealth", hp)

		end


		if sam.is_command_silent then return end
			sam.player.send_message(nil, "eventhealth", {
				A = ply, T = targets, V = hp
			})
		end
	)
:End()

command.new("seteventmodel")

	:Aliases("eventmodel")



	:SetPermission("seteventmodel", "superadmin")



	:AddArg("player")

	:AddArg("text", {hint = "model"})



	:Help(language.get("setmodel_help"))



	:OnExecute(function(ply, targets, model)

		if not util.IsValidModel(model) then

			if sam.is_command_silent then return end

			sam.player.send_message(nil, "no_setmodel", {

				A = ply, T = targets, V = model

			})

		else

			for i = 1, #targets do

				targets[i]:SetModel(model)

				targets[i]:SetNWString("EventModel", model)

			end



			if sam.is_command_silent then return end

			sam.player.send_message(nil, "seteventmodel", {

				A = ply, T = targets, V = model

			})

		end



	end)

:End()


if SERVER then

	hook.Add("PlayerSpawn", "Sam_Save_notarget", function(ply)

		if (ply:GetNWBool("notarget_mode") == true) then -- If NW Var is true

			ply:SetNoTarget(true) -- Set them to be no-targeted again.

			local playerWhoCausedThis = ply:GetNWEntity("notarget_mode_player_caused", nil)



			if playerWhoCausedThis != nil and IsValid(playerWhoCausedThis) then

				return

			end

		end

	end)

end