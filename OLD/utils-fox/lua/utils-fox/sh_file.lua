if FOX_UTILS_LOADED then return end

FoxUtils = FoxUtils or {}
FoxUtils.File = FoxUtils.File or {}

function FoxUtils.File.Load(folderPath) 
    local files, directories = file.Find(folderPath .. "/*", "LUA")

    if istable(files) then
        for _, f in ipairs(files) do
            local filePath = folderPath .. "/" .. f
    
            if string.StartWith(f, "cl_") then
                if SERVER then
                    AddCSLuaFile(filePath)
                else
                    include(filePath)
                end
            elseif string.StartWith(f, "sv_") then
                if SERVER then
                    include(filePath)
                end
            elseif string.StartWith(f, "sh_") then
                if SERVER then
                    AddCSLuaFile(filePath)
                end
                include(filePath)
            else
                print("Warning: File '" .. filePath .. "' does not have a valid prefix (sv_, sh_, cl_).")
            end
        end
    end
    

    if istable(directories) then
        for _, dir in ipairs(directories) do
            FoxUtils.File.Load(folderPath .. "/" .. dir)  -- Recursively load directories
        end
    end

end
