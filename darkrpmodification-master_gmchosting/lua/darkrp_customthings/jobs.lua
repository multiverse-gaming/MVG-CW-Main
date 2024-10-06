--[[---------------------------------------------------------------------------

DarkRP custom jobs

---------------------------------------------------------------------------

This file contains your custom jobs.

This file should also contain jobs from DarkRP that you edited.



Note: If you want to edit a default DarkRP job, first disable it in darkrp_config/disabled_defaults.lua

      Once you've done that, copy and paste the job to this file and edit it.



The default jobs can be found here:

https://github.com/FPtje/DarkRP/blob/master/gamemode/config/jobrelated.lua



For examples and explanation please visit this wiki page:

https://darkrp.miraheze.org/wiki/DarkRP:CustomJobFields



Add your custom jobs under the following line:

---------------------------------------------------------------------------]]





--## CLONE TROOPERS ##--

TEAM_CADET = DarkRP.createJob("Cadet", {

    color = Color(209, 219, 20, 255),

    model = {"models/player/olive/cadet/cadet.mdl"},

    description = [[Congratulations, new arrival to the Titan's Battalion!]],

    weapons = {"arccw_dc15a_v2_trn","arccw_dc17_training_v2", "arccw_dc15s_training_v2"},

    command = "cadet",

    max = 0,

    salary = 100,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Recruits",

    candemote = false,

    PlayerSpawn = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 2

})



--## CLONE TROOPERS ##--

TEAM_CT = DarkRP.createJob("Clone Trooper", {

    color = Color(30, 165, 232, 255),

    model = {"models/aussiwozzi/cgi/base/unassigned_trp.mdl"},

    description = [[Congratulations, you have made it as a shinie!]],

    weapons = {"arccw_dc15s_v2", "arccw_dc15a_v2"},

    command = "clone",

    max = 0,

    salary = 150,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Clone Trooper",

    candemote = false,

    PlayerSpawn = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 1

})



TEAM_CTJDSGT = DarkRP.createJob("Clone Trooper JDSGT", {

    color = Color(30, 165, 232, 255),

    model = {"models/aussiwozzi/cgi/base/unassigned_sgt.mdl"},

    description = [[Congratulations, you are a Clone Trooper Junior Drill Sergeant!]],

    weapons = {"arccw_dc15s_v2", "arccw_dc15a_v2", "arccw_dc17_v2", "stunstick", "weapon_cuff_elastic"},

    command = "clonejdsgt",

    max = 9,

    salary = 150,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Clone Trooper",

    candemote = false,

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 3

})


TEAM_CTDSGT = DarkRP.createJob("Clone Trooper DSGT", {

    color = Color(30, 165, 232, 255),

    model = {"models/aussiwozzi/cgi/base/unassigned_lt.mdl"},

    description = [[Congratulations, you are a Clone Trooper Drill Sergeant!]],

    weapons = {"arccw_dc15s_v2", "arccw_dc15a_v2", "arccw_dc17_v2", "stunstick", "weapon_cuff_elastic"},

    command = "clonedsgt",

    max = 9,

    salary = 150,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Clone Trooper",

    candemote = false,

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 4

})

TEAM_CTMDSGT = DarkRP.createJob("Clone Trooper MDSGT", {

    color = Color(30, 165, 232, 255),

    model = {"models/aussiwozzi/cgi/base/unassigned_cpt.mdl"},

    description = [[Congratulations, you are a Clone Trooper Master Drill Sergeant!]],

    weapons = {"arccw_dc15s_v2", "arccw_dc15a_v2", "arccw_duals_dc17ext_v2", "stunstick", "weapon_cuff_elastic"},

    command = "clonemdsgt",

    max = 2,

    salary = 150,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Clone Trooper",

    candemote = false,

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 5

})

TEAM_CTSDSGT = DarkRP.createJob("Clone Trooper SDSGT", {

    color = Color(30, 165, 232, 255),

    model = {"models/aussiwozzi/cgi/base/howzer.mdl"},

    description = [[Congratulations, you are a Clone Trooper Senior Drill Sergeant!]],

    weapons = {"arccw_dc15s_v2", "arccw_dc15a_v2", "arccw_duals_dc17ext_v2", "stunstick", "weapon_cuff_elastic"},

    command = "clonesdsgt",

    max = 1,

    salary = 150,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Clone Trooper",

    candemote = false,

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 6

})



-- 501st LEGION --

TEAM_501STGENERAL = DarkRP.createJob("501st General", {

    color = Color(0, 51, 255, 255),

    model = {"models/toe/cgi/gens/gen_acolyte.mdl", "models/toe/cgi/gens/gen_archer.mdl", "models/toe/cgi/gens/gen_id.mdl", "models/toe/cgi/gens/gen_foxjack.mdl", "models/toe/cgi/gens/gen_matrix.mdl", "models/toe/cgi/gens/gen_nomad.mdl", "models/aussiwozzi/cgi/base/501st_rex.mdl", "models/naval_offduty/pm_naval_cas.mdl", "models/jajoff/sps/republic/tc13j/rsb01.mdl"},

    description = [[Congratulations, you are the Deployed General of the 501st Legion!]],

    weapons = {"arccw_dc15le_v2", "arccw_duals_dc17ext_v2", "arccw_meeks_z6","personal_shield_activator", "realistic_hook", "weapon_officerboost_501st", "tfa_sparks_501st","weapon_remotedrone","datapad_player"},

    command = "501stgen",

    max = 2,

    salary = 300,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "501st Legion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 0

})


TEAM_501STMCOMMANDER = DarkRP.createJob("501st Marshal Commander", {

    color = Color(0, 51, 255, 255),

    model = {"models/aussiwozzi/cgi/base/501st_rex.mdl","models/aussiwozzi/cgi/base/224th_toast.mdl","models/zeus/22nd_dempsey_rh.mdl", "models/aussiwozzi/cgi/base/advisor_red.mdl","models/aussiwozzi/cgi/base/advisor_grey.mdl", "models/aussiwozzi/cgi/base/advisor_green.mdl", "models/aussiwozzi/cgi/base/advisor_blue.mdl", "models/aussiwozzi/cgi/base/501st_atoa3.mdl","models/aussiwozzi/cgi/base/501st_sarge.mdl","models/aussiwozzi/cgi/base/501st_appo.mdl","models/aussiwozzi/cgi/base/501st_vaughn.mdl","models/aussiwozzi/cgi/base/501st_trooper.mdl","models/jajoff/sps/republic/tc13j/rsb02.mdl"},

    description = [[Congratulations, you are the Marshal Commander of the 501st Legion!]],

    weapons = {"arccw_dc15le_v2", "arccw_duals_dc17ext_v2", "arccw_meeks_z6", "personal_shield_activator", "weapon_officerboost_501st"},

    command = "501stmco",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "501st Legion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 2

})

TEAM_501STCOMMANDER = DarkRP.createJob("501st Commander", {

    color = Color(0, 51, 255, 255),

    model = {"models/aussiwozzi/cgi/base/501st_rex.mdl","models/aussiwozzi/cgi/base/501st_atoa3.mdl","models/aussiwozzi/cgi/base/501st_sarge.mdl","models/aussiwozzi/cgi/base/501st_appo.mdl","models/aussiwozzi/cgi/base/501st_vaughn.mdl","models/aussiwozzi/cgi/base/501st_trooper.mdl"},

    description = [[Congratulations, you are the Commander of the 501st Legion!]],

    weapons = {"arccw_dc15le_v2", "arccw_duals_dc17ext_v2", "arccw_meeks_z6","personal_shield_activator", "weapon_officerboost_501st"},

    command = "501stco",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "501st Legion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(600) ply:SetHealth(600) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 3

})



TEAM_501STEXECUTIVEOFFICER = DarkRP.createJob("501st Executive Officer", {

    color = Color(0, 51, 255, 255),

    model = {"models/aussiwozzi/cgi/base/501st_appo.mdl","models/aussiwozzi/cgi/base/501st_atoa3.mdl","models/aussiwozzi/cgi/base/501st_sarge.mdl","models/aussiwozzi/cgi/base/501st_rex.mdl","models/aussiwozzi/cgi/base/501st_vaughn.mdl","models/aussiwozzi/cgi/base/501st_trooper.mdl"},

    description = [[Congratulations, you are the Executive Officer of the 501st Legion!]],

    weapons = {"arccw_dc15le_v2", "arccw_duals_dc17ext_v2", "arccw_meeks_z6","personal_shield_activator", "weapon_officerboost_501st"},

    command = "501stxo",

    max = 1,

    salary = 250,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "501st Legion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 4

})



TEAM_501STMAJOR = DarkRP.createJob("501st Major", {

    color = Color(0, 51, 255, 255),

    model = {"models/aussiwozzi/cgi/base/501st_appo.mdl","models/aussiwozzi/cgi/base/501st_atoa3.mdl","models/aussiwozzi/cgi/base/501st_sarge.mdl","models/aussiwozzi/cgi/base/501st_trooper.mdl","models/aussiwozzi/cgi/base/501st_rex.mdl","models/aussiwozzi/cgi/base/501st_vaughn.mdl"},

    description = [[Congratulations, you are the Major of the 501st Legion!]],

    weapons = {"arccw_dc15le_v2", "arccw_duals_dc17ext_v2", "arccw_meeks_z6","personal_shield_activator", "weapon_officerboost_501st"},

    command = "501stmjr",

    max = 1,

    salary = 225,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "501st Legion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 5

})



TEAM_501STLIEUTENANT = DarkRP.createJob("501st Lieutenant", {

    color = Color(0, 51, 255, 255),

    model = {"models/aussiwozzi/cgi/base/501st_sarge.mdl","models/aussiwozzi/cgi/base/501st_trooper.mdl","models/aussiwozzi/cgi/base/501st_rex.mdl","models/aussiwozzi/cgi/base/501st_raffle.mdl","models/aussiwozzi/cgi/base/501st_atoa3.mdl","models/aussiwozzi/cgi/base/501st_atoa.mdl","models/aussiwozzi/cgi/base/501st_brighton.mdl","models/aussiwozzi/cgi/base/501st_pork.mdl","models/aussiwozzi/cgi/base/501st_scar.mdl","models/aussiwozzi/cgi/base/501st_boomer.mdl","models/aussiwozzi/cgi/base/501st_atoa2.mdl","models/aussiwozzi/cgi/base/501st_jet_trooper.mdl","models/aussiwozzi/cgi/base/501st_dogma.mdl","models/aussiwozzi/cgi/base/501st_arf.mdl","models/aussiwozzi/cgi/base/501st_barc.mdl","models/aussiwozzi/cgi/base/501st_tup.mdl","models/aussiwozzi/cgi/base/501st_hardcase.mdl","models/aussiwozzi/cgi/base/501st_vaughn.mdl", "models/aussiwozzi/cgi/base/501st_knotts.mdl", "models/aussiwozzi/cgi/base/501st_torrent_officer.mdl", "models/aussiwozzi/cgi/base/501st_torrent.mdl"},

    description = [[Congratulations, you are a Lieutenant of the 501st Legion!]],

    weapons = {"arccw_dc15le_v2","arccw_meeks_z6","personal_shield_activator","arccw_dc17_v2"},

    command = "501stlt",

    max = 6,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "501st Legion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)   end,

    sortOrder = 6

})



TEAM_501STJUGGERNAUT = DarkRP.createJob("501st Heavy Trooper", {

    color = Color(0, 51, 255, 255),

    model = {"models/aussiwozzi/cgi/base/501st_trooper.mdl","models/aussiwozzi/cgi/base/501st_sarge.mdl","models/aussiwozzi/cgi/base/501st_rex.mdl","models/aussiwozzi/cgi/base/501st_raffle.mdl","models/aussiwozzi/cgi/base/501st_atoa.mdl","models/aussiwozzi/cgi/base/501st_brighton.mdl","models/aussiwozzi/cgi/base/501st_pork.mdl","models/aussiwozzi/cgi/base/501st_scar.mdl","models/aussiwozzi/cgi/base/501st_boomer.mdl","models/aussiwozzi/cgi/base/501st_atoa2.mdl","models/aussiwozzi/cgi/base/501st_jet_trooper.mdl","models/aussiwozzi/cgi/base/501st_dogma.mdl","models/aussiwozzi/cgi/base/501st_arf.mdl","models/aussiwozzi/cgi/base/501st_barc.mdl","models/aussiwozzi/cgi/base/501st_tup.mdl","models/aussiwozzi/cgi/base/501st_hardcase.mdl","models/aussiwozzi/cgi/base/501st_appo.mdl", "models/aussiwozzi/cgi/base/501st_knotts.mdl","models/aussiwozzi/cgi/base/501st_torrent_officer.mdl", "models/aussiwozzi/cgi/base/501st_torrent.mdl","models/herm/cgi_new/501st/501st_trooper2.mdl","models/aussiwozzi/cgi/base/501st_atoa3.mdl"},

    description = [[Congratulations, you are a Heavy Trooper of the 501st Legion!]],

    weapons = {"arccw_dc15le_v2", "arccw_meeks_z6", "arccw_dc17_v2", "weapon_officerboost_501st"},

    command = "501stjug",

    max = 3,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "501st Legion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 7

})

TEAM_ARCALPHA501st = DarkRP.createJob("501st Alpha ARC", {

    color = Color(0, 51, 255, 255),

    model = {"models/aussiwozzi/cgi/base/arc_cpt_grenadier.mdl","models/aussiwozzi/cgi/base/arc_sgt_grenadier.mdl","models/aussiwozzi/cgi/base/arc_lt_grenadier.mdl","models/aussiwozzi/cgi/base/501st_trooper.mdl","models/aussiwozzi/cgi/base/501st_arc_cobalt.mdl","models/aussiwozzi/cgi/base/501st_jesse_arc.mdl","models/aussiwozzi/cgi/base/501st_fives.mdl","models/aussiwozzi/cgi/base/501st_arc.mdl","models/aussiwozzi/cgi/base/arc_cpt.mdl","models/aussiwozzi/cgi/base/arc_cpt_marksman.mdl", "models/aussiwozzi/cgi/base/arc_cpt_heavy.mdl","models/aussiwozzi/cgi/base/arc_cpt_rat.mdl","models/aussiwozzi/cgi/base/arc_cpt_medic.mdl","models/aussiwozzi/cgi/base/arc_cpt_pab.mdl", "models/aussiwozzi/cgi/base/arc_lt.mdl", "models/aussiwozzi/cgi/base/arc_lt_marksman.mdl", "models/aussiwozzi/cgi/base/arc_lt_heavy.mdl","models/aussiwozzi/cgi/base/arc_lt_medic.mdl","models/aussiwozzi/cgi/base/arc_lt_chunky.mdl", "models/aussiwozzi/cgi/base/arc_raffle.mdl","models/aussiwozzi/cgi/base/arc_cpt_jarr.mdl","models/aussiwozzi/cgi/base/arc_sgt.mdl","models/aussiwozzi/cgi/base/arc_sgt_marksman.mdl", "models/aussiwozzi/cgi/base/arc_sgt_heavy.mdl","models/aussiwozzi/cgi/base/arc_sgt_medic.mdl","models/aussiwozzi/cgi/base/arc_sgt_spida.mdl","models/aussiwozzi/cgi/base/arc_lt_macka.mdl","models/aussiwozzi/cgi/base/arc_cpt_shadowz.mdl"},

    description = [[Congratulations, you are ARC Alpha 501st!]],

    weapons = {"arccw_westarm5_v2", "arccw_dual_dc17s", "realistic_hook", "personal_shield_activator", "carkeys"},

    command = "arca501st",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "501st Legion",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 8

})


TEAM_501STARC = DarkRP.createJob("501st ARC", {

    color = Color(0, 51, 255, 255),

    model = {"models/aussiwozzi/cgi/base/501st_trooper.mdl","models/aussiwozzi/cgi/base/501st_arc_cobalt.mdl","models/aussiwozzi/cgi/base/501st_jesse_arc.mdl","models/aussiwozzi/cgi/base/501st_fives.mdl","models/aussiwozzi/cgi/base/501st_arc.mdl"},

    description = [[Congratulations, you are 501st ARC Trooper!]],

    weapons = {"arccw_westarm5_v2", "arccw_dual_dc17s", "realistic_hook","personal_shield_activator"},

    command = "501starc",

    max = 2,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "501st Legion",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 8

})



TEAM_501STMEDOFFICER = DarkRP.createJob("501st Medic Officer", {

    color = Color(0, 51, 255, 255),

    model = {"models/aussiwozzi/cgi/base/501st_medic_officer.mdl","models/aussiwozzi/cgi/base/501st_kix.mdl"},

    description = [[Congratulations, you are the Medical Officer of the 501st Legion!]],

    weapons = {"arccw_dc15le_v2", "arccw_dc17_v2", "lord_chrome_medkit", "weapon_bactainjector", "personal_shield_activator","weapon_jew_stimkit", "weapon_defibrillator", "arccw_bacta_grenade", "tf_weapon_medigun", "realistic_hook", "carkeys"},

    command = "501stmo",

    max = 1,

    salary = 175,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "501st Legion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 9

})



TEAM_501STSERGEANT = DarkRP.createJob("501st Sergeant", {

    color = Color(0, 51, 255, 255),

    model = {"models/aussiwozzi/cgi/base/501st_trooper.mdl","models/aussiwozzi/cgi/base/501st_raffle.mdl","models/aussiwozzi/cgi/base/501st_atoa.mdl","models/aussiwozzi/cgi/base/501st_brighton.mdl","models/aussiwozzi/cgi/base/501st_scar.mdl","models/aussiwozzi/cgi/base/501st_boomer.mdl","models/aussiwozzi/cgi/base/501st_jet_trooper.mdl","models/aussiwozzi/cgi/base/501st_dogma.mdl","models/aussiwozzi/cgi/base/501st_arf.mdl","models/aussiwozzi/cgi/base/501st_barc.mdl","models/aussiwozzi/cgi/base/501st_tup.mdl","models/aussiwozzi/cgi/base/501st_pork.mdl","models/aussiwozzi/cgi/base/501st_hardcase.mdl", "models/aussiwozzi/cgi/base/501st_knotts.mdl"},

    description = [[Congratulations, you are a Sergeant of the 501st Legion!]],

    weapons = {"arccw_dc15le_v2", "personal_shield_activator","arccw_dc17_v2"},

    command = "501stsgt",

    max = 0,

    salary = 175,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "501st Legion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 10

})



TEAM_501STMEDTROOPER = DarkRP.createJob("501st Medic Trooper", {

    color = Color(0, 51, 255, 255),

    model = {"models/aussiwozzi/cgi/base/501st_medic.mdl","models/aussiwozzi/cgi/base/501st_kix.mdl"},

    description = [[Congratulations, you are a Medic of the 501st Legion!]],

    weapons = {"arccw_dc15le_v2", "arccw_dc17_v2", "lord_chrome_medkit", "personal_shield_activator","weapon_bactainjector", "weapon_jew_stimkit", "weapon_defibrillator", "realistic_hook", "carkeys"},

    command = "501stmt",

    max = 3,

    salary = 150,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "501st Legion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 11

})



TEAM_501STTROOPER = DarkRP.createJob("501st Trooper", {

    color = Color(0, 51, 255, 255),

 model = {"models/aussiwozzi/cgi/base/501st_trooper.mdl"},

    description = [[Congratulations, you are a Trooper of the 501st Legion!]],

    weapons = {"arccw_dc15le_v2", "personal_shield_activator","arccw_dc17_v2"},

    command = "501sttrp",

    max = 0,

    salary = 150,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "501st Legion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 12

})

TEAM_501STJEDI = DarkRP.createJob("501st Jedi", {
    color = Color(0, 51, 255, 255),
    model = {"models/aussiwozzi/cgi/base/jedi_rahm_kota.mdl",
    "models/aussiwozzi/cgi/base/jedi_bultar_swan.mdl",
    "models/tfa/comm/gg/pm_sw_adigallia.mdl",
    "models/tfa/comm/gg/pm_sw_barriss.mdl",
    "models/tfa/comm/gg/pm_sw_eeth_koth.mdl",
    "models/tfa/comm/gg/pm_sw_imagundi.mdl",
    "models/gonzo/saeseetiin/saeseetiin.mdl",
    "models/player/jedi/nyssa_delacor.mdl",
    "models/player/jedi/female_chiss_consular.mdl",
    "models/player/jedi/female_human_consular.mdl",
    "models/player/jedi/female_kaleesh_consular.mdl",
    "models/player/jedi/female_keldoran_consular.mdl",
    "models/player/jedi/female_pantoran_consular.mdl",
    "models/player/jedi/female_rodian_consular.mdl",
    "models/player/jedi/female_tholothian_consular.mdl",
    "models/player/jedi/female_zabrak_consular.mdl",
    "models/player/jedi/male_chiss_consular.mdl",
    "models/player/jedi/male_human_consular.mdl",
    "models/player/jedi/male_kaleesh_consular.mdl",
    "models/player/jedi/male_keldoran_consular.mdl",
    "models/player/jedi/male_tholothian_consular.mdl",
    "models/player/jedi/male_zabrak_consular.mdl",
    "models/player/jedi/pantoran_male_consular.mdl",
    "models/player/jedi/rodian_male_consular.mdl",
    "models/player/jedi/twilek_consular_male.mdl",
    "models/player/jedi/twilek_female_consular.mdl",
    "models/player/jedi/female_chiss_guardian.mdl",
    "models/player/jedi/female_human_guardian.mdl",
    "models/player/jedi/female_kaleesh_guardian.mdl",
    "models/player/jedi/female_keldoran_guardian.mdl",
    "models/player/jedi/female_pantoran_guardian.mdl",
    "models/player/jedi/female_rodian_guardian.mdl",
    "models/player/jedi/female_tholothian_guardian.mdl",
    "models/player/jedi/female_zabrak_guardian.mdl",
    "models/player/jedi/male_chiss_guardian.mdl",
    "models/player/jedi/male_human_guardian.mdl",
    "models/player/jedi/male_kaleesh_guardian.mdl",
    "models/player/jedi/male_keldoran_guardian.mdl",
    "models/player/jedi/male_tholothian_guardian.mdl",
    "models/player/jedi/male_zabrak_guardian.mdl",
    "models/player/jedi/pantoran_male_guardian.mdl",
    "models/player/jedi/rodian_male_guardian.mdl",
    "models/player/jedi/twilek_female_guardian.mdl",
    "models/player/jedi/twilek_guardian_male.mdl",
    "models/player/jedi/female_chiss_sentinel.mdl",
    "models/player/jedi/female_human_sentinel.mdl",
    "models/player/jedi/female_kaleesh_sentinel.mdl",
    "models/player/jedi/female_keldoran_sentinel.mdl",
    "models/player/jedi/female_pantoran_sentinel.mdl",
    "models/player/jedi/female_rodian_sentinel.mdl",
    "models/player/jedi/female_tholothian_sentinel.mdl",
    "models/player/jedi/female_zabrak_sentinel.mdl",
    "models/player/jedi/male_chiss_sentinel.mdl",
    "models/player/jedi/male_human_sentinel.mdl",
    "models/player/jedi/male_kaleesh_sentinel.mdl",
    "models/player/jedi/male_keldoran_sentinel.mdl",
    "models/player/jedi/male_tholothian_sentinel.mdl",
    "models/player/jedi/male_zabrak_sentinel.mdl",
    "models/player/jedi/pantoran_male_sentinel.mdl",
    "models/player/jedi/rodian_male_sentinel.mdl",
    "models/player/jedi/twilek_female_sentinel.mdl",
    "models/player/jedi/twilek_sentinel_male.mdl"
    },
    description = [[Congratulations, you are a Jedi of the 501st Legion!]],
    weapons = { "weapon_lightsaber_personal", "wos_inventory", "arccw_ll30" },
    command = "501stjedi",
    max = 4,
    salary = 150,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "501st Legion",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 13,
})

TEAM_501STGENERALTANO = DarkRP.createJob("501st Commander Ahsoka Tano", {
    color = Color(0, 51, 255, 255),
    model = {"models/plo/ahsoka/ahsoka_s7.mdl","models/tfa/comm/gg/pm_sw_ahsoka_v1.mdl","models/tfa/comm/gg/pm_sw_ahsoka_v2.mdl"},
    description = [[You are Jedi Commander Ahsoka Tano. It is your role to help lower ranking Jedi get an understanding of the Order!]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30"},
    command = "501sttano",
    max = 1,
    salary = 275,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "501st Legion",
    modelScale = 0.92,
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 14,
})

TEAM_501STGENERALSKYWALKER = DarkRP.createJob("501st General Anakin Skywalker", {
    color = Color(0, 51, 255, 255),
    model = {"models/player/sample/anakin/anakins7.mdl","models/tfa/comm/gg/pm_sw_anakin_v2.mdl"},
    description = [[You are Jedi General Anakin Skywalker. It is your role to help lower ranking Jedi get an understanding of the Order!]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},
    command = "501stsky",
    max = 1,
    salary = 275,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "501st Legion",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 15,
})

-- 212th ATTACK BATTALION --

TEAM_212THGENERAL = DarkRP.createJob("212th General", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/base/212th_cody.mdl", "models/toe/cgi/gens/gen_acolyte.mdl", "models/toe/cgi/gens/gen_archer.mdl", "models/toe/cgi/gens/gen_id.mdl", "models/toe/cgi/gens/gen_foxjack.mdl", "models/toe/cgi/gens/gen_matrix.mdl", "models/toe/cgi/gens/gen_nomad.mdl", "models/naval_offduty/pm_naval_cas.mdl","models/jajoff/sps/republic/tc13j/rsb01.mdl"},

    description = [[Congratulations, you are the Deployed General of the 212th Attack Battalion!]],

    weapons = {"zeus_dlt19", "arccw_duals_dc17ext_v2", "arccw_sw_rocket_rps6", "realistic_hook", "arccw_thermal_grenade", "weapon_remotedrone", "datapad_player", "carkeys"},

    command = "212thgen",

    max = 2,

    salary = 300,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "212th Attack Battalion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 0

})



TEAM_212THMCOMMANDER = DarkRP.createJob("212th Marshal Commander", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/base/212th_cody.mdl","models/aussiwozzi/cgi/base/advisor_red.mdl", "models/aussiwozzi/cgi/base/advisor_grey.mdl", "models/aussiwozzi/cgi/base/advisor_green.mdl", "models/aussiwozzi/cgi/base/advisor_blue.mdl", "models/aussiwozzi/cgi/base/212th_meanstreak.mdl","models/aussiwozzi/cgi/base/224th_toast.mdl","models/aussiwozzi/cgi/base/22nd_dempsey.mdl","models/jajoff/sps/republic/tc13j/rsb02.mdl"},

    description = [[Congratulations, you are the Marshal Commander of the 212th Attack Battalion!]],

    weapons = {"zeus_dlt19", "arccw_duals_dc17ext_v2", "arccw_sw_rocket_rps6", "arccw_thermal_grenade", "carkeys"},

    command = "212thmco",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "212th Attack Battalion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 2

})

TEAM_212THCOMMANDER = DarkRP.createJob("212th Commander", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/base/212th_cody.mdl","models/aussiwozzi/cgi/base/212th_meanstreak.mdl"},

    description = [[Congratulations, you are the Commander of the 212th Attack Battalion!]],

    weapons = {"zeus_dlt19", "arccw_duals_dc17ext_v2", "arccw_sw_rocket_rps6", "arccw_thermal_grenade", "carkeys"},

    command = "212thco",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "212th Attack Battalion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(600) ply:SetHealth(600) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 3

})



TEAM_212THEXECUTIVEOFFICER = DarkRP.createJob("212th Executive Officer", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/base/212th_waxer.mdl", "models/zeus/212th_desert_arf.mdl","models/aussiwozzi/cgi/base/212th_meanstreak.mdl"},

    description = [[Congratulations, you are the Executive Officer of the 212th Attack Battalion]],

    weapons = {"zeus_dlt19", "arccw_duals_dc17ext_v2", "arccw_sw_rocket_rps6", "arccw_thermal_grenade", "carkeys"},

    command = "212thxo",

    max = 1,

    salary = 250,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "212th Attack Battalion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

     sortOrder = 4

})



TEAM_212THMAJOR = DarkRP.createJob("212th Major", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/base/212th_boil.mdl", "models/zeus/212th_desert_arf.mdl" ,"models/aussiwozzi/cgi/base/212th_meanstreak.mdl"},

    description = [[Congratulations, you are the Major of the 212th Attack Battalion]],

    weapons = {"zeus_dlt19", "arccw_duals_dc17ext_v2", "arccw_sw_rocket_rps6", "arccw_thermal_grenade", "carkeys"},

    command = "212thmjr",

    max = 1,

    salary = 225,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "212th Attack Battalion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 5

})



TEAM_212THLIEUTENANT = DarkRP.createJob("212th Lieutenant", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/base/212th_ghost_officer.mdl","models/aussiwozzi/cgi/base/212th_allen.mdl","models/aussiwozzi/cgi/base/212th_boulder_co.mdl","models/aussiwozzi/cgi/base/212th_dug.mdl","models/aussiwozzi/cgi/base/212th_dug2.mdl","models/aussiwozzi/cgi/base/212th_tahm.mdl","models/aussiwozzi/cgi/base/2ndac_barlex.mdl","models/aussiwozzi/cgi/base/212th_ghost_company.mdl","models/aussiwozzi/cgi/base/212th_arf.mdl","models/aussiwozzi/cgi/base/2ndac_officer.mdl","models/aussiwozzi/cgi/base/212th_officer.mdl","models/aussiwozzi/cgi/base/212th_barc.mdl","models/aussiwozzi/cgi/base/212th_desert_trooper.mdl", "models/zeus/212th_calereed.mdl", "models/zeus/212th_threepwood.mdl", "models/zeus/212th_desert_arf.mdl"},

    description = [[Congratulations, you are a Lieutenant of the 212th Attack Battalion!]],

    weapons = {"zeus_dlt19", "arccw_dc17_v2", "arccw_thermal_grenade", "carkeys"},

    command = "212thlt",

    max = 6,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "212th Attack Battalion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 6

})



TEAM_212THHEAVYTROOPER = DarkRP.createJob("212th Ghost Company", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/base/212th_arf.mdl","models/aussiwozzi/cgi/base/212th_boulder_co.mdl","models/aussiwozzi/cgi/base/212th_desert_trooper.mdl","models/aussiwozzi/cgi/base/2ndac_barlex.mdl","models/aussiwozzi/cgi/base/212th_barc.mdl", "models/aussiwozzi/cgi/base/212th_ghost_officer.mdl","models/aussiwozzi/cgi/base/212th_ghost_company.mdl","models/aussiwozzi/cgi/base/2ndac_trooper.mdl","models/aussiwozzi/cgi/base/2ndac_officer.mdl","models/aussiwozzi/cgi/base/212th_officer.mdl", "models/aussiwozzi/cgi/base/212th_raffle.mdl","models/aussiwozzi/cgi/base/212th_dug.mdl", "models/zeus/212th_calereed.mdl", "models/zeus/212th_threepwood.mdl", "models/zeus/212th_desert_arf.mdl"},

    description = [[Congratulations, you are a part of the Ghost Company in the 212th Attack Battalion!]],

    weapons = {"zeus_dlt19", "arccw_dc17_v2", "arccw_sw_rocket_rps6", "arccw_thermal_grenade", "carkeys"},

    command = "212thht",

    max = 3,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "212th Attack Battalion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 7

})

