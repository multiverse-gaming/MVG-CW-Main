CustomHUD_Fox = CustomHUD_Fox or {}
CustomHUD_Fox.Loader = CustomHUD_Fox.Loader or {}

local internal = internal or {}

function CustomHUD_Fox.Loader:GetConfig(name)
    local uniqueID = CustomHUD_Fox.Loader.UniqueID
    local config

    local configType = internal:HudHasConfig(name, uniqueID)

    if configType == 2 then
        config =  FoxLibs.File:Include(name .. "_" .. uniqueID .. ".lua", "customhud/config/huds/") 
    elseif configType == 1 then
        config = FoxLibs.File:Include(name .. ".lua", "customhud/config/huds/") 
    elseif configType == 0 then
        config = {} -- No config available. 
    end

    return config
end

--[[
    RETURNS CONDITION TO USE:
    2 -- Has unique config. (Related to community)
    1 -- Has normal config.
    0 -- Has no config.

    PREWARNING: UNIQUEID's CANNOT BE CAPITALISED.
]]
function internal:HudHasConfig(name, uniqueID)

    -- TODO VERIFY UNIQUEID?

    local files, dictonary = file.Find("customhud/config/huds/*","LUA")

    if uniqueID != nil then
        for i,v in pairs(files) do
            if isnumber(string.find(v, name .. "_" .. uniqueID .. ".lua")) then
                return 2
            end
        end
    end


    for i,v in pairs(files) do
        if isnumber(string.find(v, name)) then
            return 1
        end
    end

    return 0
end


--[[
    Don't include cl part.
]]
function CustomHUD_Fox.Loader:ComponentExists(name)
    local files, directories = file.Find("customhud/huds/*","LUA")

    for i,v in pairs(files) do
        if "cl_" .. name .. ".lua" == v then
            return true
        end
    end

    return false
end


--[[
    I could turn this into a more general function but might seem useless?
]]
function CustomHUD_Fox.Loader.RequestAllowedModules(len, ply)
    
    if SERVER and (not FoxLibs.Network_Data:IsExistingNetworkString("CustomHUD_Fox.Request.AllowedModules")) then
        FoxLibs.Network_Data:CreateNetworkLink("CustomHUD_Fox.Request.AllowedModules")
        net.Receive("CustomHUD_Fox.Request.AllowedModules", CustomHUD_Fox.Loader.RequestAllowedModules)

    end

    if CLIENT then
        if len ~= nil then
            return (net.ReadTable()) -- This will return to hook...
        end

        net.Start("CustomHUD_Fox.Request.AllowedModules")
        net.SendToServer()
    else
        net.Start("CustomHUD_Fox.Request.AllowedModules")
            net.WriteTable(CustomHUD_Fox.Loader.OnlineDataLoad)
        net.Send(ply)
    end
end
