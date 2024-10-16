local COMMS = RDV.COMMUNICATIONS

include("teams.lua")
--local getTeams = require("addons/rdv_library_v2/lua/teams.lua")


COMMS:RegisterChannel("Generals", {

    Color = Color(176, 184, 182, 180),

    Factions = mergeTables(teams.Generals, teams.TeamNSO),

    CustomCheck = function(ply)
    end,

})



COMMS:RegisterChannel("Fleet", {

    Color = Color(176, 184, 182, 180),

    Factions = teams.Fleet,

    CustomCheck = function(ply)
    end,

})


COMMS:RegisterChannel("OD Communication", {
    Color = Color(176, 184, 182, 180),
    Factions = mergeTables(
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        teams.TeamCT,
        teams.Team501,
        teams.Team212,
        teams.TeamGreen,
        teams.TeamCG,
        teams.TeamGM,
        teams.TeamWP,
        teams.TeamCE,
        teams.TeamARC,
        teams.TeamRC,
        teams.TeamMed,
        teams.JediCouncil,
        teams.TeamShadow
    ),

    CustomCheck = function(ply)
    end,
})



COMMS:RegisterChannel("501st Legion Primary", {

    Color = Color(0, 51, 255, 255),

    Factions = mergeTables(
        teams.Team501,
        teams.Team501trp,
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        "Jedi General Anakin Skywalker",
        "Jedi Commander Ahsoka Tano",
        "501st General Anakin Skywalker",
        "501st Commander Ahsoka Tano"
    ),

    CustomCheck = function(ply)
    end,

})

COMMS:RegisterChannel("501st Legion Secondary", {

    Color = Color(0, 51, 255, 255),

    Factions = mergeTables(
        teams.Team501,
        teams.Team501trp,
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        "Jedi General Anakin Skywalker",
        "Jedi Commander Ahsoka Tano",
        "501st General Anakin Skywalker",
        "501st Commander Ahsoka Tano"
    ),

    CustomCheck = function(ply)
    end,

})


COMMS:RegisterChannel("212th Attack Battalion Primary", {

    Color = Color(255, 157, 0, 255),

    Factions = mergeTables(
        teams.Team212,
        teams.Team212Trp,
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        "Jedi General Obi-Wan Kenobi",
        "212th General Obi-Wan Kenobi"
    ),

    CustomCheck = function(ply)
    end,

})


COMMS:RegisterChannel("212th Attack Battalion Secondary", {

    Color = Color(255, 157, 0, 255),

    Factions = mergeTables(
        teams.Team212,
        teams.Team212Trp,
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        "Jedi General Obi-Wan Kenobi",
        "212th General Obi-Wan Kenobi"
    ),

    CustomCheck = function(ply)
    end,

})



COMMS:RegisterChannel("Green Company Primary", {

    Color = Color(0, 255, 64, 255),

    Factions = mergeTables(
        teams.TeamGreen,
        teams.TeamGreenTrp,
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        "GC Grand Master",
        "Jedi Grand Master"
    ),

    CustomCheck = function(ply)
    end,

})

COMMS:RegisterChannel("Green Company Secondary", {

    Color = Color(0, 255, 64, 255),

    Factions = mergeTables(
        teams.TeamGreen,
        teams.TeamGreenTrp,
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        "GC Grand Master",
        "Jedi Grand Master"
    ),

    CustomCheck = function(ply)
    end,

})



COMMS:RegisterChannel("Coruscant Guard Primary", {

    Color = Color(255, 77, 77, 255),

    Factions = mergeTables(
        teams.TeamCG,
        teams.TeamCGTrp,
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        teams.JediTemple,
        "Jedi General Shaak Ti",
        "CG General Shaak Ti"
    ),

    CustomCheck = function(ply)
    end,

})


COMMS:RegisterChannel("Coruscant Guard Secondary", {

    Color = Color(255, 77, 77, 255),

    Factions = mergeTables(
        teams.TeamCG,
        teams.TeamCGTrp,
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        teams.JediTemple,
        "Jedi General Shaak Ti",
        "CG General Shaak Ti"
    ),

    CustomCheck = function(ply)
    end,

})



COMMS:RegisterChannel("Galactic Marines Primary", {

    Color = Color(119, 63, 202, 255),

    Factions = mergeTables(
        teams.TeamGM,
        teams.TeamGMTrp,
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        "GM General Ki-Adi-Mundi",
        "Jedi General Ki-Adi-Mundi"
    ),

    CustomCheck = function(ply)
    end,

})


COMMS:RegisterChannel("Galactic Marines Secondary", {

    Color = Color(119, 63, 202, 255),

    Factions = mergeTables(
        teams.TeamGM,
        teams.TeamGMTrp,
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        "GM General Ki-Adi-Mundi",
        "Jedi General Ki-Adi-Mundi"
    ),

    CustomCheck = function(ply)
    end,

})



