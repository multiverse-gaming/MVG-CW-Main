

local function isSuspiciousMessage(stringContent)

    for _, pattern in ipairs(WatchFox.Modules.Net.Config.SuspiciousStringPatterns) do
        if string.find(stringContent, pattern) then
            return true
        end
    end

    return false
end

hook.Add("watchfox.security.shouldWrapNet", "string-injection.shouldWrapNet", function( name, ply, len)

    local specificDataConfigEntry = WatchFox.Modules.Net.Config:GetNetMessageConfig(name)

    if( specificDataConfigEntry.CheckType == CHECKTYPE.MUST ) then
        
        return true
        
    end
    
    
end)


hook.Add("watchfox.security.readString", "readString", function(stringContent)

    if WatchFox.Core.WrapperContext:IsWrapped() and isSuspiciousMessage(stringContent) then
        WatchFox.Core.WrapperContext:PreventMessage("String found suspcious patterns content: " .. stringContent)
    end

end)