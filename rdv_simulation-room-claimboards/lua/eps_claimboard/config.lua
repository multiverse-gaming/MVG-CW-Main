AddCSLuaFile()

EPS_ClaimBoard_Config = {}

EPS_ClaimBoard_Config.Prefix = "Claim Board"
EPS_ClaimBoard_Config.PrefixColor = Color(255,0,0)

--[[

	Which people should be able to unclaim a board forcefully, etc.

--]]

EPS_ClaimBoard_Config.Admins = {
    ["admin"] = true,
    ["mod"] = true,
    ["headadmin"] = true,
    ["superadmin"] = true,
    ["trialmod"] = true,
}

--[[

	Settings

--]]

EPS_ClaimBoard_Config.Arrest = false -- Should the Claimboards be reset if the claimer is arrested?

EPS_ClaimBoard_Config.Death = false -- Should the Claimboards be reset if the claimer is killed?

--[[

	Battalion Listing Information

--]]

EPS_ClaimBoard_Config.Battalions = {
     ["Clone Trooper"] = { -- False means this will show up for every player, remove this if you don't want this.
        Jobs = {
            ["Clone Trooper Instructor"] = true,
            ["Clone Trooper JDSGT"] = true,
            ["Clone Trooper DSGT"] = true,
            ["Clone Trooper MDSGT"] = true,
            ["Clone Trooper SDSGT"] = true,
        },
    },
    ["501st Legion"] = { -- False means this will show up for every player, remove this if you don't want this.
        Jobs = {
            ["501st General"] = true,
            ["501st Marshal Commander"] = true,
            ["501st Commander"] = true,
            ["501st Executive Officer"] = true,
            ["501st Major"] = true,
            ["501st Lieutenant"] = true,
            ["501st ARC"] = true,
            ["501st Alpha ARC"] = true,
            ["501st Heavy Trooper"] = true,
            ["501st Medic Officer"] = true,
            ["501st Medic Trooper"] = true,
            ["501st Heavy Ordnance Officer"] = true,

        },
    },
    ["212th Attack Battalion"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["212th General"] = true,
            ["212th Marshal Commander"] = true,
            ["212th Commander"] = true,
            ["212th Executive Officer"] = true,
            ["212th Major"] = true,
            ["212th Lieutenant"] = true,
            ["212th ARC"] = true,
            ["212th Alpha ARC"] = true,
            ["212th Ghost Company"] = true,
            ["212th Medic Officer"] = true,
            ["212th Medic Trooper"] = true,

        },
    },
    ["Green Company"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["Green Company General"] = true,
            ["Green Company Marshal Commander"] = true,
            ["Green Company Commander"] = true,
            ["Green Company Executive Officer"] = true,
            ["Green Company Major"] = true,
            ["Green Company Lieutenant"] = true,
            ["Green Company ARC"] = true,
            ["Green Company Alpha ARC"] = true,
            ["Green Company Marksman"] = true,
            ["Green Company Ranger"] = true,
            ["Green Company Medic Officer"] = true,
            ["Green Company Medic Trooper"] = true,

        },
    },
    ["91st Medical Corps"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["91st General"] = true,
            ["91st Commander"] = true,
            ["91st Executive Officer"] = true,
            ["91st Major"] = true,
            ["91st Lieutenant"] = true,
            ["91st ARC"] = true,
            ["91st Lightning Squad"] = true,
            ["91st Paratrooper"] = true,
        },
    },

    ["Coruscant Guard"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["Coruscant Guard General"] = true,
            ["Coruscant Guard Marshal Commander"] = true,
            ["Coruscant Guard Commander"] = true,
            ["Coruscant Guard Executive Officer"] = true,
            ["Coruscant Guard Major"] = true,
            ["Coruscant Guard Lieutenant"] = true,
            ["Coruscant Guard ARC"] = true,
            ["Coruscant Guard Alpha ARC"] = true,
            ["Coruscant Guard Defensive Unit"] = true,
            ["Coruscant Guard Security Officer"] = true,
            ["Coruscant Guard Medic Officer"] = true,
            ["Coruscant Guard Medic Trooper"] = true,
        },
    },

    ["Shock Trooper"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["Shock General"] = true,
            ["Shock Marshal Commander"] = true,
            ["Shock Commander"] = true,
            ["Shock Executive Officer"] = true,
            ["Shock Major"] = true,
            ["Shock Lieutenant"] = true,
            ["Shock ARC"] = true,
            ["Shock Alpha ARC"] = true,
            ["Shock Defensive Unit"] = true,
            ["Shock Security Officer"] = true,
            ["Shock Medic Officer"] = true,
            ["Shock Medic Trooper"] = true,
        },
},


    ["Galactic Marines"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["Galactic Marines General"] = true,
            ["Galactic Marines Marshal Commander"] = true,
            ["Galactic Marines Commander"] = true,
            ["Galactic Marines Executive Officer"] = true,
            ["Galactic Marines Major"] = true,
            ["Galactic Marines Lieutenant"] = true,
            ["Galactic Marines ARC"] = true,
            ["Galactic Marines Alpha ARC"] = true,
            ["Galactic Marines Centurion"] = true,
            ["Galactic Marines Medic Officer"] = true,
            ["Galactic Marines Medic Trooper"] = true,
            ["Galactic Marines Flame Trooper"] = true,
            ["Galactic Marines Kellers Unit"] = true,

        },
    },
    ["Wolfpack Battalion"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["Wolfpack General"] = true,
            ["Wolfpack Marshal Commander"] = true,
            ["Wolfpack Commander"] = true,
            ["Wolfpack Executive Officer"] = true,
            ["Wolfpack Major"] = true,
            ["Wolfpack Lieutenant"] = true,
            ["Wolfpack ARC"] = true,
            ["Wolfpack Alpha ARC"] = true,
            ["Wolfpack Pathfinder"] = true,
            ["Wolfpack Medic Officer"] = true,
            ["Wolfpack Medic Trooper"] = true,

        },
    },
    ["Combat Engineers"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["Combat Engineer General"] = true,
            ["Combat Engineer Marshal Chief"] = true,
            ["Combat Engineer Chief"] = true,
            ["Combat Engineer Assistant Chief"] = true,
            ["Combat Engineer Chief Technician"] = true,
            ["Combat Engineer Technician"] = true,
            ["Combat Engineer ARC"] = true,
            ["Combat Engineer Alpha ARC"] = true,
            ["Combat Engineer Razor Squadron"] = true,
            ["Combat Engineer EOD"] = true,
            ["327th Carnivore Company"] = true,
            ["Engineering Officer"] = true,
            ["Combat Engineer Medic Officer"] = true,
            ["Combat Engineer Medic Trooper"] = true,
        },
    },

    ["Clan Rodarch"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["Clan Rodarch General"] = true,
            ["Clan Rodarch Chieftain"] = true,
            ["Clan Rodarch Underchief"] = true,
            ["Clan Rodarch Executor"] = true,
            ["Clan Rodarch Champion"] = true,
            ["Clan Master Stalker"] = true,
            ["Clan Rodarch Warrior"] = true,
            ["Clan Rodarch Master Stalker"] = true,
            ["Clan Rodarch Master Warrior"] = true,
            ["Clan Rodarch High Stalker"] = true,
            ["Clan Rodarch High Warrior"] = true,

        },
    },

    ["Cuy'val Dar"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["Cuy'val Dar General"] = true,
            ["Shadow Field Marshall"] = true,
            ["Marshal Commander Walon Vau"] = true,
            ["Walon Vau"] = true,
            ["Kal Skirata"] = true,
            ["Fen Rau"] = true,
            ["Cuy'val Dar Captain"] = true,
            ["Cuy'val Dar Officer"] = true,
            ["Cuy'val Dar Guard Lead"] = true,
            ["Cuy'val Dar Guard Trooper"] = true,
            ["Cuy'val Dar Sergeant"] = true,
            ["Mand'alor"] = true,
            ["Shadow Lead"] = true,
            ["Shadow Member"] = true,
            ["Marauder Lead"] = true,
            ["Marauder Trooper"] = true,
        },
    },

    ["Shadow"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["Shadow General"] = true,
            ["Shadow Marshal Commander"] = true,
            ["Shadow Commander"] = true,
            ["Shadow Executive Officer"] = true,
            ["Shadow Major"] = true,
            ["Shadow Officer"] = true,
            ["Shadow Sergeant"] = true,
            ["Covert Lead"] = true,
            ["Covert Specialists"] = true,
            ["Covert Trooper"] = true,
        },
    },


    ["ARC Directive"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["ARC General"] = true,
            ["ARC Marshal Commander"] = true,
            ["ARC Command"] = true,
        },
    },

    ["Republic Commandos"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["RC General"] = true,
            ["RC Boss"] = true,
            ["RC Fixer"] = true,
            ["RC Gregor"] = true,
            ["RC Scorch"] = true,
            ["RC Sev"] = true,
            ["RC Sarge"] = true,
            ["RC Hunter"] = true,
            ["RC Vale"] = true,
            ["RC Plank"] = true,
            ["RC Riggs"] = true,
            ["RC Crosshair"] = true,

            ["RC Niner"] = true,
            ["RC Fi"] = true,
            ["RC Darman"] = true,
            ["RC Atin"] = true,

            ["RC Lieutenant"] = true,

            ["RC Grinder"] = true,
            ["RC Grip"] = true,
            ["RC Kurz"] = true,
            ["RC Watson"] = true,
            ["RC Sarge"] = true,
            ["RC Zag"] = true,
            ["RC Dikut"] = true,
            ["RC Tyto"] = true,

            ["CF99 Hunter"] = true,
            ["CF99 Crosshair"] = true,
            ["CF99 Wrecker"] = true,
            ["CF99 Tech"] = true,

            ["Clone Advisor"] = true,
            ["RC Marshal Commander"] = true,

        },
    },
    ["Generals"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["Supreme General"] = true,
            ["Battalion General"] = true,
            ["Assistant General"] = true,
        },
    },
    ["Fleet Officers"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["Grand Admiral"] = true,
            ["Fleet Admiral"] = true,
            ["Fleet Seniority"] = true,
            ["Fleet Lieutenant"] = true,
            ["Fleet Officer"] = true,
            ["Fleet Recruit"] = true,
            ["Fleet Security Officer"] = true,
            ["Fleet Engineering Officer"] = true,
            ["Fleet Medical Officer"] = true,
            ["Clone Advisor"] = true,
        },
    },
   ["Medical Directive"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["Medical General"] = true,
            ["Medical Marshal Commander"] = true,
            ["Medical Director"] = true,
            ["Assistant Medical Director"] = true,
        },
    },
    ["Jedi Order"] = { -- Otherwise if you want certain teams to have certain battalions put the jobs name here.
        Jobs = {
            ["Jedi Sentinel"] = true,
            ["Jedi Guardian"] = true,
            ["Jedi Consular"] = true,
            ["Jedi Council Member"] = true,
            ["GC Grand Master"] = true,
            ["501st Commander Ahsoka Tano"] = true,
            ["501st General Anakin Skywalker"] = true,
            ["212th General Obi-Wan Kenobi"] = true,
            ["WP General Plo Koon"] = true,
            ["RC General Kit Fisto"] = true,
            ["Combat Engineer General Aayla Secura"] = true,
            ["CG General Shaak Ti"] = true,
            ["GM General Ki-Adi-Mundi"] = true,
            ["Shadow General Quinlan Vos"] = true,
            ["GC General Luminara Unduli"] = true,
            ["Jedi Grand Master"] = true,
            ["Jedi Commander Ahsoka Tano"] = true,
            ["Jedi General Anakin Skywalker"] = true,
            ["Jedi General Obi-Wan Kenobi"] = true,
            ["Jedi Master Mace Windu"] = true,
            ["Jedi General Plo Koon"] = true,
            ["Jedi General Kit Fisto"] = true,
            ["Jedi General Aayla Secura"] = true,
            ["Jedi General Shaak Ti"] = true,
            ["Jedi General Ki-Adi-Mundi"] = true,
            ["Jedi General Quinlan Vos"] = true,
            ["Jedi General Luminara Unduli"] = true,

            ["Jedi Chief of Security Cin Drallig"] = true,
            ["Jedi Consular Temple Guard"] = true,
            ["Jedi Sentinel Temple Guard"] = true,
            ["Jedi Guardian Temple Guard"] = true,
        },
    },
    ["Regimental ARC"] = {
        Jobs = {
            ["ARC Marshal Commander"] = true,
            ["ARC Command"] = true,
            ["501st ARC"] = true,
            ["212th ARC"] = true,
            ["Galactic Marines ARC"] = true,
            ["Wolfpack ARC"] = true,
            ["Combat Engineer ARC"] = true,
            ["Coruscant Guard ARC"] = true,
            ["Shock ARC"] = true,
            ["Green Company ARC"] = true,
            ["501st Alpha ARC"] = true,
            ["212th Alpha ARC"] = true,
            ["Green Company Alpha ARC"] = true,
            ["Coruscant Guard Alpha ARC"] = true,
            ["Shock Alpha ARC"] = true,
            ["Galactic Marines Alpha ARC"] = true,
            ["Wolfpack Alpha ARC"] = true,
            ["Combat Engineer Alpha ARC"] = true,
        },
    },
}