COMMS:RegisterChannel("Wolfpack Battalion Primary", {

    Color = Color(153, 144, 144, 255),

    Factions = mergeTables(
        teams.TeamWP,
        teams.TeamWPTrp,
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        "WP General Plo Koon",
        "Jedi General Plo Koon"
    ),

    CustomCheck = function(ply)
    end,

})

COMMS:RegisterChannel("Wolfpack Battalion Secondary", {

    Color = Color(153, 144, 144, 255),

    Factions = mergeTables(
        teams.TeamWP,
        teams.TeamWPTrp,
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        "WP General Plo Koon",
        "Jedi General Plo Koon"
    ),

    CustomCheck = function(ply)
    end,

})



COMMS:RegisterChannel("Engineers Primary", {

    Color = Color(198, 155, 61, 255),

    Factions = mergeTables(
        teams.TeamCE,
        teams.TeamCETrp,
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        "Jedi General Aayla Secura",
        "Combat Engineer General Aayla Secura",
        "CF99 Tech",
        "CF99 Echo"
    ),

    CustomCheck = function(ply)
    end,

})

COMMS:RegisterChannel("Engineers Secondary", {

    Color = Color(198, 155, 61, 255),

    Factions = mergeTables(
        teams.TeamCE,
        teams.TeamCETrp,
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        "Jedi General Aayla Secura",
        "Combat Engineer General Aayla Secura",
        "CF99 Tech",
        "CF99 Echo"
    ),

    CustomCheck = function(ply)
    end,

})



COMMS:RegisterChannel("Shadow Troopers", {

    Color = Color(130,16,8, 255),

    Factions = mergeTables(
        teams.TeamShadow,
        teams.Marshal,
        teams.TeamNSO,
        "Jedi General Quinlan Vos",
        "Shadow General Quinlan Vos",
        "Shadow General"
    ),

    CustomCheck = function(ply)
    end,

})

COMMS:RegisterChannel("Republic Commandos Primary", {

    Color = Color(255, 157, 0, 255),

    Factions = mergeTables(
        teams.TeamRC,
        teams.TeamRCTrp,
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        "Jedi General Kit Fisto",
        "RC General Kit Fisto"
    ),

    CustomCheck = function(ply)
    end,

})

COMMS:RegisterChannel("Republic Commandos Secondary", {

    Color = Color(255, 157, 0, 255),

    Factions = mergeTables(
        teams.TeamRC,
        teams.TeamRCTrp,
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        "Jedi General Kit Fisto",
        "RC General Kit Fisto"
    ),

    CustomCheck = function(ply)
    end,

})



COMMS:RegisterChannel("Jedi Council", {

    Color = Color(242, 0, 255, 255),

    Factions = mergeTables(
        teams.JediCouncil
    ),

    CustomCheck = function(ply)
    end,

})



COMMS:RegisterChannel("Jedi Order Primary", {

    Color = Color(242, 0, 255, 255),

    Factions = mergeTables(
        teams.JediCouncil,
        teams.JediTemple,
        teams.JediSpec,
        teams.Jedi,
        teams.JediOther
    ),

    CustomCheck = function(ply)
    end,

})

COMMS:RegisterChannel("Jedi Order Secondary", {

    Color = Color(242, 0, 255, 255),

    Factions = mergeTables(
        teams.JediCouncil,
        teams.JediTemple,
        teams.JediSpec,
        teams.Jedi,
        teams.JediOther
    ),

    CustomCheck = function(ply)
    end,

})


COMMS:RegisterChannel("Clone Troopers", {
    Color = Color(30, 165, 232, 255),
    Factions = mergeTables(
        teams.TeamCT,
        teams.TeamCTtrp,
        teams.Fleet,
        teams.TeamNSO
    ),
    CustomCheck = function(ply)
    end,
})



COMMS:RegisterChannel("Medical Primary", {

    Color = Color(245, 56, 81, 255),

    Factions = mergeTables(
        teams.TeamMed,
        teams.TeamMedTrp,
        teams.TeamNSO, -- But.. Why, theres no Genearls in this???
        "Jedi Master Mace Windu"
    ),

    CustomCheck = function(ply)
    end,

})

COMMS:RegisterChannel("Medical Secondary", {

    Color = Color(245, 56, 81, 255),

    Factions = mergeTables(
        teams.TeamMed,
        teams.TeamMedTrp,
        teams.TeamNSO,
        "Jedi Master Mace Windu"
    ),

    CustomCheck = function(ply)
    end,

})

COMMS:RegisterChannel("ARC Primary", {
    Color = Color(0, 161, 255, 255),
    Factions = mergeTables(
        teams.TeamARC,
        teams.TeamARCTrp,
        teams.TeamNSO,
        "ARC Marshal Commander"
    ),

    CustomCheck = function(ply)
    end,
})