TEAM_ARCALPHA212th = DarkRP.createJob("212th Alpha ARC", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/base/212th_arc.mdl","models/zeus/212th_blackout.mdl","models/aussiwozzi/cgi/base/arc_cpt_grenadier.mdl","models/aussiwozzi/cgi/base/arc_sgt_grenadier.mdl","models/aussiwozzi/cgi/base/arc_lt_grenadier.mdl","models/aussiwozzi/cgi/base/arc_cpt.mdl","models/aussiwozzi/cgi/base/arc_cpt_marksman.mdl", "models/aussiwozzi/cgi/base/arc_cpt_heavy.mdl", "models/aussiwozzi/cgi/base/arc_cpt_rat.mdl","models/aussiwozzi/cgi/base/arc_cpt_medic.mdl","models/aussiwozzi/cgi/base/arc_cpt_pab.mdl","models/aussiwozzi/cgi/base/arc_lt.mdl", "models/aussiwozzi/cgi/base/arc_lt_marksman.mdl","models/aussiwozzi/cgi/base/arc_lt_heavy.mdl", "models/aussiwozzi/cgi/base/arc_lt_medic.mdl","models/aussiwozzi/cgi/base/arc_lt_chunky.mdl","models/aussiwozzi/cgi/base/arc_raffle.mdl", "models/aussiwozzi/cgi/base/arc_cpt_jarr.mdl","models/aussiwozzi/cgi/base/arc_sgt.mdl","models/aussiwozzi/cgi/base/arc_sgt_marksman.mdl","models/aussiwozzi/cgi/base/arc_sgt_heavy.mdl","models/aussiwozzi/cgi/base/arc_sgt_medic.mdl","models/aussiwozzi/cgi/base/arc_sgt_spida.mdl","models/aussiwozzi/cgi/base/arc_lt_macka.mdl","models/aussiwozzi/cgi/base/arc_cpt_shadowz.mdl"},
    description = [[Congratulations, you are 212th ARC Alpha!]],

    weapons = {"arccw_westarm5_v2", "arccw_dual_dc17s", "realistic_hook", "arccw_thermal_grenade", "carkeys"},

    command = "arca212th",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "212th Attack Battalion",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 8

})



TEAM_212THARC = DarkRP.createJob("212th ARC", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/base/212th_arc.mdl", "models/zeus/212th_blackout.mdl"},

    description = [[Congratulations, you are a 212th ARC Trooper!]],

    weapons = {"arccw_westarm5_v2", "arccw_dual_dc17s", "realistic_hook", "arccw_thermal_grenade", "carkeys"},

    command = "212tharc",

    max = 2,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "212th Attack Battalion",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 8

})



TEAM_212THMEDOFFICER = DarkRP.createJob("212th Medic Officer", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/base/212th_medic_officer.mdl","models/aussiwozzi/cgi/base/212th_april.mdl","models/aussiwozzi/cgi/base/212th_buzzcut.mdl","models/aussiwozzi/cgi/base/212th_dug2.mdl","models/aussiwozzi/cgi/base/212th_2ndacmedic.mdl"},

    description = [[Congratulations, you are a Medical Officer of the 212th Attack Battalion!]],

    weapons = {"zeus_dlt19", "arccw_dc17_v2", "lord_chrome_medkit", "arccw_ammo_crate", "weapon_jew_stimkit", "weapon_defibrillator", "arccw_bacta_grenade", "tf_weapon_medigun", "arccw_thermal_grenade", "realistic_hook", "carkeys"},

    command = "212thmo",

    max = 1,

    salary = 175,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "212th Attack Battalion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)   end,

    sortOrder = 9

})



TEAM_212THSERGEANT = DarkRP.createJob("212th Sergeant", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/base/212th_trooper.mdl","models/aussiwozzi/cgi/base/212th_allen.mdl","models/aussiwozzi/cgi/base/212th_boulder.mdl","models/aussiwozzi/cgi/base/212th_dug.mdl","models/aussiwozzi/cgi/base/212th_tahm.mdl","models/aussiwozzi/cgi/base/212th_barc.mdl","models/aussiwozzi/cgi/base/2ndac_trooper.mdl","models/aussiwozzi/cgi/base/212th_desert_trooper.mdl","models/aussiwozzi/cgi/base/2ndac_barlex.mdl", "models/zeus/212th_calereed.mdl", "models/zeus/212th_threepwood.mdl", "models/zeus/212th_desert_arf.mdl"},

    description = [[Congratulations, you are a Sergeant of the 212th Attack Battalion!]],

    weapons = {"zeus_dlt19", "arccw_dc17_v2", "arccw_thermal_grenade", "carkeys"},

    command = "212thsgt",

    max = 0,

    salary = 175,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "212th Attack Battalion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)   end,

    sortOrder = 10

})



TEAM_212THMEDTROOPER = DarkRP.createJob("212th Medic Trooper", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/base/212th_medic.mdl","models/aussiwozzi/cgi/base/212th_april.mdl","models/aussiwozzi/cgi/base/212th_buzzcut.mdl","models/aussiwozzi/cgi/base/212th_dug2.mdl","models/aussiwozzi/cgi/base/212th_2ndacmedic.mdl","models/aussiwozzi/cgi/base/2ndac_barlex.mdl"},

    description = [[Congratulations, you are a Medic of the 212th Attack Battalion!]],

    weapons = {"zeus_dlt19", "arccw_dc17_v2","lord_chrome_medkit", "arccw_ammo_crate", "weapon_jew_stimkit", "weapon_defibrillator", "realistic_hook", "arccw_thermal_grenade", "carkeys"},

    command = "212thmt",

    max = 3,

    salary = 150,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "212th Attack Battalion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 11

})



TEAM_212THTROOPER = DarkRP.createJob("212th Trooper", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/base/212th_trooper.mdl","models/aussiwozzi/cgi/base/212th_boulder.mdl","models/aussiwozzi/cgi/base/212th_allen.mdl","models/aussiwozzi/cgi/base/212th_tahm.mdl"},

    description = [[Congratulations, you are a member of the 212th Attack Battalion!]],

    weapons = {"zeus_dlt19", "arccw_dc17_v2"},

    command = "212thtrp",

    max = 0,

    salary = 150,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "212th Attack Battalion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 12

})

