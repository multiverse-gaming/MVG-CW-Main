BF2_Scoreboard = {}

hook.Add("SummeLibrary.Loaded", "RegisterBattlefront II Scoreboard", function()
    SummeLibrary:Register({
        class = "bf2_scoreboard",
        name = "Battlefront II Scoreboard",
        color = Color(251,255,0),
    })
end)

hook.Add("Battlefront II Scoreboard.Registered", "34343", function()
    local rootDir = "bf2_scoreboard"

    local function AddFile(File, dir)
        local fileSide = string.lower(string.Left(File , 3))

        if SERVER and fileSide == "sv_" then
            include(dir..File)
            SummeLibrary:Print("bf2_scoreboard", "> "..dir..File)
        elseif fileSide == "sh_" then
            if SERVER then 
                AddCSLuaFile(dir..File)
            end
            include(dir..File)
            SummeLibrary:Print("bf2_scoreboard", "> "..dir..File)
        elseif fileSide == "cl_" then
            if SERVER then 
                AddCSLuaFile(dir..File)
            elseif CLIENT then
                include(dir..File)
                SummeLibrary:Print("bf2_scoreboard", "> "..dir..File)
            end
        end
    end

    local function IncludeDir(dir)
        dir = dir .. "/"
        local File, Directory = file.Find(dir.."*", "LUA")

        for k, v in ipairs(File) do
            if string.EndsWith(v, ".lua") then
                AddFile(v, dir)
            end
        end
        
        for k, v in ipairs(Directory) do
            IncludeDir(dir..v)
        end

    end
    IncludeDir(rootDir)
end)