AddCSLuaFile()

-- foxLibs
FoxLibs = FoxLibs or {}
FoxLibs.Load = {}

local function HandleAddingElements(curDirectory)
    local files, directories = file.Find(curDirectory .. "*","LUA")

    for i,v in pairs(files) do
        table.insert(FoxLibs.Load, curDirectory .. v)
    end
    
    if istable(directories) then
        for i,v in pairs(directories) do
            HandleAddingElements(curDirectory .. v .. "/")
        end
    end

end

HandleAddingElements("foxlibs/")

