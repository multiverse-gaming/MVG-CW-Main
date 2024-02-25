FoxLibs = FoxLibs or {}
FoxLibs.File = FoxLibs.File or {}

local internal = internal or {}

internal.FileHasBeenUpdatedTbl = internal.FileHasBeenUpdatedTbl or {}

function FoxLibs.File:FileHasBeenUpdated(id, path, base)

    if internal.FileHasBeenUpdatedTbl[id] == nil then -- If this is nil will create data.
        internal.FileHasBeenUpdatedTbl[id] = false -- This creates a area to store last time.
    end
    
    local curSecondsSince = file.Time(path,base)


    if ( internal.FileHasBeenUpdatedTbl[id] ~= false) and (curSecondsSince >  internal.FileHasBeenUpdatedTbl[id])  then
        internal.FileHasBeenUpdatedTbl[id] = curSecondsSince
        return true 
    elseif  internal.FileHasBeenUpdatedTbl[id] == false then
        internal.FileHasBeenUpdatedTbl[id] = curSecondsSince
        return false
    else
        return false
    end


    -- This shouldnt get to here.
    Error("[FoxLibs][File][FileHasBeenUpdated] Somehow go to this, if you see this error please report.")


end


function FoxLibs.File:Include(name, path)

    local files, dictonary = file.Find(path .. "*","LUA")

    for i,v in pairs(files) do
        if v == name then
            return include(path .. name)
        end
    end
    
    ErrorNoHalt("[FoxLibs][File][Include]Failed to find component therefore cannot load component: " .. name)

    return false
end
