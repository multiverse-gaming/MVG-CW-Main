local VARS = {}

function RDV.LIBRARY.SetVar(addon, key, val)
    VARS[addon] = VARS[addon] or {}
    VARS[addon][key] = val
end

function RDV.LIBRARY.GetVar(addon, key)
    if !VARS[addon] or !VARS[addon][key] then
        return false
    end

    return VARS[addon][key]
end