TEAM_212THJEDI = DarkRP.createJob("212th Jedi", {
    color = Color(255, 157, 0, 255),
    model = {"models/aussiwozzi/cgi/base/jedi_rahm_kota.mdl",
    "models/aussiwozzi/cgi/base/jedi_bultar_swan.mdl",
    "models/tfa/comm/gg/pm_sw_adigallia.mdl",
    "models/tfa/comm/gg/pm_sw_barriss.mdl",
    "models/tfa/comm/gg/pm_sw_eeth_koth.mdl",
    "models/tfa/comm/gg/pm_sw_imagundi.mdl",
    "models/gonzo/saeseetiin/saeseetiin.mdl",
    "models/player/jedi/nyssa_delacor.mdl",
    "models/player/jedi/female_chiss_consular.mdl",
    "models/player/jedi/female_human_consular.mdl",
    "models/player/jedi/female_kaleesh_consular.mdl",
    "models/player/jedi/female_keldoran_consular.mdl",
    "models/player/jedi/female_pantoran_consular.mdl",
    "models/player/jedi/female_rodian_consular.mdl",
    "models/player/jedi/female_tholothian_consular.mdl",
    "models/player/jedi/female_zabrak_consular.mdl",
    "models/player/jedi/male_chiss_consular.mdl",
    "models/player/jedi/male_human_consular.mdl",
    "models/player/jedi/male_kaleesh_consular.mdl",
    "models/player/jedi/male_keldoran_consular.mdl",
    "models/player/jedi/male_tholothian_consular.mdl",
    "models/player/jedi/male_zabrak_consular.mdl",
    "models/player/jedi/pantoran_male_consular.mdl",
    "models/player/jedi/rodian_male_consular.mdl",
    "models/player/jedi/twilek_consular_male.mdl",
    "models/player/jedi/twilek_female_consular.mdl",
    "models/player/jedi/female_chiss_guardian.mdl",
    "models/player/jedi/female_human_guardian.mdl",
    "models/player/jedi/female_kaleesh_guardian.mdl",
    "models/player/jedi/female_keldoran_guardian.mdl",
    "models/player/jedi/female_pantoran_guardian.mdl",
    "models/player/jedi/female_rodian_guardian.mdl",
    "models/player/jedi/female_tholothian_guardian.mdl",
    "models/player/jedi/female_zabrak_guardian.mdl",
    "models/player/jedi/male_chiss_guardian.mdl",
    "models/player/jedi/male_human_guardian.mdl",
    "models/player/jedi/male_kaleesh_guardian.mdl",
    "models/player/jedi/male_keldoran_guardian.mdl",
    "models/player/jedi/male_tholothian_guardian.mdl",
    "models/player/jedi/male_zabrak_guardian.mdl",
    "models/player/jedi/pantoran_male_guardian.mdl",
    "models/player/jedi/rodian_male_guardian.mdl",
    "models/player/jedi/twilek_female_guardian.mdl",
    "models/player/jedi/twilek_guardian_male.mdl",
    "models/player/jedi/female_chiss_sentinel.mdl",
    "models/player/jedi/female_human_sentinel.mdl",
    "models/player/jedi/female_kaleesh_sentinel.mdl",
    "models/player/jedi/female_keldoran_sentinel.mdl",
    "models/player/jedi/female_pantoran_sentinel.mdl",
    "models/player/jedi/female_rodian_sentinel.mdl",
    "models/player/jedi/female_tholothian_sentinel.mdl",
    "models/player/jedi/female_zabrak_sentinel.mdl",
    "models/player/jedi/male_chiss_sentinel.mdl",
    "models/player/jedi/male_human_sentinel.mdl",
    "models/player/jedi/male_kaleesh_sentinel.mdl",
    "models/player/jedi/male_keldoran_sentinel.mdl",
    "models/player/jedi/male_tholothian_sentinel.mdl",
    "models/player/jedi/male_zabrak_sentinel.mdl",
    "models/player/jedi/pantoran_male_sentinel.mdl",
    "models/player/jedi/rodian_male_sentinel.mdl",
    "models/player/jedi/twilek_female_sentinel.mdl",
    "models/player/jedi/twilek_sentinel_male.mdl"
    },
    description = [[Congratulations, you are a Jedi of the 212th Attack Battalion!]],
    weapons = { "weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},
    command = "212thjedi",
    max = 4,
    salary = 150,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "212th Attack Battalion",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 13,
})

TEAM_212THGENERALOBI = DarkRP.createJob("212th General Obi-Wan Kenobi", {
    color = Color(255, 157, 0, 255),
    model = { "models/player/generalkenobi/cgikenobi.mdl","models/tfa/comm/gg/pm_sw_obiwan_alt.mdl","models/kylejwest/cgihdobiwan/cgihdobiwan.mdl","models/dw_sgt/pm_deathwatch_maul_sgt.mdl"},
    description = [[You are Jedi General Obi-Wan Kenobi. It is your role to help lower ranking Jedi get an understanding of the Order!]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},
    command = "212thobi",
    max = 1,
    salary = 275,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "212th Attack Battalion",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 14,
})

-- GREEN COMPANY --

TEAM_GREENGENERAL = DarkRP.createJob("Green Company General", {

    color = Color(0, 255, 64, 255),

    model = {"models/aussiwozzi/cgi/base/41st_gree.mdl", "models/toe/cgi/gens/gen_acolyte.mdl", "models/toe/cgi/gens/gen_archer.mdl", "models/toe/cgi/gens/gen_id.mdl", "models/toe/cgi/gens/gen_foxjack.mdl", "models/toe/cgi/gens/gen_matrix.mdl", "models/toe/cgi/gens/gen_nomad.mdl", "models/naval_offduty/pm_naval_cas.mdl","models/herm/cgi_new/41st/41st_trooper2.mdl","models/herm/cgi_new/41st/41st_trooper1.mdl","models/jajoff/sps/republic/tc13j/rsb01.mdl"},

    description = [[Congratulations, you are the Deployed General of the Green Company!]],

    weapons = {"realistic_hook", "arccw_dc15s_v2_gc", "arccw_iqa11", "masita_sops_t702", "arccw_duals_dc17ext_v2", "weapon_remotedrone", "datapad_player", "carkeys"},

    command = "gcgen",

    max = 2,

    salary = 300,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Green Company",

    PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 0

})

TEAM_GREENMCOMMANDER = DarkRP.createJob("Green Company Marshal Commander", {

    color = Color(0, 255, 64, 255),

    model = {"models/aussiwozzi/cgi/base/advisor_red.mdl","models/zeus/41st_barrage.mdl","models/aussiwozzi/cgi/base/advisor_grey.mdl", "models/aussiwozzi/cgi/base/advisor_green.mdl", "models/aussiwozzi/cgi/base/advisor_blue.mdl", "models/aussiwozzi/cgi/base/41st_gree.mdl","models/aussiwozzi/cgi/base/41st_ranger.mdl","models/aussiwozzi/cgi/base/41st_havoc_officer.mdl","models/aussiwozzi/cgi/base/41st_arf.mdl","models/aussiwozzi/cgi/base/41st_officer.mdl","models/aussiwozzi/cgi/base/224th_toast.mdl","models/aussiwozzi/cgi/base/22nd_dempsey.mdl","models/jajoff/sps/republic/tc13j/rsb02.mdl","models/herm/cgi_new/41st/41st_trooper2.mdl","models/herm/cgi_new/41st/41st_trooper1.mdl","models/zeus/41st_trooper_snow.mdl","models/zeus/41st_ranger_snow.mdl"},

    description = [[Congratulations, you are the Marshal Commander of the Green Company!]],

    weapons = {"realistic_hook", "arccw_dc15s_v2_gc", "arccw_iqa11", "masita_sops_t702", "arccw_duals_dc17ext_v2", "carkeys"},

    command = "gcmco",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Green Company",

    PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 2

})

TEAM_GREENCOMMANDER = DarkRP.createJob("Green Company Commander", {

    color = Color(0, 255, 64, 255),

    model = {"models/aussiwozzi/cgi/base/41st_gree.mdl","models/aussiwozzi/cgi/base/41st_ranger.mdl","models/zeus/41st_barrage.mdl","models/aussiwozzi/cgi/base/41st_havoc_officer.mdl","models/aussiwozzi/cgi/base/41st_arf.mdl","models/aussiwozzi/cgi/base/41st_officer.mdl","models/herm/cgi_new/41st/41st_trooper2.mdl","models/herm/cgi_new/41st/41st_trooper1.mdl","models/zeus/41st_trooper_snow.mdl","models/zeus/41st_ranger_snow.mdl"},

    description = [[Congratulations, you are the Commander of the Green Company!]],

    weapons = {"realistic_hook", "arccw_dc15s_v2_gc", "arccw_iqa11", "masita_sops_t702", "arccw_duals_dc17ext_v2", "carkeys"},

    command = "gcco",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Green Company",

    PlayerSpawn = function(ply) ply:SetMaxHealth(600) ply:SetHealth(600) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 3

})



TEAM_GREENEXECUTIVEOFFICER = DarkRP.createJob("Green Company Executive Officer", {

    color = Color(0, 255, 64, 255),

    model = {"models/aussiwozzi/cgi/base/41st_officer.mdl","models/aussiwozzi/cgi/base/41st_ranger.mdl","models/zeus/41st_barrage.mdl","models/aussiwozzi/cgi/base/41st_havoc_officer.mdl","models/aussiwozzi/cgi/base/41st_arf.mdl","models/herm/cgi_new/41st/41st_trooper2.mdl","models/herm/cgi_new/41st/41st_trooper1.mdl","models/zeus/41st_trooper_snow.mdl","models/zeus/41st_ranger_snow.mdl"},

    description = [[Congratulations, you are the Executive Officer of the Green Company!]],

    weapons = {"realistic_hook", "arccw_dc15s_v2_gc", "arccw_iqa11", "masita_sops_t702", "arccw_duals_dc17ext_v2", "carkeys"},

    command = "gcxo",

    max = 1,

    salary = 250,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Green Company",

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 4

})



TEAM_GREENMAJOR = DarkRP.createJob("Green Company Major", {

    color = Color(0, 255, 64, 255),

    model = {"models/aussiwozzi/cgi/base/41st_officer.mdl","models/aussiwozzi/cgi/base/41st_havoc.mdl","models/zeus/41st_barrage.mdl","models/aussiwozzi/cgi/base/41st_ranger.mdl","models/aussiwozzi/cgi/base/41st_arf.mdl","models/herm/cgi_new/41st/41st_trooper2.mdl","models/herm/cgi_new/41st/41st_trooper1.mdl","models/zeus/41st_trooper_snow.mdl","models/zeus/41st_ranger_snow.mdl"},

    description = [[Congratulations, you are the Major of the Green Company!]],

    weapons = {"realistic_hook", "arccw_dc15s_v2_gc", "arccw_iqa11", "masita_sops_t702", "arccw_duals_dc17ext_v2", "carkeys"},

    command = "gcmjr",

    max = 1,

    salary = 225,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Green Company",

    PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 5

})





TEAM_GREENLIEUTENANT = DarkRP.createJob("Green Company Lieutenant", {

    color = Color(0, 255, 64, 255),

    model = {"models/aussiwozzi/cgi/base/41st_officer.mdl","models/aussiwozzi/cgi/base/41st_arf.mdl","models/aussiwozzi/cgi/base/41st_draa.mdl","models/aussiwozzi/cgi/base/41st_cooker.mdl","models/herm/cgi_new/41st/41st_trooper2.mdl"},

    description = [[Congratulations, you are a Lieutenant of the Green Company! Can Spawn: Barc Speeder]],

    weapons = {"arccw_iqa11", "realistic_hook", "arccw_dc15s_v2_gc", "arccw_dc17_v2", "carkeys"},

    command = "gclt",

    max = 6,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Green Company",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 6

})



TEAM_GREENMARKSMAN = DarkRP.createJob("Green Company Marksman", {

    color = Color(0, 255, 64, 255),

    model = {"models/aussiwozzi/cgi/base/41st_ranger.mdl","models/aussiwozzi/cgi/base/41st_arf.mdl","models/aussiwozzi/cgi/base/41st_draa.mdl","models/aussiwozzi/cgi/base/41st_cooker.mdl","models/herm/cgi_new/41st/41st_trooper2.mdl","models/herm/cgi_new/41st/41st_trooper1.mdl","models/zeus/41st_trooper_snow.mdl","models/zeus/41st_ranger_snow.mdl"},

    description = [[Congratulations, you are a Marksman for the Green Company! Can Spawn: Barc Speeder]],

    weapons = {"arccw_dc15s_v2_gc", "arccw_iqa11", "masita_sops_t702", "realistic_hook", "arccw_dc17_v2", "carkeys"},

    command = "gcmm",

    max = 3,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Green Company",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 7

})


TEAM_ARCALPHAGC = DarkRP.createJob("Green Company Alpha ARC", {

    color = Color(0, 255, 64, 255),

    model = {"models/aussiwozzi/cgi/base/arc_cpt_grenadier.mdl","models/aussiwozzi/cgi/base/arc_sgt_grenadier.mdl","models/aussiwozzi/cgi/base/arc_lt_grenadier.mdl","models/aussiwozzi/cgi/base/41st_draa_arc.mdl", "models/aussiwozzi/cgi/base/41st_arc.mdl","models/aussiwozzi/cgi/base/41st_cooker_arc.mdl","models/aussiwozzi/cgi/base/arc_cpt.mdl","models/aussiwozzi/cgi/base/arc_cpt_marksman.mdl","models/aussiwozzi/cgi/base/arc_cpt_heavy.mdl","models/aussiwozzi/cgi/base/arc_cpt_rat.mdl","models/aussiwozzi/cgi/base/arc_cpt_medic.mdl","models/aussiwozzi/cgi/base/arc_cpt_pab.mdl","models/aussiwozzi/cgi/base/arc_lt.mdl","models/aussiwozzi/cgi/base/arc_lt_marksman.mdl","models/aussiwozzi/cgi/base/arc_lt_heavy.mdl","models/aussiwozzi/cgi/base/arc_lt_medic.mdl","models/aussiwozzi/cgi/base/arc_lt_chunky.mdl","models/aussiwozzi/cgi/base/arc_raffle.mdl","models/aussiwozzi/cgi/base/arc_cpt_jarr.mdl","models/aussiwozzi/cgi/base/arc_sgt.mdl","models/aussiwozzi/cgi/base/arc_sgt_marksman.mdl","models/aussiwozzi/cgi/base/arc_sgt_heavy.mdl","models/aussiwozzi/cgi/base/arc_sgt_medic.mdl","models/aussiwozzi/cgi/base/arc_sgt_spida.mdl","models/aussiwozzi/cgi/base/arc_lt_macka.mdl","models/aussiwozzi/cgi/base/arc_cpt_shadowz.mdl"},

    description = [[Congratulations, you are ARC Alpha Green Company!]],

    weapons = {"arccw_westarm5_v2", "arccw_dual_dc17s", "realistic_hook", "arccw_iqa11", "carkeys"},

    command = "arcagc",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Green Company",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 9

})

TEAM_GCARC = DarkRP.createJob("Green Company ARC", {

    color = Color(0, 255, 64, 255),

    model = {"models/aussiwozzi/cgi/base/41st_draa_arc.mdl", "models/aussiwozzi/cgi/base/41st_arc.mdl","models/aussiwozzi/cgi/base/41st_cooker_arc.mdl"},

    description = [[Congratulations, you are a GC ARC Trooper!]],

    weapons = {"arccw_westarm5_v2", "arccw_dual_dc17s", "realistic_hook", "arccw_iqa11", "carkeys"},

    command = "gcarc",

    max = 2,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Green Company",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 10

})



TEAM_GREENMEDOFFICER = DarkRP.createJob("Green Company Medic Officer", {

    color = Color(0, 255, 64, 255),

    model = {"models/aussiwozzi/cgi/base/41st_medic_officer.mdl","models/aussiwozzi/cgi/base/41st_ace.mdl","models/aussiwozzi/cgi/base/41st_medic.mdl"},

    description = [[Congratulations, you are the Medical Officer of the Green Company!]],

    weapons = {"arccw_dc17_v2", "arccw_iqa11", "realistic_hook", "arccw_dc15s_v2_gc", "lord_chrome_medkit", "weapon_bactainjector", "weapon_jew_stimkit", "weapon_defibrillator", "arccw_bacta_grenade", "tf_weapon_medigun", "carkeys"},

    command = "gcmo",

    max = 1,

    salary = 175,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Green Company",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 11

})



TEAM_GREENSERGEANT = DarkRP.createJob("Green Company Sergeant", {

    color = Color(0, 255, 64, 255),

    model = {"models/aussiwozzi/cgi/base/41st_trooper.mdl","models/aussiwozzi/cgi/base/41st_arf.mdl","models/aussiwozzi/cgi/base/41st_draa.mdl","models/aussiwozzi/cgi/base/41st_cooker.mdl","models/herm/cgi_new/41st/41st_trooper2.mdl"},

    description = [[Congratulations, you are a Sergeant of the Green Company!]],

    weapons = {"arccw_dc17_v2", "arccw_iqa11","realistic_hook", "arccw_dc15s_v2_gc", "carkeys"},

    command = "gcsgt",

    max = 0,

    salary = 175,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Green Company",

    PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,



    sortOrder = 12

})



TEAM_GREENMEDTROOPER = DarkRP.createJob("Green Company Medic Trooper", {

    color = Color(0, 255, 64, 255),

    model = {"models/aussiwozzi/cgi/base/41st_medic.mdl","models/aussiwozzi/cgi/base/41st_ace.mdl"},

    description = [[Congratulations, you are a Medic of the Green Company!]],

    weapons = {"arccw_dc17_v2", "arccw_iqa11", "realistic_hook", "arccw_dc15s_v2_gc", "lord_chrome_medkit", "weapon_bactainjector", "weapon_jew_stimkit", "weapon_defibrillator", "carkeys"},

    command = "gcmt",

    max = 3,

    salary = 150,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Green Company",

PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,



    sortOrder = 13

})



TEAM_GREENTROOPER = DarkRP.createJob("Green Company Trooper", {

    color = Color(0, 255, 64, 255),

    model = {"models/aussiwozzi/cgi/base/41st_trooper.mdl","models/herm/cgi_new/41st/41st_trooper2.mdl"},

    description = [[Congratulations, you are a trooper of the Green Company!]],

    weapons = {"arccw_dc17_v2", "arccw_iqa11", "realistic_hook"},

    command = "gctrp",

    max = 0,

    salary = 150,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Green Company",

PlayerSpawn = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetRunSpeed (240) ply:SetGravity(1)  end,



    sortOrder = 14

})

TEAM_GCGENERALLUMINARA = DarkRP.createJob("GC General Luminara Unduli", {
    color = Color(0, 255, 64, 255),
    model = {"models/tfa/comm/gg/pm_sw_luminara.mdl"},
    description = [[You are Jedi General Luminara Unduli. It is your role to help lower ranking Jedi get an understanding of the Order!]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},
    command = "gclum",
    max = 1,
    salary = 275,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Green Company",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 15,
})

TEAM_GCGRANDMASTER = DarkRP.createJob("GC Grand Master", {
    color = Color(0, 255, 64, 255),
    model = {"models/tfa/comm/gg/pm_sw_yodanojig.mdl"},
    description = [[You are Jedi Grand Master Yoda. It is your role to help lower ranking Jedi get an understanding of the Order!]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},
    command = "gcyoda",
    max = 1,
    salary = 300,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Green Company",
    canDemote = false,
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed(240) ply:SetGravity(1) end,
    sortOrder = 16
})


-- Coruscant Guard (Shock)--

TEAM_CGGENERAL = DarkRP.createJob("Coruscant Guard General", {

    color = Color(255, 77, 77, 255),

    model = {"models/aussiwozzi/cgi/base/cg_fox.mdl", "models/toe/cgi/gens/gen_acolyte.mdl", "models/toe/cgi/gens/gen_archer.mdl", "models/toe/cgi/gens/gen_id.mdl", "models/toe/cgi/gens/gen_foxjack.mdl", "models/toe/cgi/gens/gen_matrix.mdl", "models/toe/cgi/gens/gen_nomad.mdl", "models/naval_offduty/pm_naval_cas.mdl", "models/jajoff/sps/republic/tc13j/rsb01.mdl"},

    description = [[Congratulations, you are the Deployed General of the Coruscant Guard!]],

    weapons = {"arccw_dc15_v2_riot", "arccw_vanguard_shotgun", "arccw_duals_dc17ext_v2_stun", "stunstick", "weapon_cuff_elastic_officer", "weapon_policeshield", "sfw_cgelectrostaff", "realistic_hook", "weapon_leash_rope","weapon_remotedrone","weaponchecker","datapad_player"},

    command = "cggen",

    max = 2,

    salary = 300,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Coruscant Guard",

    PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (260) ply:SetGravity(1)  end,

    sortOrder = 0

})

TEAM_CGMCOMMANDER = DarkRP.createJob("Coruscant Guard Marshal Commander", {

    color = Color(255, 77, 77, 255),

    model = {"models/aussiwozzi/cgi/base/advisor_red.mdl","models/aussiwozzi/cgi/base/advisor_grey.mdl", "models/aussiwozzi/cgi/base/advisor_green.mdl", "models/aussiwozzi/cgi/base/advisor_blue.mdl", "models/aussiwozzi/cgi/base/cg_fox.mdl", "models/aussiwozzi/cgi/base/cg_thorn.mdl", "models/aussiwozzi/cgi/base/cg_thire.mdl", "models/aussiwozzi/cgi/base/cg_riot_officer.mdl", "models/aussiwozzi/cgi/base/cg_officer.mdl", "models/aussiwozzi/cgi/base/cg_pibs.mdl","models/aussiwozzi/cgi/base/224th_toast.mdl","models/aussiwozzi/cgi/base/22nd_dempsey.mdl","models/jajoff/sps/republic/tc13j/rsb02.mdl"},

    description = [[Congratulations, you are the Marshal Commander of the Coruscant Guard!]],

    weapons = {"arccw_dc15_v2_riot", "arccw_duals_dc17ext_v2_stun", "stunstick", "weaponchecker", "weapon_cuff_elastic_officer", "weapon_policeshield", "sfw_cgelectrostaff", "weapon_leash_rope","arccw_vanguard_shotgun","datapad_player"},

    command = "cgmco",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Coruscant Guard",

PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (260) ply:SetGravity(1)  end,

    sortOrder = 1

})

TEAM_CGCOMMANDER = DarkRP.createJob("Coruscant Guard Commander", {

    color = Color(255, 77, 77, 255),

    model = {"models/aussiwozzi/cgi/base/cg_fox.mdl", "models/aussiwozzi/cgi/base/cg_thorn.mdl","models/aussiwozzi/cgi/base/cg_thire.mdl", "models/aussiwozzi/cgi/base/cg_riot_officer.mdl", "models/aussiwozzi/cgi/base/cg_officer.mdl","models/aussiwozzi/cgi/base/cg_pibs.mdl"},

    description = [[Congratulations, you are the Commander of the Coruscant Guard!]],

    weapons = {"arccw_dc15_v2_riot", "arccw_duals_dc17ext_v2_stun", "stunstick", "weaponchecker", "weapon_cuff_elastic_officer", "weapon_policeshield", "sfw_cgelectrostaff", "weapon_leash_rope","arccw_vanguard_shotgun","datapad_player"},

    command = "cgco",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Coruscant Guard",

PlayerSpawn = function(ply) ply:SetMaxHealth(600) ply:SetHealth(600) ply:SetRunSpeed (260) ply:SetGravity(1)  end,

    sortOrder = 2

})



TEAM_CGEXECUTIVEOFFICER = DarkRP.createJob("Coruscant Guard Executive Officer", {

    color = Color(255, 77, 77, 255),

    model = {"models/aussiwozzi/cgi/base/cg_fox.mdl", "models/aussiwozzi/cgi/base/cg_thorn.mdl", "models/aussiwozzi/cgi/base/cg_thire.mdl", "models/aussiwozzi/cgi/base/cg_riot_officer.mdl", "models/aussiwozzi/cgi/base/cg_officer.mdl","models/aussiwozzi/cgi/base/cg_pibs.mdl","models/herm/cgi_new/shock/shock_trooper1.mdl"},

    description = [[Congratulations, you are the Executive Officer of the Coruscant Guard!]],

    weapons = {"arccw_dc15_v2_riot","arccw_duals_dc17ext_v2_stun", "stunstick", "weaponchecker", "weapon_cuff_elastic_officer", "weapon_policeshield", "sfw_cgelectrostaff", "weapon_leash_rope","arccw_vanguard_shotgun","datapad_player"},

    command = "cgxo",

    max = 1,

    salary = 250,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Coruscant Guard",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (260) ply:SetGravity(1)  end,

    sortOrder = 3

})



TEAM_CGMJR = DarkRP.createJob("Coruscant Guard Major", {

    color = Color(255, 77, 77, 255),

    model = {"models/aussiwozzi/cgi/base/cg_fox.mdl", "models/aussiwozzi/cgi/base/cg_thorn.mdl","models/aussiwozzi/cgi/base/CG_officer.mdl", "models/aussiwozzi/cgi/base/cg_riot_officer.mdl","models/aussiwozzi/cgi/base/cg_pibs.mdl","models/herm/cgi_new/shock/shock_trooper1.mdl"},

    description = [[Congratulations, you are the Major of the Coruscant Guard!]],

    weapons = {"arccw_dc15_v2_riot","weapon_leash_rope" ,"arccw_vanguard_shotgun", "arccw_duals_dc17ext_v2_stun", "weaponchecker", "stunstick", "weapon_cuff_elastic_officer", "weapon_policeshield", "sfw_cgelectrostaff","datapad_player"},

    command = "cgmjr",

    max = 1,

    salary = 225,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Coruscant Guard",

PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (260) ply:SetGravity(1)  end,

    sortOrder = 4

})



TEAM_CGLIEUTENANT = DarkRP.createJob("Coruscant Guard Lieutenant", {

    color = Color(255, 77, 77, 255),

    model = {"models/aussiwozzi/cgi/base/CG_officer.mdl", "models/aussiwozzi/cgi/base/cg_pubs.mdl", "models/aussiwozzi/cgi/base/cg_raffle.mdl","models/aussiwozzi/cgi/base/cg_tops.mdl","models/aussiwozzi/cgi/base/cg_riot.mdl","models/aussiwozzi/cgi/base/cg_rys.mdl","models/aussiwozzi/cgi/base/cg_thire.mdl","models/aussiwozzi/cgi/base/cg_jek.mdl", "models/aussiwozzi/cgi/base/cg_riot_officer.mdl", "models/aussiwozzi/cgi/base/cg_stone.mdl","models/herm/cgi_new/shock/shock_trooper1.mdl"},

    description = [[Congratulations, you are an Officer of the Coruscant Guard!]],

    weapons = {"arccw_dp23_v2",  "arccw_dc17_stun_v2", "stunstick", "arccw_dc15a_v2_stun","weaponchecker", "weapon_cuff_elastic_officer", "weapon_policeshield","datapad_player"},

    command = "cglt",

    max = 6,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Coruscant Guard",

PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (260) ply:SetGravity(1)  end,

    sortOrder = 5

})


TEAM_CGRIOT = DarkRP.createJob("Coruscant Guard Riot Trooper", {

    color = Color(255, 77, 77, 255),

    model = {"models/aussiwozzi/cgi/base/cg_stone.mdl", "models/aussiwozzi/cgi/base/cg_riot_officer.mdl", "models/aussiwozzi/cgi/base/cg_riot.mdl"},

    description = [[Congratulations, you are a Riot Trooper of the Coruscant Guard!]],

    weapons = {"arccw_dc15_v2_riot", "arccw_dc17_stun_v2", "stunstick","weaponchecker", "weapon_cuff_elastic_officer", "weapon_policeshield", "datapad_player"},

    command = "cgrt",

    max = 3,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Coruscant Guard",

PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetMaxArmor(100) ply:SetArmor(100) ply:SetRunSpeed (260) ply:SetGravity(1) end,

OnPlayerChangedTeam = function(ply) ply:SetHealth(400) ply:SetRunSpeed (260) end,

    sortOrder = 6

})


TEAM_CGHANDLER = DarkRP.createJob("Coruscant Guard Security Officer", {

    color = Color(255, 77, 77, 255),

    model = {"models/aussiwozzi/cgi/base/cg_hound.mdl", "models/aussiwozzi/cgi/base/CG_tracker.mdl", "models/zeus/cg_pointer.mdl"},

    description = [[Congratulations, you are a Security Officer of the Coruscant Guard!]],

    weapons = {"arccw_vanguard_shotgun", "arccw_dc17_stun_v2", "stunstick", "arccw_dc15a_v2_stun","weaponchecker", "weapon_cuff_elastic_officer", "weapon_policeshield", "sfw_cgelectrostaff", "weapon_leash_rope","arccw_dp23_v2","datapad_player"},

    command = "cgso",

    max = 3,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Coruscant Guard",

PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetMaxArmor(100) ply:SetArmor(100) ply:SetRunSpeed (260) ply:SetGravity(1) end,

OnPlayerChangedTeam = function(ply) ply:SetHealth(400) ply:SetRunSpeed (260) end,

    sortOrder = 7

})



TEAM_CGMASSIF = DarkRP.createJob("Coruscant Guard Massif Hound", {

    color = Color(255, 77, 77, 255),

    model = {"models/mrpounder1/player/massif.mdl"},

    description = [[Congratulations, you are a Massif Hound of the Coruscant Guard!]],

    weapons = {"weapon_fistsofreprisal","weapon_massiftackle"},

    command = "cgmh",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Coruscant Guard",

PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (300) ply:SetGravity(1) end,

OnPlayerChangedTeam = function(ply) ply:SetHealth(400) ply:SetRunSpeed (300) end,

    sortOrder = 8

})

TEAM_ARCALPHACG = DarkRP.createJob("Coruscant Guard Alpha ARC", {

    color = Color(255, 77, 77, 255),

    model = {"models/aussiwozzi/cgi/base/arc_cpt_grenadier.mdl","models/aussiwozzi/cgi/base/arc_sgt_grenadier.mdl","models/aussiwozzi/cgi/base/arc_lt_grenadier.mdl","models/aussiwozzi/cgi/base/CG_arc.mdl","models/aussiwozzi/cgi/base/arc_cpt.mdl","models/aussiwozzi/cgi/base/arc_cpt_marksman.mdl","models/aussiwozzi/cgi/base/arc_cpt_heavy.mdl","models/aussiwozzi/cgi/base/arc_cpt_rat.mdl","models/aussiwozzi/cgi/base/arc_cpt_medic.mdl","models/aussiwozzi/cgi/base/arc_cpt_pab.mdl","models/aussiwozzi/cgi/base/arc_lt.mdl","models/aussiwozzi/cgi/base/arc_lt_marksman.mdl","models/aussiwozzi/cgi/base/arc_lt_heavy.mdl","models/aussiwozzi/cgi/base/arc_lt_medic.mdl","models/aussiwozzi/cgi/base/arc_lt_chunky.mdl","models/aussiwozzi/cgi/base/arc_raffle.mdl","models/aussiwozzi/cgi/base/arc_cpt_jarr.mdl", "models/aussiwozzi/cgi/base/arc_sgt.mdl","models/aussiwozzi/cgi/base/arc_sgt_marksman.mdl","models/aussiwozzi/cgi/base/arc_sgt_heavy.mdl","models/aussiwozzi/cgi/base/arc_sgt_medic.mdl","models/aussiwozzi/cgi/base/arc_sgt_spida.mdl","models/aussiwozzi/cgi/base/arc_lt_macka.mdl","models/aussiwozzi/cgi/base/arc_cpt_shadowz.mdl"},

    description = [[Congratulations, you are ARC Alpha Coruscant Guard!]],

    weapons = {"arccw_dc17_stun_v2" ,"arccw_westarm5_v2", "arccw_dp23_v2","arccw_dual_dc17s", "realistic_hook", "weapon_cuff_elastic_officer", "stunstick", "weapon_policeshield","weaponchecker","datapad_player", "carkeys"},

    command = "arcacg",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Coruscant Guard",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 9

})

TEAM_CGARC = DarkRP.createJob("Coruscant Guard ARC", {

    color = Color(255, 77, 77, 255),

    model = {"models/aussiwozzi/cgi/base/CG_arc.mdl"},

    description = [[Congratulations, you are a Coruscant Guard ARC Trooper!]],

    weapons = {"arccw_dc17_stun_v2", "arccw_westarm5_v2","arccw_dp23_v2", "arccw_dual_dc17s","weaponchecker", "realistic_hook", "weapon_cuff_elastic_officer", "stunstick", "weapon_policeshield","datapad_player"},

    command = "cgarc",

    max = 2,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Coruscant Guard",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 10

})



TEAM_CGMEDOFFICER = DarkRP.createJob("Coruscant Guard Medic Officer", {

    color = Color(255, 77, 77, 255),

    model = {"models/aussiwozzi/cgi/base/CG_medic_officer.mdl"},

    description = [[Congratulations, you are the Medical Officer of the Coruscant Guard!]],

    weapons = {"arccw_dp23_v2", "arccw_dc17_stun_v2", "stunstick", "arccw_dc15a_v2_stun", "weapon_cuff_elastic_officer","weaponchecker", "weapon_policeshield", "lord_chrome_medkit", "weapon_bactainjector", "weapon_jew_stimkit", "weapon_defibrillator", "arccw_bacta_grenade", "tf_weapon_medigun","datapad_player", "carkeys"},

    command = "cgmo",

    max = 1,

    salary = 175,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Coruscant Guard",

PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (260) ply:SetGravity(1)  end,

    sortOrder = 11

})



TEAM_CGSERGEANT = DarkRP.createJob("Coruscant Guard Sergeant", {

    color = Color(255, 77, 77, 255),

    model = {"models/aussiwozzi/cgi/base/CG_trooper.mdl", "models/aussiwozzi/cgi/base/cg_rys.mdl","models/aussiwozzi/cgi/base/cg_jek.mdl" ,"models/aussiwozzi/cgi/base/cg_tops.mdl" ,"models/aussiwozzi/cgi/base/cg_riot.mdl"},

    description = [[Congratulations, you are a Sergeant of the Coruscant Guard!]],

    weapons = {"arccw_dp23_v2", "arccw_dc17_stun_v2", "arccw_dc15a_v2_stun","stunstick", "weapon_cuff_elastic_officer", "weapon_policeshield","weaponchecker","datapad_player"},

    command = "cgsgt",

    max = 0,

    salary = 175,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Coruscant Guard",

PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (260) ply:SetGravity(1)  end,

    sortOrder = 12

})



TEAM_CGMEDTROOPER = DarkRP.createJob("Coruscant Guard Medic Trooper", {

    color = Color(255, 77, 77, 255),

    model = {"models/aussiwozzi/cgi/base/CG_medic.mdl"},

    description = [[Congratulations, you are a Medic of the Coruscant Guard!]],

    weapons = {"arccw_dp23_v2","arccw_dc17_stun_v2", "arccw_dc15a_v2_stun", "stunstick", "weapon_cuff_elastic_officer","weaponchecker", "weapon_policeshield", "lord_chrome_medkit", "weapon_bactainjector", "weapon_jew_stimkit", "weapon_defibrillator","datapad_player", "carkeys"},

    command = "cgmt",

    max = 3,

    salary = 150,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Coruscant Guard",

PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (260) ply:SetGravity(1)  end,

    sortOrder = 13

})



TEAM_CGTROOPER = DarkRP.createJob("Coruscant Guard Trooper", {

    color = Color(255, 77, 77, 255),

    model = {"models/aussiwozzi/cgi/base/CG_trooper.mdl"},

    description = [[Congratulations, you are a trooper of the Coruscant Guard!]],

    weapons = {"arccw_dc17_stun_v2", "stunstick", "weapon_cuff_elastic","weaponchecker", "weapon_policeshield","arccw_dc15a_v2_stun","datapad_player"},

    command = "cgtrp",

    max = 0,

    salary = 150,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Coruscant Guard",

PlayerSpawn = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetRunSpeed (260) ply:SetGravity(1)

end,

    sortOrder = 14

})

TEAM_CGJEDI = DarkRP.createJob("Coruscant Guard Temple Guard", {
    color = Color(255, 77, 77, 255),
    model = { "models/epangelmatikes/templeguard/peacemakerUNI.mdl" },
    description = [[Congratulations, you are a CG Temple Guard!]],
    weapons = { "weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys", "weapon_cuff_elastic_officer"},
    command = "cgtg",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Coruscant Guard",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 15,
})

TEAM_CGJEDICHIEF = DarkRP.createJob("CG Temple Guard Chief", {
    color = Color(255, 77, 77, 255),
    model = { "models/player/imagundi/cinndrallig.mdl", "models/player/imagundi/rcinndrallig.mdl", "models/epangelmatikes/templeguard/peacemakerUNI.mdl" },
    description = [[You are a part of the Jedi council, and leader of the Temple Guard!]],
    weapons = { "weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys", "weapon_cuff_elastic_officer"},
    command = "cgchief",
    max = 1,
    salary = 225,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Coruscant Guard",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 16,
})

TEAM_CGGENERALSHAAK = DarkRP.createJob("CG General Shaak Ti", {
    color = Color(255, 77, 77, 255),
    model = {"models/tfa/comm/gg/pm_sw_shaakti.mdl"},
    description = [[You are Jedi General Shaak Ti. It is your role to help lower ranking Jedi get an understanding of the Order!]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "weapon_cuff_elastic_officer", "stunstick", "carkeys"},
    command = "cgshaak",
    max = 1,
    salary = 275,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Coruscant Guard",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 17,
})


-- GM --

TEAM_GMGENERAL = DarkRP.createJob("Galactic Marines General", {

    color = Color(119, 63, 202),

    model = {"models/aussiwozzi/cgi/base/gm_bacara.mdl", "models/toe/cgi/gens/gen_acolyte.mdl", "models/toe/cgi/gens/gen_archer.mdl", "models/toe/cgi/gens/gen_id.mdl", "models/toe/cgi/gens/gen_foxjack.mdl", "models/toe/cgi/gens/gen_matrix.mdl", "models/toe/cgi/gens/gen_nomad.mdl", "models/naval_offduty/pm_naval_cas.mdl", "models/jajoff/sps/republic/tc13j/rsb01.mdl"},

    description = [[Congratulations, you are the General of the Galactic Marines!]],

    weapons = {"arccw_dc15a_v2_gm", "arccw_duals_dc17ext_v2", "arccw_incendiary", "seal6-c4", "weapons_flamethrower", "realistic_hook", "seal6-c4","weapon_remotedrone","datapad_player"},

    command = "gmgen",

    max = 2,

    salary = 300,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Galactic Marines",

    PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 0

})



TEAM_GMMCOMMANDER = DarkRP.createJob("Galactic Marines Marshal Commander", {
    color = Color(119, 63, 202),
    model = {"models/aussiwozzi/cgi/base/advisor_red.mdl", "models/aussiwozzi/cgi/base/advisor_grey.mdl", "models/aussiwozzi/cgi/base/advisor_green.mdl", "models/aussiwozzi/cgi/base/advisor_blue.mdl", "models/aussiwozzi/cgi/base/gm_bacara.mdl", "models/aussiwozzi/cgi/base/224th_toast.mdl","models/aussiwozzi/cgi/base/22nd_dempsey.mdl","models/jajoff/sps/republic/tc13j/rsb02.mdl"},
    description = [[Congratulations, you are the Marshal Commander of the Galactic Marines!]],
    weapons = {"arccw_dc15a_v2_gm", "arccw_duals_dc17ext_v2", "arccw_incendiary", "seal6-c4", "weapons_flamethrower", "realistic_hook"},
    command = "gmmco",
    max = 1,
    salary = 275,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Galactic Marines",
    PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 2
})

TEAM_GMCOMMANDER = DarkRP.createJob("Galactic Marines Commander", {
    color = Color(119, 63, 202),
    model = {"models/aussiwozzi/cgi/base/gm_bacara.mdl", "models/aussiwozzi/cgi/base/gm_elite.mdl", "models/aussiwozzi/cgi/base/gm_officer.mdl", "models/aussiwozzi/cgi/base/gm_trooper.mdl", "models/aussiwozzi/cgi/base/gm_keller_unit.mdl"},
    description = [[Congratulations, you are the Commander of the Galactic Marines!]],
    weapons = {"arccw_dc15a_v2_gm", "arccw_duals_dc17ext_v2", "arccw_incendiary", "seal6-c4", "weapons_flamethrower", "realistic_hook"},
    command = "gmco",
    max = 1,
    salary = 275,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Galactic Marines",
    PlayerSpawn = function(ply) ply:SetMaxHealth(600) ply:SetHealth(600) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 3
})

TEAM_GMEXECUTIVEOFFICER = DarkRP.createJob("Galactic Marines Executive Officer", {

    color = Color(119, 63, 202),

    model = {"models/aussiwozzi/cgi/base/gm_keller.mdl", "models/aussiwozzi/cgi/base/gm_elite.mdl", "models/aussiwozzi/cgi/base/gm_officer.mdl", "models/aussiwozzi/cgi/base/gm_trooper.mdl", "models/aussiwozzi/cgi/base/gm_keller_unit.mdl"},

    description = [[Congratulations, you are the Executive Officer of the Galactic Marines!]],

    weapons = {"arccw_dc15a_v2_gm", "arccw_duals_dc17ext_v2", "arccw_incendiary", "seal6-c4", "weapons_flamethrower", "realistic_hook"},

    command = "gmxo",

    max = 1,

    salary = 250,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Galactic Marines",

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 4

})



TEAM_GMMAJOR = DarkRP.createJob("Galactic Marines Major", {

    color = Color(119, 63, 202),

    model = {"models/aussiwozzi/cgi/base/gm_raffle.mdl", "models/aussiwozzi/cgi/base/gm_elite.mdl", "models/aussiwozzi/cgi/base/gm_officer.mdl", "models/aussiwozzi/cgi/base/gm_trooper.mdl", "models/aussiwozzi/cgi/base/gm_keller_unit.mdl"},

    description = [[Congratulations, you are the Major of the Galactic Marines!]],

    weapons = {"arccw_dc15a_v2_gm", "arccw_duals_dc17ext_v2", "arccw_incendiary", "seal6-c4", "weapons_flamethrower", "realistic_hook"},

    command = "gmmjr",

    max = 1,

    salary = 225,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Galactic Marines",

    PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 5

})



TEAM_GMLIEUTENANT = DarkRP.createJob("Galactic Marines Lieutenant", {

    color = Color(119, 63, 202),

    model = {"models/aussiwozzi/cgi/base/gm_elite.mdl", "models/aussiwozzi/cgi/base/gm_officer.mdl", "models/aussiwozzi/cgi/base/gm_trooper.mdl", "models/aussiwozzi/cgi/base/gm_keller_unit.mdl"},

    description = [[Congratulations, you are a Lieutenant of the Galactic Marines!]],

    weapons = {"arccw_dc15a_v2_gm", "arccw_dc17_v2", "seal6-c4", "realistic_hook"},

    command = "gmlt",

    max = 6,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Galactic Marines",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 6

})



TEAM_GMFLAMETROOPER = DarkRP.createJob("Galactic Marines Flame Trooper", {

    color = Color(119, 63, 202),

    model = {"models/aussiwozzi/cgi/base/gm_jet.mdl"},

    description = [[Congratulations, you are a Flame Trooper of the Galactic Marines!]],

    weapons = {"arccw_dc15a_v2_gm", "arccw_dc17_v2", "weapons_flamethrower", "realistic_hook", "seal6-c4"},

    command = "gmft",

    max = 3,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Galactic Marines",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 7

})


--[[
TEAM_GMKUTROOPER = DarkRP.createJob("Galactic Marines Kellers Unit", {

    color = Color(119, 63, 202),

    model = {"models/herm/cgi_new/21st/ku_grunt.mdl","models/herm/cgi_new/21st/gm_trooper1.mdl","models/herm/cgi_new/21st/gm_trooper2.mdl"},

    description = [[Congratulations, you are a Flame Trooper of the Galactic Marines!]]--,

--[[    weapons = {"arccw_dc15a_v2_gm", "arccw_dc17_v2", "rw_sw_dp23du", "realistic_hook", "t3m4_empgrenade"},

    command = "gmku",

    max = 2,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Galactic Marines",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 8

})--]]

TEAM_ARCALPHAGM = DarkRP.createJob("Galactic Marines Alpha ARC", {

    color = Color(119, 63, 202),

    model = {"models/aussiwozzi/cgi/base/arc_cpt_grenadier.mdl","models/aussiwozzi/cgi/base/arc_sgt_grenadier.mdl","models/aussiwozzi/cgi/base/arc_lt_grenadier.mdl","models/aussiwozzi/cgi/base/gm_arc.mdl","models/aussiwozzi/cgi/base/arc_cpt.mdl","models/aussiwozzi/cgi/base/arc_cpt_marksman.mdl","models/aussiwozzi/cgi/base/arc_cpt_heavy.mdl","models/aussiwozzi/cgi/base/arc_cpt_rat.mdl","models/aussiwozzi/cgi/base/arc_cpt_medic.mdl","models/aussiwozzi/cgi/base/arc_cpt_pab.mdl","models/aussiwozzi/cgi/base/arc_lt.mdl", "models/aussiwozzi/cgi/base/arc_lt_marksman.mdl", "models/aussiwozzi/cgi/base/arc_lt_heavy.mdl", "models/aussiwozzi/cgi/base/arc_lt_medic.mdl", "models/aussiwozzi/cgi/base/arc_lt_chunky.mdl","models/aussiwozzi/cgi/base/arc_raffle.mdl", "models/aussiwozzi/cgi/base/arc_cpt_jarr.mdl","models/aussiwozzi/cgi/base/arc_sgt.mdl", "models/aussiwozzi/cgi/base/arc_sgt_marksman.mdl","models/aussiwozzi/cgi/base/arc_sgt_heavy.mdl","models/aussiwozzi/cgi/base/arc_sgt_medic.mdl","models/aussiwozzi/cgi/base/arc_sgt_spida.mdl","models/aussiwozzi/cgi/base/arc_lt_macka.mdl","models/aussiwozzi/cgi/base/arc_cpt_shadowz.mdl"},

    description = [[Congratulations, you are ARC Alpha Galactic Marines!]],

    weapons = {"arccw_westarm5_v2", "arccw_dual_dc17s", "realistic_hook", "seal6-c4", "carkeys"},

    command = "arcagm",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Galactic Marines",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 9

})

TEAM_GMARC = DarkRP.createJob("Galactic Marines ARC", {

    color = Color(119, 63, 202),

    model = {"models/aussiwozzi/cgi/base/gm_arc.mdl"},

    description = [[Congratulations, you are a Galactic Marines ARC Trooper!]],

    weapons = {"arccw_westarm5_v2", "arccw_dual_dc17s", "seal6-c4", "realistic_hook"},

    command = "gmarc",

    max = 2,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Galactic Marines",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 9

})



TEAM_GMMEDOFFICER = DarkRP.createJob("Galactic Marines Medic Officer", {

    color = Color(119, 63, 202),

    model = {"models/aussiwozzi/cgi/base/gm_tre.mdl", "models/aussiwozzi/cgi/base/gm_medic.mdl"},

    description = [[Congratulations, you are a Medical Officer of the Galactic Marines!]],

    weapons = {"arccw_dc15a_v2_gm", "arccw_dc17_v2", "arccw_shock_grenade", "seal6-c4", "weapon_bactainjector", "weapon_jew_stimkit", "weapon_defibrillator", "arccw_bacta_grenade", "tf_weapon_medigun", "realistic_hook","lord_chrome_medkit", "carkeys"},

    command = "gmmo",

    max = 1,

    salary = 175,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Galactic Marines",

PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 10

})



TEAM_GMSERGEANT = DarkRP.createJob("Galactic Marines Sergeant", {

    color = Color(119, 63, 202),

    model = {"models/aussiwozzi/cgi/base/gm_officer.mdl", "models/aussiwozzi/cgi/base/gm_trooper.mdl", "models/aussiwozzi/cgi/base/gm_keller_unit.mdl"},

    description = [[Congratulations, you are a Sergeant of the Galactic Marines!]],

    weapons = {"arccw_dc15a_v2_gm", "arccw_dc17_v2", "arccw_shock_grenade", "realistic_hook"},

    command = "gmsgt",

    max = 0,

    salary = 175,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Galactic Marines",

PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,



    sortOrder = 11

})



TEAM_GMMEDTROOPER = DarkRP.createJob("Galactic Marines Medic Trooper", {

    color = Color(119, 63, 202),

    model = {"models/aussiwozzi/cgi/base/gm_medic.mdl"},

    description = [[Congratulations, you are a Medic of the Galactic Marines!]],

    weapons = {"arccw_dc15a_v2_gm", "arccw_dc17_v2", "arccw_shock_grenade", "lord_chrome_medkit", "weapon_bactainjector", "weapon_jew_stimkit", "weapon_defibrillator", "realistic_hook", "carkeys"},

    command = "gmmt",

    max = 3,

    salary = 150,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Galactic Marines",

PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,



    sortOrder = 12

})



TEAM_GMTROOPER = DarkRP.createJob("Galactic Marines Trooper", {

    color = Color(119, 63, 202),

    model = {"models/aussiwozzi/cgi/base/gm_trooper.mdl", "models/aussiwozzi/cgi/base/gm_keller_unit.mdl"},

    description = [[Congratulations, you are a member of the Galactic Marines!]],

    weapons = {"arccw_dc15a_v2_gm", "arccw_dc17_v2", "realistic_hook"},

    command = "gmtrp",

    max = 0,

    salary = 150,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Galactic Marines",

PlayerSpawn = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetRunSpeed (240) ply:SetGravity(1)  end,



    sortOrder = 13

})

TEAM_GMJEDI = DarkRP.createJob("Galactic Marines Jedi", {
    color = Color(119, 63, 202),
    model = {"models/aussiwozzi/cgi/base/jedi_rahm_kota.mdl",
    "models/aussiwozzi/cgi/base/jedi_bultar_swan.mdl",
    "models/tfa/comm/gg/pm_sw_adigallia.mdl",
    "models/tfa/comm/gg/pm_sw_barriss.mdl",
    "models/tfa/comm/gg/pm_sw_eeth_koth.mdl",
    "models/tfa/comm/gg/pm_sw_imagundi.mdl",
    "models/gonzo/saeseetiin/saeseetiin.mdl",
    "models/player/jedi/nyssa_delacor.mdl",
    "models/player/jedi/female_chiss_consular.mdl",
    "models/player/jedi/female_human_consular.mdl",
    "models/player/jedi/female_kaleesh_consular.mdl",
    "models/player/jedi/female_keldoran_consular.mdl",
    "models/player/jedi/female_pantoran_consular.mdl",
    "models/player/jedi/female_rodian_consular.mdl",
    "models/player/jedi/female_tholothian_consular.mdl",
    "models/player/jedi/female_zabrak_consular.mdl",
    "models/player/jedi/male_chiss_consular.mdl",
    "models/player/jedi/male_human_consular.mdl",
    "models/player/jedi/male_kaleesh_consular.mdl",
    "models/player/jedi/male_keldoran_consular.mdl",
    "models/player/jedi/male_tholothian_consular.mdl",
    "models/player/jedi/male_zabrak_consular.mdl",
    "models/player/jedi/pantoran_male_consular.mdl",
    "models/player/jedi/rodian_male_consular.mdl",
    "models/player/jedi/twilek_consular_male.mdl",
    "models/player/jedi/twilek_female_consular.mdl",
    "models/player/jedi/female_chiss_guardian.mdl",
    "models/player/jedi/female_human_guardian.mdl",
    "models/player/jedi/female_kaleesh_guardian.mdl",
    "models/player/jedi/female_keldoran_guardian.mdl",
    "models/player/jedi/female_pantoran_guardian.mdl",
    "models/player/jedi/female_rodian_guardian.mdl",
    "models/player/jedi/female_tholothian_guardian.mdl",
    "models/player/jedi/female_zabrak_guardian.mdl",
    "models/player/jedi/male_chiss_guardian.mdl",
    "models/player/jedi/male_human_guardian.mdl",
    "models/player/jedi/male_kaleesh_guardian.mdl",
    "models/player/jedi/male_keldoran_guardian.mdl",
    "models/player/jedi/male_tholothian_guardian.mdl",
    "models/player/jedi/male_zabrak_guardian.mdl",
    "models/player/jedi/pantoran_male_guardian.mdl",
    "models/player/jedi/rodian_male_guardian.mdl",
    "models/player/jedi/twilek_female_guardian.mdl",
    "models/player/jedi/twilek_guardian_male.mdl",
    "models/player/jedi/female_chiss_sentinel.mdl",
    "models/player/jedi/female_human_sentinel.mdl",
    "models/player/jedi/female_kaleesh_sentinel.mdl",
    "models/player/jedi/female_keldoran_sentinel.mdl",
    "models/player/jedi/female_pantoran_sentinel.mdl",
    "models/player/jedi/female_rodian_sentinel.mdl",
    "models/player/jedi/female_tholothian_sentinel.mdl",
    "models/player/jedi/female_zabrak_sentinel.mdl",
    "models/player/jedi/male_chiss_sentinel.mdl",
    "models/player/jedi/male_human_sentinel.mdl",
    "models/player/jedi/male_kaleesh_sentinel.mdl",
    "models/player/jedi/male_keldoran_sentinel.mdl",
    "models/player/jedi/male_tholothian_sentinel.mdl",
    "models/player/jedi/male_zabrak_sentinel.mdl",
    "models/player/jedi/pantoran_male_sentinel.mdl",
    "models/player/jedi/rodian_male_sentinel.mdl",
    "models/player/jedi/twilek_female_sentinel.mdl",
    "models/player/jedi/twilek_sentinel_male.mdl"
    },
    description = [[Congratulations, you are a Galatic Marines Jedi!]],
    weapons = { "weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},
    command = "gmjedi",
    max = 4,
    salary = 150,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Galactic Marines",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 14,
})

TEAM_GMGENERALADI = DarkRP.createJob("GM General Ki-Adi-Mundi", {
    color = Color(119, 63, 202),
    model = {"models/tfa/comm/gg/pm_sw_mundi.mdl"},
    description = [[You are Jedi General Ki-Adi-Mundi. It is your role to help lower ranking Jedi get an understanding of the Order!]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},
    command = "gmadi",
    max = 1,
    salary = 275,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Galactic Marines",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 15,
})


--- WOLFPACK BATTALION  --

TEAM_WPGENERAL = DarkRP.createJob("Wolfpack General", {

    color = Color(153, 144, 144, 255),

    model = {"models/aussiwozzi/cgi/base/104th_wolffe.mdl", "models/toe/cgi/gens/gen_acolyte.mdl", "models/toe/cgi/gens/gen_archer.mdl", "models/toe/cgi/gens/gen_id.mdl", "models/toe/cgi/gens/gen_foxjack.mdl", "models/toe/cgi/gens/gen_matrix.mdl", "models/toe/cgi/gens/gen_nomad.mdl", "models/naval_offduty/pm_naval_cas.mdl","models/herm/cgi_new/104th/104th_trooper2.mdl","models/herm/cgi_new/104th/104th_trooper1.mdl", "models/jajoff/sps/republic/tc13j/rsb01.mdl"},

    description = [[Congratulations, you are the Deployed General of the Wolfpack Battalion!]],

    weapons = {"arccw_duals_dc17ext_v2", "arccw_cr2", "realistic_hook", "arccw_hunter_shotgun", "arccw_valken38x_v2", "weapon_thruster","weapon_remotedrone","datapad_player", "follower_controller"},

    command = "wpgen",

    max = 2,

    salary = 300,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Wolfpack Battalion",

PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 0

})


TEAM_ARCMCOMMANDER = DarkRP.createJob("Wolfpack Marshal Commander", {

    color = Color(153, 144, 144, 255),

    model = {"models/aussiwozzi/cgi/base/advisor_red.mdl", "models/aussiwozzi/cgi/base/advisor_grey.mdl", "models/aussiwozzi/cgi/base/advisor_green.mdl", "models/aussiwozzi/cgi/base/advisor_blue.mdl", "models/aussiwozzi/cgi/base/104th_wolffe.mdl","models/aussiwozzi/cgi/base/104th_evo_wolffe.mdl","models/aussiwozzi/cgi/base/224th_toast.mdl","models/aussiwozzi/cgi/base/22nd_dempsey.mdl","models/jajoff/sps/republic/tc13j/rsb02.mdl","models/aussiwozzi/cgi/base/104th_arf.mdl","models/aussiwozzi/cgi/base/104th_guardian.mdl", "models/aussiwozzi/cgi/base/104th_mortar.mdl", "models/aussiwozzi/cgi/base/104th_quantum.mdl", "models/aussiwozzi/cgi/base/104th_comet.mdl", "models/aussiwozzi/cgi/base/104th_sinker.mdl", "models/aussiwozzi/cgi/base/104th_raffle.mdl", "models/aussiwozzi/cgi/base/104th_jet_officer.mdl" },

    description = [[Congratulations, you are the Marshal Commander of the Wolfpack Battalion!]],

    weapons = {"arccw_cr2", "arccw_duals_dc17ext_v2", "arccw_hunter_shotgun", "arccw_valken38x_v2", "weapon_thruster","realistic_hook", "follower_controller"},

    command = "wpmco",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Wolfpack Battalion",

PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 2

})

TEAM_ARCCOMMANDER = DarkRP.createJob("Wolfpack Commander", {

    color = Color(153, 144, 144, 255),

    model = {"models/aussiwozzi/cgi/base/104th_wolffe.mdl","models/aussiwozzi/cgi/base/104th_evo_wolffe.mdl", "models/aussiwozzi/cgi/base/104th_barc.mdl", "models/aussiwozzi/cgi/base/104th_raffle.mdl","models/herm/cgi_new/104th/104th_trooper2.mdl","models/herm/cgi_new/104th/104th_trooper1.mdl" ,"models/aussiwozzi/cgi/base/104th_arf.mdl","models/aussiwozzi/cgi/base/104th_guardian.mdl", "models/aussiwozzi/cgi/base/104th_mortar.mdl", "models/aussiwozzi/cgi/base/104th_quantum.mdl", "models/aussiwozzi/cgi/base/104th_comet.mdl", "models/aussiwozzi/cgi/base/104th_sinker.mdl", "models/aussiwozzi/cgi/base/104th_raffle.mdl", "models/aussiwozzi/cgi/base/104th_jet_officer.mdl"},

    description = [[Congratulations, you are the Commander of the Wolfpack Battalion!]],

    weapons = {"arccw_cr2", "arccw_duals_dc17ext_v2", "arccw_hunter_shotgun", "arccw_valken38x_v2", "weapon_thruster","realistic_hook", "follower_controller"},

    command = "wpco",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Wolfpack Battalion",

PlayerSpawn = function(ply) ply:SetMaxHealth(600) ply:SetHealth(600) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 3

})



TEAM_ARCEXECUTIVEOFFICER = DarkRP.createJob("Wolfpack Executive Officer", {

    color = Color(153, 144, 144, 255),

    model = {"models/aussiwozzi/cgi/base/104th_sinker.mdl","models/aussiwozzi/cgi/base/104th_evo_officer.mdl","models/aussiwozzi/cgi/base/104th_officer.mdl", "models/aussiwozzi/cgi/base/104th_barc.mdl", "models/aussiwozzi/cgi/base/104th_raffle.mdl","models/aussiwozzi/cgi/base/104th_arf.mdl","models/aussiwozzi/cgi/base/104th_guardian.mdl", "models/aussiwozzi/cgi/base/104th_mortar.mdl", "models/aussiwozzi/cgi/base/104th_quantum.mdl", "models/aussiwozzi/cgi/base/104th_comet.mdl", "models/aussiwozzi/cgi/base/104th_jet_officer.mdl"},

    description = [[Congratulations, you are the Executive Officer of the Wolfpack Battalion!]],

    weapons = {"arccw_cr2", "arccw_duals_dc17ext_v2", "arccw_hunter_shotgun", "arccw_valken38x_v2", "weapon_thruster","realistic_hook", "follower_controller"},

    command = "wpxo",

    max = 1,

    salary = 250,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Wolfpack Battalion",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 4

})



TEAM_ARCMAJOR = DarkRP.createJob("Wolfpack Major", {

    color = Color(153, 144, 144, 255),

    model = {"models/aussiwozzi/cgi/base/104th_comet.mdl", "models/aussiwozzi/cgi/base/104th_evo_officer.mdl","models/aussiwozzi/cgi/base/104th_officer.mdl", "models/aussiwozzi/cgi/base/104th_barc.mdl", "models/aussiwozzi/cgi/base/104th_raffle.mdl","models/aussiwozzi/cgi/base/104th_arf.mdl","models/aussiwozzi/cgi/base/104th_guardian.mdl", "models/aussiwozzi/cgi/base/104th_mortar.mdl", "models/aussiwozzi/cgi/base/104th_quantum.mdl", "models/aussiwozzi/cgi/base/104th_comet.mdl", "models/aussiwozzi/cgi/base/104th_jet_officer.mdl"},

    description = [[Congratulations, you are the Major of the Wolfpack Battalion!]],

    weapons = {"arccw_cr2", "arccw_duals_dc17ext_v2", "arccw_hunter_shotgun", "arccw_valken38x_v2", "weapon_thruster","realistic_hook", "follower_controller"},

    command = "wpmjr",

    max = 1,

    salary = 225,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Wolfpack Battalion",

PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 5

})



TEAM_ARCLIEUTENANT = DarkRP.createJob("Wolfpack Lieutenant", {

    color = Color(153, 144, 144, 255),

    model = {"models/aussiwozzi/cgi/base/104th_jet_officer.mdl","models/aussiwozzi/cgi/base/104th_evo_officer.mdl","models/aussiwozzi/cgi/base/104th_officer.mdl","models/aussiwozzi/cgi/base/104th_barc.mdl","models/herm/cgi_new/104th/104th_trooper2.mdl","models/herm/cgi_new/104th/104th_trooper1.mdl", "models/aussiwozzi/cgi/base/104th_boost.mdl"},

    description = [[Congratulations, you are a Lieutenant of the Wolfpack Battalion!]],

    weapons = {"arccw_cr2", "arccw_dc17_v2", "arccw_hunter_shotgun", "weapon_thruster","realistic_hook", "follower_controller"},

    command = "wplt",

    max = 6,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Wolfpack Battalion",

PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 6

})



TEAM_ARCPATHFINDER = DarkRP.createJob("Wolfpack Direwolf", {

    color = Color(153, 144, 144, 255),

    model = {"models/aussiwozzi/cgi/base/104th_barc.mdl", "models/aussiwozzi/cgi/base/104th_evo_officer.mdl","models/aussiwozzi/cgi/base/104th_guardian.mdl","models/aussiwozzi/cgi/base/104th_mortar.mdl","models/aussiwozzi/cgi/base/104th_quantum.mdl","models/aussiwozzi/cgi/base/104th_arf.mdl","models/aussiwozzi/cgi/base/104th_evo.mdl","models/aussiwozzi/cgi/base/104th_jet_officer.mdl","models/aussiwozzi/cgi/base/104th_boost.mdl"},

    description = [[Congratulations, you are part of the Direwolves in the Wolfpack Battalion!]],

    weapons = {"arccw_dc17_v2", "arccw_hunter_shotgun", "arccw_cr2", "weapon_jetpack", "follower_controller"},

    command = "wpdw",

    max = 3,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Wolfpack Battalion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 7

})

TEAM_ARCALPHAWP = DarkRP.createJob("Wolfpack Alpha ARC", {

    color = Color(153, 144, 144, 255),

    model = {"models/aussiwozzi/cgi/base/arc_cpt_grenadier.mdl","models/aussiwozzi/cgi/base/arc_sgt_grenadier.mdl","models/aussiwozzi/cgi/base/arc_lt_grenadier.mdl","models/aussiwozzi/cgi/base/104th_arc.mdl","models/aussiwozzi/cgi/base/104th_arc_hazzi.mdl","models/aussiwozzi/cgi/base/104th_arc_dusty.mdl","models/aussiwozzi/cgi/base/arc_cpt.mdl","models/aussiwozzi/cgi/base/arc_cpt_marksman.mdl","models/aussiwozzi/cgi/base/arc_cpt_heavy.mdl","models/aussiwozzi/cgi/base/arc_cpt_rat.mdl","models/aussiwozzi/cgi/base/arc_cpt_medic.mdl","models/aussiwozzi/cgi/base/arc_cpt_pab.mdl","models/aussiwozzi/cgi/base/arc_lt.mdl","models/aussiwozzi/cgi/base/arc_lt_marksman.mdl","models/aussiwozzi/cgi/base/arc_lt_heavy.mdl","models/aussiwozzi/cgi/base/arc_lt_medic.mdl","models/aussiwozzi/cgi/base/arc_lt_chunky.mdl","models/aussiwozzi/cgi/base/arc_raffle.mdl","models/aussiwozzi/cgi/base/arc_cpt_jarr.mdl","models/aussiwozzi/cgi/base/arc_sgt.mdl","models/aussiwozzi/cgi/base/arc_sgt_marksman.mdl","models/aussiwozzi/cgi/base/arc_sgt_heavy.mdl","models/aussiwozzi/cgi/base/arc_sgt_medic.mdl","models/aussiwozzi/cgi/base/arc_sgt_spida.mdl","models/aussiwozzi/cgi/base/arc_lt_macka.mdl","models/aussiwozzi/cgi/base/arc_cpt_shadowz.mdl","models/aussiwozzi/cgi/base/104th_evo.mdl","models/aussiwozzi/cgi/base/104th_evo_officer.mdl"},

    description = [[Congratulations, you are a Wolfpack Alpha ARC!]],

    weapons = {"arccw_westarm5_v2", "arccw_dual_dc17s", "realistic_hook", "arccw_hunter_shotgun", "weapon_thruster", "carkeys", "follower_controller"},

    command = "arcawp",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Wolfpack Battalion",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 8

})



TEAM_WPARC = DarkRP.createJob("Wolfpack ARC", {

    color = Color(153, 144, 144, 255),

    model = {"models/aussiwozzi/cgi/base/104th_arc.mdl","models/aussiwozzi/cgi/base/104th_arc_hazzi.mdl","models/aussiwozzi/cgi/base/104th_arc_dusty.mdl","models/aussiwozzi/cgi/base/104th_evo.mdl","models/aussiwozzi/cgi/base/104th_evo_officer.mdl"},

    description = [[Congratulations, you are a Wolfpack ARC Trooper!]],

    weapons = {"arccw_westarm5_v2", "arccw_dual_dc17s", "arccw_hunter_shotgun", "realistic_hook", "weapon_thruster", "follower_controller"},

    command = "wparc",

    max = 2,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Wolfpack Battalion",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 8

})



TEAM_ARCMEDOFFICER = DarkRP.createJob("Wolfpack Medic Officer", {

    color = Color(153, 144, 144, 255),

    model = {"models/aussiwozzi/cgi/base/104th_medic_officer.mdl","models/aussiwozzi/cgi/base/104th_dash.mdl","models/aussiwozzi/cgi/base/104th_outback.mdl", "models/aussiwozzi/cgi/base/104th_evo_officer.mdl", "models/aussiwozzi/cgi/base/104th_jet_officer.mdl"},

    description = [[Congratulations, you are the Medical Officer of the Wolfpack Battalion!]],

    weapons = {"arccw_dc17_v2", "arccw_cr2", "arccw_hunter_shotgun", "weapon_thruster", "realistic_hook", "weapon_bactainjector", "lord_chrome_medkit", "weapon_jew_stimkit", "weapon_defibrillator", "arccw_bacta_grenade","tf_weapon_medigun", "carkeys", "follower_controller"},

    command = "wpmo",

    max = 1,

    salary = 175,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Wolfpack Battalion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)   end,

    sortOrder = 9

})



TEAM_ARCSERGEANT = DarkRP.createJob("Wolfpack Sergeant", {

    color = Color(153, 144, 144, 255),

    model = {"models/aussiwozzi/cgi/base/104th_trooper.mdl", "models/aussiwozzi/cgi/base/104th_boost.mdl","models/aussiwozzi/cgi/base/104th_evo.mdl","models/aussiwozzi/cgi/base/104th_barc.mdl", "models/aussiwozzi/cgi/base/104th_jet.mdl","models/herm/cgi_new/104th/104th_trooper2.mdl","models/herm/cgi_new/104th/104th_trooper1.mdl"},

    description = [[Congratulations, you are a Sergeant of the Wolfpack Battalion!]],

    weapons = {"arccw_dc17_v2", "arccw_cr2", "arccw_hunter_shotgun", "weapon_thruster", "realistic_hook", "follower_controller"},

    command = "wpsgt",

    max = 0,

    salary = 175,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Wolfpack Battalion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)   end,

    sortOrder = 10

})


TEAM_ARCMEDTROOPER = DarkRP.createJob("Wolfpack Medic Trooper", {

    color = Color(153, 144, 144, 255),

    model = {"models/aussiwozzi/cgi/base/104th_medic.mdl","models/aussiwozzi/cgi/base/104th_dash.mdl", "models/aussiwozzi/cgi/base/104th_evo.mdl", "models/aussiwozzi/cgi/base/104th_jet.mdl"},

    description = [[Congratulations, you are a Medic of the Wolfpack Battalion!]],

    weapons = {"arccw_dc17_v2", "arccw_cr2", "arccw_hunter_shotgun", "weapon_thruster", "realistic_hook", "weapon_bactainjector", "lord_chrome_medkit", "weapon_jew_stimkit", "weapon_defibrillator", "carkeys", "follower_controller"},

    command = "wpmt",

    max = 3,

    salary = 150,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Wolfpack Battalion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetRunSpeed (240) ply:SetGravity(1)  end,



    sortOrder = 11

})



TEAM_ARCTROOPER = DarkRP.createJob("Wolfpack Trooper", {

    color = Color(153, 144, 144, 255),

    model = {"models/aussiwozzi/cgi/base/104th_trooper.mdl","models/aussiwozzi/cgi/base/104th_evo.mdl", "models/aussiwozzi/cgi/base/104th_jet.mdl"},

    description = [[Congratulations, you are a trooper of the Wolfpack Battalion!]],

    weapons = {"arccw_dc17_v2", "arccw_cr2", "weapon_thruster", "realistic_hook", "follower_controller"},

    command = "wptrp",

    max = 0,

    salary = 150,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Wolfpack Battalion",

    PlayerSpawn = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetRunSpeed (240) ply:SetGravity(1)  end,



    sortOrder = 12

})

TEAM_WPJEDI = DarkRP.createJob("Wolfpack Jedi", {
    color = Color(153, 144, 144, 255),
    model = {"models/aussiwozzi/cgi/base/jedi_rahm_kota.mdl",
    "models/aussiwozzi/cgi/base/jedi_bultar_swan.mdl",
    "models/tfa/comm/gg/pm_sw_adigallia.mdl",
    "models/tfa/comm/gg/pm_sw_barriss.mdl",
    "models/tfa/comm/gg/pm_sw_eeth_koth.mdl",
    "models/tfa/comm/gg/pm_sw_imagundi.mdl",
    "models/gonzo/saeseetiin/saeseetiin.mdl",
    "models/player/jedi/nyssa_delacor.mdl",
    "models/player/jedi/female_chiss_consular.mdl",
    "models/player/jedi/female_human_consular.mdl",
    "models/player/jedi/female_kaleesh_consular.mdl",
    "models/player/jedi/female_keldoran_consular.mdl",
    "models/player/jedi/female_pantoran_consular.mdl",
    "models/player/jedi/female_rodian_consular.mdl",
    "models/player/jedi/female_tholothian_consular.mdl",
    "models/player/jedi/female_zabrak_consular.mdl",
    "models/player/jedi/male_chiss_consular.mdl",
    "models/player/jedi/male_human_consular.mdl",
    "models/player/jedi/male_kaleesh_consular.mdl",
    "models/player/jedi/male_keldoran_consular.mdl",
    "models/player/jedi/male_tholothian_consular.mdl",
    "models/player/jedi/male_zabrak_consular.mdl",
    "models/player/jedi/pantoran_male_consular.mdl",
    "models/player/jedi/rodian_male_consular.mdl",
    "models/player/jedi/twilek_consular_male.mdl",
    "models/player/jedi/twilek_female_consular.mdl",
    "models/player/jedi/female_chiss_guardian.mdl",
    "models/player/jedi/female_human_guardian.mdl",
    "models/player/jedi/female_kaleesh_guardian.mdl",
    "models/player/jedi/female_keldoran_guardian.mdl",
    "models/player/jedi/female_pantoran_guardian.mdl",
    "models/player/jedi/female_rodian_guardian.mdl",
    "models/player/jedi/female_tholothian_guardian.mdl",
    "models/player/jedi/female_zabrak_guardian.mdl",
    "models/player/jedi/male_chiss_guardian.mdl",
    "models/player/jedi/male_human_guardian.mdl",
    "models/player/jedi/male_kaleesh_guardian.mdl",
    "models/player/jedi/male_keldoran_guardian.mdl",
    "models/player/jedi/male_tholothian_guardian.mdl",
    "models/player/jedi/male_zabrak_guardian.mdl",
    "models/player/jedi/pantoran_male_guardian.mdl",
    "models/player/jedi/rodian_male_guardian.mdl",
    "models/player/jedi/twilek_female_guardian.mdl",
    "models/player/jedi/twilek_guardian_male.mdl",
    "models/player/jedi/female_chiss_sentinel.mdl",
    "models/player/jedi/female_human_sentinel.mdl",
    "models/player/jedi/female_kaleesh_sentinel.mdl",
    "models/player/jedi/female_keldoran_sentinel.mdl",
    "models/player/jedi/female_pantoran_sentinel.mdl",
    "models/player/jedi/female_rodian_sentinel.mdl",
    "models/player/jedi/female_tholothian_sentinel.mdl",
    "models/player/jedi/female_zabrak_sentinel.mdl",
    "models/player/jedi/male_chiss_sentinel.mdl",
    "models/player/jedi/male_human_sentinel.mdl",
    "models/player/jedi/male_kaleesh_sentinel.mdl",
    "models/player/jedi/male_keldoran_sentinel.mdl",
    "models/player/jedi/male_tholothian_sentinel.mdl",
    "models/player/jedi/male_zabrak_sentinel.mdl",
    "models/player/jedi/pantoran_male_sentinel.mdl",
    "models/player/jedi/rodian_male_sentinel.mdl",
    "models/player/jedi/twilek_female_sentinel.mdl",
    "models/player/jedi/twilek_sentinel_male.mdl"
    },
    description = [[Congratulations, you are a Wolfpack Jedi!]],
    weapons = { "weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},
    command = "wpjedi",
    max = 4,
    salary = 150,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Wolfpack Battalion",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 13,
})

TEAM_WPGENERALPLO = DarkRP.createJob("WP General Plo Koon", {
    color = Color(153, 144, 144, 255),
    model = {"models/player/plokoon/plokoon.mdl"},
    description = [[You are Jedi General Plo Koon. It is your role to help lower ranking Jedi get an understanding of the Order!]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},
    command = "wpplo",
    max = 1,
    salary = 275,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Wolfpack Battalion",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 14,
})


-- Combat Engineers --

TEAM_CEGENERAL = DarkRP.createJob("Combat Engineer General", {

    color = Color(198, 155, 61),

    model = { "models/zeus/ce_senior.mdl","models/toe/cgi/gens/gen_acolyte.mdl", "models/toe/cgi/gens/gen_archer.mdl", "models/toe/cgi/gens/gen_id.mdl", "models/toe/cgi/gens/gen_foxjack.mdl", "models/toe/cgi/gens/gen_matrix.mdl", "models/toe/cgi/gens/gen_nomad.mdl", "models/naval_offduty/pm_naval_cas.mdl", "models/jajoff/sps/republic/tc13j/rsb01.mdl"},

    description = [[Congratulations, you are the Deployed General of the Combat Engineers!]],

    weapons = {"turret_placerfriendly", "datapad_player", "weapon_squadshield", "alydus_fusioncutter", "weapon_physcannon", "arccw_duals_dc17ext_v2", "arccw_dc15s_v2_327th", "defuser_bomb","defuse_kit", "arccw_dp23_v2_327th", "weapon_extinguisher_infinite", "weapon_remotedrone", "weapon_dronerepair", "fort_datapad", "realistic_hook", "carkeys"},

    command = "cegen",

    max = 2,

    salary = 300,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Combat Engineers",

PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 0

})

TEAM_CEMCOMMANDER = DarkRP.createJob("Combat Engineer Marshal Chief", {

    color = Color(198, 155, 61),

    model = {"models/zeus/ce_senior.mdl","models/aussiwozzi/cgi/base/advisor_red.mdl", "models/aussiwozzi/cgi/base/advisor_grey.mdl", "models/aussiwozzi/cgi/base/advisor_green.mdl", "models/aussiwozzi/cgi/base/advisor_blue.mdl", "models/aussiwozzi/cgi/base/212th_pilot_huey.mdl","models/aussiwozzi/cgi/base/pilot_com.mdl", "models/aussiwozzi/cgi/base/13th_toast.mdl","models/aussiwozzi/cgi/base/224th_toast.mdl","models/aussiwozzi/cgi/base/22nd_dempsey.mdl","models/jajoff/sps/republic/tc13j/rsb02.mdl"},

    description = [[Congratulations, you are the Marshal Commander of the Combat Engineers!]],

    weapons = {"turret_placerfriendly","datapad_player", "weapon_squadshield", "alydus_fusioncutter", "weapon_physcannon", "arccw_duals_dc17ext_v2", "arccw_dc15s_v2_327th", "defuser_bomb", "defuse_kit", "arccw_dp23_v2_327th", "weapon_extinguisher_infinite", "weapon_remotedrone", "weapon_dronerepair", "fort_datapad", "carkeys"},

    command = "cemco",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Combat Engineers",

PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 1

})

TEAM_CECOMMANDER = DarkRP.createJob("Combat Engineer Chief", {

    color = Color(198, 155, 61),

    model = {"models/zeus/ce_senior.mdl"},

    description = [[Congratulations, you are the Commander of the Combat Engineers!]],

    weapons = {"turret_placerfriendly","datapad_player", "weapon_squadshield", "alydus_fusioncutter", "weapon_physcannon", "arccw_duals_dc17ext_v2", "arccw_dc15s_v2_327th", "defuser_bomb","defuse_kit", "arccw_dp23_v2_327th", "weapon_extinguisher_infinite", "weapon_remotedrone", "weapon_dronerepair", "fort_datapad", "carkeys"},

    command = "ceco",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Combat Engineers",

PlayerSpawn = function(ply) ply:SetMaxHealth(600) ply:SetHealth(600) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 2

})



TEAM_CEEXECUTIVEOFFICER = DarkRP.createJob("Combat Engineer Assistant Chief", {

    color = Color(198, 155, 61),

    model = {"models/zeus/ce_senior.mdl"},

    description = [[Congratulations, you are now an Executive Officer of the Combat Engineers!]],

    weapons = {"turret_placerfriendly","datapad_player", "weapon_squadshield", "arccw_dc15s_v2_327th", "alydus_fusioncutter", "weapon_physcannon", "arccw_duals_dc17ext_v2", "defuser_bomb","defuse_kit", "weapon_extinguisher_infinite", "arccw_dp23_v2_327th", "weapon_remotedrone", "weapon_dronerepair", "fort_datapad", "carkeys"},

    command = "cexo",

    max = 1,

    salary = 250,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Combat Engineers",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 3

})



TEAM_CECHIEF = DarkRP.createJob("Combat Engineer Chief Technician", {

    color = Color(198, 155, 61),

    model = {"models/zeus/ce_senior.mdl"},

    description = [[Congratulations, you are now a Major of the Combat Engineers!]],

    weapons = {"turret_placerfriendly","datapad_player", "weapon_squadshield", "arccw_dc15s_v2_327th", "alydus_fusioncutter", "weapon_physcannon", "arccw_duals_dc17ext_v2", "arccw_dp23_v2_327th", "defuser_bomb","defuse_kit", "weapon_extinguisher_infinite", "weapon_remotedrone", "weapon_dronerepair", "fort_datapad", "carkeys"},

    command = "cemjr",

    max = 1,

    salary = 225,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Combat Engineers",

PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 4

})



TEAM_CELIEUTENANT = DarkRP.createJob("Combat Engineer Technician", {

    color = Color(198, 155, 61),

    model = {"models/zeus/ce_trooper.mdl", "models/zeus/ce_pilot.mdl", "models/zeus/ce_arf.mdl", "models/zeus/ce_engineer.mdl"},

    description = [[Congratulations, you are now a Lieutenant of the Combat Engineers!]],

    weapons = {"datapad_player", "arccw_dc15s_v2_327th", "alydus_fusioncutter", "weapon_physcannon", "defuser_bomb","defuse_kit", "arccw_dp23_v2_327th", "weapon_extinguisher_infinite", "weapon_remotedrone", "weapon_dronerepair", "arccw_dc17_v2", "carkeys"},

    command = "celt",

    max = 6,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Combat Engineers",

PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 5

})



TEAM_CEMECHANIC = DarkRP.createJob("Combat Engineer Razor Squadron", {

    color = Color(198, 155, 61),

    model = {"models/zeus/ce_razor.mdl"},

    description = [[Congratulations, you are now a member of Talon Squadron in the Combat Engineers!]],

    weapons = {"datapad_player", "alydus_fusioncutter", "arccw_dc15s_v2_327th", "weapon_physcannon", "defuser_bomb","defuse_kit","weapon_extinguisher_infinite", "weapon_remotedrone", "weapon_dronerepair", "arccw_dc17_v2", "carkeys"},

    command = "cetal",

    max = 3,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Combat Engineers",

    PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 6

})



TEAM_CEFAB = DarkRP.createJob("Combat Engineer EOD", {

    color = Color(198, 155, 61),

    model = {"models/zeus/ce_eod.mdl"},

    description = [[Congratulations, you are now a member of K Company in the Combat Engineers!]],

    weapons = {"turret_placerfriendly","datapad_player", "weapon_squadshield", "turret_placer", "fort_datapad", "arccw_dc15s_v2_327th", "alydus_fusioncutter", "weapon_physcannon", "defuser_bomb","defuse_kit", "weapon_extinguisher_infinite", "weapon_remotedrone", "weapon_dronerepair", "arccw_dc17_v2", "carkeys"},

    command = "cece",

    max = 3,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Combat Engineers",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 7

})

TEAM_ARCALPHACE = DarkRP.createJob("Combat Engineer Alpha ARC", {

    color = Color(198, 155, 61),

    model = {"models/zeus/ce_arc.mdl","models/aussiwozzi/cgi/base/arc_cpt_grenadier.mdl","models/aussiwozzi/cgi/base/arc_sgt_grenadier.mdl","models/aussiwozzi/cgi/base/arc_lt_grenadier.mdl","models/aussiwozzi/cgi/base/arc_cpt.mdl","models/aussiwozzi/cgi/base/arc_cpt_marksman.mdl","models/aussiwozzi/cgi/base/arc_cpt_heavy.mdl","models/aussiwozzi/cgi/base/arc_cpt_rat.mdl","models/aussiwozzi/cgi/base/arc_cpt_medic.mdl","models/aussiwozzi/cgi/base/arc_cpt_pab.mdl","models/aussiwozzi/cgi/base/arc_lt.mdl","models/aussiwozzi/cgi/base/arc_lt_marksman.mdl","models/aussiwozzi/cgi/base/arc_lt_heavy.mdl","models/aussiwozzi/cgi/base/arc_lt_medic.mdl","models/aussiwozzi/cgi/base/arc_lt_chunky.mdl","models/aussiwozzi/cgi/base/arc_raffle.mdl","models/aussiwozzi/cgi/base/arc_cpt_jarr.mdl","models/aussiwozzi/cgi/base/arc_sgt.mdl","models/aussiwozzi/cgi/base/arc_sgt_marksman.mdl","models/aussiwozzi/cgi/base/arc_sgt_heavy.mdl","models/aussiwozzi/cgi/base/arc_sgt_medic.mdl","models/aussiwozzi/cgi/base/arc_sgt_spida.mdl","models/aussiwozzi/cgi/base/arc_lt_macka.mdl","models/aussiwozzi/cgi/base/arc_cpt_shadowz.mdl"},

    description = [[Congratulations, you are now an Alpha ARC of the Combat Engineers!]],

    weapons = {"datapad_player", "arccw_westarm5_v2", "defuser_bomb", "defuse_kit", "arccw_dp23_v2_327th", "arccw_dual_dc17s", "weapon_physcannon", "realistic_hook", "alydus_fusioncutter", "weapon_dronerepair", "weapon_extinguisher_infinite", "weapon_remotedrone", "carkeys"},

    command = "arcace",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Combat Engineers",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 8

})


TEAM_CEARC = DarkRP.createJob("Combat Engineer ARC", {

    color = Color(198, 155, 61),

    model = {"models/zeus/ce_arc.mdl"},

    description = [[Congratulations, you are now an ARC Trooper of the Combat Engineers!]],

    weapons = {"datapad_player", "arccw_westarm5_v2", "defuser_bomb", "defuse_kit", "arccw_dp23_v2_327th", "arccw_dual_dc17s", "weapon_physcannon", "realistic_hook", "alydus_fusioncutter", "weapon_dronerepair", "weapon_extinguisher_infinite", "weapon_remotedrone", "carkeys"},

    command = "cearc",

    max = 2,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Combat Engineers",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 9

})



TEAM_CEMEDOFFICER = DarkRP.createJob("Combat Engineer Medic Officer", {

    color = Color(198, 155, 61),

    model = {"models/zeus/ce_medic.mdl"},

    description = [[Congratulations, you are now a Medical Officer of the Combat Engineers!]],

    weapons = {"datapad_player", "alydus_fusioncutter", "arccw_dc15s_v2_327th", "weapon_physcannon", "defuser_bomb", "defuse_kit", "arccw_dp23_v2_327th", "weapon_extinguisher_infinite", "weapon_remotedrone", "weapon_dronerepair", "arccw_dc17_v2", "weapon_bactainjector", "weapon_jew_stimkit", "weapon_defibrillator", "arccw_bacta_grenade", "tf_weapon_medigun", "lord_chrome_medkit", "carkeys"},

    command = "cemo",

    max = 1,

    salary = 175,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Combat Engineers",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 9

})



TEAM_CESPECIALIST = DarkRP.createJob("Combat Engineer Specialist", {

    color = Color(198, 155, 61),

    model = {"models/zeus/ce_trooper.mdl", "models/zeus/ce_pilot.mdl", "models/zeus/ce_arf.mdl", "models/zeus/ce_engineer.mdl"},

    description = [[Congratulations, you are now a Specialist of the Combat Engineers!]],

    weapons = {"datapad_player", "alydus_fusioncutter", "arccw_dc15s_v2_327th", "weapon_physcannon", "defuser_bomb", "defuse_kit", "arccw_dp23_v2_327th", "weapon_extinguisher_infinite", "weapon_remotedrone", "weapon_dronerepair", "arccw_dc17_v2", "carkeys"},

    command = "cesgt",

    max = 0,

    salary = 175,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Combat Engineers",

    PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 10

})



TEAM_CEMEDTROOPER = DarkRP.createJob("Combat Engineer Medic Trooper", {

    color = Color(198, 155, 61),

    model = {"models/zeus/ce_medic.mdl"},

    description = [[Congratulations, you are now a Medical Trooper of the Combat Engineers!]],

    weapons = {"datapad_player", "weapon_physcannon", "arccw_dp23_v2_327th", "arccw_dc15s_v2_327th", "defuser_bomb", "defuse_kit", "weapon_extinguisher_infinite", "alydus_fusioncutter", "weapon_dronerepair", "weapon_remotedrone", "arccw_dc17_v2", "lord_chrome_medkit", "weapon_bactainjector", "weapon_jew_stimkit", "weapon_defibrillator", "carkeys"},

    command = "cemt",

    max = 3,

    salary = 150,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Combat Engineers",

    PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 11

})



TEAM_CETROOPER = DarkRP.createJob("Combat Engineer Trooper", {

    color = Color(198, 155, 61),

    model = {"models/zeus/ce_trooper.mdl", "models/zeus/ce_pilot.mdl", "models/zeus/ce_arf.mdl", "models/zeus/ce_engineer.mdl"},

    description = [[Congratulations, you are now a Trooper of the Combat Engineers!]],

    weapons = {"datapad_player", "weapon_physcannon", "arccw_dc15s_v2_327th", "defuser_bomb", "defuse_kit", "weapon_extinguisher_infinite", "alydus_fusioncutter", "weapon_dronerepair", "weapon_remotedrone", "arccw_dc17_v2"},

    command = "cetrp",

    max = 0,

    salary = 150,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Combat Engineers",

    PlayerSpawn = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 12

})

TEAM_327THJEDI = DarkRP.createJob("Combat Engineer Jedi", {
    color = Color(198, 155, 61),
    model = {"models/aussiwozzi/cgi/base/jedi_rahm_kota.mdl",
    "models/aussiwozzi/cgi/base/jedi_bultar_swan.mdl",
    "models/tfa/comm/gg/pm_sw_adigallia.mdl",
    "models/tfa/comm/gg/pm_sw_barriss.mdl",
    "models/tfa/comm/gg/pm_sw_eeth_koth.mdl",
    "models/tfa/comm/gg/pm_sw_imagundi.mdl",
    "models/gonzo/saeseetiin/saeseetiin.mdl",
    "models/player/jedi/nyssa_delacor.mdl",
    "models/player/jedi/female_chiss_consular.mdl",
    "models/player/jedi/female_human_consular.mdl",
    "models/player/jedi/female_kaleesh_consular.mdl",
    "models/player/jedi/female_keldoran_consular.mdl",
    "models/player/jedi/female_pantoran_consular.mdl",
    "models/player/jedi/female_rodian_consular.mdl",
    "models/player/jedi/female_tholothian_consular.mdl",
    "models/player/jedi/female_zabrak_consular.mdl",
    "models/player/jedi/male_chiss_consular.mdl",
    "models/player/jedi/male_human_consular.mdl",
    "models/player/jedi/male_kaleesh_consular.mdl",
    "models/player/jedi/male_keldoran_consular.mdl",
    "models/player/jedi/male_tholothian_consular.mdl",
    "models/player/jedi/male_zabrak_consular.mdl",
    "models/player/jedi/pantoran_male_consular.mdl",
    "models/player/jedi/rodian_male_consular.mdl",
    "models/player/jedi/twilek_consular_male.mdl",
    "models/player/jedi/twilek_female_consular.mdl",
    "models/player/jedi/female_chiss_guardian.mdl",
    "models/player/jedi/female_human_guardian.mdl",
    "models/player/jedi/female_kaleesh_guardian.mdl",
    "models/player/jedi/female_keldoran_guardian.mdl",
    "models/player/jedi/female_pantoran_guardian.mdl",
    "models/player/jedi/female_rodian_guardian.mdl",
    "models/player/jedi/female_tholothian_guardian.mdl",
    "models/player/jedi/female_zabrak_guardian.mdl",
    "models/player/jedi/male_chiss_guardian.mdl",
    "models/player/jedi/male_human_guardian.mdl",
    "models/player/jedi/male_kaleesh_guardian.mdl",
    "models/player/jedi/male_keldoran_guardian.mdl",
    "models/player/jedi/male_tholothian_guardian.mdl",
    "models/player/jedi/male_zabrak_guardian.mdl",
    "models/player/jedi/pantoran_male_guardian.mdl",
    "models/player/jedi/rodian_male_guardian.mdl",
    "models/player/jedi/twilek_female_guardian.mdl",
    "models/player/jedi/twilek_guardian_male.mdl",
    "models/player/jedi/female_chiss_sentinel.mdl",
    "models/player/jedi/female_human_sentinel.mdl",
    "models/player/jedi/female_kaleesh_sentinel.mdl",
    "models/player/jedi/female_keldoran_sentinel.mdl",
    "models/player/jedi/female_pantoran_sentinel.mdl",
    "models/player/jedi/female_rodian_sentinel.mdl",
    "models/player/jedi/female_tholothian_sentinel.mdl",
    "models/player/jedi/female_zabrak_sentinel.mdl",
    "models/player/jedi/male_chiss_sentinel.mdl",
    "models/player/jedi/male_human_sentinel.mdl",
    "models/player/jedi/male_kaleesh_sentinel.mdl",
    "models/player/jedi/male_keldoran_sentinel.mdl",
    "models/player/jedi/male_tholothian_sentinel.mdl",
    "models/player/jedi/male_zabrak_sentinel.mdl",
    "models/player/jedi/pantoran_male_sentinel.mdl",
    "models/player/jedi/rodian_male_sentinel.mdl",
    "models/player/jedi/twilek_female_sentinel.mdl",
    "models/player/jedi/twilek_sentinel_male.mdl"
    },
    description = [[Congratulations, you are a Combat Engineer Jedi!]],
    weapons = { "weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},
    command = "cejedi",
    max = 4,
    salary = 150,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Combat Engineers",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 13,
})

TEAM_327THGENERALAAYLA = DarkRP.createJob("Combat Engineer General Aayla Secura", {
    color = Color(198, 155, 61),
    model = {"models/tfa/comm/gg/pm_sw_aayala.mdl"},
    description = [[You are Jedi General Aayla Secura. It is your role to help lower ranking Jedi get an understanding of the Order!]],
    weapons = { "weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},
    command = "ceaayla",
    max = 1,
    salary = 275,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Combat Engineers",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 14,
})



-- ARC Command --


TEAM_ARCGENERAL = DarkRP.createJob("ARC General", {

    color = Color(255, 255, 255, 255),

    model = {"models/aussiwozzi/cgi/base/arc_com.mdl", "models/aussiwozzi/cgi/base/arc_gen.mdl", "models/toe/cgi/gens/gen_acolyte.mdl", "models/toe/cgi/gens/gen_archer.mdl", "models/toe/cgi/gens/gen_id.mdl", "models/toe/cgi/gens/gen_foxjack.mdl", "models/toe/cgi/gens/gen_matrix.mdl", "models/toe/cgi/gens/gen_nomad.mdl", "models/naval_offduty/pm_naval_cas.mdl", "models/jajoff/sps/republic/tc13j/rsb01.mdl"},

    description = [[Congratulations, you are an ARC General!]],

    weapons = {"arccw_westarm5_v2", "weapon_remotedrone", "arccw_dual_dc17s", "realistic_hook", "arccw_flash_grenade","datapad_player", "carkeys"},

    command = "arcgen",

    max = 2,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "ARC Directive",

PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 0

})

TEAM_ARCMC = DarkRP.createJob("ARC Marshal Commander", {

    color = Color(255, 255, 255, 255),

    model = {"models/aussiwozzi/cgi/base/advisor_red.mdl", "models/aussiwozzi/cgi/base/advisor_grey.mdl", "models/aussiwozzi/cgi/base/advisor_green.mdl", "models/aussiwozzi/cgi/base/advisor_blue.mdl", "models/aussiwozzi/cgi/base/arc_rancor_colt.mdl","models/aussiwozzi/cgi/base/arc_rancor_blitz.mdl","models/aussiwozzi/cgi/base/arc_rancor_hammer.mdl","models/aussiwozzi/cgi/base/arc_rancor_havoc.mdl","models/aussiwozzi/cgi/base/arc_fordo.mdl","models/aussiwozzi/cgi/base/arc_gen.mdl","models/aussiwozzi/cgi/base/arc_com.mdl","models/aussiwozzi/cgi/base/224th_toast.mdl","models/aussiwozzi/cgi/base/22nd_dempsey.mdl","models/jajoff/sps/republic/tc13j/rsb02.mdl"},

    description = [[Congratulations, you are the Marshal Commander of ARC!]],

    weapons = {"arccw_westarm5_v2", "weapon_remotedrone", "arccw_dual_dc17s", "realistic_hook", "arccw_flash_grenade", "carkeys"},

    command = "arcmc",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "ARC Directive",

PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 1

})

TEAM_ARCCOLT = DarkRP.createJob("ARC Command", {

    color = Color(255, 255, 255, 255),

    model = {"models/aussiwozzi/cgi/base/arc_rancor_colt.mdl","models/aussiwozzi/cgi/base/arc_rancor_blitz.mdl","models/aussiwozzi/cgi/base/arc_rancor_hammer.mdl","models/aussiwozzi/cgi/base/arc_rancor_havoc.mdl","models/aussiwozzi/cgi/base/arc_fordo.mdl","models/aussiwozzi/cgi/base/arc_gen.mdl","models/aussiwozzi/cgi/base/arc_com.mdl"},

    description = [[Congratulations, you are an ARC Command!]],

    weapons = {"arccw_westarm5_v2", "weapon_remotedrone", "arccw_dual_dc17s", "realistic_hook", "arccw_flash_grenade", "carkeys"},

    command = "arcco",

    max = 2,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "ARC Directive",

PlayerSpawn = function(ply) ply:SetMaxHealth(600) ply:SetHealth(600) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 2

})



TEAM_TRAINEEARC = DarkRP.createJob("Trainee ARC", {

    color = Color(255, 255, 255, 255),

    model = {"models/aussiwozzi/cgi/base/unassigned_arc.mdl"},

    description = [[Congratulations, you are a Trainee ARC!]],

    weapons = {"arccw_westarm5_v2", "arccw_dual_dc17s", "realistic_hook"},

    command = "trainarc",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "ARC Directive",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 10

})


-- REPUBLIC COMMANDOS --



-- Delta Squad --

TEAM_RCGENERAL = DarkRP.createJob("RC General", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/commando/rc_boss.mdl", "models/toe/cgi/gens/gen_acolyte.mdl", "models/toe/cgi/gens/gen_archer.mdl", "models/toe/cgi/gens/gen_id.mdl", "models/toe/cgi/gens/gen_foxjack.mdl", "models/toe/cgi/gens/gen_matrix.mdl", "models/toe/cgi/gens/gen_nomad.mdl", "models/naval_offduty/pm_naval_cas.mdl", "models/jajoff/sps/republic/tc13j/rsb01.mdl"},

    description = [[You are the general of the Republic Commandos!]],

    weapons = {"arccw_dc17m_v2_delta", "arccw_dc17sa_duals","realistic_hook","weapon_remotedrone", "arccw_dc17m_shotgun", "weapon_officerboost_normal", "datapad_player"},

    command = "rcgen",

    max = 2,

    salary = 300,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Republic Commandos",

PlayerSpawn = function(ply) ply:SetMaxHealth(625) ply:SetHealth(625) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    SortOrder = 0

})


TEAM_RCMCO = DarkRP.createJob("RC Marshal Commander", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/base/advisor_red.mdl", "models/aussiwozzi/cgi/base/advisor_grey.mdl", "models/aussiwozzi/cgi/base/advisor_green.mdl", "models/aussiwozzi/cgi/base/advisor_blue.mdl", "models/aussiwozzi/cgi/commando/rc_boss.mdl","models/aussiwozzi/cgi/base/224th_toast.mdl","models/aussiwozzi/cgi/base/22nd_dempsey.mdl","models/jajoff/sps/republic/tc13j/rsb02.mdl"},

    description = [[You are the Marshal Commander of the Republic Commandos!]],

    weapons = {"weapon_battlefocus_normal", "arccw_dc17sa_duals", "arccw_dc17m_v2_delta", "realistic_hook", "arccw_dc17m_shotgun"},

    command = "rcmco",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Delta Squad",

PlayerSpawn = function(ply) ply:SetMaxHealth(625) ply:SetHealth(625) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    SortOrder = 1

})

TEAM_RCBOSS = DarkRP.createJob("RC Boss", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/commando/rc_boss.mdl"},

    description = [[You are RC Boss, Commander of the Republic Commandos!]],

    weapons = {"weapon_battlefocus_normal", "arccw_dc17sa_duals", "arccw_dc17m_v2_delta", "arccw_dc17m_shotgun", "realistic_hook"}, 

    command = "rcboss",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Delta Squad",

PlayerSpawn = function(ply) ply:SetMaxHealth(600) ply:SetHealth(600) ply:SetRunSpeed (240) ply:SetGravity(1)   end,

    SortOrder = 2

})



TEAM_RCFIXER = DarkRP.createJob("RC Fixer", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/commando/rc_fixer.mdl"},

    description = [[You are RC Fixer, the technology expert and unofficial second in command of the Republic Commandos!]],

    weapons = {"turret_placerfriendly","datapad_player", "arccw_dc17m_v2_smg", "arccw_dc17sa_duals","weapon_squadshield", "turret_placer", "defuser_bomb","defuse_kit", "weapon_remotedrone", "weapon_extinguisher_infinite", "realistic_hook", "alydus_fusioncutter", "weapon_physcannon", "weapon_extinguisher_infinite", "weapon_dronerepair", "carkeys"},

    command = "rcfixer",

    max = 1,

    salary = 225,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Delta Squad",

PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    SortOrder = 3

})



TEAM_RCSEV = DarkRP.createJob("RC Sev", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/commando/rc_sev.mdl"},

    description = [[You are RC Sev, the sniper of the Republic Commandos!]],

    weapons = {"arccw_dc17sa_duals", "arccw_dc17m_sev_v2", "arccw_dc17m_v2_delta", "arccw_dc17sa_duals", "realistic_hook"},

    command = "rcsev",

    max = 1,

    salary = 225,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Delta Squad",

PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    SortOrder = 4

})