COMMS:RegisterChannel("ARC Secondary", {
    Color = Color(0, 161, 255, 255),
    Factions = mergeTables(
        teams.TeamARC,
        teams.TeamARCTrp,
        teams.TeamNSO,
        "ARC Marshal Commander"
    ),

    CustomCheck = function(ply)
    end,
})

COMMS:RegisterChannel("Reinforcements Comms", {
    Color = Color(51, 102, 0, 255),
    Factions = mergeTables(
        teams.TeamReinforce
    ),

    CustomCheck = function(ply)
    end,
})

COMMS:RegisterChannel("Open Comms Primary", {

    Color = Color(255,255,255,255),

    Factions = mergeTables(
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        teams.TeamCT,
        teams.TeamCTtrp,
        teams.Team501,
        teams.Team501trp,
        teams.Team212,
        teams.Team212Trp,
        teams.TeamGreen,
        teams.TeamGreenTrp,
        teams.TeamCG,
        teams.TeamCGTrp,
        teams.TeamGM,
        teams.TeamGMTrp,
        teams.TeamWP,
        teams.TeamWPTrp,
        teams.TeamCE,
        teams.TeamCETrp,
        teams.TeamARC,
        teams.TeamARCTrp,
        teams.TeamRC,
        teams.TeamRCTrp,
        teams.TeamCD,
        teams.TeamCDTrp,
        teams.TeamValour,
        teams.TeamSDW,
        teams.TeamMarauder,
        teams.TeamMedTrp,
        teams.JediCouncil,
        teams.JediTemple,
        teams.JediOther,
        teams.TeamLegacy,
        teams.TeamReinforce,
        teams.TeamStaff,
        teams.TeamEE
    ),

    CustomCheck = function(ply)
    end,

})

COMMS:RegisterChannel("Open Comms Secondary", {

    Color = Color(255,255,255,255),

    Factions = mergeTables(
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        teams.TeamCT,
        teams.TeamCTtrp,
        teams.Team501,
        teams.Team501trp,
        teams.Team212,
        teams.Team212Trp,
        teams.TeamGreen,
        teams.TeamGreenTrp,
        teams.TeamCG,
        teams.TeamCGTrp,
        teams.TeamGM,
        teams.TeamGMTrp,
        teams.TeamWP,
        teams.TeamWPTrp,
        teams.TeamCE,
        teams.TeamCETrp,
        teams.TeamARC,
        teams.TeamARCTrp,
        teams.TeamRC,
        teams.TeamRCTrp,
        teams.TeamCD,
        teams.TeamCDTrp,
        teams.TeamValour,
        teams.TeamSDW,
        teams.TeamMarauder,
        teams.TeamMedTrp,
        teams.JediCouncil,
        teams.JediTemple,
        teams.JediOther,
        teams.TeamLegacy,
        teams.TeamReinforce,
        teams.TeamStaff,
        teams.TeamEE
    ),

    CustomCheck = function(ply)
    end,

})

COMMS:RegisterChannel("Training Comms 1", {

    Color = Color(100,100,255,255),

    Factions = mergeTables(
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        teams.TeamCT,
        teams.TeamCTtrp,
        teams.Team501,
        teams.Team501trp,
        teams.Team212,
        teams.Team212Trp,
        teams.TeamGreen,
        teams.TeamGreenTrp,
        teams.TeamCG,
        teams.TeamCGTrp,
        teams.TeamGM,
        teams.TeamGMTrp,
        teams.TeamWP,
        teams.TeamWPTrp,
        teams.TeamCE,
        teams.TeamCETrp,
        teams.TeamARC,
        teams.TeamARCTrp,
        teams.TeamRC,
        teams.TeamRCTrp,
        teams.TeamShadow,
        teams.TeamMarauder,
        teams.TeamMedTrp,
        teams.JediCouncil,
        teams.JediTemple,
        teams.JediOther,
        teams.TeamLegacy,
        teams.TeamReinforce,
        teams.TeamStaff,
        teams.TeamSim,
        teams.TeamEE
    ),

    CustomCheck = function(ply)
    end,

})

COMMS:RegisterChannel("Training Comms 2", {

    Color = Color(100,100,255,255),

    Factions = mergeTables(
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        teams.TeamCT,
        teams.TeamCTtrp,
        teams.Team501,
        teams.Team501trp,
        teams.Team212,
        teams.Team212Trp,
        teams.TeamGreen,
        teams.TeamGreenTrp,
        teams.TeamCG,
        teams.TeamCGTrp,
        teams.TeamGM,
        teams.TeamGMTrp,
        teams.TeamWP,
        teams.TeamWPTrp,
        teams.TeamCE,
        teams.TeamCETrp,
        teams.TeamARC,
        teams.TeamARCTrp,
        teams.TeamRC,
        teams.TeamRCTrp,
        teams.TeamShadow,
        teams.TeamMedTrp,
        teams.JediCouncil,
        teams.JediTemple,
        teams.JediOther,
        teams.TeamLegacy,
        teams.TeamReinforce,
        teams.TeamStaff,
        teams.TeamSim,
        teams.TeamEE
    ),

    CustomCheck = function(ply)
    end,

})

