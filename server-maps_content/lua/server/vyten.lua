if SERVER then

	if not vyten_snow then vyten_snow = 0 end
	if not vyten_fog then vyten_fog = 0 end
	
	-- Snowfall
	if CALLER:GetName()=="vyten_snow_enable" then
		if TRIGGER_PLAYER:IsAdmin() then
			if vyten_snow == 0 then
				PrintMessage( HUD_PRINTTALK , "Snowfall enabled by " .. TRIGGER_PLAYER:GetName() .. ".")
				local particle = ents.FindByName("particle_system")
				for i=1, #particle do particle[i]:Fire("Start",1)
				vyten_snow = 1 end
			elseif vyten_snow == 1 then
				TRIGGER_PLAYER:PrintMessage( HUD_PRINTTALK , "Snowfall is already enabled.")
			end
		else
			TRIGGER_PLAYER:PrintMessage( HUD_PRINTTALK , "You are not an admin.")
		end
	end

	if CALLER:GetName()=="vyten_snow_disable" then
		if vyten_snow == 1 then
			PrintMessage( HUD_PRINTTALK , "Snowfall disabled by " .. TRIGGER_PLAYER:GetName() .. ".")
			local particle = ents.FindByName("particle_system")
			for i=1, #particle do particle[i]:Fire("Stop",1)
			vyten_snow = 0 end
		elseif vyten_snow == 0 then
			TRIGGER_PLAYER:PrintMessage( HUD_PRINTTALK , "Snowfall is already disabled.")
		end
	end
	
	--[[
	-- Fog control
		
	if CALLER:GetName()=="vyten_fog_enable" then
		if TRIGGER_PLAYER:IsAdmin() then
			if vyten_fog == 0 then
				PrintMessage( HUD_PRINTTALK , "View distance increased by " .. TRIGGER_PLAYER:GetName() .. ".")
				local fog = ents.FindByName("vyten_fog_controller")
				--local sky = ents.FindByClass("sky_camera")
				for i=1, #fog do fog[i]:Fire("SetEndDist",32000) fog[i]:Fire("SetFarZ",32512)
				--sky[1]:Fire("EndDist",32000)
				vyten_fog = 1 end
			elseif vyten_fog == 1 then
				TRIGGER_PLAYER:PrintMessage( HUD_PRINTTALK , "View distance is already increased.")
			end
		else
			TRIGGER_PLAYER:PrintMessage( HUD_PRINTTALK , "You are not an admin.")
		end
	end

	if CALLER:GetName()=="vyten_fog_disable" then
		if TRIGGER_PLAYER:IsAdmin() then
			if vyten_fog == 1 then
				PrintMessage( HUD_PRINTTALK , "View distance decreased by " .. TRIGGER_PLAYER:GetName() .. ".")
				local fog = ents.FindByName("vyten_fog_controller")
				--local sky = ents.FindByClass("sky_camera")
				for i=1, #fog do fog[i]:Fire("SetEndDist",12000) fog[i]:Fire("SetFarZ",12512)
				--sky[1]:Fire("SetEndDist",12000)
				vyten_fog = 0 end
			elseif vyten_fog == 0 then
				TRIGGER_PLAYER:PrintMessage( HUD_PRINTTALK , "View distance is already decreased.")
			end
		else
			TRIGGER_PLAYER:PrintMessage( HUD_PRINTTALK , "You are not an admin.")
		end
	end
	
	]]--
	
end