TEAM_RCSCORCH = DarkRP.createJob("RC Scorch", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/commando/rc_scorch.mdl"},

    description = [[You are RC Scorch, the explosives expert of the Republic Commandos!]],

    weapons = {"arccw_dc17sa_duals", "arccw_dc17m_scorch_v2", "arccw_dc17m_v2_delta", "arccw_dc17sa_duals", "arccw_thermal_grenade", "realistic_hook"},

    command = "rcscorch",

    max = 1,

    salary = 225,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Delta Squad",

PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:GiveAmmo(10,"rpg_round") ply:SetRunSpeed (240) ply:SetGravity(1) end,

    SortOrder = 5

})



-- Bad Batch --



TEAM_RCHUNTER = DarkRP.createJob("CF99 Hunter", {

    color = Color(255, 157, 0, 255),

    model = {"models/player/bad_batch/hunter.mdl"},

    description = [[You are RC Hunter of Clone Force 99!]],

    weapons = {"masita_sops_rep_rx21","masita_sops_rep_x11", "realistic_hook", "hunter_knife", "weapon_officerboost_normal"},

    command = "rchunter",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Bad Batch Squad",

PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    SortOrder = 1

})



TEAM_RCCROSSHAIR = DarkRP.createJob("CF99 Crosshair", {

    color = Color(255, 157, 0, 255),

    model = {"models/player/bad_batch/crosshair.mdl"},

    description = [[You are RC Crosshair of Clone Force 99!]],

    weapons = {"masita_sops_firepuncher", "masita_sops_rep_x11", "realistic_hook"},

    command = "rccrosshair",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Bad Batch Squad",

PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    SortOrder = 2

})



