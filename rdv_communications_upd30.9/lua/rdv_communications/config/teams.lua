if SERVER then AddCSLuaFile() end
teams = {

    -- ==== Fleet ====
    Fleet = {
        "Grand Admiral",
        "Fleet Admiral",
        "Fleet Seniority",
        "Fleet Lieutenant",
        "Fleet Officer",
        "Fleet Recruit",
        "Fleet Engineering Officer",
        "Fleet Security Officer",
        "Fleet Medical Officer"
    },

    -- ==== Generals ====
    Generals = {
        "Supreme General",
        "Battalion General",
        "Assistant General",
        "RC General",
        "Shadow General",
        "Medical General",
    },

-- ==== Marshals ====
    Marshal = {
        "501st Marshal Commander",
        "212th Marshal Commander",
        "Green Company Marshal Commander",
        "Coruscant Guard Marshal Commander",
        "Galactic Marines Marshal Commander",
        "Wolfpack Marshal Commander",
        "Combat Engineer Marshal Chief",
        "ARC Marshal Commander",
        "RC Marshal Commander",
        "Senior Medical Director"

    },

    -- ==== Clone Troopers ====
    TeamCT = {
        "Clone Trooper JDSGT",
        "Clone Trooper DSGT",
        "Clone Trooper MDSGT",
        "Clone Trooper SDSGT",
    },

    TeamCTtrp = {
        "Clone Trooper",
    },



    -- ==== 501st ====
    Team501 = {
        "501st General",
        "501st Commander",
        "501st Executive Officer",
        "501st Major",
        "501st Lieutenant",
        "501st Heavy Trooper",
        "501st Alpha ARC",
        "501st ARC",
        "501st Medic Officer",
        "501st Sergeant",
        "501st Medic Trooper",
    },

    Team501trp = {
        "501st Trooper",
    },

    -- ==== 212th ====
    Team212 = {
        "212th General",
        "212th Commander",
        "212th Executive Officer",
        "212th Major",
        "212th Lieutenant",
        "212th Ghost Company",
        "212th Alpha ARC",
        "212th ARC",
        "212th Medic Officer",
        "212th Sergeant",
        "212th Medic Trooper",
        "212th Medic Trooper",
    },

    Team212Trp = {
        "212th Trooper",
    },

    -- ==== Green Company ====
    TeamGreen = {
        "Green Company General",
        "Green Company Commander",
        "Green Company Executive Officer",
        "Green Company Major",
        "Green Company Lieutenant",
        "Green Company Marksman",
        "Green Company Alpha ARC",
        "Green Company ARC",
        "Green Company Medic Officer",
        "Green Company Sergeant",
        "Green Company Medic Trooper",
    },

    TeamGreenTrp = {
        "Green Company Trooper",
    },

    -- ==== Coruscant Guards ====
    TeamCG = {
        "Shock General",
        "Coruscant Guard General",
        "Coruscant Guard Commander",
        "Coruscant Guard Executive Officer",
        "Coruscant Guard Major",
        "Coruscant Guard Lieutenant",
        "Coruscant Guard Riot Trooper",
        "Coruscant Guard Security Officer",
        "Coruscant Guard Alpha ARC",
        "Coruscant Guard ARC",
        "Coruscant Guard Medic Officer",
        "Coruscant Guard Sergeant",
        "Coruscant Guard Medic Trooper",
    },

    TeamCGTrp = {
        "Coruscant Guard Massif Hound",
        "Coruscant Guard Trooper",
    },

    -- ==== Galactic Marines ====
    TeamGM = {
        "Galactic Marines General",
        "Galactic Marines Commander",
        "Galactic Marines Executive Officer",
        "Galactic Marines Major",
        "Galactic Marines Lieutenant",
        "Galactic Marines Flame Trooper",
        "Galactic Marines Kellers Unit",
        "Galactic Marines Alpha ARC",
        "Galactic Marines ARC",
        "Galactic Marines Medic Officer",
        "Galactic Marines Sergeant",
        "Galactic Marines Medic Trooper",
    },

    TeamGMTrp = {
        "Galactic Marines Trooper",
    },

    -- ==== WolfPack ====
    TeamWP = {
        "104th General",
        "Wolfpack General",
        "Wolfpack Commander",
        "Wolfpack Executive Officer",
        "Wolfpack Major",
        "Wolfpack Lieutenant",
        "Wolfpack Pathfinder",
        "Wolfpack Alpha ARC",
        "Wolfpack ARC",
        "Wolfpack Medic Officer",
        "Wolfpack Sergeant",
        "Wolfpack Medic Trooper",
    },

    TeamWPTrp = {
        "Wolfpack Trooper",
    },

    -- ==== Engineers ====
    TeamCE = {
        "Combat Engineer General",
        "Combat Engineer Chief",
        "Combat Engineer Assistant Chief",
        "Combat Engineer Chief Technician",
        "Combat Engineer Technician",
        "Combat Engineer Razor Squadron",
        "Combat Engineer EOD",
        "Combat Engineer Alpha ARC",
        "Combat Engineer ARC",
        "Combat Engineer Medic Officer",
        "Combat Engineer Specialist",
        "Combat Engineer Medic Trooper",
    },

    TeamCETrp = {
        "Combat Engineer Trooper",
    },

    -- ==== ARC ====
    TeamARC = {
        "ARC General",
        "ARC Command",
    },

    TeamARCTrp = {
        "501st Alpha ARC",
        "501st ARC",
        "212th Alpha ARC",
        "212th ARC",
        "Green Company Alpha ARC",
        "Green Company ARC",
        "Coruscant Guard Alpha ARC",
        "Coruscant Guard ARC",
        "Galactic Marines Alpha ARC",
        "Galactic Marines ARC",
        "Wolfpack Alpha ARC",
        "Wolfpack ARC",
        "Combat Engineer Alpha ARC",
        "Combat Engineer ARC",
        "Trainee ARC",
    },

    -- ==== Republic Commandos ====
    TeamRC = {
        "RC Boss",
        "RC Fixer",
        "RC Sev",
        "RC Scorch",
        "CF99 Hunter",
        "CF99 Crosshair",
        "CF99 Wrecker",
        "CF99 Tech",
        "CF99 Echo",
        "RC Niner",
        "RC Fi",
        "RC Darman",
        "RC Atin",
        "RC Corr",
        "RC Vale",
        "RC Plank",
        "RC Riggs",
        "RC Witt",
        "RC HOPE Squad",
        "RC Aiwha Squad",
        "RC Aquila Squad",
        "RC Ion Squad",
        "RC Yayax Squad",
        "RC Sergeant",

    },

    TeamRCTrp = {
        "Republic Commando",
    },

    -- ==== Cuy'val Dar ====
    TeamCD = {
        "Cuy'val Dar General",
        "Marshal Commander Walon Vau",
        "Walon Vau",
        "Kal Skirata",
        "Fen Rau",
        "Mand'alor",
    },

    TeamCDTrp = {
        "Cuy'val Dar Officer",
        "Cuy'val Dar Member",
    },

    TeamValour = {
        "Cuy'val Dar Valour Lead",
        "Cuy'val Dar Valour Trooper",
    },

    TeamSDW = {
        "Shadow Lead",
        "Shadow Member",
    },

    TeamMarauder = {
        "Marauder Lead",
        "Marauder Trooper",
    },

    TeamShadow = {
        "Shadow General",
        "Shadow Marshal Commander",
        "Shadow Commander",
        "Shadow Executive Officer",
        "Shadow Major",
        "Shadow Officer",
        "Shadow Sergeant",
        "Shadow Trooper",
        "Covert Lead",
        "Covert Specialists",
        "Covert Trooper",
    },



    -- ==== Medical Directive ====
    TeamMed = {
        "Senior Medical Director",
        "Medical Director",
        "Assistant Medical Director",
    },

    TeamMedTrp = {
        "501st Medic Officer",
        "501st Medic Trooper",
        "212th Medic Officer",
        "212th Medic Trooper",
        "Green Company Medic Officer",
        "Green Company Medic Trooper",
        "Coruscant Guard Medic Officer",
        "Coruscant Guard Medic Trooper",
        "Galactic Marines Medic Officer",
        "Galactic Marines Medic Trooper",
        "Wolfpack Medic Officer",
        "Wolfpack Medic Trooper",
        "Combat Engineer Medic Officer",
        "Combat Engineer Medic Trooper",
    },

    -- ==== NSO Command ====
    TeamNSO = {
        "NSO Captain",
        "NSO CQC Expert",
        "NSO Medic",
        "NSO Agent",
    },

    -- ==== JEDI ====
    JediCouncil = {
        "Jedi Grand Master",
        "GC Grand Master",
        "Jedi Master Mace Windu",
        "Jedi General Anakin Skywalker",
        "501st General Anakin Skywalker",
        "Jedi General Obi-Wan Kenobi",
        "212th General Obi-Wan Kenobi",
        "Jedi Commander Ahsoka Tano",
        "501st Commander Ahsoka Tano",
        "Jedi General Plo Koon",
        "WP General Plo Koon",
        "Jedi General Kit Fisto",
        "RC General Kit Fisto",
        "Jedi General Aayla Secura",
        "Combat Engineer General Aayla Secura",
        "Jedi General Shaak Ti",
        "CG General Shaak Ti",
        "Jedi General Ki-Adi-Mundi",
        "GM General Ki-Adi-Mundi",
        "Jedi General Quinlan Vos",
        "Shadow General Quinlan Vos",
        "Jedi General Luminara Unduli",
        "GC General Luminara Unduli",
        "Jedi Council Member"
    },

    JediTemple = {
        "Jedi Chief of Security Cin Drallig",
        "Jedi Consular Temple Guard",
        "Jedi Sentinel Temple Guard",
        "Jedi Guardian Temple Guard",
    },

    JediSpec = {
        "Jedi Consular",
        "Jedi Guardian",
        "Jedi Sentinel",
        "Combat Engineer Jedi",
        "501st Jedi",
        "212th Jedi",
    },

    Jedi = {
        "Jedi Knight",
    },

    JediOther = {
        "Jedi Tournament",
        "Jedi Padawan",
        "Jedi Youngling",
    },

    -- ==== Legacy ====
    TeamLegacy = {
        "Wookiee",
        "Jawa",
        "Bounty Hunter",
        "Republic Droid",
    },

    -- ==== Clone Reinforcements ====
    TeamReinforce = {
        "Dooms Unit Assault",
        "442nd Siege Battalion",
        "91st Marksman",
        "Jaguar Hunters",
    },

    -- ==== Staff ====
    TeamStaff = {
        "Staff on Duty",
        "Event Host",
    },

    -- ==== Sim ====
    TeamSim = {
        "Clone Assault",
        "Clone Heavy",
        "Clone Sniper",
        "Clone Medic",
        "Clone Pilot",
        "Clone Bomber",
        "Clone Jet Trooper",
        "Sim Enemy Assault",
        "Sim Enemy Heavy",
        "Sim Enemy Medic",
        "Sim Enemy Sniper",
        "Sim Enemy Pilot",
        "Sim Enemy Bomber",
        "Sim Enemy Jet Trooper",
    },

    -- ==== Event ====
    TeamEE = {
        "Battle Droid",
        "CQ Battle Droid",
        "Rocket Droid",
        "Heavy Battle Droid",
        "Recon Battle Droid",
        "Engineer Droid",
        "Medical Droid",
        "Commander Droid",
        "Sith",
        "Super Battle Droid",
        "Super Jump Droid",
        "Droideka",
        "Magna Guard",
        "Tactical Droid",
        "Tanker Droid",
        "Sniper Droid",
        "Technical Droid",
        "Enemy Bounty Hunter",
        "BX Commando Droid",
        "BX Assassin Droid",
        "BX Slugthrower Droid",
        "BX Splicer Droid",
        "BX Recon Droid",
        "BX Heavy Droid",
        "BX Commander Droid",
        "Umbaran Trooper",
        "Umbaran Heavy Trooper",
        "Umbaran Sniper",
        "Umbaran Engineer",
        "Umbaran Officer",
        "Prisoner",
        "Undead Clone",
        "Republic Guard",
        "Clone",
        "Event Character",
        "Republic Character",
        "Count Dooku",
        "Asajj Ventress",
        "Darth Maul",
        "General Grievous",
        "Savage Opress",
        "Pre Viszla",
        "Cad Bane",
        "Hondo Ohnaka",
        "Bossk",
        "Durge",

    },

    -- RegAccss = mergeTables(
    --     teams.Fleet,
    --     teams.Generals,
    --     teams.Marshal,
    --     teams.TeamMed,
    --     teams.TeamNSO,
    --     teams.JediSpec,
    --     teams.Jedi
    -- ),


}

function mergeTables(...)
    local result = {}

    -- Iterate through all the arguments
    for _, arg in ipairs({...}) do
        if type(arg) == "table" then
            -- If it's a table, merge its elements into the result table
            table.Add(result, arg)
        elseif type(arg) == "string" then
            -- If it's a string, concatenate it to the result table
            table.insert(result, arg)
        else
            error("mergeTables: All arguments must be tables or strings")
        end
    end

    return result
end

-- Return a function that allows you to get specific teams
return function(teamCategory)
    return teams[teamCategory]
end

