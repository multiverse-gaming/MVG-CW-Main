

local function LoadFile(path)
    include(path)
end

local function AddFile(path)
    if SERVER then
        AddCSLuaFile(path)
    end
end

local function Combine(path)
    AddFile(path)
    LoadFile(path)
end

local function FileHandler(path) -- Could improve to 1 param, but fine for now.

    local isCL = string.find(path, "cl_")
    local isSV = string.find(path, "sv_")
    local isSH = string.find(path, "sh_")

    local nameStart = nil
    local i = 0


    if isnumber(isCL) then
        nameStart = "cl_"
        i = i + 1
    end

    if isnumber(isSV) then
        nameStart = "sv_"
        i = i + 1

    end

    if isnumber(isSH) then
        nameStart = "sh_"
        i = i + 1

    end

    if i > 1 then
        Error("Filename consists of two phrases for sv_, sh_, cl_")
    end

    if nameStart == "sv_" and SERVER then
        LoadFile(path)
    elseif nameStart == "cl_" then
        if SERVER then
            AddFile(path)
        else
            LoadFile(path)
        end
    elseif nameStart == "sh_" then
        Combine(path)
    else
        -- TODO: Should I error? probs not.
    end
    
end


do
    success, varArg = pcall(function() include("foxLibs/sh_version.lua") end)

    if success == false then
        print("[ERROR] FoxLibs doesn't exist.")
    else
        for i, v in pairs (FoxLibs.Load) do
            FileHandler(v)
            print(v)
        end
    end
end







local function HandleAddingElements(curDirectory)
    local files, directories = file.Find(curDirectory .. "*","LUA")

    for i,v in pairs(files) do
        FileHandler(curDirectory .. v)
    end
    
    if istable(directories) then
        for i,v in pairs(directories) do
            HandleAddingElements(curDirectory .. v .. "/")
        end
    end

end

HandleAddingElements("CustomHUD/")


-- TODO: Use github verison idea

if SERVER then
    resource.AddWorkshop("2736140936")
end




