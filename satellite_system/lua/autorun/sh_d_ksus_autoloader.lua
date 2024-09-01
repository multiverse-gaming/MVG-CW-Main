//  __   _  __     _ _          __ 
// | _| | |/ /__ _(_) |_ ___   |_ |
// | |  | ' // _` | | __/ _ \   | |
// | |  | . \ (_| | | || (_) |  | |
// | |  |_|\_\__,_|_|\__\___/   | |
// |__|                        |__|
                                                                      
/*
    Coucou.
*/

-- Répertoire racine où se trouvent les fichiers LUA de l'addon
local rootDirectory = "kaito-satellite-uav-system"

-- Fonction pour ajouter un fichier
local function AddFile(File, directory, indent)
    local indentation = string.rep("|   ", indent)
    local prefix = string.lower(string.Left(File, 3))

    if SERVER and prefix == "sv_" then
        include(directory .. File)
        MsgC(Color(43,215,228),indentation .. "| - [S] " .. File .. '\n')
    elseif prefix == "sh_" then
        if SERVER then
            AddCSLuaFile(directory .. File)
            MsgC(Color(43,215,228),indentation .. "| - [S] " .. File .. '\n')
        end
        include(directory .. File)
        MsgC(Color(23,248,23),indentation .. "| - [S/C] " .. File .. '\n') 
    elseif prefix == "cl_" then
        if SERVER then
            AddCSLuaFile(directory .. File)
            MsgC(Color(43,215,228),indentation .. "| - [S] " .. File .. '\n')
        elseif CLIENT then
            include(directory .. File)
            MsgC(Color(197,236,23),indentation .. "| - [C] " .. File..'\n')
        end
    end
end

-- Fonction pour inclure tous les fichiers d'un répertoire
local function IncludeDir(directory, indent)
    directory = directory .. "/"

    local indentation = string.rep("|   ", indent)

    local files, directories = file.Find(directory .. "*", "LUA")

    for _, v in ipairs(files) do
        if string.EndsWith(v, ".lua") then
            AddFile(v, directory, indent)
        end
    end

    for _, v in ipairs(directories) do
        MsgC(Color(65,78,252),indentation .. "| - " .. v .. '\n')
        IncludeDir(directory .. v, indent + 1)
    end
end

local kaitoAscii = {
	"            _ _        ",
	"  /\\ /\\__ _(_) |_ ___  ",
	" / //_/ _` | | __/ _ \\ ",
	"/ __ \\ (_| | | || (_) |",
	"\\/  \\/\\__,_|_|\\__\\___/ ",
    "\n"
}

-- Fonction pour afficher l'art ASCII
function displayAsciiArt(asciiArt)
    for _, line in ipairs(asciiArt) do
        MsgC(Color(65,78,250),line..'\n')
    end
end



MsgC(Color(65,78,250),"---[Kaito's Satellite and UAV System :: Init]---\n")
displayAsciiArt(kaitoAscii)
MsgC(Color(65,78,253),rootDirectory..'\n')
IncludeDir(rootDirectory, 0)





