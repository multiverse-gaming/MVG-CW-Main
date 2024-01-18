WatchFox = WatchFox or {}
WatchFox.Core = WatchFox.Core or {}

-- Overriding net.Receive
local oldNetReceive = net.Receive or nil


net.Receive = function(name, originalFunc)
    oldNetReceive(name, function(len, ply)
        -- We hook check to see if we should wrap it.
        local shouldWrapNet = hook.Call("watchfox.security.shouldWrapNet", nil, name, ply, len) or false
        
        if shouldWrapNet then
            WatchFox.Core.WrapperContext:New(name, ply, len)
        end
        
        -- Call original function
        originalFunc(len, ply)


        if shouldWrapNet then
            -- Reset the context
            WatchFox.Core.WrapperContext:Reset()
        end
    end)

end

-- Update net.Receivers to use the new net.Receive function
for name, func in pairs(net.Receivers) do
    net.Receive(name, func)
end

-- Overriding net.ReadString
local oldReadStringFunc = net.ReadString or nil

net.ReadString = function()
    local outputString = oldReadStringFunc()

    if WatchFox.Core.WrapperContext:IsWrapped() then
        hook.Call("watchfox.security.readString", nil, outputString)
    end

    return outputString
end
