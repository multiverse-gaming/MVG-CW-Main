local COMMS = RDV.COMMUNICATIONS





COMMS:RegisterChannel("Generals", {

    Color = Color(176, 184, 182, 180),

    Factions = {"327th General","501st General","NSO CQC Expert","NSO Medic","212th General","Green Company General","Coruscant Guard General","Galactic Marines General","Wolfpack General","ARC General","RC General","Shadow General","Medical General","Supreme General","Battalion General","Assistant General", "NSO Agent",  "NSO Captain"},

    CustomCheck = function(ply)



    end,

})



COMMS:RegisterChannel("Fleet", {

    Color = Color(176, 184, 182, 180),

    Factions = {"Grand Admiral","Republic Intelligence","RC Clone Advisor","Clone Trooper Instructor","Engineering Officer", "Medical Officer","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","Grand Admiral","Fleet Maverick","Fleet StarFighter Officer","Fleet Chief of Intelligence","Fleet Intelligence Officer","Fleet Director of Research and Development","Fleet Research and Development Officer"},

    CustomCheck = function(ply)



    end,

})



COMMS:RegisterChannel("OD Communication", {
    Color = Color(176, 184, 182, 180),
    Factions = {"Grand Admiral","NSO Agent",  "Marshal Commander Walon Vau","Walon Vau","Field Marshall","Kal Skirata","Fen Rau","Mand'alor","Shadow Lead","NSO Captain","Cuy'val Dar General","Cuy'val Dar Valour Lead","Cuy'val Dar Valour Trooper", "NSO CQC Expert","NSO Medic", "Republic Intelligence","RC Clone Advisor","Shadow Field Marshall", "Clone Trooper Instructor","501st Heavy Weapons Officer","212th Heavy Ordnance Officer","Green Company Reconnaissance Officer","Galactic Marines Breaching Officer","Wolfpack Reconnaissance Officer","Engineering Officer","Medical Officer","Fleet Pilot","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","327th General","501st General","212th General","Green Company General","Coruscant Guard General","Galactic Marines General","Wolfpack General","ARC General","RC General","Shadow General","Medical General","Supreme General","Battalion General","Assistant General","Jedi Grand Master","Jedi Master Mace Windu","Jedi General Anakin Skywalker","Jedi General Obi-Wan Kenobi","Jedi Commander Ahsoka Tano","Jedi General Plo Koon","Jedi General Kit Fisto","Jedi General Aayla Secura","Jedi General Shaak Ti","Jedi General Ki-Adi-Mundi","Jedi General Quinlan Vos","Jedi General Luminara Unduli","Jedi Council Member","501st Commander","501st Executive Officer","501st Major","501st Lieutenant","501st Heavy Trooper","501st Medic Officer","501st Medic Trooper","501st ARC","212th Commander","212th Executive Officer","212th Major","212th Lieutenant","212th Ghost Company","212th Medic Officer","212th Medic Trooper","212th ARC","Green Company Commander","Green Company Executive Officer","Green Company Major","Green Company Lieutenant","Green Company Marksman","Green Company Ranger","Green Company Medic Officer","Green Company Medic Trooper","Green Company ARC","Coruscant Guard Commander","Coruscant Guard Executive Officer","Coruscant Guard Major","Coruscant Guard Lieutenant","Coruscant Guard Security Officer","Coruscant Guard Medic Officer","Coruscant Guard Medic Trooper","Coruscant Guard ARC","Galactic Marines Commander","Galactic Marines Executive Officer","Galactic Marines Major","Galactic Marines Lieutenant","Galactic Marines Flame Trooper","Galactic Marines Kellers Unit","Galactic Marines Medic Officer","Galactic Marines Medic Trooper","Galactic Marines ARC","Wolfpack Commander","Wolfpack Executive Officer","Wolfpack Major","Wolfpack Lieutenant","Wolfpack Pathfinder","Wolfpack Medic Officer","Wolfpack Medic Trooper","Wolfpack ARC","327th Commander","327th Executive Officer","327th Major","327th Lieutenant","327th Talon Squadron","327th K Company","327th Medic Officer","327th Medic Trooper","327th ARC","RC Boss","RC Fixer","RC Sev","RC Scorch","CF99 Hunter","CF99 Crosshair","CF99 Wrecker","CF99 Tech","CF99 Echo","RC Niner","RC Fi","RC Darman","RC Atin","RC Gregor","RC Charger","RC Cannon","RC Impact","Senate Commando","ARC Command","501st Alpha ARC", "212th Alpha ARC", "Green Company Alpha ARC", "Galactic Marines Alpha ARC", "Wolfpack Alpha ARC", "327th Alpha ARC", "Coruscant Guard Alpha ARC", "Medical Director","Assistant Medical Director", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander","ARC Marshal Commander","Jedi Consular","Jedi Guardian","Jedi Sentinel","Clone Trooper JDSGT", "Clone Trooper DSGT","Clone Trooper MDSGT","Clone Trooper SDSGT","Jedi Chief of Security Cin Drallig","Jedi Consular Temple Guard","Jedi Sentinel Temple Guard","Jedi Guardian Temple Guard","Fleet Maverick","Fleet StarFighter Officer","Fleet Chief of Intelligence","Fleet Intelligence Officer","Fleet Director of Research and Development","Fleet Research and Development Officer","RC Vale"},
    CustomCheck = function(ply)
    end,
})



COMMS:RegisterChannel("501st Legion", {

    Color = Color(0, 51, 255, 255),

    Factions = {"Jedi General Anakin Skywalker","Grand Admiral","Republic Intelligence","RC Clone Advisor","Clone Trooper Instructor","501st Heavy Weapons Officer","212th Heavy Ordnance Officer","Green Company Reconnaissance Officer","Galactic Marines Breaching Officer",

    "Wolfpack Reconnaissance Officer","Engineering Officer","Field Marshall", "Medical Officer","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","Grand Admiral", "NSO Agent",  "NSO Captain", "NSO CQC Expert","NSO Medic", "Jedi Commander Ahsoka Tano","501st General","501st Heavy Weapons Officer","501st Commander","501st Executive Officer","501st Major","501st Lieutenant","501st ARC", "501st Alpha ARC", "501st Heavy Trooper","501st Medic Officer","501st Sergeant","501st Medic Trooper","501st Trooper","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander"},

    CustomCheck = function(ply)



    end,

})

COMMS:RegisterChannel("501st Secondary", {

    Color = Color(0, 51, 255, 255),

    Factions = {"Jedi General Anakin Skywalker","NSO Agent",  "NSO Captain", "Jedi Commander Ahsoka Tano","501st General","501st Heavy Weapons Officer","501st Commander","501st Executive Officer","501st Major","501st Lieutenant","501st ARC",  "501st Alpha ARC", "501st Heavy Trooper","501st Medic Officer","501st Sergeant","501st Medic Trooper","501st Trooper","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander"},

    CustomCheck = function(ply)



    end,

})


COMMS:RegisterChannel("212th Attack Battalion", {

    Color = Color(255, 157, 0, 255),

    Factions = {"Jedi General Obi-Wan Kenobi","Grand Admiral","Republic Intelligence","RC Clone Advisor","Clone Trooper Instructor","501st Heavy Weapons Officer","212th Heavy Ordnance Officer","Green Company Reconnaissance Officer","Galactic Marines Breaching Officer",

    "Wolfpack Reconnaissance Officer","Engineering Officer","Field Marshall", "Medical Officer","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","Grand Admiral", "NSO Captain", "NSO Agent", "NSO CQC Expert","NSO Medic", "212th General","212th Heavy Ordnance Officer","212th Commander","212th Executive Officer","212th Major","212th Lieutenant","212th ARC","212th Alpha ARC", "212th Ghost Company","212th Medic Officer","212th Sergeant","212th Medic Trooper","212th Trooper","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander"},

    CustomCheck = function(ply)



    end,

})


COMMS:RegisterChannel("212th Secondary", {

    Color = Color(255, 157, 0, 255),

    Factions = {"Jedi General Obi-Wan Kenobi", "NSO Captain","NSO Agent","212th General","212th Heavy Ordnance Officer","212th Commander","212th Executive Officer","212th Major","212th Lieutenant","212th ARC","212th Alpha ARC", "212th Ghost Company","212th Medic Officer","212th Sergeant","212th Medic Trooper","212th Trooper","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander"},

    CustomCheck = function(ply)



    end,

})



COMMS:RegisterChannel("Green Company", {

    Color = Color(0, 255, 64, 255),

    Factions = {"Jedi Grand Master","Grand Admiral","Republic Intelligence","RC Clone Advisor","Clone Trooper Instructor","501st Heavy Weapons Officer","212th Heavy Ordnance Officer","Green Company Reconnaissance Officer","Galactic Marines Breaching Officer",

    "Wolfpack Reconnaissance Officer","Engineering Officer","Field Marshall", "Medical Officer","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","Grand Admiral","NSO Agent", "NSO Captain", "NSO CQC Expert","NSO Medic", "Jedi General Luminara Unduli","Green Company General","Green Company Reconnaissance Officer","Green Company Commander","Green Company Executive Officer","Green Company Major","Green Company Lieutenant","Green Company ARC","Green Company Alpha ARC","Green Company Marksman","Green Company Ranger","Green Company Medic Officer","Green Company Sergeant","Green Company Medic Trooper","Green Company Trooper", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander"},

    CustomCheck = function(ply)



    end,

})

COMMS:RegisterChannel("GC Secondary", {

    Color = Color(0, 255, 64, 255),

    Factions = {"Jedi Grand Master","NSO Agent", "NSO Captain","Jedi General Luminara Unduli","Green Company General","Green Company Reconnaissance Officer","Green Company Commander","Green Company Executive Officer","Green Company Major","Green Company Lieutenant","Green Company ARC","Green Company Alpha ARC","Green Company Marksman","Green Company Ranger","Green Company Medic Officer","Green Company Sergeant","Green Company Medic Trooper","Green Company Trooper", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander"},

    CustomCheck = function(ply)



    end,

})



COMMS:RegisterChannel("Coruscant Guard", {

    Color = Color(255, 77, 77, 255),

    Factions = {"Jedi General Shaak Ti","Grand Admiral","Republic Intelligence","RC Clone Advisor","Clone Trooper Instructor","501st Heavy Weapons Officer","212th Heavy Ordnance Officer","Green Company Reconnaissance Officer","Galactic Marines Breaching Officer",

    "Wolfpack Reconnaissance Officer","Engineering Officer","Field Marshall", "Medical Officer","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","Grand Admiral","NSO Agent", "NSO Captain","NSO CQC Expert","NSO Medic", "Coruscant Guard General","Republic Intelligence","Coruscant Guard Commander","Coruscant Guard Executive Officer","Coruscant Guard Major","Coruscant Guard Lieutenant","Coruscant Guard ARC","Coruscant Guard Alpha ARC","Coruscant Guard Security Officer","Coruscant Guard Massif Hound","Coruscant Guard Medic Officer","Coruscant Guard Sergeant","Coruscant Guard Medic Trooper","Coruscant Guard Trooper","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander","Jedi Consular Temple Guard","Jedi Sentinel Temple Guard","Jedi Guardian Temple Guard","Jedi Chief of Security Cin Drallig"},

    CustomCheck = function(ply)



    end,

})


COMMS:RegisterChannel("Coruscant Guard Secondary", {

    Color = Color(255, 77, 77, 255),

    Factions = {"Jedi General Shaak Ti","NSO Agent", "NSO Captain","Coruscant Guard General","Republic Intelligence","Coruscant Guard Commander","Coruscant Guard Executive Officer","Coruscant Guard Major","Coruscant Guard Lieutenant","Coruscant Guard ARC","Coruscant Guard Alpha ARC","Coruscant Guard Security Officer","Coruscant Guard Massif Hound","Coruscant Guard Medic Officer","Coruscant Guard Sergeant","Coruscant Guard Medic Trooper","Coruscant Guard Trooper","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander","Jedi Consular Temple Guard","Jedi Sentinel Temple Guard","Jedi Guardian Temple Guard","Jedi Chief of Security Cin Drallig"},

    CustomCheck = function(ply)



    end,

})



COMMS:RegisterChannel("Galactic Marines", {

    Color = Color(119, 63, 202, 255),

    Factions = {"Jedi General Ki-Adi-Mundi","Grand Admiral","Republic Intelligence","RC Clone Advisor","Clone Trooper Instructor","501st Heavy Weapons Officer","212th Heavy Ordnance Officer","Green Company Reconnaissance Officer","Galactic Marines Breaching Officer",

    "Wolfpack Reconnaissance Officer","Engineering Officer","Field Marshall", "Medical Officer","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","Grand Admiral","NSO Agent", "NSO Captain","NSO CQC Expert","NSO Medic", "Galactic Marines General","Galactic Marines Breaching Officer","Galactic Marines Commander","Galactic Marines Executive Officer","Galactic Marines Major","Galactic Marines Lieutenant","Galactic Marines ARC","Galactic Marines Alpha ARC","Galactic Marines Flame Trooper","Galactic Marines Kellers Unit","Galactic Marines Medic Officer","Galactic Marines Sergeant","Galactic Marines Medic Trooper","Galactic Marines Trooper","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander"},

    CustomCheck = function(ply)



    end,

})


COMMS:RegisterChannel("GM Secondary", {

    Color = Color(119, 63, 202, 255),

    Factions = {"Jedi General Ki-Adi-Mundi","NSO Agent", "NSO Captain","Galactic Marines General","Galactic Marines Breaching Officer","Galactic Marines Commander","Galactic Marines Executive Officer","Galactic Marines Major","Galactic Marines Lieutenant","Galactic Marines ARC","Galactic Marines Alpha ARC","Galactic Marines Flame Trooper","Galactic Marines Kellers Unit","Galactic Marines Medic Officer","Galactic Marines Sergeant","Galactic Marines Medic Trooper","Galactic Marines Trooper","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander"},

    CustomCheck = function(ply)



    end,

})



COMMS:RegisterChannel("Wolfpack Battalion", {

    Color = Color(153, 144, 144, 255),

    Factions = {"Jedi General Plo Koon","Grand Admiral","Republic Intelligence","RC Clone Advisor","Clone Trooper Instructor","501st Heavy Weapons Officer","212th Heavy Ordnance Officer","Green Company Reconnaissance Officer","Galactic Marines Breaching Officer",

    "Wolfpack Reconnaissance Officer","Engineering Officer","Field Marshall", "Medical Officer","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","Grand Admiral","Wolfpack General","NSO Agent", "NSO Captain","NSO CQC Expert","NSO Medic", "Wolfpack Reconnaissance Officer","Wolfpack Commander","Wolfpack Executive Officer","Wolfpack Major","Wolfpack Lieutenant","Wolfpack ARC","Wolfpack Alpha ARC","Wolfpack Pathfinder","Wolfpack Medic Officer","Wolfpack Sergeant","Wolfpack Medic Trooper","Wolfpack Trooper","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander"},

    CustomCheck = function(ply)



    end,

})

COMMS:RegisterChannel("Wolfpack Secondary", {

    Color = Color(153, 144, 144, 255),

    Factions = {"Jedi General Plo Koon","Wolfpack General","NSO Agent", "NSO Captain","Wolfpack Reconnaissance Officer","Wolfpack Commander","Wolfpack Executive Officer","Wolfpack Major","Wolfpack Lieutenant","Wolfpack ARC","Wolfpack Alpha ARC","Wolfpack Pathfinder","Wolfpack Medic Officer","Wolfpack Sergeant","Wolfpack Medic Trooper","Wolfpack Trooper","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander"},

    CustomCheck = function(ply)



    end,

})



COMMS:RegisterChannel("Engineers", {

    Color = Color(198, 155, 61, 255),

    Factions = {"Jedi General Aayla Secura","Grand Admiral","Republic Intelligence","RC Clone Advisor","Clone Trooper Instructor","501st Heavy Weapons Officer","212th Heavy Ordnance Officer","Green Company Reconnaissance Officer","Galactic Marines Breaching Officer",

    "Wolfpack Reconnaissance Officer","Engineering Officer","Field Marshall", "Medical Officer","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","Grand Admiral","327th General","NSO Agent", "NSO Captain","NSO CQC Expert","NSO Medic", "Engineering Officer","327th Commander","327th Executive Officer","327th Major","327th Lieutenant","327th ARC","327th Alpha ARC","327th Talon Squadron","327th K Company","327th Medic Officer","327th Sergeant","327th Medic Trooper","327th Trooper","Jedi Sentinel","RC Impact","CF99 Tech","CF99 Echo","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Knight", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander"},

    CustomCheck = function(ply)



    end,

})

COMMS:RegisterChannel("Engineers Secondary", {

    Color = Color(198, 155, 61, 255),

    Factions = {"Jedi General Aayla Secura","327th General","NSO Agent", "NSO Captain","Engineering Officer","327th Commander","327th Executive Officer","327th Major","327th Lieutenant","327th ARC","327th Alpha ARC","327th Talon Squadron","327th K Company","327th Medic Officer","327th Sergeant","327th Medic Trooper","327th Trooper","Jedi Sentinel","RC Impact","CF99 Tech","CF99 Echo","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Knight", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander"},

    CustomCheck = function(ply)



    end,

})



COMMS:RegisterChannel("Cuy'val Dar", {

    Color = Color(66,67,67, 255),

    Factions = {"Jedi General Quinlan Vos","Grand Admiral","Republic Intelligence","RC Clone Advisor","Clone Trooper Instructor","501st Heavy Weapons Officer","212th Heavy Ordnance Officer","Green Company Reconnaissance Officer","Galactic Marines Breaching Officer",

    "Wolfpack Reconnaissance Officer","Engineering Officer","Field Marshall", "Medical Officer","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","Grand Admiral","Cuy'val Dar General","NSO Agent","NSO CQC Expert","NSO Medic", "NSO Captain","Shadow Field Marshall","Marshal Commander Walon Vau","Walon Vau","Kal Skirata","Fen Rau","Cuy'val Dar Officer","Cuy'val Dar Valour Lead","Cuy'val Dar Valour Trooper","Cuy'val Dar Sergeant","Cuy'val Dar Member","Mand'alor","Shadow Lead","Shadow Member","Marauder Lead","Marauder Trooper","501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander"},

    CustomCheck = function(ply)



    end,

})

COMMS:RegisterChannel("Cuy'val Dar Secondary", {

    Color = Color(66,67,67, 255),

    Factions = {"Jedi General Quinlan Vos","Cuy'val Dar General","NSO Agent","NSO CQC Expert","NSO Medic", "NSO Captain","Field Marshall","Marshal Commander Walon Vau","Walon Vau","Kal Skirata","Fen Rau","Cuy'val Dar Captain","Cuy'val Dar Officer","Cuy'val Dar Valour Lead","Cuy'val Dar Valour Trooper","Cuy'val Dar Sergeant","Cuy'val Dar Member","Mand'alor","Shadow Lead","Shadow Member","Marauder Lead","Marauder Trooper","Senate Commando", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander"},

    CustomCheck = function(ply)



    end,

})

COMMS:RegisterChannel("Cuy'val Dar Valour", {
    Color = Color(210,158,0,255),
    Factions = {"Cuy'val Dar General","NSO Agent","NSO CQC Expert","NSO Medic", "NSO Captain","Field Marshall","Marshal Commander Walon Vau","Walon Vau","Kal Skirata","Fen Rau","Mand'alor","Cuy'val Dar Valour Lead","Cuy'val Dar Valour Trooper"},
    CustomCheck = function(ply)
    end,
})

COMMS:RegisterChannel("Cuy'val Dar Shadow", {
    Color = Color(153,0,0,255),
    Factions = {"Cuy'val Dar General","NSO Agent","NSO CQC Expert","NSO Medic", "NSO Captain","Field Marshall","Marshal Commander Walon Vau","Walon Vau","Kal Skirata","Fen Rau","Mand'alor","Shadow Lead","Shadow Member"},
    CustomCheck = function(ply)
    end,
})

COMMS:RegisterChannel("Cuy'val Dar Marauder", {
    Color = Color(53,28,117,255),
    Factions = {"Cuy'val Dar General","NSO Agent","NSO CQC Expert","NSO Medic", "NSO Captain","Field Marshall","Marshal Commander Walon Vau","Walon Vau","Kal Skirata","Fen Rau","Mand'alor","Marauder Lead","Marauder Trooper",},
    CustomCheck = function(ply)
    end,
})


COMMS:RegisterChannel("Republic Commandos", {

  color = Color(255, 157, 0, 255),

    Factions = {"Jedi General Kit Fisto","Grand Admiral","Republic Intelligence","RC Clone Advisor","Clone Trooper Instructor","501st Heavy Weapons Officer","212th Heavy Ordnance Officer","Green Company Reconnaissance Officer","Galactic Marines Breaching Officer",

    "Wolfpack Reconnaissance Officer","Engineering Officer", "Medical Officer","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","Grand Admiral","RC Boss","NSO Agent", "NSO Captain","NSO CQC Expert","NSO Medic", "RC Fixer","RC Sev","RC Scorch","CF99 Hunter","CF99 Crosshair","CF99 Wrecker","CF99 Tech","CF99 Echo","RC Niner","RC Fi","RC Darman","RC Atin","RC Corr","RC Gregor","RC Charger","RC Cannon","RC Impact","RC HOPE Squad","RC Aiwha Squad","RC Aquila Squad","RC Ion Squad","RC Yayax Squad","RC General","RC Clone Advisor","RC Lieutenant","RC Sergeant","Republic Commando", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander","RC Plank","RC Vale","RC Riggs","RC Witt"},

    CustomCheck = function(ply)



    end,

})

COMMS:RegisterChannel("RC Secondary", {

  color = Color(255, 157, 0, 255),

    Factions = {"Jedi General Kit Fisto","RC Boss","NSO Agent", "NSO Captain","RC Fixer","RC Sev","RC Scorch","CF99 Hunter","CF99 Crosshair","CF99 Wrecker","CF99 Tech","CF99 Echo","RC Niner","RC Fi","RC Darman","RC Atin","RC Corr","RC Gregor","RC Charger","RC Cannon","RC Impact","RC HOPE Squad","RC Aiwha Squad","RC Aquila Squad","RC Ion Squad","RC Yayax Squad","RC General","RC Clone Advisor","RC Lieutenant","RC Sergeant","Republic Commando", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander","RC Plank","RC Vale","RC Riggs","RC Witt"},

    CustomCheck = function(ply)



    end,

})



COMMS:RegisterChannel("Jedi Council", {

    Color = Color(242, 0, 255, 255),

    Factions = {"Jedi Grand Master","Jedi Master Mace Windu","Jedi General Anakin Skywalker","Jedi General Obi-Wan Kenobi","Jedi Commander Ahsoka Tano","Jedi General Plo Koon","Jedi General Kit Fisto","Jedi General Aayla Secura","Jedi General Shaak Ti","Jedi General Ki-Adi-Mundi","Jedi General Quinlan Vos","Jedi General Luminara Unduli","Jedi Council Member"},

    CustomCheck = function(ply)



    end,

})



COMMS:RegisterChannel("The Jedi Order", {

    Color = Color(242, 0, 255, 255),

    Factions = {"Jedi Grand Master","Jedi Master Mace Windu","Jedi General Anakin Skywalker","Jedi General Obi-Wan Kenobi","Jedi Commander Ahsoka Tano","Jedi General Plo Koon","Jedi General Kit Fisto","Jedi General Aayla Secura","Jedi General Shaak Ti","Jedi General Ki-Adi-Mundi","Jedi General Quinlan Vos","Jedi General Luminara Unduli","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight","Jedi Tournament","Jedi Padawan","Jedi Youngling","Jedi Chief of Security Cin Drallig","Jedi Consular Temple Guard","Jedi Sentinel Temple Guard","Jedi Guardian Temple Guard"},

    CustomCheck = function(ply)



    end,

})

COMMS:RegisterChannel("Jedi Secondary", {

    Color = Color(242, 0, 255, 255),

    Factions = {"Jedi Grand Master","Jedi Master Mace Windu","Jedi General Anakin Skywalker","Jedi General Obi-Wan Kenobi","Jedi Commander Ahsoka Tano","Jedi General Plo Koon","Jedi General Kit Fisto","Jedi General Aayla Secura","Jedi General Shaak Ti","Jedi General Ki-Adi-Mundi","Jedi General Quinlan Vos","Jedi General Luminara Unduli","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight","Jedi Tournament","Jedi Padawan","Jedi Youngling","Jedi Chief of Security Cin Drallig","Jedi Consular Temple Guard","Jedi Sentinel Temple Guard","Jedi Guardian Temple Guard"},

    CustomCheck = function(ply)



    end,

})


COMMS:RegisterChannel("Clone Troopers", {
    Color = Color(30, 165, 232, 255),
    Factions = {"Clone Trooper Instructor","Clone Trooper JDSGT", "Clone Trooper DSGT", "Clone Trooper MDSGT", "Clone Trooper SDSGT", "Clone Trooper", "Grand Admiral","Republic Intelligence","RC Clone Advisor","Clone Trooper Instructor","Engineering Officer", "Medical Officer","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","Grand Admiral","Fleet Maverick","Fleet StarFighter Officer","Fleet Chief of Intelligence","Fleet Intelligence Officer","Fleet Director of Research and Development","Fleet Research and Development Officer"},
    CustomCheck = function(ply)
    end,
})



COMMS:RegisterChannel("Medics", {

    Color = Color(245, 56, 81, 255),

    Factions = {"Jedi Master Mace Windu","Medical General","NSO Agent", "NSO Captain","NSO CQC Expert","NSO Medic", "Medical Officer","Medical Director","Assistant Medical Director","501st Medic Officer","212th Medic Officer","Green Company Medic Officer","Galactic Marines Medic Officer","Coruscant Guard Medic Officer","Wolfpack Medic Officer","327th Medic Officer","501st Medic Trooper","212th Medic Trooper","Green Company Medic Trooper","Coruscant Guard Medic Trooper","Galactic Marines Medic Trooper","Wolfpack Medic Trooper","327th Medic Trooper"},

    CustomCheck = function(ply)



    end,

})

COMMS:RegisterChannel("Medics Secondary", {

    Color = Color(245, 56, 81, 255),

    Factions = {"Jedi Master Mace Windu","Medical General","NSO Agent", "NSO Captain","Medical Officer","Medical Director","Assistant Medical Director","501st Medic Officer","212th Medic Officer","Green Company Medic Officer","Galactic Marines Medic Officer","Coruscant Guard Medic Officer","Wolfpack Medic Officer","327th Medic Officer","501st Medic Trooper","212th Medic Trooper","Green Company Medic Trooper","Coruscant Guard Medic Trooper","Galactic Marines Medic Trooper","Wolfpack Medic Trooper","327th Medic Trooper"},

    CustomCheck = function(ply)



    end,

})

COMMS:RegisterChannel("Advanced Recon Commandos", {
    Color = Color(0, 51, 255, 255),
    Factions = {"ARC General","ARC Marshal Commander","ARC Command","NSO Agent","NSO CQC Expert","NSO Medic", "NSO Captain","Trainee ARC","501st ARC","212th ARC","Green Company ARC","Galactic Marines ARC","Coruscant Guard ARC","Wolfpack ARC","327th ARC","501st Alpha ARC", "212th Alpha ARC", "Green Company Alpha ARC", "Galactic Marines Alpha ARC", "Wolfpack Alpha ARC", "327th Alpha ARC", "Coruscant Guard Alpha ARC", "Captain of the Guard","Advisor to the Guard","Senate Commando"},
    CustomCheck = function(ply)
    end,
})

COMMS:RegisterChannel("ARC Secondary", {
    Color = Color(0, 51, 255, 255),
    Factions = {"ARC General","ARC Marshal Commander","ARC Command","NSO Agent", "NSO Captain","Trainee ARC","501st ARC","212th ARC","Green Company ARC","Galactic Marines ARC","Coruscant Guard ARC","Wolfpack ARC","327th ARC","501st Alpha ARC", "212th Alpha ARC", "Green Company Alpha ARC", "Galactic Marines Alpha ARC", "Wolfpack Alpha ARC", "327th Alpha ARC", "Coruscant Guard Alpha ARC", "Captain of the Guard","Advisor to the Guard","Senate Commando"},
    CustomCheck = function(ply)
    end,
})

COMMS:RegisterChannel("Reinforcements Comms", {
    Color = Color(51, 102, 0, 255),
    Factions = {"Dooms Unit Assault","442nd Siege Battalion","91st Marksman","Jaguar Hunters"},
    CustomCheck = function(ply)
    end,
})

COMMS:RegisterChannel("Open Comms 1", {

    Color = Color(255,255,255,255),

    Factions = {"327th General","501st General","Cuy'val Dar General","NSO Agent","Field Marshall","NSO CQC Expert","NSO Medic", "NSO Captain","Marshal Commander Walon Vau","Walon Vau","Kal Skirata","Fen Rau","Cuy'val Dar Captain","Cuy'val Dar Officer","Cuy'val Dar Guard Lead","Cuy'val Dar Guard Trooper","Cuy'val Dar Sergeant","Cuy'val Dar Member","Mand'alor","Shadow Lead","Shadow Member","Marauder Lead","Marauder Trooper","212th General","NSO Agent", "NSO CQC Expert","NSO Medic", "NSO Captain","Green Company General","Coruscant Guard General","Galactic Marines General","Wolfpack General","ARC General","RC General","Shadow General","Medical General","Supreme General","Battalion General","Assistant General", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander",  "Grand Admiral","Republic Intelligence","RC Clone Advisor","Clone Trooper Instructor","501st Heavy Weapons Officer","212th Heavy Ordnance Officer","Green Company Reconnaissance Officer","Galactic Marines Breaching Officer", "Wolfpack Reconnaissance Officer","Engineering Officer","Medical Officer","Shadow Field Marshall", "Fleet Pilot","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","501st Commander","501st Executive Officer","501st Major","501st Lieutenant","501st ARC","501st Heavy Trooper","501st Medic Officer","501st Sergeant","501st Medic Trooper","501st Trooper", "212th Commander","212th Executive Officer","212th Major","212th Lieutenant","212th ARC","212th Ghost Company","212th Medic Officer","212th Sergeant","212th Medic Trooper","212th Trooper", "Green Company General","Green Company Reconnaissance Officer","Green Company Commander","Green Company Executive Officer","Green Company Major","Green Company Lieutenant","Green Company ARC","Green Company Marksman","Green Company Ranger","Green Company Medic Officer","Green Company Sergeant","Green Company Medic Trooper","Green Company Trooper", "Coruscant Guard Commander","Coruscant Guard Executive Officer","Coruscant Guard Major","Coruscant Guard Lieutenant","Coruscant Guard ARC","Coruscant Guard Security Officer","Coruscant Guard Massif Hound","Coruscant Guard Medic Officer","Coruscant Guard Sergeant","Coruscant Guard Medic Trooper","Coruscant Guard Trooper", "Galactic Marines Commander","Galactic Marines Executive Officer","Galactic Marines Major","Galactic Marines Lieutenant","Galactic Marines ARC","Galactic Marines Flame Trooper","Galactic Marines Kellers Unit","Galactic Marines Medic Officer","Galactic Marines Sergeant","Galactic Marines Medic Trooper","Galactic Marines Trooper", "Wolfpack Commander","Wolfpack Executive Officer","Wolfpack Major","Wolfpack Lieutenant","Wolfpack ARC","Wolfpack Pathfinder","Wolfpack Medic Officer","Wolfpack Sergeant","Wolfpack Medic Trooper","Wolfpack Trooper", "327th Commander","327th Executive Officer","327th Major","327th Lieutenant","327th ARC","327th Talon Squadron","327th K Company","327th Medic Officer","327th Sergeant","327th Medic Trooper","327th Trooper", "RC Boss","RC Fixer","RC Sev","RC Scorch","CF99 Hunter","CF99 Crosshair","CF99 Wrecker","CF99 Tech","CF99 Echo","RC Niner","RC Fi","RC Darman","RC Atin","RC Corr","RC Gregor","RC Charger","RC Cannon","RC Impact","RC HOPE Squad","RC Aiwha Squad","RC Aquila Squad","RC Ion Squad","RC Yayax Squad","RC Plank","RC Vale","RC Riggs","RC Witt","RC General","RC Clone Advisor","RC Lieutenant","RC Sergeant","Republic Commando", "Jedi Grand Master","Jedi Master Mace Windu","Jedi General Anakin Skywalker","Jedi General Obi-Wan Kenobi","Jedi Commander Ahsoka Tano","Jedi General Plo Koon","Jedi General Kit Fisto","Jedi General Aayla Secura","Jedi General Shaak Ti","Jedi General Ki-Adi-Mundi","Jedi General Quinlan Vos","Jedi General Luminara Unduli","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight","Jedi Tournament","Jedi Padawan","Jedi Youngling", "Clone Trooper Instructor","Clone Trooper JDSGT", "Clone Trooper DSGT", "Clone Trooper MDSGT", "Clone Trooper SDSGT", "Clone Trooper", "Medical Officer","Medical Director","Assistant Medical Director", "ARC Command","501st Alpha ARC", "212th Alpha ARC", "Green Company Alpha ARC", "Galactic Marines Alpha ARC", "Wolfpack Alpha ARC", "327th Alpha ARC", "Coruscant Guard Alpha ARC", "Trainee ARC", "CIS Trooper","CIS Heavy Trooper","CIS Pilot","CIS Sniper","CIS Specialist","CIS Droid Commander","CIS Engineer","CIS B2 Droid","Droideka","CIS Electro Staff User","CIS Elite Captain","CIS Elite Melee","CIS Elite Marksman","CIS Elite Heavy","CIS Elite Trooper","Sith","Enemy Jetpack Trooper","Enemy Trooper","Enemy Heavy","Enemy Sniper","Enemy Specialist","Enemy Melee","Enemy Medic","Enemy Engineer","Umbaran Trooper","Umbaran Heavy Trooper","Umbaran Sniper","Umbaran Engineer","Umbaran Officer","Prisoner","Undead Clone","Republic Guard","Clone","Event Character","Republic Character","Count Dooku","Asajj Ventress","Darth Maul","General Grievous","Savage Opress","Pre Viszla","Cad Bane","Hondo Ohnaka","Bossk","Staff on Duty","Event Host", "Clone Assault", "Clone Heavy", "Clone Sniper", "Clone Medic", "Clone Pilot", "Clone Jet Trooper", "Sim Enemy Assault", "Sim Enemy Heavy", "Sim Enemy Medic", "Sim Enemy Sniper", "Sim Enemy Pilot", "Sim Enemy Jet Trooper","Clone Bomber","Jedi Chief of Security Cin Drallig","Jedi Consular Temple Guard","Jedi Sentinel Temple Guard","Jedi Guardian Temple Guard","Dooms Unit Assault","442nd Siege Battalion","91st Marksman","Jaguar Hunters","Fleet Maverick","Fleet StarFighter Officer","Fleet Chief of Intelligence","Fleet Intelligence Officer","Fleet Director of Research and Development","Fleet Research and Development Officer"},

    CustomCheck = function(ply)

    end,

})

COMMS:RegisterChannel("Open Comms 2", {

    Color = Color(255,255,255,255),

    Factions = {"327th General","501st General","212th General","Cuy'val Dar General","Field Marshall","NSO Agent","NSO CQC Expert","NSO Medic", "NSO Captain","Marshal Commander Walon Vau","Walon Vau","Kal Skirata","Fen Rau","Cuy'val Dar Captain","Cuy'val Dar Officer","Cuy'val Dar Guard Lead","Cuy'val Dar Guard Trooper","Cuy'val Dar Sergeant","Cuy'val Dar Member","Mand'alor","Shadow Lead","Shadow Member","Marauder Lead","Marauder Trooper","NSO Agent","NSO CQC Expert","NSO Medic",  "NSO Captain","Green Company General","Coruscant Guard General","Galactic Marines General","Wolfpack General","ARC General","RC General","Shadow General","Medical General","Supreme General","Battalion General","Assistant General", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander",  "Grand Admiral","Republic Intelligence","RC Clone Advisor","Clone Trooper Instructor","501st Heavy Weapons Officer","212th Heavy Ordnance Officer","Green Company Reconnaissance Officer","Galactic Marines Breaching Officer", "Wolfpack Reconnaissance Officer","Engineering Officer","Medical Officer","Shadow Field Marshall", "Fleet Pilot","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","501st Commander","501st Executive Officer","501st Major","501st Lieutenant","501st ARC","501st Heavy Trooper","501st Medic Officer","501st Sergeant","501st Medic Trooper","501st Trooper", "212th Commander","212th Executive Officer","212th Major","212th Lieutenant","212th ARC","212th Ghost Company","212th Medic Officer","212th Sergeant","212th Medic Trooper","212th Trooper", "Green Company General","Green Company Reconnaissance Officer","Green Company Commander","Green Company Executive Officer","Green Company Major","Green Company Lieutenant","Green Company ARC","Green Company Marksman","Green Company Ranger","Green Company Medic Officer","Green Company Sergeant","Green Company Medic Trooper","Green Company Trooper", "Coruscant Guard Commander","Coruscant Guard Executive Officer","Coruscant Guard Major","Coruscant Guard Lieutenant","Coruscant Guard ARC","Coruscant Guard Security Officer","Coruscant Guard Massif Hound","Coruscant Guard Medic Officer","Coruscant Guard Sergeant","Coruscant Guard Medic Trooper","Coruscant Guard Trooper", "Galactic Marines Commander","Galactic Marines Executive Officer","Galactic Marines Major","Galactic Marines Lieutenant","Galactic Marines ARC","Galactic Marines Flame Trooper","Galactic Marines Kellers Unit","Galactic Marines Medic Officer","Galactic Marines Sergeant","Galactic Marines Medic Trooper","Galactic Marines Trooper", "Wolfpack Commander","Wolfpack Executive Officer","Wolfpack Major","Wolfpack Lieutenant","Wolfpack ARC","Wolfpack Pathfinder","Wolfpack Medic Officer","Wolfpack Sergeant","Wolfpack Medic Trooper","Wolfpack Trooper", "327th Commander","327th Executive Officer","327th Major","327th Lieutenant","327th ARC","327th Talon Squadron","327th K Company","327th Medic Officer","327th Sergeant","327th Medic Trooper","327th Trooper", "RC Boss","RC Fixer","RC Sev","RC Scorch","CF99 Hunter","CF99 Crosshair","CF99 Wrecker","CF99 Tech","CF99 Echo","RC Niner","RC Fi","RC Darman","RC Atin","RC Corr","RC Gregor","RC Charger","RC Cannon","RC Impact","RC HOPE Squad","RC Aiwha Squad","RC Aquila Squad","RC Ion Squad","RC Yayax Squad","RC Plank","RC Vale","RC Riggs","RC Witt","RC General","RC Clone Advisor","RC Lieutenant","RC Sergeant","Republic Commando", "Jedi Grand Master","Jedi Master Mace Windu","Jedi General Anakin Skywalker","Jedi General Obi-Wan Kenobi","Jedi Commander Ahsoka Tano","Jedi General Plo Koon","Jedi General Kit Fisto","Jedi General Aayla Secura","Jedi General Shaak Ti","Jedi General Ki-Adi-Mundi","Jedi General Quinlan Vos","Jedi General Luminara Unduli","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight","Jedi Tournament","Jedi Padawan","Jedi Youngling", "Clone Trooper Instructor","Clone Trooper JDSGT", "Clone Trooper DSGT", "Clone Trooper MDSGT", "Clone Trooper SDSGT", "Clone Trooper", "Medical Officer","Medical Director","Assistant Medical Director", "ARC Command","501st Alpha ARC", "212th Alpha ARC", "Green Company Alpha ARC", "Galactic Marines Alpha ARC", "Wolfpack Alpha ARC", "327th Alpha ARC", "Coruscant Guard Alpha ARC", "Trainee ARC", "CIS Trooper","CIS Heavy Trooper","CIS Pilot","CIS Sniper","CIS Specialist","CIS Droid Commander","CIS Engineer","CIS B2 Droid","Droideka","CIS Electro Staff User","CIS Elite Captain","CIS Elite Melee","CIS Elite Marksman","CIS Elite Heavy","CIS Elite Trooper","Sith","Enemy Jetpack Trooper","Enemy Trooper","Enemy Heavy","Enemy Sniper","Enemy Specialist","Enemy Melee","Enemy Medic","Enemy Engineer","Umbaran Trooper","Umbaran Heavy Trooper","Umbaran Sniper","Umbaran Engineer","Umbaran Officer","Prisoner","Undead Clone","Republic Guard","Clone","Event Character","Republic Character","Count Dooku","Asajj Ventress","Darth Maul","General Grievous","Savage Opress","Pre Viszla","Cad Bane","Hondo Ohnaka","Bossk","Staff on Duty","Event Host", "Clone Assault", "Clone Heavy", "Clone Sniper", "Clone Medic", "Clone Pilot", "Clone Jet Trooper", "Sim Enemy Assault", "Sim Enemy Heavy", "Sim Enemy Medic", "Sim Enemy Sniper", "Sim Enemy Pilot", "Sim Enemy Jet Trooper","Clone Bomber","Jedi Chief of Security Cin Drallig","Jedi Consular Temple Guard","Jedi Sentinel Temple Guard","Jedi Guardian Temple Guard","Dooms Unit Assault","442nd Siege Battalion","91st Marksman","Jaguar Hunters","Fleet Maverick","Fleet StarFighter Officer","Fleet Chief of Intelligence","Fleet Intelligence Officer","Fleet Director of Research and Development","Fleet Research and Development Officer"},

    CustomCheck = function(ply)

    end,

})

COMMS:RegisterChannel("Training Comms 1", {

    Color = Color(255,255,255,255),

    Factions = {"327th General","501st General","212th General","NSO Agent","Field Marshall","Cuy'val Dar General","NSO Agent","NSO CQC Expert","NSO Medic", "NSO Captain","Marshal Commander Walon Vau","Walon Vau","Kal Skirata","Fen Rau","Cuy'val Dar Captain","Cuy'val Dar Officer","Cuy'val Dar Guard Lead","Cuy'val Dar Guard Trooper","Cuy'val Dar Sergeant","Cuy'val Dar Member","Mand'alor","Shadow Lead","Shadow Member","Marauder Lead","Marauder Trooper","NSO CQC Expert","NSO Medic", "NSO Captain","Green Company General","Coruscant Guard General","Galactic Marines General","Wolfpack General","ARC General","RC General","Shadow General","Medical General","Supreme General","Battalion General","Assistant General", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander",   "Grand Admiral","Republic Intelligence","RC Clone Advisor","Clone Trooper Instructor","501st Heavy Weapons Officer","212th Heavy Ordnance Officer","Green Company Reconnaissance Officer","Galactic Marines Breaching Officer", "Wolfpack Reconnaissance Officer","Engineering Officer","Medical Officer", "Fleet Pilot","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","501st Commander","501st Executive Officer","501st Major","501st Lieutenant","501st ARC","501st Heavy Trooper","501st Medic Officer","501st Sergeant","501st Medic Trooper","501st Trooper", "212th Commander","212th Executive Officer","212th Major","212th Lieutenant","212th ARC","212th Ghost Company","212th Medic Officer","212th Sergeant","212th Medic Trooper","212th Trooper", "Green Company General","Green Company Reconnaissance Officer","Green Company Commander","Green Company Executive Officer","Green Company Major","Green Company Lieutenant","Green Company ARC","Green Company Marksman","Green Company Ranger","Green Company Medic Officer","Green Company Sergeant","Green Company Medic Trooper","Green Company Trooper", "Coruscant Guard Commander","Coruscant Guard Executive Officer","Coruscant Guard Major","Coruscant Guard Lieutenant","Coruscant Guard ARC","Coruscant Guard Security Officer","Coruscant Guard Massif Hound","Coruscant Guard Medic Officer","Coruscant Guard Sergeant","Coruscant Guard Medic Trooper","Coruscant Guard Trooper", "Galactic Marines Commander","Galactic Marines Executive Officer","Galactic Marines Major","Galactic Marines Lieutenant","Galactic Marines ARC","Galactic Marines Flame Trooper","Galactic Marines Kellers Unit","Galactic Marines Medic Officer","Galactic Marines Sergeant","Galactic Marines Medic Trooper","Galactic Marines Trooper", "Wolfpack Commander","Wolfpack Executive Officer","Wolfpack Major","Wolfpack Lieutenant","Wolfpack ARC","Wolfpack Pathfinder","Wolfpack Medic Officer","Wolfpack Sergeant","Wolfpack Medic Trooper","Wolfpack Trooper", "327th Commander","327th Executive Officer","327th Major","327th Lieutenant","327th ARC","327th Talon Squadron","327th K Company","327th Medic Officer","327th Sergeant","327th Medic Trooper","327th Trooper", "RC Boss","RC Fixer","RC Sev","RC Scorch","CF99 Hunter","CF99 Crosshair","CF99 Wrecker","CF99 Tech","CF99 Echo","RC Niner","RC Fi","RC Darman","RC Atin","RC Corr","RC Gregor","RC Charger","RC Cannon","RC Impact","RC HOPE Squad","RC Aiwha Squad","RC Aquila Squad","RC Ion Squad","RC Yayax Squad","RC Plank","RC Vale","RC Riggs","RC Witt","RC General","RC Clone Advisor","RC Lieutenant","RC Sergeant","Republic Commando", "Jedi Grand Master","Jedi Master Mace Windu","Jedi General Anakin Skywalker","Jedi General Obi-Wan Kenobi","Jedi Commander Ahsoka Tano","Jedi General Plo Koon","Jedi General Kit Fisto","Jedi General Aayla Secura","Jedi General Shaak Ti","Jedi General Ki-Adi-Mundi","Jedi General Quinlan Vos","Jedi General Luminara Unduli","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight","Jedi Tournament","Jedi Padawan","Jedi Youngling", "Clone Trooper Instructor","Clone Trooper JDSGT", "Clone Trooper DSGT", "Clone Trooper MDSGT", "Clone Trooper SDSGT", "Clone Trooper", "Medical Officer","Medical Director","Assistant Medical Director", "ARC Command","501st Alpha ARC", "212th Alpha ARC", "Green Company Alpha ARC", "Galactic Marines Alpha ARC", "Wolfpack Alpha ARC", "327th Alpha ARC", "Coruscant Guard Alpha ARC", "Trainee ARC", "CIS Trooper","CIS Heavy Trooper","CIS Pilot","CIS Sniper","CIS Specialist","CIS Droid Commander","CIS Engineer","CIS B2 Droid","Droideka","CIS Electro Staff User","CIS Elite Captain","CIS Elite Melee","CIS Elite Marksman","CIS Elite Heavy","CIS Elite Trooper","Sith","Enemy Jetpack Trooper","Enemy Trooper","Enemy Heavy","Enemy Sniper","Enemy Specialist","Enemy Melee","Enemy Medic","Enemy Engineer","Umbaran Trooper","Umbaran Heavy Trooper","Umbaran Sniper","Umbaran Engineer","Umbaran Officer","Prisoner","Undead Clone","Republic Guard","Clone","Event Character","Republic Character","Count Dooku","Asajj Ventress","Darth Maul","General Grievous","Savage Opress","Pre Viszla","Cad Bane","Hondo Ohnaka","Bossk","Staff on Duty","Event Host", "Clone Assault", "Clone Heavy", "Clone Sniper", "Clone Medic", "Clone Pilot", "Clone Jet Trooper", "Sim Enemy Assault", "Sim Enemy Heavy", "Sim Enemy Medic", "Sim Enemy Sniper", "Sim Enemy Pilot", "Sim Enemy Jet Trooper","Clone Bomber","Jedi Chief of Security Cin Drallig","Jedi Consular Temple Guard","Jedi Sentinel Temple Guard","Jedi Guardian Temple Guard","Dooms Unit Assault","442nd Siege Battalion","91st Marksman","Jaguar Hunters","Fleet Maverick","Fleet StarFighter Officer","Fleet Chief of Intelligence","Fleet Intelligence Officer","Fleet Director of Research and Development","Fleet Research and Development Officer"},

    CustomCheck = function(ply)

    end,

})

COMMS:RegisterChannel("Training Comms 2", {

    Color = Color(255,255,255,255),

    Factions = {"327th General","501st General","212th General","NSO Agent","Field Marshall","Cuy'val Dar General","NSO Agent","NSO CQC Expert","NSO Medic", "NSO Captain","Marshal Commander Walon Vau","Walon Vau","Kal Skirata","Fen Rau","Cuy'val Dar Captain","Cuy'val Dar Officer","Cuy'val Dar Guard Lead","Cuy'val Dar Guard Trooper","Cuy'val Dar Sergeant","Cuy'val Dar Member","Mand'alor","Shadow Lead","Shadow Member","Marauder Lead","Marauder Trooper","NSO CQC Expert","NSO Medic", "NSO Captain","Green Company General","Coruscant Guard General","Galactic Marines General","Wolfpack General","ARC General","RC General","Shadow General","Medical General","Supreme General","Battalion General","Assistant General", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander",  "Grand Admiral","Republic Intelligence","RC Clone Advisor","Clone Trooper Instructor","501st Heavy Weapons Officer","212th Heavy Ordnance Officer","Green Company Reconnaissance Officer","Galactic Marines Breaching Officer", "Wolfpack Reconnaissance Officer","Engineering Officer","Medical Officer", "Fleet Pilot","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","501st Commander","501st Executive Officer","501st Major","501st Lieutenant","501st ARC","501st Heavy Trooper","501st Medic Officer","501st Sergeant","501st Medic Trooper","501st Trooper", "212th Commander","212th Executive Officer","212th Major","212th Lieutenant","212th ARC","212th Ghost Company","212th Medic Officer","212th Sergeant","212th Medic Trooper","212th Trooper", "Green Company General","Green Company Reconnaissance Officer","Green Company Commander","Green Company Executive Officer","Green Company Major","Green Company Lieutenant","Green Company ARC","Green Company Marksman","Green Company Ranger","Green Company Medic Officer","Green Company Sergeant","Green Company Medic Trooper","Green Company Trooper", "Coruscant Guard Commander","Coruscant Guard Executive Officer","Coruscant Guard Major","Coruscant Guard Lieutenant","Coruscant Guard ARC","Coruscant Guard Security Officer","Coruscant Guard Massif Hound","Coruscant Guard Medic Officer","Coruscant Guard Sergeant","Coruscant Guard Medic Trooper","Coruscant Guard Trooper", "Galactic Marines Commander","Galactic Marines Executive Officer","Galactic Marines Major","Galactic Marines Lieutenant","Galactic Marines ARC","Galactic Marines Flame Trooper","Galactic Marines Kellers Unit","Galactic Marines Medic Officer","Galactic Marines Sergeant","Galactic Marines Medic Trooper","Galactic Marines Trooper", "Wolfpack Commander","Wolfpack Executive Officer","Wolfpack Major","Wolfpack Lieutenant","Wolfpack ARC","Wolfpack Pathfinder","Wolfpack Medic Officer","Wolfpack Sergeant","Wolfpack Medic Trooper","Wolfpack Trooper", "327th Commander","327th Executive Officer","327th Major","327th Lieutenant","327th ARC","327th Talon Squadron","327th K Company","327th Medic Officer","327th Sergeant","327th Medic Trooper","327th Trooper", "RC Boss","RC Fixer","RC Sev","RC Scorch","CF99 Hunter","CF99 Crosshair","CF99 Wrecker","CF99 Tech","CF99 Echo","RC Niner","RC Fi","RC Darman","RC Atin","RC Corr","RC Gregor","RC Charger","RC Cannon","RC Impact","RC HOPE Squad","RC Aiwha Squad","RC Aquila Squad","RC Ion Squad","RC Yayax Squad","RC Plank","RC Vale","RC Riggs","RC Witt","RC General","RC Clone Advisor","RC Lieutenant","RC Sergeant","Republic Commando", "Jedi Grand Master","Jedi Master Mace Windu","Jedi General Anakin Skywalker","Jedi General Obi-Wan Kenobi","Jedi Commander Ahsoka Tano","Jedi General Plo Koon","Jedi General Kit Fisto","Jedi General Aayla Secura","Jedi General Shaak Ti","Jedi General Ki-Adi-Mundi","Jedi General Quinlan Vos","Jedi General Luminara Unduli","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight","Jedi Tournament","Jedi Padawan","Jedi Youngling", "Clone Trooper Instructor","Clone Trooper JDSGT", "Clone Trooper DSGT", "Clone Trooper MDSGT", "Clone Trooper SDSGT", "Clone Trooper", "Medical Officer","Medical Director","Assistant Medical Director", "ARC Command","501st Alpha ARC", "212th Alpha ARC", "Green Company Alpha ARC", "Galactic Marines Alpha ARC", "Wolfpack Alpha ARC", "327th Alpha ARC", "Coruscant Guard Alpha ARC", "Trainee ARC", "CIS Trooper","CIS Heavy Trooper","CIS Pilot","CIS Sniper","CIS Specialist","CIS Droid Commander","CIS Engineer","CIS B2 Droid","Droideka","CIS Electro Staff User","CIS Elite Captain","CIS Elite Melee","CIS Elite Marksman","CIS Elite Heavy","CIS Elite Trooper","Sith","Enemy Jetpack Trooper","Enemy Trooper","Enemy Heavy","Enemy Sniper","Enemy Specialist","Enemy Melee","Enemy Medic","Enemy Engineer","Umbaran Trooper","Umbaran Heavy Trooper","Umbaran Sniper","Umbaran Engineer","Umbaran Officer","Prisoner","Undead Clone","Republic Guard","Clone","Event Character","Republic Character","Count Dooku","Asajj Ventress","Darth Maul","General Grievous","Savage Opress","Pre Viszla","Cad Bane","Hondo Ohnaka","Bossk","Staff on Duty","Event Host", "Clone Assault", "Clone Heavy", "Clone Sniper", "Clone Medic", "Clone Pilot", "Clone Jet Trooper", "Sim Enemy Assault", "Sim Enemy Heavy", "Sim Enemy Medic", "Sim Enemy Sniper", "Sim Enemy Pilot", "Sim Enemy Jet Trooper","Clone Bomber","Jedi Chief of Security Cin Drallig","Jedi Consular Temple Guard","Jedi Sentinel Temple Guard","Jedi Guardian Temple Guard","Dooms Unit Assault","442nd Siege Battalion","91st Marksman","Jaguar Hunters","Fleet Maverick","Fleet StarFighter Officer","Fleet Chief of Intelligence","Fleet Intelligence Officer","Fleet Director of Research and Development","Fleet Research and Development Officer"},

    CustomCheck = function(ply)

    end,

})

COMMS:RegisterChannel("Training Comms 3", {

    Color = Color(255,255,255,255),

    Factions = {"327th General","501st General","212th General","NSO Agent", "NSO CQC Expert","Field Marshall","Cuy'val Dar General","NSO Agent","NSO CQC Expert","NSO Medic", "NSO Captain","Marshal Commander Walon Vau","Walon Vau","Kal Skirata","Fen Rau","Cuy'val Dar Captain","Cuy'val Dar Officer","Cuy'val Dar Guard Lead","Cuy'val Dar Guard Trooper","Cuy'val Dar Sergeant","Cuy'val Dar Member","Mand'alor","Shadow Lead","Shadow Member","Marauder Lead","Marauder Trooper","NSO Medic","NSO Captain","Green Company General","Coruscant Guard General","Galactic Marines General","Wolfpack General","ARC General","RC General","Shadow General","Medical General","Supreme General","Battalion General","Assistant General", "501st Marshal Commander", "212th Marshal Commander", "Green Company Marshal Commander", "Coruscant Guard Marshal Commander", "Galactic Marines Marshal Commander", "Wolfpack Marshal Commander", "327th Marshal Commander", "ARC Marshal Commander", "RC Marshal Commander", "Shadow Marshal Commander", "Medical Marshal Commander",  "Grand Admiral","Republic Intelligence","RC Clone Advisor","Clone Trooper Instructor","501st Heavy Weapons Officer","212th Heavy Ordnance Officer","Green Company Reconnaissance Officer","Galactic Marines Breaching Officer", "Wolfpack Reconnaissance Officer","Engineering Officer","Medical Officer", "Fleet Pilot","Fleet Recruit","Fleet Member","Fleet High Ranking","Fleet Admiral","501st Commander","501st Executive Officer","501st Major","501st Lieutenant","501st ARC","501st Heavy Trooper","501st Medic Officer","501st Sergeant","501st Medic Trooper","501st Trooper", "212th Commander","212th Executive Officer","212th Major","212th Lieutenant","212th ARC","212th Ghost Company","212th Medic Officer","212th Sergeant","212th Medic Trooper","212th Trooper", "Green Company General","Green Company Reconnaissance Officer","Green Company Commander","Green Company Executive Officer","Green Company Major","Green Company Lieutenant","Green Company ARC","Green Company Marksman","Green Company Ranger","Green Company Medic Officer","Green Company Sergeant","Green Company Medic Trooper","Green Company Trooper", "Coruscant Guard Commander","Coruscant Guard Executive Officer","Coruscant Guard Major","Coruscant Guard Lieutenant","Coruscant Guard ARC","Coruscant Guard Security Officer","Coruscant Guard Massif Hound","Coruscant Guard Medic Officer","Coruscant Guard Sergeant","Coruscant Guard Medic Trooper","Coruscant Guard Trooper", "Galactic Marines Commander","Galactic Marines Executive Officer","Galactic Marines Major","Galactic Marines Lieutenant","Galactic Marines ARC","Galactic Marines Flame Trooper","Galactic Marines Kellers Unit","Galactic Marines Medic Officer","Galactic Marines Sergeant","Galactic Marines Medic Trooper","Galactic Marines Trooper", "Wolfpack Commander","Wolfpack Executive Officer","Wolfpack Major","Wolfpack Lieutenant","Wolfpack ARC","Wolfpack Pathfinder","Wolfpack Medic Officer","Wolfpack Sergeant","Wolfpack Medic Trooper","Wolfpack Trooper", "327th Commander","327th Executive Officer","327th Major","327th Lieutenant","327th ARC","327th Talon Squadron","327th K Company","327th Medic Officer","327th Sergeant","327th Medic Trooper","327th Trooper", "RC Boss","RC Fixer","RC Sev","RC Scorch","CF99 Hunter","CF99 Crosshair","CF99 Wrecker","CF99 Tech","CF99 Echo","RC Niner","RC Fi","RC Darman","RC Atin","RC Corr","RC Gregor","RC Charger","RC Cannon","RC Impact","RC HOPE Squad","RC Aiwha Squad","RC Aquila Squad","RC Ion Squad","RC Yayax Squad","RC Plank","RC Vale","RC Riggs","RC Witt","RC General","RC Clone Advisor","RC Lieutenant","RC Sergeant","Republic Commando", "Jedi Grand Master","Jedi Master Mace Windu","Jedi General Anakin Skywalker","Jedi General Obi-Wan Kenobi","Jedi Commander Ahsoka Tano","Jedi General Plo Koon","Jedi General Kit Fisto","Jedi General Aayla Secura","Jedi General Shaak Ti","Jedi General Ki-Adi-Mundi","Jedi General Quinlan Vos","Jedi General Luminara Unduli","Jedi Council Member","Jedi Consular","Jedi Guardian","Jedi Sentinel","Jedi Knight","Jedi Tournament","Jedi Padawan","Jedi Youngling", "Clone Trooper Instructor","Clone Trooper JDSGT", "Clone Trooper DSGT", "Clone Trooper MDSGT", "Clone Trooper SDSGT", "Clone Trooper", "Medical Officer","Medical Director","Assistant Medical Director", "ARC Command","501st Alpha ARC", "212th Alpha ARC", "Green Company Alpha ARC", "Galactic Marines Alpha ARC", "Wolfpack Alpha ARC", "327th Alpha ARC", "Coruscant Guard Alpha ARC", "Trainee ARC", "CIS Trooper","CIS Heavy Trooper","CIS Pilot","CIS Sniper","CIS Specialist","CIS Droid Commander","CIS Engineer","CIS B2 Droid","Droideka","CIS Electro Staff User","CIS Elite Captain","CIS Elite Melee","CIS Elite Marksman","CIS Elite Heavy","CIS Elite Trooper","Sith","Enemy Jetpack Trooper","Enemy Trooper","Enemy Heavy","Enemy Sniper","Enemy Specialist","Enemy Melee","Enemy Medic","Enemy Engineer","Umbaran Trooper","Umbaran Heavy Trooper","Umbaran Sniper","Umbaran Engineer","Umbaran Officer","Prisoner","Undead Clone","Republic Guard","Clone","Event Character","Republic Character","Count Dooku","Asajj Ventress","Darth Maul","General Grievous","Savage Opress","Pre Viszla","Cad Bane","Hondo Ohnaka","Bossk","Staff on Duty","Event Host", "Clone Assault", "Clone Heavy", "Clone Sniper", "Clone Medic", "Clone Pilot", "Clone Jet Trooper", "Sim Enemy Assault", "Sim Enemy Heavy", "Sim Enemy Medic", "Sim Enemy Sniper", "Sim Enemy Pilot", "Sim Enemy Jet Trooper","Clone Bomber","Jedi Chief of Security Cin Drallig","Jedi Consular Temple Guard","Jedi Sentinel Temple Guard","Jedi Guardian Temple Guard","Dooms Unit Assault","442nd Siege Battalion","91st Marksman","Jaguar Hunters","Fleet Maverick","Fleet StarFighter Officer","Fleet Chief of Intelligence","Fleet Intelligence Officer","Fleet Director of Research and Development","Fleet Research and Development Officer"},

    CustomCheck = function(ply)

    end,

})

COMMS:RegisterChannel("Event One", {

    Color = Color(204, 0, 0, 255),

    Factions = {"CIS Trooper","CIS Heavy Trooper","CIS Pilot","CIS Sniper","CIS Specialist","CIS Droid Commander","CIS Engineer","CIS B2 Droid","Droideka","CIS Electro Staff User","CIS Elite Captain","CIS Elite Melee","CIS Elite Marksman","CIS Elite Heavy","CIS Elite Trooper","Sith","Enemy Jetpack Trooper","Enemy Trooper","Enemy Heavy","Enemy Sniper","Enemy Specialist","Enemy Melee","Enemy Medic","Enemy Engineer","Umbaran Trooper","Umbaran Heavy Trooper","Umbaran Sniper","Umbaran Engineer","Umbaran Officer","Prisoner","Undead Clone","Republic Guard","Clone","Event Character","Republic Character","Count Dooku","Asajj Ventress","Darth Maul","General Grievous","Savage Opress","Pre Viszla","Cad Bane","Hondo Ohnaka","Bossk","Staff on Duty","Event Host"},

    CustomCheck = function(ply)

    end,

})



COMMS:RegisterChannel("Event Two", {

    Color = Color(204, 0, 0, 255),

    Factions = {"CIS Trooper","CIS Heavy Trooper","CIS Pilot","CIS Sniper","CIS Specialist","CIS Droid Commander","CIS Engineer","CIS B2 Droid","Droideka","CIS Electro Staff User","CIS Elite Captain","CIS Elite Melee","CIS Elite Marksman","CIS Elite Heavy","CIS Elite Trooper","Sith","Enemy Jetpack Trooper","Enemy Trooper","Enemy Heavy","Enemy Sniper","Enemy Specialist","Enemy Melee","Enemy Medic","Enemy Engineer","Umbaran Trooper","Umbaran Heavy Trooper","Umbaran Sniper","Umbaran Engineer","Umbaran Officer","Prisoner","Undead Clone","Republic Guard","Clone","Event Character","Republic Character","Count Dooku","Asajj Ventress","Darth Maul","General Grievous","Savage Opress","Pre Viszla","Cad Bane","Hondo Ohnaka","Bossk","Staff on Duty","Event Host"},

    CustomCheck = function(ply)

    end,

})




--[[

COMMS:RegisterChannel("NAME", {

    Color = Color(176, 184, 182, 180),

    Factions = {"JOB"},

    CustomCheck = function(ply)



    end,

})

--]]
