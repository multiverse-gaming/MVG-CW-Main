WatchFox = WatchFox or {}
WatchFox.Core = WatchFox.Core or {}

-- Initialize WrapperContext
WatchFox.Core.WrapperContext = {
    _nameOfNetMessage = nil,
    _nameOfPlySender = nil,
    _lenOfMessage = nil,
} 

-- Define methods for WrapperContext
function WatchFox.Core.WrapperContext:New(nameOfNetMessage, nameOfPlySender, lengthOfMessage)
    self._nameOfNetMessage = nameOfNetMessage 
    self._nameOfPlySender = nameOfPlySender 
    self._lenOfMessage = lengthOfMessage
end

function WatchFox.Core.WrapperContext:IsWrapped()
    return self._nameOfNetMessage ~= nil
end

function WatchFox.Core.WrapperContext:GetNetMessageName()
    return self._nameOfNetMessage
end

function WatchFox.Core.WrapperContext:GetNameOfPlayerSender()
    return self._nameOfPlySender
end

function WatchFox.Core.WrapperContext:GetLengthOfMessage()
    return self._lenOfMessage
end

function WatchFox.Core.WrapperContext:PreventMessage(customContextReason)

    local message = "User: " .. self:GetNameOfPlayerSender():GetName() .. " (" .. self:GetNameOfPlayerSender():SteamID() .. ") has exploited."
    local detailedNetMessageName = "Net Message Name: " .. self:GetNetMessageName()
    local customContextReasonCase = nil 

    if customContextReason then
        customContextReasonCase = "Custom Context Reason: " .. customContextReason
    end
    

    -- INGAME
    WatchFox.Core.Notifications:AdminChat(message)

    timer.Simple(0, function()
        if sam then
            RunConsoleCommand("sam", "freeze", self._nameOfPlySender)
        end

    end)

    -- Console
    print(message)
    print(detailedNetMessageName)

    if customContextReason then
        print(customContextReasonCase)
    end



    error("Erroring stack to prevent explotation")
end


function WatchFox.Core.WrapperContext:Reset()
    self._nameOfNetMessage = nil
    self._nameOfPlySender = nil
    self._lenOfMessage = nil
end