TEAM_RCWRECKER = DarkRP.createJob("CF99 Wrecker", {

    color = Color(255, 157, 0, 255),

    model = {"models/player/bad_batch/wrecker.mdl"},

    description = [[You are RC Wrecker of Clone Force 99!]],

    weapons = {"masita_sops_rep_zx6", "masita_sops_rep_x11", "weapon_wreckerfists","realistic_hook"},

    command = "rcwrecker",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Bad Batch Squad",

    PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (240) ply:SetGravity(1) end,

    SortOrder = 3

})



TEAM_RCTECH = DarkRP.createJob("CF99 Tech", {

    color = Color(255, 157, 0, 255),

    model = {"models/player/bad_batch/tech.mdl"},

    description = [[You are RC Tech of Clone Force 99!]],

    weapons = {"datapad_player", "masita_sops_rep_x11dual","turret_placer", "defuser_bomb","defuse_kit", "realistic_hook", "weapon_remotedrone","weapon_squadshield", "weapon_physcannon", "alydus_fusioncutter", "weapon_extinguisher_infinite", "carkeys"},

    command = "rctech",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Bad Batch Squad",

PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    SortOrder = 4

})



TEAM_RCECHO = DarkRP.createJob("CF99 Echo", {

    color = Color(255, 157, 0, 255),

    model = {"models/player/bad_batch/echo.mdl"},

    description = [[You are RC Echo of Clone Force 99!]],

    weapons = {"turret_placerfriendly","datapad_player", "weapon_remotedrone","masita_sops_rep_x11_echo","weapon_bactainjector", "realistic_hook", "weapon_extinguisher_infinite","alydus_fusioncutter"},

    command = "rcecho",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Bad Batch Squad",

PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (260) ply:SetGravity(1)  end,

    SortOrder = 4

})





-- OMEGA SQUAD --

TEAM_RCNINER = DarkRP.createJob("RC Niner", {

    color = Color(255, 157, 0),

    model = {"models/aussiwozzi/cgi/commando/rc_niner.mdl"},

    description = [[You are RC Niner of Omega Squad!]],

    weapons = {

        "arccw_dc17m_v2",

        "arccw_dc17sa",

        "arccw_dc17m_shotgun_v2",

        "realistic_hook",

        "arccw_shock_grenade",

        "weapon_officerboost_normal"

    },

    command = "rcniner",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Omega Squad",

    canDemote = false,

    PlayerSpawn = function(ply)

        ply:SetHealth(400)

        ply:SetMaxHealth(400)

        ply:SetRunSpeed (240)

        ply:SetGravity(1)

    end,

    sortOrder = 1



})



TEAM_RCFI = DarkRP.createJob("RC Fi", {

    color = Color(255, 157, 0),

    model = {"models/aussiwozzi/cgi/commando/rc_fi.mdl"},

    description = [[You are RC Fi of Omega Squad!]],

    weapons = {

        "arccw_dc17m_v2",

        "arccw_dc17sa",

        "arccw_dc17m_fi_v2",

        "realistic_hook"

    },

    command = "rcfi",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Omega Squad",

    canDemote = false,

    PlayerSpawn = function(ply)

        ply:SetHealth(350)

        ply:SetMaxHealth(350)

        ply:SetRunSpeed (240)

        ply:SetGravity(1)

    end,

    sortOrder = 2

})


TEAM_RCDARMAN = DarkRP.createJob("RC Darman", {

    color = Color(255, 157, 0),

    model = {"models/aussiwozzi/cgi/commando/rc_darman.mdl"},

    description = [[You are RC Darman Omega Squad!]],

    weapons = {

        "arccw_dc17m_v2",

        "arccw_dc17m_darman_v2", 

        "arccw_dc17sa",

        "realistic_hook",

        "arccw_thermal_grenade"

    },

    command = "rcdarman",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Omega Squad",

    canDemote = false,

    PlayerSpawn = function(ply)

        ply:SetHealth(350)

        ply:SetMaxHealth(350)

        ply:SetRunSpeed (240)

        ply:GiveAmmo(10,"rpg_round")

        ply:SetGravity(1)

    end,

    sortOrder = 3

})



TEAM_RCATIN = DarkRP.createJob("RC Atin", {

    color = Color(255, 157, 0),

    model = {"models/aussiwozzi/cgi/commando/rc_atin.mdl"},

    description = [[You are RC Atin Omega Squad!]],

    weapons = {

        "arccw_dc17m_v2",

        "arccw_dc17sa",

        "realistic_hook",

        "defuser_bomb",

        "defuse_kit",

        "weapon_physcannon",

        "weapon_extinguisher_infinite",

        "alydus_fusioncutter",

        "weapon_squadshield"

    },

    command = "rcatin",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Omega Squad",

    canDemote = false,

    PlayerSpawn = function(ply)

        ply:SetHealth(350)

        ply:SetMaxHealth(350)

        ply:SetRunSpeed (240)

        ply:SetGravity(1)

    end,

    sortOrder = 4

})

TEAM_RCCORR = DarkRP.createJob("RC Corr", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/commando/rc_corr.mdl"},

    description = [[You are a member of the Elite Republic Commandos!]],

    weapons = {"arccw_dc17m_v2","arccw_dc17sa","realistic_hook"},

    command = "rccorr",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Omega Squad",

PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    SortOrder = 5

})







-- EPSILON SQUAD --



TEAM_RCVALE = DarkRP.createJob("RC Vale", {

    color = Color(255, 157, 0),

    model = {"models/temporal/riggs/epsilon/vale.mdl"},

    description = [[You are RC Vale Epsilon Squad!]],

    weapons = {

        "arccw_dc17m_v2_vale",

        "arccw_dc17sa",

        "realistic_hook",

        "weapon_officerboost_normal",

        "weapon_defibrillator"

    },

    command = "rcvale",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Epsilon Squad",

    canDemote = false,

    PlayerSpawn = function(ply)

        ply:SetHealth(400)

        ply:SetMaxHealth(400)

        ply:SetRunSpeed (240)

        ply:SetGravity(1)

    end,

    sortOrder = 1

})



TEAM_RCPLANK = DarkRP.createJob("RC Plank", {

    color = Color(255, 157, 0),

    model = {"models/temporal/riggs/epsilon/plank.mdl"},

    description = [[You are RC Plank Epsilon Squad!]],

    weapons = {

        "arccw_dc17sa",

        "arccw_dc17m_dmr_v2",

        "realistic_hook"

    },

    command = "rcplank",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Epsilon Squad",

    canDemote = false,

    PlayerSpawn = function(ply)

        ply:SetHealth(400)

        ply:SetMaxHealth(400)

        ply:SetRunSpeed (260)

        ply:SetGravity(1)

    end,

    sortOrder = 2

})



TEAM_RCRIGGS = DarkRP.createJob("RC Riggs", {

    color = Color(255, 157, 0),

    model = {"models/temporal/riggs/epsilon/riggs.mdl"},

    description = [[You are RC Riggs Epsilon Squad!]],

    weapons = {

        "arccw_dc17m_v2_riggs",

        "arccw_dc17sa",

        "realistic_hook",

        "arccw_ammo_crate"

    },

    command = "rcriggs",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Epsilon Squad",

    canDemote = false,

    PlayerSpawn = function(ply)

        ply:SetHealth(350)

        ply:SetMaxHealth(350)

        ply:SetRunSpeed (240)

        ply:SetGravity(1)

    end,

    sortOrder = 3

})



TEAM_RCWITT = DarkRP.createJob("RC Witt", {

    color = Color(255, 157, 0),

    model = {"models/temporal/riggs/epsilon/witt.mdl"},

    description = [[You are RC Witt Epsilon Squad!]],

    weapons = {

        "arccw_dc17m_v2",

        "arccw_dc17sa",

        "realistic_hook",

        "weapon_bactainjector",

        "lord_chrome_medkit",

        "weapon_defibrillator",
        

    },

    command = "rcwitt",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Epsilon Squad",

    canDemote = false,

    PlayerSpawn = function(ply)

        ply:SetHealth(350)

        ply:SetMaxHealth(350)

        ply:SetRunSpeed (260)

        ply:SetGravity(1)

    end,

    sortOrder = 4

})




-- RC Misc Squads --



TEAM_RCHOPE = DarkRP.createJob("RC HOPE Squad", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/commando/rc_hope_leader.mdl","models/aussiwozzi/cgi/commando/rc_hope_demo.mdl","models/aussiwozzi/cgi/commando/rc_hope_sniper.mdl","models/aussiwozzi/cgi/commando/rc_hope_tech.mdl"},

    description = [[You are a member of the Elite Republic Commandos!]],

    weapons = {"arccw_dc17m_v2","arccw_dc17sa","realistic_hook"},

    command = "rchope",

    max = 4,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Republic Commandos",

PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    SortOrder = 9

})



TEAM_RCAIWHA = DarkRP.createJob("RC Aiwha Squad", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/commando/rc_dikut.mdl","models/aussiwozzi/cgi/commando/rc_sarge.mdl","models/aussiwozzi/cgi/commando/rc_tyto.mdl","models/aussiwozzi/cgi/commando/rc_zag.mdl"},

    description = [[You are a member of the Elite Republic Commandos!]],

    weapons = {"arccw_dc17m_v2","arccw_dc17sa","realistic_hook"},

    command = "rcaiwha",

    max = 4,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Republic Commandos",

PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    SortOrder = 8

})



TEAM_RCAQUILA = DarkRP.createJob("RC Aquila Squad", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/commando/rc_aquila_batnor.mdl","models/aussiwozzi/cgi/commando/rc_aquila_cabur.mdl","models/aussiwozzi/cgi/commando/rc_aquila_cyarika.mdl","models/aussiwozzi/cgi/commando/rc_aquila_monarch.mdl"},

    description = [[You are a member of the Elite Republic Commandos!]],

    weapons = {"arccw_dc17m_v2","arccw_dc17sa","realistic_hook"},

    command = "rcaquila",

    max = 4,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Republic Commandos",

PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    SortOrder = 7

})



TEAM_RCION = DarkRP.createJob("RC Ion Squad", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/commando/rc_ion_climber.mdl","models/aussiwozzi/cgi/commando/rc_ion_ras.mdl","models/aussiwozzi/cgi/commando/rc_ion_sniper.mdl","models/aussiwozzi/cgi/commando/rc_ion_trace.mdl"},

    description = [[You are a member of the Elite Republic Commandos!]],

    weapons = {"arccw_dc17m_v2","arccw_dc17sa","realistic_hook"},

    command = "rcion",

    max = 4,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Republic Commandos",

PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    SortOrder = 6

})



TEAM_RCYAYAX = DarkRP.createJob("RC Yayax Squad", {

    color = Color(255, 157, 0, 255),

    model = {"models/aussiwozzi/cgi/commando/rc_yayax_cov.mdl","models/aussiwozzi/cgi/commando/rc_yayax_dev.mdl","models/aussiwozzi/cgi/commando/rc_yayax_jind.mdl","models/aussiwozzi/cgi/commando/rc_yayax_yover.mdl"},

    description = [[You are a member of the Elite Republic Commandos!]],

    weapons = {"arccw_dc17m_v2","arccw_dc17sa","realistic_hook"},

    command = "rcyayax",

    max = 4,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Republic Commandos",

PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    SortOrder = 5

})







--TEAM_RCADVISOR = DarkRP.createJob("RC Clone Advisor", {

--    color = Color(255, 157, 0, 255),

--    model = {"models/aussiwozzi/cgi/commando/clone_commando.mdl","models/aussiwozzi/cgi/commando/clone_commando_royal.mdl","models/aussiwozzi/cgi/commando/rc_fisher.mdl", "models/aussiwozzi/cgi/commando/rc_plain.mdl", "models/naval_crew/pm_naval_crewman.mdl", "models/jajoff/sps/republic/tc13j/army_01.mdl", "models/jajoff/sps/republic/tc13j/army_02.mdl", "models/jajoff/sps/republic/tc13j/army02_female.mdl", "models/naval_officer/pm_naval_officer.mdl"},

--    description = [[You are a member of the Elite Republic Commandos!]],

--    weapons = {"weapon_remotedrone", "at_sw_dc15sadelta", "realistic_hook", "at_sw_dc17m_squad", "rw_sw_shield_rep"},

--    command = "rcadvisor",

--    max = 0,

--    salary = 175,

--    admin = 0,

--   vote = false,

--    candemote = false,

--    hasLicense = false,

--    category = "Republic Commandos",

--PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (260)   end,

--    sortOrder = 2

--})




TEAM_REPUBLICCOMMANDOSGT = DarkRP.createJob("RC Sergeant", {

    color = Color(255, 157, 0),

    model = {"models/aussiwozzi/cgi/commando/clone_commando_royal.mdl"},

    description = [[You are Republic Commandos Sergeant]],

    weapons = {

        "arccw_dc17m_v2",

        "arccw_dc17sa",

        "realistic_hook"

    },

    command = "rcsgt",

    max = 0,

    salary = 175,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Republic Commandos",

    canDemote = false,

    PlayerSpawn = function(ply)

        ply:SetHealth(350)

        ply:SetRunSpeed (240)

        ply:SetMaxHealth(350)

        ply:SetGravity(1)

    end,

    sortOrder = 10



})


TEAM_REPUBLICCOMMANDO = DarkRP.createJob("Republic Commando", {
    color = Color(255, 157, 0),
    model = {"models/aussiwozzi/cgi/commando/clone_commando.mdl"},
    description = [[You are Republic Commando Trainee]],
    weapons = {
        "arccw_dc17m_v2",
        "arccw_dc17sa",
        "realistic_hook"
    },
    command = "rc",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Republic Commandos",
    canDemote = false,
    PlayerSpawn = function(ply)
        ply:SetHealth(350)
        ply:SetRunSpeed (240)
        ply:SetMaxHealth(350)
        ply:SetGravity(1)
    end,
    sortOrder = 11
})

TEAM_RCGENERALKIT = DarkRP.createJob("RC General Kit Fisto", {
    color = Color(255, 157, 0),
    model = {"models/tfa/comm/gg/pm_sw_fisto.mdl"},
    description = [[You are Jedi General Kit Fisto. It is your role to help lower ranking Jedi get an understanding of the Order!]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},
    command = "rcfisto",
    max = 1,
    salary = 275,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Republic Commandos",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 20,
})


-- Shadow / SDW --

TEAM_SDWGENERAL = DarkRP.createJob("Shadow General", {
	color = Color(130,16,8),
    model = {"models/toe/cgi/gens/gen_acolyte.mdl", "models/toe/cgi/gens/gen_archer.mdl", "models/toe/cgi/gens/gen_id.mdl", "models/toe/cgi/gens/gen_foxjack.mdl", "models/toe/cgi/gens/gen_matrix.mdl", "models/toe/cgi/gens/gen_nomad.mdl", "models/naval_offduty/pm_naval_cas.mdl", "models/jajoff/sps/republic/tc13j/rsb01.mdl", "models/aussiwozzi/cgi/base/shadow_commander.mdl"},
    description = [[Congratulations You are now Shadow General]],
    weapons = {"arccw_dc19","arccw_duals_dc17ext_v2_suppresed","weapon_cloak","sfw_staffv2","sfw_estaffdual2","covert","realistic_hook","datapad_player"},
    command = "sdwgen",
    max = 2,
    salary = 300,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Shadow",
PlayerSpawn = function(ply) ply:SetMaxHealth(600) ply:SetHealth(600) ply:SetRunSpeed (270) end,
PlayerLoadout = function( ply )
    ply:SetJumpPower(240)
    ply:SetGravity(1)
end,
    sortOrder = 0
})

TEAM_SDWMCO = DarkRP.createJob("Shadow Marshal Commander", {
	color = Color(130,16,8),
    model = {"models/aussiwozzi/cgi/base/shadow_commander.mdl","models/aussiwozzi/cgi/base/224th_toast.mdl","models/aussiwozzi/cgi/base/22nd_dempsey.mdl","models/jajoff/sps/republic/tc13j/rsb02.mdl","models/aussiwozzi/cgi/base/shadow_arc.mdl","models/aussiwozzi/cgi/base/shadow_barc.mdl"},
    description = [[Congratulations You are now  Marshal Commander Walon Vau]],
    weapons = {"arccw_dc19","arccw_duals_dc17ext_v2_suppresed","weapon_cloak","sfw_staffv2","sfw_estaffdual2","covert"},
    command = "sdwmco",
    max = 1,
    salary = 275,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Shadow",
    PlayerSpawn = function(ply) ply:SetMaxHealth(600) ply:SetHealth(600) ply:SetRunSpeed (270) end,
    PlayerLoadout = function( ply )
        ply:SetJumpPower(240)
        ply:SetGravity(1)
    end,
    sortOrder = 1
})