COMMS:RegisterChannel("Training Comms 3", {

    Color = Color(100,100,255,255),

    Factions = mergeTables(
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        teams.TeamCT,
        teams.TeamCTtrp,
        teams.Team501,
        teams.Team501trp,
        teams.Team212,
        teams.Team212Trp,
        teams.TeamGreen,
        teams.TeamGreenTrp,
        teams.TeamCG,
        teams.TeamCGTrp,
        teams.TeamGM,
        teams.TeamGMTrp,
        teams.TeamWP,
        teams.TeamWPTrp,
        teams.TeamCE,
        teams.TeamCETrp,
        teams.TeamARC,
        teams.TeamARCTrp,
        teams.TeamRC,
        teams.TeamRCTrp,
        teams.TeamShadow,
        teams.TeamMedTrp,
        teams.JediCouncil,
        teams.JediTemple,
        teams.JediOther,
        teams.TeamLegacy,
        teams.TeamReinforce,
        teams.TeamStaff,
        teams.TeamSim,
        teams.TeamEE
    ),

    CustomCheck = function(ply)
    end,

})

COMMS:RegisterChannel("Secure Comms 1", {

    Color = Color(100,100,255,255),

    Factions = mergeTables(
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        teams.TeamCT,
        teams.TeamCTtrp,
        teams.Team501,
        teams.Team501trp,
        teams.Team212,
        teams.Team212Trp,
        teams.TeamGreen,
        teams.TeamGreenTrp,
        teams.TeamCG,
        teams.TeamCGTrp,
        teams.TeamGM,
        teams.TeamGMTrp,
        teams.TeamWP,
        teams.TeamWPTrp,
        teams.TeamCE,
        teams.TeamCETrp,
        teams.TeamARC,
        teams.TeamARCTrp,
        teams.TeamRC,
        teams.TeamRCTrp,
        teams.TeamShadow,
        teams.TeamMarauder,
        teams.TeamMedTrp,
        teams.JediCouncil,
        teams.JediTemple,
        teams.JediOther,
        teams.TeamLegacy,
        teams.TeamReinforce,
        teams.TeamStaff,
        teams.TeamSim,
        teams.TeamEE
    ),

    CustomCheck = function(ply)
    end,

})

COMMS:RegisterChannel("Secure Comms 2", {

    Color = Color(100,100,255,255),

    Factions = mergeTables(
        teams.Fleet,
        teams.Generals,
        teams.Marshal,
        teams.TeamMed,
        teams.TeamNSO,
        teams.JediSpec,
        teams.Jedi,
        teams.TeamCT,
        teams.TeamCTtrp,
        teams.Team501,
        teams.Team501trp,
        teams.Team212,
        teams.Team212Trp,
        teams.TeamGreen,
        teams.TeamGreenTrp,
        teams.TeamCG,
        teams.TeamCGTrp,
        teams.TeamGM,
        teams.TeamGMTrp,
        teams.TeamWP,
        teams.TeamWPTrp,
        teams.TeamCE,
        teams.TeamCETrp,
        teams.TeamARC,
        teams.TeamARCTrp,
        teams.TeamRC,
        teams.TeamRCTrp,
        teams.TeamShadow,
        teams.TeamMedTrp,
        teams.JediCouncil,
        teams.JediTemple,
        teams.JediOther,
        teams.TeamLegacy,
        teams.TeamReinforce,
        teams.TeamStaff,
        teams.TeamSim,
        teams.TeamEE
    ),

    CustomCheck = function(ply)
    end,

})

COMMS:RegisterChannel("Event Primary", {

    Color = Color(204, 0, 0, 255),

    Factions = mergeTables(
        teams.TeamStaff,
        teams.TeamEE
    ),

    CustomCheck = function(ply)
    end,

})



COMMS:RegisterChannel("Event Secondary", {

    Color = Color(204, 0, 0, 255),

    Factions = mergeTables(
        teams.TeamStaff,
        teams.TeamEE
    ),

    CustomCheck = function(ply)
    end,

})




--[[

COMMS:RegisterChannel("NAME", {

    Color = Color(R, G, B, A), -- Red, Green, Blue, Alpha

    Factions = {"JOB"},

    CustomCheck = function(ply)
    end,

})

--]]
