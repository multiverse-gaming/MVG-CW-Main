FoxLibs = FoxLibs or {}
FoxLibs.Hook = FoxLibs.Hook or {}


-- Hook Exists?

--[[
    Returns true if hook exists, false if not.
]]
function FoxLibs.Hook:HookExists(eventName, identifier)
    local curHookTable = hook.GetTable()

    if curHookTable[eventName] == nil then
        return false
    end

    if curHookTable[eventName][identifier] == nil then
        return false 
    end

    return true
end