TEAM_SDWCO = DarkRP.createJob("Shadow Commander", {
	color = Color(130,16,8),
    model = {"models/aussiwozzi/cgi/base/shadow_commander.mdl","models/aussiwozzi/cgi/base/shadow_officer.mdl","models/aussiwozzi/cgi/base/shadow_arf.mdl","models/aussiwozzi/cgi/base/shadow_arc.mdl","models/aussiwozzi/cgi/base/shadow_barc.mdl"},
    description = [[Congratulations You are now SDW CO!]],
    weapons = {"arccw_dc19","arccw_duals_dc17ext_v2_suppresed","weapon_cloak","sfw_staffv2","sfw_estaffdual2","covert"},
    command = "sdwco",
    max = 1,
    salary = 275,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Shadow",
    PlayerSpawn = function(ply) ply:SetMaxHealth(600) ply:SetHealth(600) ply:SetRunSpeed (270) end,
    PlayerLoadout = function( ply )
        ply:SetJumpPower(240)
        ply:SetGravity(1)
    end,
    sortOrder = 2
})

TEAM_SDWXO = DarkRP.createJob("Shadow Executive Officer", {
	color = Color(130,16,8),
    model = {"models/aussiwozzi/cgi/base/shadow_officer.mdl","models/aussiwozzi/cgi/base/shadow_arf.mdl","models/aussiwozzi/cgi/base/shadow_barc.mdl","models/aussiwozzi/cgi/base/shadow_arc.mdl"},
    description = [[Congratulations You are now SDW XO!]],
    weapons = {"arccw_dc19","arccw_duals_dc17ext_v2_suppresed","weapon_cloak","sfw_staffv2","sfw_estaffdual2","covert"},
    command = "sdwxo",
    max = 1,
    salary = 250,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Shadow",
    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (270)  end,
    PlayerLoadout = function( ply )
        ply:SetJumpPower(240)
        ply:SetGravity(1)
    end,
    sortOrder = 3
})

TEAM_SDWMJR = DarkRP.createJob("Shadow Major", {
	color = Color(130,16,8),
    model = {"models/aussiwozzi/cgi/base/shadow_officer.mdl","models/aussiwozzi/cgi/base/shadow_arf.mdl","models/aussiwozzi/cgi/base/shadow_barc.mdl","models/aussiwozzi/cgi/base/shadow_arc.mdl"},
    description = [[Congratulations You are now SDW Major!]],
    weapons = {"arccw_dc19","arccw_duals_dc17ext_v2_suppresed","weapon_cloak","sfw_staffv2","sfw_estaffdual2","covert"},
    command = "sdwmjr",
    max = 1,
    salary = 250,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Shadow",
    PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (270)  end,
    PlayerLoadout = function( ply )
        ply:SetJumpPower(240)
        ply:SetGravity(1)
    end,
    sortOrder = 4
})

TEAM_SDWOFF = DarkRP.createJob("Shadow Officer", {
	color = Color(130,16,8),
    model = {"models/aussiwozzi/cgi/base/shadow_officer.mdl","models/aussiwozzi/cgi/base/shadow_arf.mdl","models/aussiwozzi/cgi/base/shadow_barc.mdl"},
    description = [[Congratulations You are now a SDW Officer!]],
    weapons = {"arccw_dc19","arccw_dc17_v2_suppressed","weapon_cloak","sfw_estaffdual2"},
    command = "sdwoff",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Shadow",
    PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (270) end,
    PlayerLoadout = function( ply )
        ply:SetJumpPower(240)
        ply:SetGravity(1)
    end,
    sortOrder = 5
})

TEAM_SDWSGT = DarkRP.createJob("Shadow Sergeant", {
	color = Color(130,16,8),
    model = {"models/aussiwozzi/cgi/base/shadow_trooper.mdl","models/aussiwozzi/cgi/base/shadow_barc.mdl"},
    description = [[Congratulations You are now a SDW Sergeant!]],
    weapons = {"arccw_dc19","arccw_dc17_v2_suppressed","weapon_cloak","sfw_magnastaff"},
    command = "sdwsgt",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Shadow",
    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (270) end,
    PlayerLoadout = function( ply )
        ply:SetJumpPower(240)
        ply:SetGravity(1)
    end,
    sortOrder = 6
})

TEAM_SDWTRP = DarkRP.createJob("Shadow Trooper", {
	color = Color(130,16,8),
    model = {"models/aussiwozzi/cgi/base/shadow_trooper.mdl"},
    description = [[Congratulations You are now a member of SDW!]],
    weapons = {"arccw_dc19","arccw_dc17_v2_suppressed","weapon_cloak","sfw_magnastaff"},
    command = "sdwtrp",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Shadow",
    PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (270) end,
    PlayerLoadout = function( ply )
        ply:SetJumpPower(240)
        ply:SetGravity(1)
    end,
    sortOrder = 7
})

TEAM_CVLD = DarkRP.createJob("Covert Lead", {
	color = Color(130,16,8),
    model = {"models/aussiwozzi/cgi/base/nso_deyash.mdl","models/aussiwozzi/cgi/base/nso_roach.mdl"},
    description = [[Congratulations You are now leader of Covert!]],
    weapons = {"covert","arccw_dc19le","arccw_dc17_v2_suppressed","arccw_blaster_lrb11","arccw_btrs_41","weapon_cloak","sfw_staffv2"},
    command = "covlead",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Covert",
    PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (270) end,
    PlayerLoadout = function( ply )
        ply:SetJumpPower(240)
        ply:SetGravity(1)
    end,
    sortOrder = 8
})

TEAM_CVSPC = DarkRP.createJob("Covert Specialists", {
	color = Color(130,16,8),
    model = {"models/aussiwozzi/cgi/base/nso_crusader.mdl"},
    description = [[Congratulations You are now a member of Covert!]],
    weapons = {"covert","arccw_dc19le","arccw_dc17_v2_suppressed","arccw_blaster_lrb11","weapon_cloak","sfw_staffv2"},
    command = "covspec",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Covert",
    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (270) end,
    PlayerLoadout = function( ply )
        ply:SetJumpPower(240)
        ply:SetGravity(1)
    end,
    sortOrder = 9
})

TEAM_CVTRP = DarkRP.createJob("Covert Trooper", {
	color = Color(130,16,8),
    model = {"models/aussiwozzi/cgi/base/nso_nari.mdl"},
    description = [[Congratulations You are now a member of Covert!]],
    weapons = {"covert","arccw_dc19le","arccw_dc17_v2_suppressed","weapon_cloak","sfw_staffv2"},
    command = "covtrp",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Covert",
    PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (270) end,
    PlayerLoadout = function( ply )
        ply:SetJumpPower(240)
        ply:SetGravity(1)
    end,
    sortOrder = 10
})

TEAM_SHADOWGENERALVOS = DarkRP.createJob("Shadow General Quinlan Vos", {
	color = Color(130,16,8),
    model = {"models/tfa/comm/gg/pm_sw_quinlanvos.mdl"},
    description = [[You are Jedi General Quinlan Vos. It is your role to help lower ranking Jedi get an understanding of the Order!]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},
    command = "shadowvos",
    max = 1,
    salary = 275,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Shadow",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 11,
})

---- Medical Directive ----

TEAM_MEDICALGENERAL = DarkRP.createJob("Medical General", {

    color = Color(245, 56, 81, 255),

    model = {"models/aussiwozzi/cgi/base/917th_commander.mdl", "models/aussiwozzi/cgi/base/917th_evo_osman.mdl", "models/aussiwozzi/cgi/base/917th_evo_leanin.mdl", "models/aussiwozzi/cgi/base/917th_evo_hudson.mdl", "models/aussiwozzi/cgi/base/917th_scarlet.mdl", "models/toe/cgi/gens/gen_acolyte.mdl", "models/toe/cgi/gens/gen_archer.mdl", "models/toe/cgi/gens/gen_id.mdl", "models/toe/cgi/gens/gen_foxjack.mdl", "models/toe/cgi/gens/gen_matrix.mdl", "models/toe/cgi/gens/gen_nomad.mdl", "models/naval_offduty/pm_naval_cas.mdl", "models/jajoff/sps/republic/tc13j/rsb01.mdl"},

    description = [[Congratulations, you are the General of the Regimetntal Medics!]],

    weapons = {"weapon_bactainjector", "arccw_dc15le_v2", "arccw_duals_dc17ext_v2", "lord_chrome_medkit", "weapon_jew_stimkit", "realistic_hook", "weapon_defibrillator", "arccw_impact_bacta", "tf_weapon_medigun","weapon_remotedrone","datapad_player", "carkeys"},

    command = "medgen",

    max = 2,

    salary = 300,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Medical Directive",

    PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 0

})

TEAM_MEDICALMCO = DarkRP.createJob("Senior Medical Director", {

    color = Color(245, 56, 81, 255),

    model = {"models/aussiwozzi/cgi/base/advisor_red.mdl", "models/aussiwozzi/cgi/base/advisor_grey.mdl", "models/aussiwozzi/cgi/base/advisor_green.mdl", "models/aussiwozzi/cgi/base/advisor_blue.mdl", "models/aussiwozzi/cgi/base/917th_commander.mdl","models/aussiwozzi/cgi/base/917th_cpd_officer.mdl","models/aussiwozzi/cgi/base/917th_evo_osman.mdl", "models/aussiwozzi/cgi/base/917th_evo_leanin.mdl", "models/aussiwozzi/cgi/base/917th_evo_hudson.mdl", "models/aussiwozzi/cgi/base/917th_scarlet.mdl", "models/aussiwozzi/cgi/base/917th_eduardo.mdl","models/naval_medic/pm_naval_medic.mdl","models/jajoff/sps/republic/tc13j/navy_medic_female.mdl","models/jajoff/sps/republic/tc13j/navy_medic.mdl","models/aussiwozzi/cgi/base/224th_toast.mdl","models/aussiwozzi/cgi/base/22nd_dempsey.mdl","models/jajoff/sps/republic/tc13j/rsb02.mdl"},

    description = [[Congratulations, You are now the Senior Medical Director. You will lead all medics.]],

    weapons = {"weapon_bactainjector", "arccw_dc15le_v2", "arccw_duals_dc17ext_v2", "lord_chrome_medkit", "weapon_jew_stimkit", "realistic_hook", "weapon_defibrillator", "arccw_impact_bacta", "tf_weapon_medigun", "carkeys"},

    command = "smd",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Medical Directive",

    PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (250) ply:SetGravity(1)  end,

    sortOrder = 2,

})


TEAM_MEDICALDIRECTOR = DarkRP.createJob("Medical Director", {

    color = Color(245, 56, 81, 255),

    model = {"models/aussiwozzi/cgi/base/917th_commander.mdl","models/aussiwozzi/cgi/base/917th_cpd_officer.mdl","models/aussiwozzi/cgi/base/917th_eduardo.mdl","models/aussiwozzi/cgi/base/917th_evo_osman.mdl", "models/aussiwozzi/cgi/base/917th_evo_leanin.mdl", "models/aussiwozzi/cgi/base/917th_evo_hudson.mdl", "models/aussiwozzi/cgi/base/917th_scarlet.mdl", "models/naval_medic/pm_naval_medic.mdl","models/jajoff/sps/republic/tc13j/navy_medic_female.mdl","models/jajoff/sps/republic/tc13j/navy_medic.mdl"},

    description = [[Congratulations, You are now the Medical Director. You will lead all medics.]],

    weapons = {"weapon_bactainjector", "arccw_dc15le_v2", "arccw_duals_dc17ext_v2", "lord_chrome_medkit", "weapon_jew_stimkit", "realistic_hook", "weapon_defibrillator", "arccw_impact_bacta", "tf_weapon_medigun", "carkeys"},

    command = "mdr",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Medical Directive",

    PlayerSpawn = function(ply) ply:SetMaxHealth(600) ply:SetHealth(600) ply:SetRunSpeed (250) ply:SetGravity(1)  end,

    sortOrder = 3,

})



TEAM_ASSISTANTMEDICALDIRECTOR = DarkRP.createJob("Assistant Medical Director", {

    color = Color(245, 56, 81, 255),

    model = {"models/aussiwozzi/cgi/base/917th_cpd_officer.mdl","models/aussiwozzi/cgi/base/917th_evo_hudson.mdl","models/aussiwozzi/cgi/base/917th_lucky.mdl","models/aussiwozzi/cgi/base/917th_evo_osman.mdl", "models/aussiwozzi/cgi/base/917th_evo_leanin.mdl", "models/aussiwozzi/cgi/base/917th_evo_hudson.mdl", "models/aussiwozzi/cgi/base/917th_scarlet.mdl", "models/naval_medic/pm_naval_medic.mdl","models/jajoff/sps/republic/tc13j/navy_medic_female.mdl","models/jajoff/sps/republic/tc13j/navy_medic.mdl"},

    description = [[Congratulations, You are now the Assistant Medical Director. You will assist with leading all medics.]],

    weapons = {"weapon_bactainjector", "arccw_dc15le_v2", "arccw_duals_dc17ext_v2", "lord_chrome_medkit", "weapon_jew_stimkit", "realistic_hook", "weapon_defibrillator", "arccw_impact_bacta", "tf_weapon_medigun", "carkeys"},

    command = "amd",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Medical Directive",

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (250) ply:SetGravity(1)  end,

    sortOrder = 4,

})


---- Fleet Officer ----
-- Comment: CTRL + K -> CTRL C
-- Undo:    CTRL + K -> CTRL U

TEAM_FLEETRECRUIT = DarkRP.createJob("Fleet Recruit", {

    color = Color(122, 122, 122, 255),

    model = {"models/jajoff/sps/republic/tc13j/navy_03.mdl","models/jajoff/sps/republic/tc13j/navy_04.mdl","models/jajoff/sps/republic/tc13j/navy04_female.mdl","models/jajoff/sps/republic/tc13j/navy03_female.mdl"},

    description = [[Congratulations, You are now a Fleet Recruit!]],

    weapons = {"datapad_player", "weapon_remotedrone", "arccw_defender_sporting", "voice_amplifier", "carkeys", "kaito_satellite_tablet_noartillery"},

    command = "fleetrec",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Fleet Officers",

PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (250) ply:SetGravity(1)  end,

    sortOrder = 6,

})




TEAM_FLEETMEMBER = DarkRP.createJob("Fleet Officer", {

    color = Color(122, 122, 122, 255),

    model = {"models/jajoff/sps/republic/tc13j/navy_03.mdl","models/jajoff/sps/republic/tc13j/navy_04.mdl","models/jajoff/sps/republic/tc13j/navy04_female.mdl","models/jajoff/sps/republic/tc13j/navy03_female.mdl"},

    description = [[Congratulations You Are Now A Officer Of The Navy!]],

    weapons = {"datapad_player", "weapon_remotedrone", "arccw_defender_sporting", "voice_amplifier", "carkeys", "kaito_satellite_tablet_noartillery"},

    command = "fleetofficer",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Fleet Officers",

PlayerSpawn = function(ply) ply:SetMaxHealth(425) ply:SetHealth(425) ply:SetRunSpeed (250) ply:SetGravity(1)  end,

    sortOrder = 5,

})


TEAM_FLEETLIEUTENANT = DarkRP.createJob("Fleet Lieutenant", {

    color = Color(122, 122, 122, 255),

    model = {"models/jajoff/sps/republic/tc13j/navy_01.mdl","models/jajoff/sps/republic/tc13j/navy01_female.mdl"},

    description = [[Congratulations You Are Now A Lieutenant Of The Navy!]],

    weapons = {"datapad_player", "weapon_remotedrone", "arccw_defender_sporting", "voice_amplifier", "carkeys", "kaito_satellite_tablet"},

    command = "fleetlt",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Fleet Officers",

PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (250) ply:SetGravity(1)  end,

    sortOrder = 4,

})


TEAM_FLEETMEMBERSNR = DarkRP.createJob("Fleet Seniority", {

    color = Color(122, 122, 122, 255),

    model = {"models/jajoff/sps/republic/tc13j/navy_02.mdl","models/jajoff/sps/republic/tc13j/navy02_female.mdl"},

    description = [[Congratulations You Are Now A Member Of The Navy!]],

    weapons = {"datapad_player", "weapon_remotedrone", "arccw_dual_defender_sporting", "voice_amplifier", "carkeys", "kaito_satellite_tablet"},

    command = "fleetsnr",

    max = 3,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Fleet Officers",

    PlayerSpawn = function(ply) ply:SetMaxHealth(475) ply:SetHealth(475) ply:SetRunSpeed (250) ply:SetGravity(1)  end,

    sortOrder = 3,

})




TEAM_FLEETADMIRAL = DarkRP.createJob("Fleet Admiral", {

    color = Color(122, 122, 122, 255),

    model = {"models/jajoff/sps/republic/tc13j/rsb03.mdl","models/jajoff/sps/republic/tc13j/rsb03_female.mdl","models/aussiwozzi/cgi/base/shadow_pilot.mdl", "models/player/wullf/wullf.mdl"},

    description = [[Congratulations You Are Now A Member Of The Navy!]],

    weapons = {"datapad_player", "weapon_remotedrone", "arccw_dual_defender_sporting", "arccw_ib94", "voice_amplifier", "carkeys", "kaito_satellite_tablet"},

    command = "fleetadmiral",

    max = 5,

    salary = 300,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Fleet Officers",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (250) ply:SetGravity(1)  end,

    sortOrder = 2,

})



TEAM_GRANDADMIRAL = DarkRP.createJob("Grand Admiral", {

    color = Color(122, 122, 122, 255),

    model = {"models/jajoff/sps/republic/tc13j/rsb03.mdl","models/jajoff/sps/republic/tc13j/rsb03_female.mdl","models/aussiwozzi/cgi/base/shadow_pilot.mdl","models/player/wullf/wullf.mdl"},

    description = [[Congratulations You Are The Grand Admiral!]],

    weapons = {"datapad_player", "weapon_remotedrone", "arccw_dual_defender_sporting", "arccw_ib94", "voice_amplifier", "arccw_ga_pistol", "carkeys", "kaito_satellite_tablet"},

    command = "grandadmiral",

    max = 1,

    salary = 300,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Fleet Officers",

PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (250) ply:SetGravity(1)  end,

    sortOrder = 1,

})

TEAM_RSBMEMBER = DarkRP.createJob("RSB Member", {

    color = Color(122, 122, 122, 255),

    model = {"models/jajoff/sps/republic/tc13j/rsb_director.mdl", "models/jajoff/sps/republic/tc13j/rsb03.mdl"},

    description = [[Congratulations, you are a member of the RSB!]],

    weapons = {"datapad_player", "lord_chrome_medkit", "weapon_remotedrone", "masita_sops_rep_rx21", "voice_amplifier", "arccw_ga_pistol", "masita_sops_rep_zx6", "masita_sops_rep_hh12", "masita_sops_md12x", "weapon_cuff_elastic_officer", "carkeys", "kaito_satellite_tablet"},

    command = "rsb",

    max = 3,

    salary = 500,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Fleet Officers",

PlayerSpawn = function(ply) ply:SetMaxHealth(1200) ply:SetHealth(1200) ply:SetRunSpeed (260) ply:SetGravity(1) end,

    sortOrder = 0,

})

---- FLEET SPECIALISTS----
TEAM_FLEET_IO = DarkRP.createJob("Fleet Security Officer", {
    color = Color(122, 122, 122, 255),
    model = {"models/zeus/security_officer_male.mdl", "models/zeus/security_officer_female.mdl"},
    description = [[Congratulations You are now a Fleet Security Officer!]],
    weapons = {"datapad_player", "arccw_dc17_stun_v2", "arccw_defender_sporting", "weapon_remotedrone", "weapon_cuff_elastic_officer", "voice_amplifier", "carkeys", "kaito_satellite_tablet"},
    command = "fleetso",
    max = 4,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Fleet Branches",
    PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (250) ply:SetGravity(1)  end,
    sortOrder = 4
})

TEAM_FLEET_RDM = DarkRP.createJob("Fleet Medical Officer", {
    color = Color(122, 122, 122, 255),
    model = {"models/jajoff/sps/republic/tc13j/navy_medic.mdl","models/jajoff/sps/republic/tc13j/navy_medic_female.mdl","models/aussiwozzi/cgi/base/917th_evo.mdl","models/aussiwozzi/cgi/base/pilot_cpt.mdl","models/aussiwozzi/cgi/base/pilot_lt.mdl","models/aussiwozzi/cgi/base/pilot_sgt.mdl","models/aussiwozzi/cgi/base/pilot_com.mdl"},
    description = [[Congratulations You are now a Fleet Medical Officer!]],
    weapons = {"datapad_player", "arccw_defender_sporting", "arccw_dc15s_v2", "weapon_medkit", "weapon_defibrillator", "arccw_impact_bacta", "tf_weapon_medigun", "voice_amplifier", "weapon_remotedrone", "kaito_satellite_tablet"},
    command = "fleetmo",
    max = 4,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Fleet Branches",
    PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (250) ply:SetGravity(1)  end,
    sortOrder = 2
})

TEAM_FLEET_RDE = DarkRP.createJob("Fleet Engineering Officer", {
    color = Color(122, 122, 122, 255),
    model = {"models/jajoff/sps/republic/tc13j/navy_03.mdl","models/jajoff/sps/republic/tc13j/navy_04.mdl","models/jajoff/sps/republic/tc13j/navy04_female.mdl","models/jajoff/sps/republic/tc13j/navy03_female.mdl","models/jajoff/sps/republic/tc13j/navy_01.mdl","models/jajoff/sps/republic/tc13j/navy01_female.mdl","models/jajoff/sps/republic/tc13j/navy_02.mdl","models/jajoff/sps/republic/tc13j/navy02_female.mdl","models/jajoff/sps/republic/tc13j/engineer.mdl","models/aussiwozzi/cgi/base/eod_trooper.mdl","models/aussiwozzi/cgi/base/pilot_cpt.mdl","models/aussiwozzi/cgi/base/pilot_lt.mdl","models/aussiwozzi/cgi/base/pilot_sgt.mdl","models/aussiwozzi/cgi/base/pilot_com.mdl"},
    description = [[Congratulations You are now a Fleet Engineering Officer!]],
    weapons = {"datapad_player", "arccw_defender_sporting", "arccw_dc15s_v2", "weapon_dronerepair", "weapon_physcannon", "voice_amplifier", "alydus_fusioncutter", "weapon_remotedrone", "kaito_satellite_tablet"},
    command = "fleeteo",
    max = 4,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Fleet Branches",
    PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (250) ply:SetGravity(1)  end,
    sortOrder = 1
})

---- Generals ----

TEAM_SUPREMEGENERAL = DarkRP.createJob("Supreme General", {
    color = Color(122, 122, 122, 255),
    model = {"models/toe/cgi/gens/gen_acolyte.mdl", "models/toe/cgi/gens/gen_archer.mdl", "models/toe/cgi/gens/gen_id.mdl", "models/toe/cgi/gens/gen_foxjack.mdl", "models/toe/cgi/gens/gen_matrix.mdl", "models/toe/cgi/gens/gen_nomad.mdl", "models/jajoff/sps/republic/tc13j/rsb01.mdl", "models/naval_offduty/pm_naval_cas.mdl"},
    description = [[Congratulations you are the Supreme General of the Titan's Battalion!]],
    weapons = {"arccw_dc15_v2_ultimate", "arccw_duals_dc17ext_v2_stun", "arccw_sw_rocket_rps6", "realistic_hook", "weapon_jew_stimkit", "weapon_remotedrone","datapad_player", "carkeys"},
    command = "sg",
    max = 1,
    salary = 300,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Battalion Generals",
    PlayerSpawn = function(ply) ply:SetMaxHealth(750) ply:SetHealth(750) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 1,
})


TEAM_BATTALIONGENERAL = DarkRP.createJob("Battalion General", {
    color = Color(122, 122, 122, 255),
    model = {"models/toe/cgi/gens/gen_acolyte.mdl", "models/toe/cgi/gens/gen_archer.mdl", "models/toe/cgi/gens/gen_id.mdl", "models/toe/cgi/gens/gen_foxjack.mdl", "models/toe/cgi/gens/gen_matrix.mdl", "models/toe/cgi/gens/gen_nomad.mdl", "models/jajoff/sps/republic/tc13j/rsb01.mdl", "models/naval_offduty/pm_naval_cas.mdl"},
    description = [[Congratulations you are a Battalion General of the Titan's Battalion!]],
    weapons = {"realistic_hook", "arccw_dc15_v2_ultimate", "weapon_remotedrone", "arccw_duals_dc17ext_v2_stun", "arccw_sw_rocket_rps6","datapad_player", "carkeys"},
    command = "bg",
    max = 2,
    salary = 300,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Battalion Generals",
    PlayerSpawn = function(ply) ply:SetMaxHealth(700) ply:SetHealth(700) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 2,
})

TEAM_ASSISTANTBATTALIONGENERAL = DarkRP.createJob("Assistant General", {
    color = Color(122, 122, 122, 255),
    model = {"models/toe/cgi/gens/gen_acolyte.mdl", "models/toe/cgi/gens/gen_archer.mdl", "models/toe/cgi/gens/gen_id.mdl", "models/toe/cgi/gens/gen_foxjack.mdl", "models/toe/cgi/gens/gen_matrix.mdl", "models/toe/cgi/gens/gen_nomad.mdl", "models/jajoff/sps/republic/tc13j/rsb01.mdl", "models/naval_offduty/pm_naval_cas.mdl"},
    description = [[Congratulations you are an Assistant General!]],
    weapons = {"realistic_hook", "arccw_dc15_v2_ultimate", "weapon_remotedrone", "arccw_duals_dc17ext_v2_stun","datapad_player", "carkeys"},
    command = "abg",
    max = 3,
    salary = 300,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Battalion Generals",
    PlayerSpawn = function(ply) ply:SetMaxHealth(650) ply:SetHealth(650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 3,
})



-- JEDI COUNCIL --

TEAM_JEDIGRANDMASTER = DarkRP.createJob("Jedi Grand Master", {

    color = Color(65, 230, 0),

    model = {"models/tfa/comm/gg/pm_sw_yodanojig.mdl"},

    description = [[You are Jedi Grand Master Yoda. It is your role to help lower ranking Jedi get an understanding of the Order!]],

    weapons = {

        "weapon_lightsaber_personal",

        "wos_inventory",

        "arccw_ll30",

        "carkeys"

    },

    command = "yoda",

    max = 1,

    salary = 300,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Jedi Generals",

    canDemote = false,

    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed(240) ply:SetGravity(1) end,

    sortOrder = 1

})


TEAM_JEDIGENERALWINDU = DarkRP.createJob("Jedi Master Mace Windu", {

    color = Color(242, 0, 255, 255),

    model = {"models/player/mace/mace.mdl"},

    description = [[You are Jedi General Mace Windu. It is your role to help lower ranking Jedi get an understanding of the Order!]],

    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},

    command = "mace",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Jedi Generals",

    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 5,

})



TEAM_JEDIGENERALSKYWALKER = DarkRP.createJob("Jedi General Anakin Skywalker", {

    color = Color(242, 0, 255, 255),

    model = {"models/player/sample/anakin/anakins7.mdl","models/tfa/comm/gg/pm_sw_anakin_v2.mdl"},

    description = [[You are Jedi General Anakin Skywalker. It is your role to help lower ranking Jedi get an understanding of the Order!]],

    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},

    command = "sky",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Jedi Generals",

PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 3,

})



TEAM_JEDIGENERALOBI = DarkRP.createJob("Jedi General Obi-Wan Kenobi", {

    color = Color(242, 0, 255, 255),

    model = { "models/player/generalkenobi/cgikenobi.mdl","models/tfa/comm/gg/pm_sw_obiwan_alt.mdl","models/kylejwest/cgihdobiwan/cgihdobiwan.mdl","models/dw_sgt/pm_deathwatch_maul_sgt.mdl"},

    description = [[You are Jedi General Obi-Wan Kenobi. It is your role to help lower ranking Jedi get an understanding of the Order!]],

    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},

    command = "obi",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Jedi Generals",

    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 4,

})



TEAM_JEDIGENERALTANO = DarkRP.createJob("Jedi Commander Ahsoka Tano", {

    color = Color(242, 0, 255, 255),

    model = {"models/plo/ahsoka/ahsoka_s7.mdl","models/tfa/comm/gg/pm_sw_ahsoka_v1.mdl","models/tfa/comm/gg/pm_sw_ahsoka_v2.mdl"},

    description = [[You are Jedi Commander Ahsoka Tano. It is your role to help lower ranking Jedi get an understanding of the Order!]],

    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},

    command = "tano",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Jedi Generals",

    modelScale = 0.92,

    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 2,

})



TEAM_JEDIGENERALPLO = DarkRP.createJob("Jedi General Plo Koon", {

    color = Color(242, 0, 255, 255),

    model = {"models/player/plokoon/plokoon.mdl"},

    description = [[You are Jedi General Plo Koon. It is your role to help lower ranking Jedi get an understanding of the Order!]],

    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},

    command = "plo",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Jedi Generals",

PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 6,

})



TEAM_JEDIGENERALKIT = DarkRP.createJob("Jedi General Kit Fisto", {

    color = Color(242, 0, 255, 255),

    model = {"models/tfa/comm/gg/pm_sw_fisto.mdl"},

    description = [[You are Jedi General Kit Fisto. It is your role to help lower ranking Jedi get an understanding of the Order!]],

    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},

    command = "fisto",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Jedi Generals",

PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 7,

})



TEAM_JEDIGENERALAAYLA = DarkRP.createJob("Jedi General Aayla Secura", {

    color = Color(242, 0, 255, 255),

    model = {"models/tfa/comm/gg/pm_sw_aayala.mdl"},

    description = [[You are Jedi General Aayla Secura. It is your role to help lower ranking Jedi get an understanding of the Order!]],

    weapons = { "weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},

    command = "aayla",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    hasLicense = false,

    candemote = false,

    category = "Jedi Generals",

PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 8,

})



TEAM_JEDIGENERALSHAAK = DarkRP.createJob("Jedi General Shaak Ti", {

    color = Color(242, 0, 255, 255),

    model = {"models/tfa/comm/gg/pm_sw_shaakti.mdl"},

    description = [[You are Jedi General Shaak Ti. It is your role to help lower ranking Jedi get an understanding of the Order!]],

    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "weapon_cuff_elastic_officer", "stunstick", "carkeys"},

    command = "shaak",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Jedi Generals",

PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 9,

})



TEAM_JEDIGENERALADI = DarkRP.createJob("Jedi General Ki-Adi-Mundi", {

    color = Color(242, 0, 255, 255),

    model = {"models/tfa/comm/gg/pm_sw_mundi.mdl"},

    description = [[You are Jedi General Ki-Adi-Mundi. It is your role to help lower ranking Jedi get an understanding of the Order!]],

    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},

    command = "adi",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Jedi Generals",

PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 10,

})



TEAM_JEDIGENERALVOS = DarkRP.createJob("Jedi General Quinlan Vos", {

    color = Color(242, 0, 255, 255),

    model = {"models/tfa/comm/gg/pm_sw_quinlanvos.mdl"},

    description = [[You are Jedi General Quinlan Vos. It is your role to help lower ranking Jedi get an understanding of the Order!]],

    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},

    command = "vos",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Jedi Generals",

PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 11,

})



TEAM_JEDIGENERALLUMINARA = DarkRP.createJob("Jedi General Luminara Unduli", {

    color = Color(242, 0, 255, 255),

    model = {"models/tfa/comm/gg/pm_sw_luminara.mdl"},

    description = [[You are Jedi General Luminara Unduli. It is your role to help lower ranking Jedi get an understanding of the Order!]],

    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},

    command = "lum",

    max = 1,

    salary = 275,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Jedi Generals",

PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 12,

})

