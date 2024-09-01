//  __   _  __     _ _          __ 
// | _| | |/ /__ _(_) |_ ___   |_ |
// | |  | ' // _` | | __/ _ \   | |
// | |  | . \ (_| | | || (_) |  | |
// | |  |_|\_\__,_|_|\__\___/   | |
// |__|                        |__|
                                                                      
/*
    Coucou.
*/

if SERVER then
    ksusUtils = ksusUtils or {}
    ksusDataHolder = ksusDataHolder or {} 

    function ksusRegisterNetworkString(stringList)
        for _, str in ipairs(stringList) do
            MsgC(Color(43,215,228), "|   | - " .. str .. '>> added to net messages registry \n')
            util.AddNetworkString(str)
        end
    end

    ksusUtils.registerNWStrings = ksusRegisterNetworkString 

    function ksusSecurityCheckForWeap(ply,weapClass)
        return ply:GetActiveWeapon():GetClass() == weapClass
    end
    
    ksusUtils.securityNetInjectionWeapCheck = ksusSecurityCheckForWeap
    

end


if CLIENT then
    
end