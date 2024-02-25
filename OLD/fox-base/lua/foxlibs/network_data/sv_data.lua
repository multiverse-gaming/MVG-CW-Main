FoxLibs = FoxLibs or {}
FoxLibs.Network_Data = FoxLibs.Network_Data or {}




--[[
    Output: 
        1) Returns if completed it first time.
]]
function FoxLibs.Network_Data:CreateNetworkLink(networkString, dontWarn)
    local networkV = util.NetworkStringToID(networkString)

    if networkV == 0 and isbool(dontWarn) and dontWarn then
        if Debug_Fox then
            ErrorNoHalt("[Foxlibs][Network_Data][CreateNetworkLink] Failed to create network string as already exist's.")
        end
        return false
    else
        util.AddNetworkString(networkString)
        return true
    end

end