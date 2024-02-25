CustomHUD_Fox = CustomHUD_Fox or {}
CustomHUD_Fox.Loader = CustomHUD_Fox.Loader or {}
CustomHUD_Fox.Loaded = CustomHUD_Fox.Loaded or {}
CustomHUD_Fox.Loaded_Control = CustomHUD_Fox.Loaded_Control or {}


hook.Add("PostGamemodeLoaded", "CustomHUD_Loaded.LoadUniqueID", function()
    CustomHUD_Fox.Loader:LoadUniqueID()
    CustomHUD_Fox.Loader:CreateUniqueID_Request()
end)


FoxLibs.Network_Data:CreateNetworkLink("CustomHUD_Fox.UniqueID.Request")
FoxLibs.Network_Data:CreateNetworkLink("CustomHUD_Fox.UniqueID.SendID")


--[[
    Used to find and Load UniqueID onto the system.
]]
function CustomHUD_Fox.Loader:LoadUniqueID()
    local ID = nil

    succ, err = pcall(function() 
        ID = file.Open("customhud/main/customhud_uniqueid.txt", "r", "LUA"):Read()
        
    end)
    
    if not succ then
        if Debug then
            print(err)
        end

        return -- TODO: THIS OK
    end
    

    if ID ~= nil then
        CustomHUD_Fox.Loader.UniqueID = ID
    else
        print("[CustomHUD_Fox][Base] No unique ID found for server.")
    end
    
end

function CustomHUD_Fox.Loader:CreateUniqueID_Request()
    net.Receive("CustomHUD_Fox.UniqueID.Request", function(len, ply)
        net.Start("CustomHUD_Fox.UniqueID.SendID")
            net.WriteString(CustomHUD_Fox.Loader.UniqueID or "nil")

        net.Send(ply)
    end)
end


