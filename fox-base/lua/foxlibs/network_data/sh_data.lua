FoxLibs = FoxLibs or {}
FoxLibs.Network_Data = FoxLibs.Network_Data or {}

function FoxLibs.Network_Data:IsExistingNetworkString(networkString)
    local networkV = util.NetworkStringToID(networkString)

    if networkV == 0 then
        return false
    else
        return true
    end

end