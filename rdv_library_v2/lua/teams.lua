if SERVER then AddCSLuaFile() end
teams = {
    Generals = { 
        "Supreme General", 
        "Battalion General", 
        "Assistant General",
        "Combat Engineer General", 
        "501st General", 
        "212th General", 
        "Green Company General", 
        "Shock General", 
        "Coruscant Guard General", 
        "Galactic Marines General", 
        "104th General", 
        "ARC General", 
        "RC General",
        "Cuy'val Dar General", 
        "Shadow General", 
        "Medical General", 
    },

    Jedi = {
        "Jedi Grand Master",
        "GC Grand Master",
        "Jedi General Aayla Secura",
        "Combat Engineer General Aayla Secura",
        "Jedi Sentinel",
        "Jedi Sentinel Temple Guard",
        "Jedi Council Member",
        "501st Jedi",
        "212th Jedi",
        "Combat Engineer Jedi",
        "Galactic Marines Jedi",
        "Wolfpack Jedi",
    },

    Engineers = {
        "Combat Engineer Marshal Chief",
        "Combat Engineer Chief",
        "Combat Engineer Assistant Chief",
        "Combat Engineer Chief Technician",
        "Combat Engineer Razor Squadron",
    },

    Pilots = {
        "RC Fixer",
        "CF99 Tech",
    },

    Fleet = {
        "Grand Admiral",
        "Fleet Admiral",
        "Fleet High Rank",
        "Fleet Member",
        "Fleet Recruit",
        "Fleet StarFighter Officer",
        "Fleet Maverick",
        "Fleet Medical Officer",
        "Fleet Engineering Officer",
        "Fleet Security Officer",
    },
}

function mergeTables(...)
    local result = {}

    -- Iterate through all the tables
    for _, tbl in ipairs({...}) do
        if type(tbl) == "table" then
            table.Add(result, tbl)
        else
            error("mergeTables: All arguments must be tables")
        end
    end

    return result
  end

-- Return a function that allows you to get specific teams
return function(teamCategory)
    return teams[teamCategory]
end