TEAM_JEDIGENCINDRALLIG = DarkRP.createJob("Jedi General Cin Drallig", {
    color = Color(242, 0, 255, 255),
    model = { "models/player/imagundi/cinndrallig.mdl", "models/player/imagundi/rcinndrallig.mdl" },
    description = [[You are Jedi General Cin Drallig. It is your role to help lower ranking Jedi get an understanding of the Order!]],
    weapons = { "weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys", "weapon_cuff_elastic_officer"},
    command = "cin",
    max = 1,
    salary = 275,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Jedi Generals",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 13,
})



--

TEAM_JEDITGCHIEF = DarkRP.createJob("Temple Guard Chief", {
    color = Color(0, 166, 255, 255),
    model = { "models/player/imagundi/cinndrallig.mdl", "models/player/imagundi/rcinndrallig.mdl", "models/epangelmatikes/templeguard/peacemakerUNI.mdl" },
    description = [[You are a part of the Jedi council, and leader of the Temple Guard!]],
    weapons = { "weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys", "weapon_cuff_elastic_officer"},
    command = "tgchief",
    max = 1,
    salary = 225,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Jedi",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 1,
})




TEAM_JEDICOUNCIL = DarkRP.createJob("Jedi Council Member", {

    color = Color(0, 166, 255, 255),

    model = {"models/aussiwozzi/cgi/base/jedi_rahm_kota.mdl",
    "models/aussiwozzi/cgi/base/jedi_bultar_swan.mdl",
    "models/tfa/comm/gg/pm_sw_adigallia.mdl",
    "models/tfa/comm/gg/pm_sw_barriss.mdl",
    "models/tfa/comm/gg/pm_sw_eeth_koth.mdl",
    "models/tfa/comm/gg/pm_sw_imagundi.mdl",
    "models/gonzo/saeseetiin/saeseetiin.mdl",
    "models/player/jedi/nyssa_delacor.mdl",
    "models/player/jedi/female_chiss_consular.mdl",
    "models/player/jedi/female_human_consular.mdl",
    "models/player/jedi/female_kaleesh_consular.mdl",
    "models/player/jedi/female_keldoran_consular.mdl",
    "models/player/jedi/female_pantoran_consular.mdl",
    "models/player/jedi/female_rodian_consular.mdl",
    "models/player/jedi/female_tholothian_consular.mdl",
    "models/player/jedi/female_zabrak_consular.mdl",
    "models/player/jedi/male_chiss_consular.mdl",
    "models/player/jedi/male_human_consular.mdl",
    "models/player/jedi/male_kaleesh_consular.mdl",
    "models/player/jedi/male_keldoran_consular.mdl",
    "models/player/jedi/male_tholothian_consular.mdl",
    "models/player/jedi/male_zabrak_consular.mdl",
    "models/player/jedi/pantoran_male_consular.mdl",
    "models/player/jedi/rodian_male_consular.mdl",
    "models/player/jedi/twilek_consular_male.mdl",
    "models/player/jedi/twilek_female_consular.mdl",
    "models/player/jedi/female_chiss_guardian.mdl",
    "models/player/jedi/female_human_guardian.mdl",
    "models/player/jedi/female_kaleesh_guardian.mdl",
    "models/player/jedi/female_keldoran_guardian.mdl",
    "models/player/jedi/female_pantoran_guardian.mdl",
    "models/player/jedi/female_rodian_guardian.mdl",
    "models/player/jedi/female_tholothian_guardian.mdl",
    "models/player/jedi/female_zabrak_guardian.mdl",
    "models/player/jedi/male_chiss_guardian.mdl",
    "models/player/jedi/male_human_guardian.mdl",
    "models/player/jedi/male_kaleesh_guardian.mdl",
    "models/player/jedi/male_keldoran_guardian.mdl",
    "models/player/jedi/male_tholothian_guardian.mdl",
    "models/player/jedi/male_zabrak_guardian.mdl",
    "models/player/jedi/pantoran_male_guardian.mdl",
    "models/player/jedi/rodian_male_guardian.mdl",
    "models/player/jedi/twilek_female_guardian.mdl",
    "models/player/jedi/twilek_guardian_male.mdl",
    "models/player/jedi/female_chiss_sentinel.mdl",
    "models/player/jedi/female_human_sentinel.mdl",
    "models/player/jedi/female_kaleesh_sentinel.mdl",
    "models/player/jedi/female_keldoran_sentinel.mdl",
    "models/player/jedi/female_pantoran_sentinel.mdl",
    "models/player/jedi/female_rodian_sentinel.mdl",
    "models/player/jedi/female_tholothian_sentinel.mdl",
    "models/player/jedi/female_zabrak_sentinel.mdl",
    "models/player/jedi/male_chiss_sentinel.mdl",
    "models/player/jedi/male_human_sentinel.mdl",
    "models/player/jedi/male_kaleesh_sentinel.mdl",
    "models/player/jedi/male_keldoran_sentinel.mdl",
    "models/player/jedi/male_tholothian_sentinel.mdl",
    "models/player/jedi/male_zabrak_sentinel.mdl",
    "models/player/jedi/pantoran_male_sentinel.mdl",
    "models/player/jedi/rodian_male_sentinel.mdl",
    "models/player/jedi/twilek_female_sentinel.mdl",
    "models/player/jedi/twilek_sentinel_male.mdl"

    },

    description = [[You are a part of the Jedi council, a leading member of the Jedi Order!]],

    weapons = { "weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},

    command = "council",

    max = 0,

    salary = 225,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Jedi",

PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 2,

})

TEAM_TGJEDI = DarkRP.createJob("Jedi Temple Guard", {
    color = Color(0, 166, 255, 255),
    model = { "models/epangelmatikes/templeguard/peacemakerUNI.mdl" },
    description = [[Congratulations, you are a Jedi Temple Guard!]],
    weapons = { "weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys", "weapon_cuff_elastic_officer" },
    command = "tg",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Jedi",
    PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 3,
})



TEAM_JEDICONSULAR = DarkRP.createJob("Jedi Consular", {

    color = Color(0, 166, 255, 255),

    model = {

        "models/player/jedi/female_chiss_consular.mdl",
        "models/player/jedi/female_human_consular.mdl",
        "models/player/jedi/female_kaleesh_consular.mdl",
        "models/player/jedi/female_keldoran_consular.mdl",
        "models/player/jedi/female_pantoran_consular.mdl",
        "models/player/jedi/female_rodian_consular.mdl",
        "models/player/jedi/female_tholothian_consular.mdl",
        "models/player/jedi/female_zabrak_consular.mdl",
        "models/player/jedi/male_chiss_consular.mdl",
        "models/player/jedi/male_human_consular.mdl",
        "models/player/jedi/male_kaleesh_consular.mdl",
        "models/player/jedi/male_keldoran_consular.mdl",
        "models/player/jedi/male_tholothian_consular.mdl",
        "models/player/jedi/male_zabrak_consular.mdl",
        "models/player/jedi/pantoran_male_consular.mdl",
        "models/player/jedi/rodian_male_consular.mdl",
        "models/player/jedi/twilek_consular_male.mdl",
        "models/player/jedi/twilek_female_consular.mdl"

},

    description = [[You are a Jedi Consular. It is your role to use the force to keep the peace and to protect the Jedi Order and the Republic!]],

    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "weapon_camo", "carkeys"},

    command = "consular",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Jedi",

PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 5,

})




TEAM_JEDIGUARDIAN = DarkRP.createJob("Jedi Guardian", {

    color = Color(0, 166, 255, 255),

    model = {

        "models/player/jedi/female_chiss_guardian.mdl",
        "models/player/jedi/female_human_guardian.mdl",
        "models/player/jedi/female_kaleesh_guardian.mdl",
        "models/player/jedi/female_keldoran_guardian.mdl",
        "models/player/jedi/female_pantoran_guardian.mdl",
        "models/player/jedi/female_rodian_guardian.mdl",
        "models/player/jedi/female_tholothian_guardian.mdl",
        "models/player/jedi/female_zabrak_guardian.mdl",
        "models/player/jedi/male_chiss_guardian.mdl",
        "models/player/jedi/male_human_guardian.mdl",
        "models/player/jedi/male_kaleesh_guardian.mdl",
        "models/player/jedi/male_keldoran_guardian.mdl",
        "models/player/jedi/male_tholothian_guardian.mdl",
        "models/player/jedi/male_zabrak_guardian.mdl",
        "models/player/jedi/pantoran_male_guardian.mdl",
        "models/player/jedi/rodian_male_guardian.mdl",
        "models/player/jedi/twilek_female_guardian.mdl",
        "models/player/jedi/twilek_guardian_male.mdl"
    },

    description = [[You are a Jedi Guardian. It is your role to embark on the front-lines and deal with hostiles in a clean approach!]],

    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},

    command = "guardian",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Jedi",

PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 6,

})



TEAM_JEDISENTINEL = DarkRP.createJob("Jedi Sentinel", {

    color = Color(0, 166, 255, 255),

    model = {

        "models/player/jedi/female_chiss_sentinel.mdl",
        "models/player/jedi/female_human_sentinel.mdl",
        "models/player/jedi/female_kaleesh_sentinel.mdl",
        "models/player/jedi/female_keldoran_sentinel.mdl",
        "models/player/jedi/female_pantoran_sentinel.mdl",
        "models/player/jedi/female_rodian_sentinel.mdl",
        "models/player/jedi/female_tholothian_sentinel.mdl",
        "models/player/jedi/female_zabrak_sentinel.mdl",
        "models/player/jedi/male_chiss_sentinel.mdl",
        "models/player/jedi/male_human_sentinel.mdl",
        "models/player/jedi/male_kaleesh_sentinel.mdl",
        "models/player/jedi/male_keldoran_sentinel.mdl",
        "models/player/jedi/male_tholothian_sentinel.mdl",
        "models/player/jedi/male_zabrak_sentinel.mdl",
        "models/player/jedi/pantoran_male_sentinel.mdl",
        "models/player/jedi/rodian_male_sentinel.mdl",
        "models/player/jedi/twilek_female_sentinel.mdl",
        "models/player/jedi/twilek_sentinel_male.mdl"
    },

    description = [[You are a Jedi Sentinel. It is your role to assist the Combat Engineers with their engineering.]],

    weapons = { "weapon_lightsaber_personal", "wos_inventory", "arccw_ll30", "carkeys"},

    command = "sentinel",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Jedi",

PlayerSpawn = function(ply) ply:SetMaxHealth(550) ply:SetHealth(550) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 7,



})

TEAM_JEDIKNIGHT = DarkRP.createJob("Jedi Knight", {

    color = Color(0, 166, 255, 255),

            model = {

                "models/player/jedi/female_chiss_knight.mdl",
                "models/player/jedi/female_human_knight.mdl",
                "models/player/jedi/female_keldoran_knight.mdl",
                "models/player/jedi/female_pantoran_knight.mdl",
                "models/player/jedi/female_rodian_knight.mdl",
                "models/player/jedi/female_tholothian_knight.mdl",
                "models/player/jedi/female_zabrak_knight.mdl",
                "models/player/jedi/male_chiss_knight.mdl",
                "models/player/jedi/male_human_knight.mdl",
                "models/player/jedi/male_kaleesh_knight.mdl",
                "models/player/jedi/male_keldoran_knight.mdl",
                "models/player/jedi/male_tholothian_knight.mdl",
                "models/player/jedi/male_zabrak_knight.mdl",
                "models/player/jedi/pantoran_male_knight.mdl",
                "models/player/jedi/rodian_male_knight.mdl",
                "models/player/jedi/twilek_female_knight.mdl",
                "models/player/jedi/twilek_knight_male.mdl"

    },

    description = [[You are a Jedi Knight, you have passed your Padawan trials and now will benefit the Order and the Republic as a higher rank!]],

    weapons = {"weapon_lightsaber_personal", "wos_inventory", "arccw_ll30"},

    command = "knight",

    max = 0,

    salary = 175,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Jedi",

PlayerSpawn = function(ply) ply:SetMaxHealth(450) ply:SetHealth(450) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 10,

})



TEAM_JEDITOURNAMENT = DarkRP.createJob("Jedi Tournament", {

    color = Color(0, 166, 255, 255),

    model = {

        "models/player/jedi/female_chiss_knight.mdl",
        "models/player/jedi/female_human_knight.mdl",
        "models/player/jedi/female_keldoran_knight.mdl",
        "models/player/jedi/female_pantoran_knight.mdl",
        "models/player/jedi/female_rodian_knight.mdl",
        "models/player/jedi/female_tholothian_knight.mdl",
        "models/player/jedi/female_zabrak_knight.mdl",
        "models/player/jedi/male_chiss_knight.mdl",
        "models/player/jedi/male_human_knight.mdl",
        "models/player/jedi/male_kaleesh_knight.mdl",
        "models/player/jedi/male_keldoran_knight.mdl",
        "models/player/jedi/male_tholothian_knight.mdl",
        "models/player/jedi/male_zabrak_knight.mdl",
        "models/player/jedi/pantoran_male_knight.mdl",
        "models/player/jedi/rodian_male_knight.mdl",
        "models/player/jedi/twilek_female_knight.mdl",
        "models/player/jedi/twilek_knight_male.mdl"

},

    description = [[Jedi Tournament Role]],

    weapons = {"weapon_lightsaber_tournament", "weapon_lightsaber_tournament_twin", "weapon_lightsaber_tournament_staff", "weapon_lightsaber_tournament_pike", "wos_inventory", "arccw_ll30"},

    command = "jeditourn",

    max = 0,

    salary = 175,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Jedi",

PlayerSpawn = function(ply) ply:SetMaxHealth(1000) ply:SetHealth(1000) ply:SetRunSpeed (270) ply:SetGravity(1)  end,

    sortOrder = 11,

})



TEAM_JEDIPADAWAN = DarkRP.createJob("Jedi Padawan", {

    color = Color(0, 166, 255, 255),

    model = {

        "models/player/jedi/female_chiss_padawan.mdl",
        "models/player/jedi/female_human_padawan.mdl",
        "models/player/jedi/female_kaleesh_padawan.mdl",
        "models/player/jedi/female_keldoran_padawan.mdl",
        "models/player/jedi/female_pantoran_padawan.mdl",
        "models/player/jedi/female_rodian_padawan.mdl",
        "models/player/jedi/female_tholothian_padawan.mdl",
        "models/player/jedi/female_zabrak_padawan.mdl",
        "models/player/jedi/male_chiss_padawan.mdl",
        "models/player/jedi/male_human_padawan.mdl",
        "models/player/jedi/male_kaleesh_padawan.mdl",
        "models/player/jedi/male_keldoran_padawan.mdl",
        "models/player/jedi/male_tholothian_padawan.mdl",
        "models/player/jedi/male_zabrak_padawan.mdl",
        "models/player/jedi/pantoran_male_padawan.mdl",
        "models/player/jedi/rodian_male_padawan.mdl",
        "models/player/jedi/twilek_female_padawan.mdl",
        "models/player/jedi/twilek_padawan_male.mdl"

},

    description = [[You are a Jedi Padawan, a new member to the Jedi Order! You will be granted a Master who will train you and teach you the Jedi ways.]],

    weapons = {"weapon_lightsaber_padawan_ts","weapon_lightsaber_personal", "wos_inventory", "arccw_ll30"},

    command = "padawan",

    max = 0,

    salary = 150,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Jedi",

PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 12,

})





TEAM_JEDIYOUNGLING = DarkRP.createJob("Jedi Youngling", {

    color = Color(0, 166, 255, 255),

            model = {

        "models/jazzmcfly/jka/younglings/jka_young_anikan.mdl",

        "models/jazzmcfly/jka/younglings/jka_young_female.mdl",

        "models/jazzmcfly/jka/younglings/jka_young_male.mdl",

        "models/jazzmcfly/jka/younglings/jka_young_shak.mdl"

    },

    description = [[You are a Jedi Youngling, a new member to the Jedi Order!]],

    weapons = {"wos_inventory"},

    command = "youngling",

    max = 0,

    salary = 150,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Jedi",

PlayerSpawn = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 13,

})


-----------Legacy Neutral Jobs--------------



TEAM_WOOKIE = DarkRP.createJob("Wookiee", {

    color = Color(51, 102, 0, 255),

    model = {"models/grand/wookie_wild.mdl","models/grand/wookie.mdl"},

    description = [[Congratulations! You are a Wookiee. Capable of performing many tasks required.]],

    weapons = {"weapon_fists", "arccw_bowcaster", "lord_chrome_medkit"},

    command = "wook",

    max = 4,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Legacy Neutral Jobs",

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (250) ply:SetGravity(1) end,

    sortOrder = 1

})



TEAM_JAWA = DarkRP.createJob("Jawa", {

    color = Color(51, 25, 0, 255),

    model = {"models/jajoff/sw/jawacustom.mdl"},

    description = [[Congratulations! You are a Jawa.]],

    weapons = {"weapon_fists", "arccw_dual_dt12", "weapon_bugbait", "keypad_cracker"},

    command = "jawa",

    max = 4,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Legacy Neutral Jobs",

    PlayerSpawn = function(ply) ply:SetMaxHealth(200) ply:SetHealth(200) ply:SetRunSpeed (240) ply:SetGravity(1) end,

    sortOrder = 2

})



--[[]

TEAM_BARTENDER = DarkRP.createJob("Bartender", {

    color = Color(204, 255, 153, 255),

    model = {"models/gonzo/narshaddaabarstaff/barmanager/barmanager.mdl", "models/gonzo/narshaddaabarstaff/twilekdancer/twilekdancer.mdl"},

    description = [[You are a Bartender. Tasked with refreshing the Republic's troopers!],

    weapons = {"meleearts_spear_truepushbroom", "weapon_fists", "rw_sw_relbyk23", "clone_card_c1"},

    command = "barten",

    max = 2,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Legacy Neutral Jobs",

    PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (260) ply:SetGravity(1) end,

    sortOrder = 3

})]]--







TEAM_BOUNTYHUNTER = DarkRP.createJob("Bounty Hunter", {

    color = Color(255, 87, 87, 255),

    model = {"models/jajoff/sps/jlmbase/jaronlangley2021.mdl", "models/jajoff/sps/jlmbase/malchialangley2021.mdl"},

    description = [[You are a Bounty Hunter. You are paid by the republic to aid them in their struggles]],

    weapons = {"arccw_ee3", "arccw_dual_dt12", "realistic_hook", "arccw_nt242", "weapon_jetpack"},

    command = "bounty",

    max = 4,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Legacy Neutral Jobs",

    PlayerSpawn = function(ply) ply:SetMaxHealth(400) ply:SetHealth(400) ply:SetRunSpeed (280) ply:SetGravity(1) end,

    sortOrder = 4

})



TEAM_NEUTRALDROID = DarkRP.createJob("Republic Droid", {

    color = Color(255, 87, 87, 255),

    model = {"models/ace/sw/r2.mdl", "models/ace/sw/r4.mdl","models/ace/sw/r5.mdl"},

    description = [[You are a Droid. You are programmed by the republic to aid them in their completing tasks]],

    weapons = {"alydus_fusioncutter", "weapon_dronerepair", "weapon_extinguisher_infinite", "arccw_ammo_crate"},

    command = "droid",

    max = 4,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Legacy Neutral Jobs",

    PlayerSpawn = function(ply) ply:SetMaxHealth(200) ply:SetHealth(200) ply:SetRunSpeed (180) ply:SetGravity(1) end,

    sortOrder = 5

})

-----------Clone Reinforcement Jobs--------------


TEAM_DUA = DarkRP.createJob("Dooms Unit Assault", {
    color = Color(51, 102, 0, 255),
    model = {"models/herm/cgi_new/doom_unit/du_trooper1.mdl","models/aussiwozzi/cgi/base/doom_jet.mdl","models/aussiwozzi/cgi/base/doom_hrs.mdl","models/aussiwozzi/cgi/base/doom_sydney.mdl"}, 
    description = [[Congratulations! You are apart of the Dooms Unit Assault, for the republic.]],
    weapons = {"arccw_duals_dc17ext_v2", "arccw_z6_pak"},
    command = "dua",
    max = 4,
    salary = 175,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Clone Reinforcements",
    PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1) end,
    sortOrder = 1
})

TEAM_SIEGE = DarkRP.createJob("442nd Siege Battalion", {
    color = Color(56, 79, 26, 255),
    model = {"models/herm/cgi_new/442nd/442nd_trooper1.mdl","models/aussiwozzi/cgi/base/442nd_odin.mdl","models/aussiwozzi/cgi/base/442nd_raffle.mdl"}, 
    description = [[Congratulations! You are apart of the 442nd Siege Battalion, for the republic!]],
    weapons = {"arccw_duals_dc17ext_v2", "arccw_dc15s_v2", "arccw_hunter_shotgun"},
    command = "siege",
    max = 4,
    salary = 175,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Clone Reinforcements",
    PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1) end,
    sortOrder = 2
})



TEAM_MEDMM = DarkRP.createJob("91st Marksman", {
    color = Color(111, 42, 40, 255),
    model = {"models/herm/cgi_new/91st/91st_trooper1.mdl","models/aussiwozzi/cgi/base/91st_razor.mdl","models/aussiwozzi/cgi/base/91st_strac.mdl","models/aussiwozzi/cgi/base/91st_strike.mdl"}, 
    description = [[Congratulations! You are a 91st Marksman, for the republic!]],
    weapons = {"arccw_dc17_v2", "arccw_valkenx38a", "realistic_hook"},
    command = "91stmm",
    max = 4,
    salary = 175,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Clone Reinforcements",
    PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1) end,
    sortOrder = 3
})


TEAM_JAGUAR = DarkRP.createJob("Jaguar Hunters", {
    color = Color(80, 51, 49, 255),
    model = {"models/herm/cgi_new/jaguar/jaguar_trooper1.mdl","models/aussiwozzi/cgi/base/jaguar_arf.mdl","models/aussiwozzi/cgi/base/jaguar_trooper.mdl"}, 
    description = [[Congratulations! You are a Jaguar Hunter for the republic.]],
    weapons = {"arccw_dc17_v2_suppressed", "arccw_dc19le", "realistic_hook"},
    command = "jaguar",
    max = 4,
    salary = 175,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Clone Reinforcements",
    PlayerSpawn = function(ply) ply:SetMaxHealth(350) ply:SetHealth(350) ply:SetRunSpeed (240) ply:SetGravity(1) end,
    sortOrder = 4
})

-- OTHER --



TEAM_SOD = DarkRP.createJob("Staff on Duty", {

    color = Color(204, 0, 0, 255),

    model = {"models/grand/wookie_kwehs.mdl"},

    description = [[Use this when on duty]],

    weapons = {"weapon_physgun", "gmod_tool"},

    command = "sod",

    max = 0,

    salary = 0,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Other",

    PlayerSpawn = function(ply) ply:SetMaxHealth(30000) ply:SetHealth(30000) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

})



TEAM_EH = DarkRP.createJob("Event Host", {

    color = Color(204, 0, 0, 255),

    model = {"models/grand/wookie_kwehs.mdl"},

    description = [[Use this when hosting an event]],

    weapons = {"weapon_physgun", "gmod_tool"},

    command = "eh",

    max = 0,

    salary = 0,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Other",

    PlayerSpawn = function(ply) ply:SetMaxHealth(30000) ply:SetHealth(30000) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

})



-------- SIMULATION JOBS ---------



TEAM_SIMASSAULT = DarkRP.createJob("Clone Assault", {

    color = Color(30, 165, 232, 255),

    model = {"models/aussiwozzi/cgi/base/unassigned_trp.mdl"},

    description = [[You are an Assault Clone!]],

    weapons = {"arccw_dc17_v2",  "arccw_dc15s_v2"},

    command = "simassault",

    max = 0,

    salary = 1,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Other",

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 1

})



TEAM_SIMHEAVY = DarkRP.createJob("Clone Heavy", {

    color = Color(30, 165, 232, 255),

    model = {"models/aussiwozzi/cgi/base/unassigned_trp.mdl","models/aussiwozzi/cgi/base/unassigned_heavy.mdl"},

    description = [[You are a Heavy Clone!]],

    weapons = {"arccw_dc17_v2", "arccw_dc15a_v2", "arccw_z6_pak"},

    command = "simheavy",

    max = 0,

    salary = 1,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Other",

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 1

})



TEAM_SIMSNIPER = DarkRP.createJob("Clone Sniper", {

    color = Color(30, 165, 232, 255),

    model = {"models/aussiwozzi/cgi/base/unassigned_trp.mdl"},

    description = [[You are a Sniper Clone!]],

    weapons = {"arccw_dc17_v2",  "arccw_dc15x"},

    command = "simsniper",

    max = 0,

    salary = 1,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Other",

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 1

})



TEAM_SIMMEDIC = DarkRP.createJob("Clone Medic", {

    color = Color(30, 165, 232, 255),

    model = {"models/aussiwozzi/cgi/base/unassigned_specops.mdl"},

    description = [[You are a Medic Clone!]],

    weapons = {"arccw_dc17_v2", "arccw_dc15s_v2", "lord_chrome_medkit", "weapon_bactainjector", "weapon_jew_stimkit", "weapon_defibrillator", "tf_weapon_medigun"},

    command = "simmedic",

    max = 0,

    salary = 1,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Other",

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 1

})



TEAM_SIMPILOT = DarkRP.createJob("Clone Pilot", {

    color = Color(30, 165, 232, 255),

    model = {"models/aussiwozzi/cgi/base/unassigned_pilot.mdl"},

    description = [[You are a Pilot Clone!]],

    weapons = {"arccw_dc17_v2", "gmod_tool", "carkeys"},

    command = "simpilot",

    max = 0,

    salary = 1,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Other",

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 1

})

TEAM_SIMRBOMBER = DarkRP.createJob("Clone Bomber", {

    color = Color(30, 165, 232, 255),

    model = {"models/aussiwozzi/cgi/base/unassigned_pilot.mdl"},

    description = [[You are a Bomber Clone!]],

    weapons = {"arccw_dc17_v2", "gmod_tool"},

    command = "simbomb",

    max = 0,

    salary = 1,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Other",

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 1

})



TEAM_SIMJET = DarkRP.createJob("Clone Jet Trooper", {

    color = Color(30, 165, 232, 255),

    model = {"models/aussiwozzi/cgi/base/unassigned_para.mdl"},

    description = [[You are a Clone Jet Trooper!]],

    weapons = {"arccw_dc17_v2", "arccw_dc15s_v2", "weapon_jetpack"},

    command = "simjet",

    max = 0,

    salary = 1,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Other",

    PlayerSpawn = function(ply) ply:SetMaxHealth(500) ply:SetHealth(500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 1

})



TEAM_CISSIMASSAULT = DarkRP.createJob("Sim Enemy Assault", {

    color = Color(204, 0, 0, 255),

    model = {

        "models/aussiwozzi/cgi/b1droids/b1_battledroid_pm.mdl",

        "models/dw_grunt/pm_deathwatch_grunt.mdl",

        "models/player/ohanak_gang/pm_pirate_grunt.mdl"

    },

    description = [[You are a Enemy Assault]],

    weapons = {

        "arccw_e5",

        "arccw_rg4d",

        "seal6tacinsert"

    },

    command = "simenemyassault",

    max = 0,

    salary = 1,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Other",

    canDemote = false,

    PlayerSpawn = function(ply)

        ply:SetHealth(500)

        ply:SetMaxHealth(500)

        ply:SetArmor(0)

        ply:SetMaxArmor(0)

    end,

    sortOrder = 1

})



TEAM_CISSIMHEAVY = DarkRP.createJob("Sim Enemy Heavy", {

    color = Color(204, 0, 0, 255),

    model = {

        "models/aussiwozzi/cgi/b1droids/b1_battledroid_heavy_pm.mdl",

        "models/dw_grunt/pm_deathwatch_grunt.mdl",

        "models/player/ohanak_gang/pm_pirate_marauder.mdl"

    },

    description = [[You are a Enemy Heavy]],

    weapons = {

        "arccw_z4",

        "arccw_rg4d",

        "arccw_e5c",

        "seal6tacinsert"

    },

    command = "simenemyheavy",

    max = 0,

    salary = 1,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Other",

    canDemote = false,

    PlayerSpawn = function(ply)

        ply:SetHealth(500)

        ply:SetMaxHealth(500)

        ply:SetArmor(0)

        ply:SetMaxArmor(0)

    end,

    sortOrder = 1

})



TEAM_CISSIMMEDIC = DarkRP.createJob("Sim Enemy Medic", {

    color = Color(204, 0, 0, 255),

    model = {

        "models/aussiwozzi/cgi/b1droids/b1_battledroid_marine_pm.mdl",

        "models/dw_cpt/pm_deathwatch_cpt.mdl",

        "models/player/ohanak_gang/pm_pirate_gwarm.mdl"

    },

    description = [[You are a Enemy Medic]],

    weapons = {

        "arccw_e5",

        "arccw_rg4d",

        "weapon_defibrillator",

        "tf_weapon_medigun",

        "lord_chrome_medkit",

        "weapon_jew_stimkit",

        "weapon_bactainjector",

        "seal6tacinsert"

    },

    command = "simenemymedic",

    max = 0,

    salary = 1,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Other",

    canDemote = false,

    PlayerSpawn = function(ply)

        ply:SetHealth(500)

        ply:SetMaxHealth(500)

        ply:SetArmor(0)

        ply:SetMaxArmor(0)

    end,

    sortOrder = 1

})



TEAM_CISSIMSNIPER = DarkRP.createJob("Sim Enemy Sniper", {

    color = Color(204, 0, 0, 255),

    model = {

        "models/aussiwozzi/cgi/b1droids/b1_battledroid_marine_pm.mdl",

        "models/dw_grunt/pm_deathwatch_grunt.mdl",

        "models/player/ohanak_gang/pm_pirate_soldier.mdl"

    },

    description = [[You are a Enemy Sniper]],

    weapons = {

        "arccw_e5s_sniper",

        "arccw_rg4d",

        "seal6tacinsert"

    },

    command = "simenemysniper",

    max = 0,

    salary = 1,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Other",

    canDemote = false,

    PlayerSpawn = function(ply)

        ply:SetHealth(500)

        ply:SetMaxHealth(500)

        ply:SetArmor(0)

        ply:SetMaxArmor(0)

    end,

    sortOrder = 1

})



TEAM_CISSIMPILOT = DarkRP.createJob("Sim Enemy Pilot", {

    color = Color(204, 0, 0, 255),

    model = {

        "models/aussiwozzi/cgi/b1droids/b1_battledroid_pilot_pm.mdl",

        "models/aussiwozzi/cgi/b1droids/b1_battledroid_aat_pm.mdl",

        "models/dw_grunt/pm_deathwatch_grunt.mdl",

        "models/player/ohanak_gang/pm_pirate_turk.mdl"

    },

    description = [[You are a Enemy Pilot]],

    weapons = {

        "arccw_rg4d",

        "seal6tacinsert"

    },

    command = "simenemypilot",

    max = 0,

    salary = 1,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Other",

    canDemote = false,

    PlayerSpawn = function(ply)

        ply:SetHealth(500)

        ply:SetMaxHealth(500)

        ply:SetArmor(0)

        ply:SetMaxArmor(0)

    end,

    sortOrder = 1

})

TEAM_CISSIMBOM = DarkRP.createJob("Sim Enemy Bomber", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_pilot_pm.mdl",
        "models/dw_grunt/pm_deathwatch_grunt.mdl",
        "models/player/ohanak_gang/pm_pirate_turk.mdl"
    },
    description = [[You are a Enemy Bomber]],
    weapons = {
        "arccw_rg4d",
        "seal6tacinsert"
    },
    command = "simenemyBomber",
    max = 0,
    salary = 1,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Other",
    canDemote = false,
    PlayerSpawn = function(ply)
        ply:SetHealth(500)
        ply:SetMaxHealth(500)
        ply:SetArmor(0)
        ply:SetMaxArmor(0)
    end,
    sortOrder = 1
})



