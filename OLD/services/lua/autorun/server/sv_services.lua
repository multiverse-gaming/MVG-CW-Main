

AddCSLuaFile("autorun/client/cl_services.lua")

AddCSLuaFile("sh_services_config.lua")

--include("sh_services_config.lua")


util.AddNetworkString("services_open")

util.AddNetworkString("services_request")

util.AddNetworkString("services_receive")

util.AddNetworkString("services_accept")

util.AddNetworkString("services_location")

util.AddNetworkString("services_updatenums")

util.AddNetworkString("serivces_notification")





hook.Add("PlayerSay", "servicesCommand", function(sender, text, teamchat)



	

	if text == CONFIG_SERVICES.ChatCommand and sender:Alive() or text == CONFIG_SERVICES.ChatCommand2 and sender:Alive()  then



		if sender.calling and CurTime() - 60 > sender.calling or not sender.calling then 
			local senderPos = sender:GetPos()

			net.Start("services_open")


			net.WriteVector(senderPos)
			
			

			net.Send(sender)



		elseif sender.calling and CurTime() - 60 < sender.calling then



			sender:ChatPrint("Please wait " .. math.Round(sender.calling - (CurTime() - 60))  .. " seconds before making another call.")



		end 

	

	end





end)



function updateTeamInfo()

	timer.Create("UpdatePlayerServices.Update", 10, 0, function()

		for g,v in pairs(CONFIG_SERVICES.Settings) do

			CONFIG_SERVICES.Settings[g].plyOnline = 0

			for k, p in pairs(player.GetAll()) do 

				if table.HasValue(CONFIG_SERVICES.Settings[g].Teams, p:Team()) then

					CONFIG_SERVICES.Settings[g].plyOnline = CONFIG_SERVICES.Settings[g].plyOnline + 1
				end
			end
		end
		net.Start("services_updatenums")

		net.Broadcast()
	end)
end

updateTeamInfo()


local doneBefore = false
net.Receive("services_request", function(len,ply)
	if doneBefore == false then
		include("sh_services_config.lua")
		doneBefore = true
	end

	local Location = net.ReadVector()

	

	local Group = net.ReadString()

	

	local Message = net.ReadString()


	ply.calling = CurTime() 


	timer.Simple(CONFIG_SERVICES.CoolDown, function()



		if IsValid(ply) then

			ply.calling = nil

		end 



	end)

	if CONFIG_SERVICES.Settings[Group].CustomCheck(ply) then
			
			

			for k, v in pairs(player.GetAll()) do 
				

				if table.HasValue(CONFIG_SERVICES.Settings[Group].Teams, v:Team()) and v != ply then
					net.Start("services_receive")

					net.WriteString(Message)

					net.WriteVector(Location)

					net.WriteEntity(ply)

					net.Send(v)

					

				end

			

			end



			if not CONFIG_SERVICES.UseDefaultNotifications then

			

				Notification911(CONFIG_SERVICES.Confirmation, ply)



			else

			

				DarkRP.notify(ply, 2, 3.5, CONFIG_SERVICES.Confirmation)

			

			end

		

	else

		

		if not CONFIG_SERVICES.UseDefaultNotifications then

		

			if ply:getDarkRPVar("money") < CONFIG_SERVICES.Settings[Group].price then

			

			Notification911(CONFIG_SERVICES.CantAfford, ply)

			

			else

			

			Notification911(CONFIG_SERVICES.Settings[Group].FailMessage, ply)

			

			end

		



		else

		

		

			if ply:getDarkRPVar("money") < CONFIG_SERVICES.Settings[Group].price then

			

				DarkRP.notify(ply, 2, 3.5, CONFIG_SERVICES.CantAfford)

			

			else

			

				DarkRP.notify(ply, 2, 3.5, CONFIG_SERVICES.Settings[Group].FailMessage)

			

			end

		

		end

		

	end



end)



local function notifyAdmin(message)



	for k,v in pairs(player.GetAll()) do

		if v:IsAdmin() then

			v:ChatPrint(message)

		end 

	end 



end 



local CurTime = CurTime



local spamCooldowns = {}

local interval = .1



local function spamCheck(pl, name)

    if spamCooldowns[pl:SteamID()] then

        if spamCooldowns[pl:SteamID()][name] then

            if spamCooldowns[pl:SteamID()][name] > CurTime() then

                return false

            else

                spamCooldowns[pl:SteamID()][name] = CurTime() + interval

                return true

            end

        else

            spamCooldowns[pl:SteamID()][name] = CurTime() + interval

            return true

        end

    else

        spamCooldowns[pl:SteamID()] = {}

        spamCooldowns[pl:SteamID()][name] = CurTime() + interval



        return true 

    end

end







net.Receive("services_accept", function(len,ply)
	if not spamCheck(ply, "services_accept") then return end 
	local Message = net.ReadString()

	local Location = net.ReadVector()

	local OriginalSender = net.ReadEntity()

	if not OriginalSender.calling == nil then return end
	if Message == "Nice security, retards xd" then

		notifyAdmin("SERVICES: " .. ply:GetName() .. " is abusing net messages and should be banned immediately!")

	end 
	net.Start("services_location")

	net.WriteString(Message)

	net.WriteVector(Location)

	net.WriteEntity(OriginalSender)

	net.Send(ply)

	

	if not CONFIG_SERVICES.UseDefaultNotifications then

	

		Notification911(string.Left(ply:Name(), 10)..CONFIG_SERVICES.CallAccepted, OriginalSender)

	

	else

	

		DarkRP.notify(OriginalSender, 2, 3.5, ply:Name()..CONFIG_SERVICES.CallAccepted)

	

	end



end)



function Notification911(Text, ply)



	net.Start("serivces_notification")

	net.WriteString(Text)

	net.Send(ply)





end