-----------------------
CustomHUD_Fox = CustomHUD_Fox or {}
CustomHUD_Fox.Loader = CustomHUD_Fox.Loader or {}
CustomHUD_Fox.Loaded = CustomHUD_Fox.Loaded or {}
CustomHUD_Fox.Loaded_Control = CustomHUD_Fox.Loaded_Control or {}
------------------------------
CustomHUD_Fox.Loaded_Control.Loaded = CustomHUD_Fox.Loaded_Control.Loaded or false  -- This is to indicate to start looping to stop normal hl2 hud. TODO fix, kinda scuffy?

function CustomHUD_Fox.Loaded_Control:Load()

	if not FoxLibs.Hook:HookExists("OnScreenSizeChanged", "CustomHUD_Fox.OnScreenSizeChanged") then
		hook.Add("OnScreenSizeChanged", "CustomHUD_Fox.OnScreenSizeChanged", function() 
			CustomHUD_Fox.Loaded_Control:Unload()
			CustomHUD_Fox.Loaded_Control:Load()
		end)
	end



	if CustomHUD_Fox.Loaded_Control.Loaded == true then
		print("[CustomHUD_Fox][Load] Already loaded, refreshing hud now.")

		CustomHUD_Fox.Loaded_Control:Unload()
		CustomHUD_Fox.Loaded_Control:Load()

		return -- Return else causes double loop shit
	else
		CustomHUD_Fox.Loaded_Control.Loaded = true

	end
	
	
	CustomHUD_Fox.Loader:OnStart()





	if CustomHUD_Fox.Loaded.PreInitI ~= nil then
		CustomHUD_Fox.Loaded_Control:RunFunctions(CustomHUD_Fox.Loaded.PreInitI, ScrW(), ScrH())
	end

	if CustomHUD_Fox.Loaded.PreInit ~= nil then
		CustomHUD_Fox.Loaded_Control:RunFunctions(CustomHUD_Fox.Loaded.PreInit, ScrW(), ScrH())
	end

	if CustomHUD_Fox.Loaded.Init ~= nil then
		CustomHUD_Fox.Loaded_Control:RunFunctions(CustomHUD_Fox.Loaded.Init, ScrW(), ScrH())
	end

	if CustomHUD_Fox.Loaded.PostInitI ~= nil then
		CustomHUD_Fox.Loaded_Control:RunFunctions(CustomHUD_Fox.Loaded.PostInitI, ScrW(), ScrH(), false)
	end

	if CustomHUD_Fox.Loaded.PostInit ~= nil then
		CustomHUD_Fox.Loaded_Control:RunFunctions(CustomHUD_Fox.Loaded.PostInit, ScrW(), ScrH(), false)
	end





	hook.Add("PreDrawHUD", "CustomHUD_Fox.PreDrawHUD", function() CustomHUD_Fox.Loaded_Control:Calculate() end)


		
	hook.Add("HUDShouldDraw", "CustomHUD_Fox.HideHud", function(name) return CustomHUD_Fox.Loaded_Control:ShouldDraw(name) end)



	gameevent.Listen( "player_spawn" )
	hook.Add( "player_spawn", "player_spawn_example", function( data ) CustomHUD_Fox.Loaded_Control:Spawn(data.userid) end ) -- TODO MAYBE BAD TO USE??? Not really rn tho
		
end




function CustomHUD_Fox.Loaded_Control:Spawn(UserID)
	if UserID == LocalPlayer():UserID() then
		timer.Simple(1, function() -- TODO : THIS IS MEGA SCUFFED BUT SOLVES ISSUE
			if CustomHUD_Fox.Loaded.Spawn ~= nil then
				CustomHUD_Fox.Loaded_Control:RunFunctions(CustomHUD_Fox.Loaded.Spawn, LocalPlayer())
			end
		end)
	end
end






function CustomHUD_Fox.Loaded_Control:Unload()
	if CustomHUD_Fox.Loaded_Control.Loaded == true then
		
		hook.Remove("PreDrawHUD", "CustomHUD_Fox.PreDrawHUD")

		do -- Unload elements and set to nil
			if CustomHUD_Fox.Loaded.C ~= nil and istable(CustomHUD_Fox.Loaded.C) then
				for i,v in pairs(CustomHUD_Fox.Loaded.C) do
					v:Remove()
				end
			end
			CustomHUD_Fox.Loaded = {} 
		end


		CustomHUD_Fox.Loaded_Control.Loaded = false

	elseif CustomHUD_Fox.Loaded_Control.Loaded == false then
		ErrorNoHalt("Tried to Unload without being loaded.")
	else
		ErrorNoHalt("Loaded value doesn't exist for state.")
	end
end






function CustomHUD_Fox.Loaded_Control:Calculate()
	if CustomHUD_Fox.Loaded.Calculate ~= nil then
		CustomHUD_Fox.Loaded_Control:RunFunctions(CustomHUD_Fox.Loaded.Calculate)
	end
end





function CustomHUD_Fox.Loaded_Control:ShouldDraw(name)

	if CustomHUD_Fox.Loaded_Control.Loaded == true then
		local hud = {"CHudHealth","CHudBattery", "CHudSecondaryAmmo", "CHudAmmo"}
		for k, element in pairs ( hud ) do
			if name == element then
				return false
			end
		end
	end
end



hook.Add("InitPostEntity", "CustomHUD_Fox.InitPostEntity", function()

	CustomHUD_Fox.Loader:Net_RecieveUniqueID()

	CustomHUD_Fox.Loader:RequestUniqueID()

	hook.Add("CustomHUD_Fox", "FinishedGettingUniqueID", function() CustomHUD_Fox.Loaded_Control:Load() end)
	
end)



--[[
	We use this self, as when its in a table for runfunctions it's self will be the enviorment in it (THE TABLE IN THIS CASE).
]]
function CustomHUD_Fox.Loaded_Control:RunFunctions(func, param1, param2, param3, param4, param5)
    if istable(func) then
        for i,v in pairs(func) do
            v(CustomHUD_Fox.Loaded, param1, param2, param3, param4, param5)
        end
    elseif isfunction(func) then
        func(CustomHUD_Fox.Loaded, param1, param2, param3, param4, param5)
    else
        print("[CustomHUD_Fox.Loader][RunFunctions] Isn't function or table [" .. type(func) .. "] " .. ", identifier: " .. tostring(func) .. ", " .. tostring(param1))
    end
end