TEAM_CISSIMJET = DarkRP.createJob("Sim Enemy Jet Trooper", {

    color = Color(204, 0, 0, 255),

    model = {

        "models/aussiwozzi/cgi/b1droids/b1_battledroid_rocket_pm.mdl",

        "models/dw_grunt/pm_deathwatch_grunt.mdl",

        "models/player/ohanak_gang/pm_pirate_jiro.mdl"

    },

    description = [[You are a Enemy Jet Trooper]],

    weapons = {

        "arccw_e5",

        "arccw_rg4d",

        "weapon_jetpack",

        "seal6tacinsert"

    },

    command = "simenemyjet",

    max = 0,

    salary = 1,

    admin = 0,

    vote = false,

    hasLicense = false,

    category = "Other",

    canDemote = false,

    PlayerSpawn = function(ply)

        ply:SetHealth(500)

        ply:SetMaxHealth(500)

        ply:SetArmor(0)

        ply:SetMaxArmor(0)

    end,

    sortOrder = 1

})



-------- EVENT ENEMY JOBS ---------



-- Other EEs --

TEAM_BATTLEDROID = DarkRP.createJob("Battle Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_pm.mdl",
    },
    description = [[You are a Battle Droid!]],
    weapons = { "arccw_e5",  "arccw_cis_se14", "arccw_thermal_grenade" },
    command = "b1",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Infantry",
    PlayerSpawn = function(ply) ply:SetMaxHealth(2000) ply:SetHealth(2000) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 0
})

TEAM_CQBATTLEDROID = DarkRP.createJob("CQ Battle Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_marine_pm.mdl",
    },
    description = [[You are a CQ Battle Droid!]],
    weapons = { "arccw_e5_smg",  "arccw_sg6", "shock" },
    command = "b1cqb",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Infantry",
    PlayerSpawn = function(ply) ply:SetMaxHealth(2100) ply:SetHealth(2100) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 1
})

TEAM_ROCKETDROID = DarkRP.createJob("Rocket Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_rocket_pm.mdl",
    },
    description = [[You are a Rocket Droid!]],
    weapons = { "arccw_e5",  "arccw_cis_se14", "arccw_sw_rocket_smartlauncher", "realistic_hook" },
    command = "b1rocket",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Infantry",
    PlayerSpawn = function(ply) ply:SetMaxHealth(1800) ply:SetHealth(1800) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 2
})

TEAM_HEAVYBATTLEDROID = DarkRP.createJob("Heavy Battle Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_heavy_pm.mdl",
    },
    description = [[You are a Heavy Battle Droid!]],
    weapons = { "arccw_e5c",  "arccw_cis_se14", "arccw_thermal_grenade", "personal_shield_activator" },
    command = "b1heavy",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Infantry",
    PlayerSpawn = function(ply) ply:SetMaxHealth(2100) ply:SetHealth(2100) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 3
})

TEAM_RECONBATTLEDROID = DarkRP.createJob("Recon Battle Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_aat_pm.mdl",
    },
    description = [[You are a Recon Battle Droid!]],
    weapons = { "arccw_e5s_dmr",  "arccw_cis_se14", "realistic_hook", "cloaking-infinite" },
    command = "b1recon",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Infantry",
    PlayerSpawn = function(ply) ply:SetMaxHealth(1300) ply:SetHealth(1300) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 4
})

TEAM_ENGINEERDROID = DarkRP.createJob("Engineer Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_pilot_pm.mdl",
    },
    description = [[You are a Engineer Droid!]],
    weapons = { "arccw_e5_smg",  "arccw_cis_se14", "alydus_fortificationbuildertablet", "weapon_squadshield", "weapon_slam" },
    command = "b1engineer",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Infantry",
    PlayerSpawn = function(ply) ply:SetMaxHealth(1800) ply:SetHealth(1800) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 5
})

TEAM_MEDICALDROID = DarkRP.createJob("Medical Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_snow_pm.mdl",
    },
    description = [[You are a Medical Droid!]],
    weapons = { "arccw_e5",  "arccw_cis_se14", "lord_chrome_medkit", "weapon_bactainjector", "weapon_defibrillator" },
    command = "b1medic",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Infantry",
    PlayerSpawn = function(ply) ply:SetMaxHealth(1800) ply:SetHealth(1800) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 6
})

TEAM_COMMANDERDROID = DarkRP.createJob("Commander Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_commander_pm.mdl",
    },
    description = [[You are a Commander Droid!]],
    weapons = { "arccw_e5c",  "arccw_cis_se14", "realistic_hook", "lord_chrome_medkit", "personal_shield_activator", "weapon_officerboost_laststand" },
    command = "b1cmdr",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Infantry",
    PlayerSpawn = function(ply) ply:SetMaxHealth(2000) ply:SetHealth(2000) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 7
})

TEAM_SITH = DarkRP.createJob("Sith", {
    color = Color(204, 0, 0, 255),
    model = {"models/player/sith/twilek.mdl","models/player/sith/gotal.mdl", "models/player/sith/gungan.mdl",
    "models/player/sith/human.mdl", "models/player/sith/twilek2.mdl", "models/player/sith/umbaran.mdl", "models/player/sith/zabrak.mdl", "models/player/sith/togruta.mdl", "models/player/sith/trandoshan.mdl"},
    description = [[You are a Sith!]],
    weapons = {"weapon_lightsaber_sith_single", "weapon_lightsaber_sith_dual", "weapon_lightsaber_sith_twin", "gmod_tool"},
    command = "sith",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Infantry",
    PlayerSpawn = function(ply) ply:SetMaxHealth(3000) ply:SetHealth(3000) ply:SetRunSpeed (280) ply:SetGravity(1)  end,
    sortOrder = 0
})

-- CIS Reinforcements

TEAM_SUPERBATTLEDROID = DarkRP.createJob("Super Battle Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/aussiwozzi/cgi/b1droids/b2_battledroid_cannon_pm.mdl",
    },
    description = [[You are a Super Battle Droid!]],
    weapons = { "arccw_b2_blaster" },
    command = "b2heavy",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Reinforcements",
    PlayerSpawn = function(ply) ply:SetMaxHealth(7000) ply:SetHealth(7000) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 1
})

TEAM_SUPERJUMPDROID = DarkRP.createJob("Super Jump Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/aussiwozzi/cgi/b1droids/b2_battledroid_rocket_pm.mdl",
    },
    description = [[You are a Super Jump Droid!]],
    weapons = { "arccw_b2_blaster", "weapon_thruster" },
    command = "b2jump",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Reinforcements",
    PlayerSpawn = function(ply) ply:SetMaxHealth(6000) ply:SetHealth(6000) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 2
})

TEAM_DROIDEKA = DarkRP.createJob("Droideka", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/starwars/stan/droidekas/droideka.mdl",
    },
    description = [[You are a Droideka!]],
    weapons = { "arccw_droideka_twin", "personal_shield_activator_droideka" },
    command = "droideka",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Reinforcements",
    PlayerSpawn = function(ply) ply:SetMaxHealth(6000) ply:SetHealth(6000) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 3
})

TEAM_MAGNAGUARD = DarkRP.createJob("Magna Guard", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/tfa/comm/gg/pm_sw_magna_guard_combined.mdl",
    },
    description = [[You are a Magna Guard!]],
    weapons = { "arccw_e5", "sfw_magnastaff", "weapon_thruster", "shock" },
    command = "magna",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Reinforcements",
    PlayerSpawn = function(ply) ply:SetMaxHealth(2500) ply:SetHealth(2500) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 4
})

TEAM_TACTICALDROID = DarkRP.createJob("Tactical Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/tactical_black/pm_droid_tactical_black.mdl","models/tactical_blue/pm_droid_tactical_blue.mdl","models/tactical_gold/pm_droid_tactical_gold.mdl","models/tactical_purple/pm_droid_tactical_purple.mdl","models/tactical_red/pm_droid_tactical_red.mdl"
    },
    description = [[You are a Tactical Droid!]],
    weapons = { "arccw_e5", "arccw_z4", "weapon_officerboost_laststand", "tf_weapon_medigun" },
    command = "tacdroid",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Reinforcements",
    PlayerSpawn = function(ply) ply:SetMaxHealth(3000) ply:SetHealth(3000) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 5
})

TEAM_TANKERDROID = DarkRP.createJob("Tanker Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_pointrain_pm.mdl",
    },
    description = [[You are a Tactical Droid!]],
    weapons = { "arccw_e5" },
    command = "b1tank",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Reinforcements",
    PlayerSpawn = function(ply) ply:SetMaxHealth(1800) ply:SetHealth(1800) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 6
})

TEAM_SNIPERDROID = DarkRP.createJob("Sniper Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_aat_pm.mdl",
    },
    description = [[You are a Sniper Droid!]],
    weapons = { "arccw_e5_smg", "arccw_e5s_sniper", "realistic_hook", "cloaking-infinite" },
    command = "b1mm",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Reinforcements",
    PlayerSpawn = function(ply) ply:SetMaxHealth(1800) ply:SetHealth(1800) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 7
})

TEAM_TECHNICALDROID = DarkRP.createJob("Technical Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/aussiwozzi/cgi/b1droids/b1_battledroid_pilot_pm.mdl",
    },
    description = [[You are a Technical Droid!]],
    weapons = { "arccw_e5","arccw_e5_smg", "weapon_medkit", "weapon_bactainjector", "weapon_defibrillator", "realistic_hook" },
    command = "b1tech",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Reinforcements",
    PlayerSpawn = function(ply) ply:SetMaxHealth(2100) ply:SetHealth(2100) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 8
})

TEAM_BOUNTYHUNTERREINFORCE = DarkRP.createJob("Enemy Bounty Hunter", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/assassin/pm_civ_assassin_human_female.mdl","models/assassin/pm_civ_assassin_human_male.mdl","models/bandit/pm_civ_bandit_human_female.mdl","models/bandit/pm_civ_bandit_human_male.mdl"
    },
    description = [[You are a Bounty Hunter!]],
    weapons = { "arccw_ee3_ee", "weapon_jetpack", "arccw_cis_se14" },
    command = "eebh",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Reinforcements",
    PlayerSpawn = function(ply) ply:SetMaxHealth(1800) ply:SetHealth(1800) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 9
})

-- CIS Special Forces

TEAM_BXCOMMANDODROID = DarkRP.createJob("BX Commando Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/bx/pm_droid_cis_bx.mdl",
    },
    description = [[You are a Commando Droid!]],
    weapons = { "arccw_e5bx", "realistic_hook", "weapon_cloak" },
    command = "bxco",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Special Forces",
    PlayerSpawn = function(ply) ply:SetMaxHealth(2000) ply:SetHealth(2000) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 0
})

TEAM_BXASSASSINDROID = DarkRP.createJob("BX Assassin Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/bx_senate/pm_droid_cis_bx_senate.mdl",
    },
    description = [[You are an assassin Droid!]],
    weapons = { "arccw_e5bx", "covert", "weapon_thruster", "realistic_hook", "weapon_cloak" },
    command = "bxknife",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Special Forces",
    PlayerSpawn = function(ply) ply:SetMaxHealth(1650) ply:SetHealth(1650) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 1
})

TEAM_BXSLUGDROID = DarkRP.createJob("BX Slugthrower Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/bx_citadel/pm_droid_cis_bx_citadel.mdl",
    },
    description = [[You are an flamer Droid!]],
    weapons = { "arccw_e5", "arccw_slugthrower", "realistic_hook" },
    command = "bxslug",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Special Forces",
    PlayerSpawn = function(ply) ply:SetMaxHealth(1600) ply:SetHealth(1600) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 2
})

TEAM_BXSPLICERDROID = DarkRP.createJob("BX Splicer Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/bx_senate/pm_droid_cis_bx_senate.mdl",
    },
    description = [[You are an splicer Droid!]],
    weapons = { "arccw_e5bx_smg", "alydus_fortificationbuildertablet", "weapon_cloak", "weapon_slam", "realistic_hook" },
    command = "bxsmg",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Special Forces",
    PlayerSpawn = function(ply) ply:SetMaxHealth(1800) ply:SetHealth(1800) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 3
})

TEAM_BXRECONDROID = DarkRP.createJob("BX Recon Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/bx/pm_droid_cis_bx.mdl",
    },
    description = [[You are an recon Droid!]],
    weapons = { "arccw_e5bx_sniper", "shock", "weapon_cloak", "realistic_hook", "cloaking-infinite" },
    command = "bxmm",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Special Forces",
    PlayerSpawn = function(ply) ply:SetMaxHealth(1800) ply:SetHealth(1800) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 4
})

TEAM_BXHEAVYDROID = DarkRP.createJob("BX Heavy Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/bx_citadel/pm_droid_cis_bx_citadel.mdl",
    },
    description = [[You are an heavy Droid!]],
    weapons = { "arccw_e5bx", "masita_sops_quadblaster", "arccw_sw_rocket_smartlauncher", "weapon_cloak", "realistic_hook" },
    command = "bxheavy",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Special Forces",
    PlayerSpawn = function(ply) ply:SetMaxHealth(2200) ply:SetHealth(2200) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 5
})

TEAM_BXCOMMANDERDROID = DarkRP.createJob("BX Commander Droid", {
    color = Color(204, 0, 0, 255),
    model = {
        "models/bx_captain/pm_droid_cis_bx_captain.mdl",
    },
    description = [[You are a BX Commander Droid!]],
    weapons = { "arccw_dual_e5",  "weapon_defibrillator", "realistic_hook", "tf_weapon_medigun", "weapon_cloak", "weapon_officerboost_laststand" },
    command = "bxcmdr",
    max = 0,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "CIS Special Forces",
    PlayerSpawn = function(ply) ply:SetMaxHealth(2000) ply:SetHealth(2000) ply:SetRunSpeed (240) ply:SetGravity(1)  end,
    sortOrder = 6
})




-- Umbaran Event Enemies



TEAM_UMBARANTROOPER = DarkRP.createJob("Umbaran Trooper", {

    color = Color(204, 0, 0, 255),

    model = {"models/player/icefusenetworks/ifnumbaran.mdl"},

    description = [[You are an Umbaran Trooper!]],

    weapons = {"arccw_umb1", "arccw_thermal_grenade","keypad_cracker"},

    command = "umbtrp",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Enemy",

    PlayerSpawn = function(ply) ply:SetMaxHealth(1800) ply:SetHealth(1800) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 9

})



TEAM_UMBARANHEAVYTROOPER = DarkRP.createJob("Umbaran Heavy Trooper", {

    color = Color(204, 0, 0, 255),

    model = {"models/player/icefusenetworks/ifnumbaran.mdl"},

    description = [[You are an Umbaran Heavy Trooper!]],

    weapons = {"arccw_umb1", "realistic_hook", "arccw_sw_rocket_smartlauncher","keypad_cracker"},

    command = "umbhvy",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Enemy",

    PlayerSpawn = function(ply) ply:SetMaxHealth(1600) ply:SetHealth(1600) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 10

})



TEAM_UMBARANSNIPER = DarkRP.createJob("Umbaran Sniper", {

    color = Color(204, 0, 0, 255),

    model = {"models/player/icefusenetworks/ifnumbaran.mdl"},

    description = [[You are an Sniper!]],

    weapons = {"arccw_umb1", "realistic_hook","keypad_cracker"},

    command = "umbsniper",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Enemy",

    PlayerSpawn = function(ply) ply:SetMaxHealth(1400) ply:SetHealth(1400) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 11

})



TEAM_UMBARANENGINEER = DarkRP.createJob("Umbaran Engineer", {

    color = Color(204, 0, 0, 255),

    model = {"models/player/icefusenetworks/ifnumbarangeneral.mdl"},

    description = [[You are an Umbaran Engineer!]],

    weapons = {"arccw_umb1", "realistic_hook", "weapon_physcannon", "alydus_fusioncutter", "weapon_squadshield", "alydus_fortificationbuildertablet","keypad_cracker"},

    command = "umbeng",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Enemy",

    PlayerSpawn = function(ply) ply:SetMaxHealth(1800) ply:SetHealth(1800) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 12

})



TEAM_UMBARANOFFICER = DarkRP.createJob("Umbaran Officer", {

    color = Color(204, 0, 0, 255),

    model = {"models/player/icefusenetworks/ifnumbaran.mdl","models/player/icefusenetworks/ifnumbarangeneral.mdl"},

    description = [[You are an Umbaran Officer!]],

    weapons = {"arccw_umb1", "realistic_hook", "weapon_bactainjector", "weapon_officerboost_laststand","keypad_cracker"},

    command = "umbofficer",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Enemy",

    PlayerSpawn = function(ply) ply:SetMaxHealth(2000) ply:SetHealth(2000) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 13

})



TEAM_PRISONER = DarkRP.createJob("Prisoner", {

    color = Color(204, 0, 0, 255),

    model = {"models/clone/pm_prisoner_clone.mdl","models/human1/pm_prisoner_human1.mdl","models/human2/pm_prisoner_human2.mdl","models/human3/pm_prisoner_human3.mdl","models/trandoshan/pm_prisoner_trandoshan.mdl","models/rodian/pm_prisoner_rodian.mdl","models/quarren/pm_prisoner_quarren.mdl","models/pantoran/pm_prisoner_pantoran.mdl","models/nautolan/pm_prisoner_nautolan.mdl","models/umbaran/pm_prisoner_umbaran.mdl"},

    description = [[You are an Prisoner!]],

    weapons = {"weapon_fists"},

    command = "prisoner",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Enemy",

    PlayerSpawn = function(ply) ply:SetMaxHealth(2000) ply:SetHealth(2000) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 14

})



TEAM_UNDEAD = DarkRP.createJob("Undead Clone", {

    color = Color(204, 0, 0, 255),

    model = {"models/dead_ct/dead_ct.mdl","models/dead_cmd/dead_cmd.mdl","models/dead_eng/dead_eng.mdl","models/dead_inf/dead_inf.mdl","models/dead_jet/dead_jet.mdl","models/dead_jugg/dead_jugg.mdl","models/dead_med/dead_med.mdl","models/dead_nav/dead_nav.mdl","models/dead_nav2/dead_nav2.mdl","models/dead_nohelm/dead_nohelm.mdl","models/dead_scuba/dead_scuba.mdl","models/dead_snow/dead_snow.mdl"},

    description = [[You are an Undead Clone!]],

    weapons = {"weapon_fists"},

    command = "undead",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Enemy",

    PlayerSpawn = function(ply) ply:SetMaxHealth(1200) ply:SetHealth(1200) ply:SetRunSpeed (200) ply:SetGravity(1)  end,

    sortOrder = 15

})



TEAM_GUARD = DarkRP.createJob("Republic Guard", {

    color = Color(0, 51, 255, 255),

    model = {"models/aussiwozzi/cgi/base/senate_trp.mdl","models/player/mandalorian/royal_guard_male.mdl","models/player/mandalorian/secret_service_male.mdl","models/herm/cgi_new/kamino_security/kamino_trooper.mdl"},

    description = [[You are an Republic Guard!]],

    weapons = {"sfw_cgelectrostaff","arccw_dc15a_v2","arccw_duals_dc17ext_v2"},

    command = "guard",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Enemy",

    PlayerSpawn = function(ply) ply:SetMaxHealth(1200) ply:SetHealth(1200) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 16

})



TEAM_CLONE = DarkRP.createJob("Clone", {

    color = Color(0, 51, 255, 255),

    model = {"models/aussiwozzi/cgi/base/unassigned_trp.mdl","models/aussiwozzi/cgi/base/unassigned_sgt.mdl","models/aussiwozzi/cgi/base/unassigned_lt.mdl","models/aussiwozzi/cgi/base/unassigned_cpt.mdl","models/aussiwozzi/cgi/base/unassigned_com.mdl","models/aussiwozzi/cgi/base/501st_trooper.mdl","models/aussiwozzi/cgi/base/212th_trooper.mdl","models/aussiwozzi/cgi/base/41st_trooper.mdl","models/aussiwozzi/cgi/base/CG_trooper.mdl","models/herm/cgi_new/21st/21st_trooper.mdl","models/aussiwozzi/cgi/base/104th_trooper.mdl","models/aussiwozzi/cgi/base/327th_trooper.mdl","models/herm/cgi_new/leviathan/leviathan_trooper1.mdl","models/herm/cgi_new/kamino_security/kamino_trooper.mdl","models/herm/cgi_new/442nd/442nd_trooper1.mdl","models/herm/cgi_new/91st/91st_trooper1.mdl","models/herm/cgi_new/doom_unit/du_trooper1.mdl","models/herm/cgi_new/jaguar/jaguar_trooper1.mdl","models/aussiwozzi/cgi/commando/clone_commando.mdl","models/naval_crew/pm_naval_crewman.mdl","models/naval_eng/pm_naval_eng.mdl"},

    description = [[You are an Event Clone!]],

    weapons = {"arccw_dc15s_v2","arccw_dc15a_v2","arccw_dc17_v2"},

    command = "eventclone",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Enemy",

    PlayerSpawn = function(ply) ply:SetMaxHealth(1000) ply:SetHealth(1000) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 17

})



-- Event Characters --



TEAM_CUSTOMENEMY = DarkRP.createJob("Event Character", {

    color = Color(204, 0, 0, 255),

    model = {"models/player/nsn/gunray.mdl", "models/pm_admiral_trench.mdl","models/player/nsn/wattambor.mdl","models/player/tiki/nm.mdl","models/player/nsn/poggle.mdl","models/player/dathomir/pm_nightsister_mothertalzin.mdl","models/player/valley/BobaFettYoungSuit.mdl","models/dw_garsaxon/pm_deathwatch_maul_garsaxon.mdl","models/dw_bokatan/pm_deathwatch_bokatan.mdl"},

    description = [[You are an Event Character!]],

    weapons = {"arccw_cis_se14"},

    command = "enemy",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Characters",

PlayerSpawn = function(ply) ply:SetMaxHealth(3000) ply:SetHealth(3000) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 0

})


TEAM_REPUBLICCHARACTER = DarkRP.createJob("Republic Character", {

    color = Color(0, 51, 255, 255),

    model = {"models/riddick/sr/palpatine/palpatine.mdl","models/jajoff/sps/republic/tc13j/tarkin.mdl","models/player/wullf/wullf.mdl","models/tfa/comm/gg/pm_sw_padme.mdl","models/player/mandalorian/dutchess_satine.mdl"},

    description = [[You are an Republic Event Character!]],

    weapons = {"arccw_dc17_v2"},

    command = "republicchar",

    max = 0,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Characters",

PlayerSpawn = function(ply) ply:SetMaxHealth(3000) ply:SetHealth(3000) ply:SetRunSpeed (240) ply:SetGravity(1)  end,

    sortOrder = 0

})



TEAM_COUNTDOOKU = DarkRP.createJob("Count Dooku", {

    color = Color(204, 0, 0, 255),

    model = {"models/tfa/comm/gg/pm_sw_dooku.mdl"},

    description = [[You are Count Dooku! Leader of the CIS.]],

    weapons = { "weapon_lightsaber_dooku"},

    command = "dooku",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Characters",

    PlayerSpawn = function(ply) ply:SetMaxHealth(6000) ply:SetHealth(6000) ply:SetRunSpeed (280) ply:SetGravity(1)  ply:setDarkRPVar("rpname", "Count Dooku") end,

    sortOrder = 1

})



TEAM_ASAJJVENTRESS = DarkRP.createJob("Asajj Ventress", {

    color = Color(204, 0, 0, 255),

    model = {"models/jellik/asajj/asajj.mdl","models/player/dathomir/pm_nightsister_ventress.mdl","models/church/ventress_season4.mdl"},

    description = [[You are Asajj Ventress! Assassin working for Count Dooku.]],

    weapons = { "weapon_lightsaber_ventress"},

    command = "asajj",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Characters",

    PlayerSpawn = function(ply) ply:SetMaxHealth(5000) ply:SetHealth(5000) ply:SetRunSpeed (280) ply:SetGravity(1) 
        local x = DarkRP.getChatCommand("forcerpname")
        print(type(x))
        print()
        x[1](nil, ply, "Asajj Ventress") end,

    sortOrder = 2

})



TEAM_DARTHMAUL = DarkRP.createJob("Darth Maul", {

    color = Color(204, 0, 0, 255),

    model = {"models/maul.mdl","models/tfa/comm/gg/pm_sw_cyberdarthmaul.mdl","models/jazzmcfly/jka/darth_maul/jka_maul.mdl"},

    description = [[You are Darth Maul.]],

    weapons = { "weapon_lightsaber_maul"},

    command = "maul",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Characters",

    PlayerSpawn = function(ply) ply:SetMaxHealth(5000) ply:SetHealth(5000) ply:SetRunSpeed (280) ply:SetGravity(1)  ply:setDarkRPVar("rpname", "Darth Maul") end,

    sortOrder = 3

})



TEAM_GENERALGRIEVOUS = DarkRP.createJob("General Grievous", {

    color = Color(204, 0, 0, 255),

    model = {"models/tfa/comm/gg/pm_sw_grievous.mdl","models/tfa/comm/gg/pm_sw_grievous_nocloak.mdl"},

    description = [[You are General Grievous! General of the CIS Droid Army]],

    weapons = { "weapon_lightsaber_grievous"},

    command = "grievous",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Characters",

    PlayerSpawn = function(ply) ply:SetMaxHealth(5000) ply:SetHealth(5000) ply:SetRunSpeed (320) ply:SetGravity(1)  ply:setDarkRPVar("rpname", "General Grievous") end,

    sortOrder = 4

})



TEAM_SAVAGEOPRESS = DarkRP.createJob("Savage Opress", {

    color = Color(204, 0, 0, 255),

    model = {"models/savage.mdl"},

    description = [[You are Savage Opress!]],

    weapons = { "weapon_lightsaber_opress"},

    command = "savage",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Characters",

    PlayerSpawn = function(ply) ply:SetMaxHealth(7000) ply:SetHealth(7000) ply:SetRunSpeed (300) ply:SetGravity(1)  ply:setDarkRPVar("rpname", "Savage Opress") end,

    sortOrder = 5

})



TEAM_PREVISZLA = DarkRP.createJob("Pre Viszla", {

    color = Color(204, 0, 0, 255),

    model = {"models/dw_previzsla/pm_deathwatch_previzsla.mdl"},

    description = [[You are Pre Viszla! Leader of the Death Watch]],

    weapons = { "weapon_lightsaber_viszla", "arccw_westar11", "weapon_jetpack", "arccw_dual_westar35"},

    command = "previszla",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Characters",

    PlayerSpawn = function(ply) ply:SetMaxHealth(5000) ply:SetHealth(5000) ply:SetRunSpeed (240) ply:SetGravity(1)  ply:setDarkRPVar("rpname", "Pre Viszla") end,

    sortOrder = 6

})



TEAM_CADBANE = DarkRP.createJob("Cad Bane", {

    color = Color(204, 0, 0, 255),

    model = {"models/grealms/characters/cadbane/cadbane.mdl"},

    description = [[You are Cad Bane! Bounty Hunter working against the Republic]],

    weapons = { "arccw_dual_westar34", "weapon_jetpack"},

    command = "cadbane",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Characters",

    PlayerSpawn = function(ply) ply:SetMaxHealth(5000) ply:SetHealth(5000) ply:SetRunSpeed (240) ply:SetGravity(1)  ply:setDarkRPVar("rpname", "Cad Bane") end,

    sortOrder = 7

})



TEAM_HONDO = DarkRP.createJob("Hondo Ohnaka", {

    color = Color(204, 0, 0, 255),

    model = {"models/player/ohanak_gang/pm_pirate_hondo.mdl"},

    description = [[You are Hondo Ohnaka! Leader of the pirates]],

    weapons = { "arccw_dl18", "sfw_magnastaff"},

    command = "hondo",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Characters",

    PlayerSpawn = function(ply) ply:SetMaxHealth(5000) ply:SetHealth(5000) ply:SetRunSpeed (240) ply:SetGravity(1)  ply:setDarkRPVar("rpname", "Hondo Ohnaka") end,

    sortOrder = 8

})



TEAM_BOSK = DarkRP.createJob("Bossk", {

    color = Color(204, 0, 0, 255),

    model = {"models/trando_bossk/pm_trando_bossk.mdl"},

    description = [[You are Bossk! Bounty Hunter]],

    weapons = { "arccw_relbyv10", "arccw_hunter_shotgun", "my_interceptor", "seal6-c4", "realistic_hook", "arccw_poison_grenade"},

    command = "bossk",

    max = 1,

    salary = 200,

    admin = 0,

    vote = false,

    candemote = false,

    hasLicense = false,

    category = "Event Characters",

PlayerSpawn = function(ply) ply:SetMaxHealth(5000) ply:SetHealth(5000) ply:SetRunSpeed(300) ply:SetJumpPower(420) ply:SetGravity(1)  ply:setDarkRPVar("rpname", "Bossk") end,

    sortOrder = 9

})


TEAM_DURGE = DarkRP.createJob("Durge", {
    color = Color(204, 0, 0, 255),
    model = {"models/player/garith/golden/durge.mdl"},
    description = [[You are Durge!]],
    weapons = {"masita_sops_quadblaster", "arccw_ee3", "arccw_dual_westar34", "weapon_cuff_elastic", "durge_knife"},
    command = "durge",
    max = 1,
    salary = 200,
    admin = 0,
    vote = false,
    candemote = false,
    hasLicense = false,
    category = "Event Characters",
    PlayerSpawn = function(ply) ply:SetMaxHealth(3000) ply:SetHealth(3000) ply:SetRunSpeed(240) ply:SetGravity(1) end,
    sortOrder = 10
})


--[[---------------------------------------------------------------------------

Define which team joining players spawn into and what team you change to if demoted

---------------------------------------------------------------------------]]

GAMEMODE.DefaultTeam = TEAM_CADET



--[[---------------------------------------------------------------------------

Define which teams belong to civil protection

Civil protection can set warrants, make people wanted and do some other police related things

---------------------------------------------------------------------------]]

GAMEMODE.CivilProtection = {

    [TEAM_GRANDADMIRAL] = true,

    [TEAM_FLEETADMIRAL] = true,

    [TEAM_FLEETMEMBERSNR] = true,

    [TEAM_FLEETMEMBER] = true,

    [TEAM_FLEETRECRUIT] = true,

    [TEAM_SUPREMEGENERAL] = true,

    [TEAM_CGCOMMANDER] = true,

    [TEAM_BATTALIONGENERAL] = true,

    [TEAM_ASSISTANTBATTALIONGENERAL] = true,

    [TEAM_CGEXECUTIVEOFFICER] = true,

    [TEAM_CGMJR] = true,

    [TEAM_CGLIEUTENANT] = true,

    [TEAM_CGSERGEANT] = true,

    [TEAM_CGHANDLER] = true,

    [TEAM_501STGENERAL] = true,

    [TEAM_212THGENERAL] = true,

    [TEAM_GREENGENERAL] = true,

    [TEAM_CGGENERAL] = true,

    [TEAM_GMGENERAL] = true,

   -- [TEAM_ARCGENERAL] = true,

    [TEAM_CEGENERAL] = true,

    [TEAM_RCGENERAL] = true,

    [TEAM_JEDIGENERALSHAAK] = true,

}

--[[---------------------------------------------------------------------------

Jobs that are hitmen (enables the hitman menu)

---------------------------------------------------------------------------]]

DarkRP.addHitmanTeam(TEAM_MOB)
