--[[---------------------------------------------------------------------------
DarkRP custom entities
---------------------------------------------------------------------------

This file contains your custom entities.
This file should also contain entities from DarkRP that you edited.

Note: If you want to edit a default DarkRP entity, first disable it in darkrp_config/disabled_defaults.lua
    Once you've done that, copy and paste the entity to this file and edit it.

The default entities can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua

For examples and explanation please visit this wiki page:
https://darkrp.miraheze.org/wiki/DarkRP:CustomEntityFields

Add entities under the following line:
---------------------------------------------------------------------------]]
DarkRP.createEntity("JumpPack", {
    ent = "jump_jet",
    model = "models/lt_c/sci_fi/am_container.mdl",
    price = 0,
    max = 1,
    cmd = "jump1",
    allowed = {TEAM_FLEET212THHOO, TEAM_212THARC, TEAM_ARCALPHA212th, TEAM_212THHEAVYTROOPER, TEAM_212THMEDOFFICER, TEAM_212THMEDTROOPER, TEAM_212THMCOMMANDER, TEAM_212THCOMMANDER, TEAM_212THEXECUTIVEOFFICER, TEAM_212THMAJOR, TEAM_212THGENERAL, TEAM_212THLIEUTENANT, TEAM_212THSERGEANT, TEAM_212THTROOPER, TEAM_212THOFFICER},
    category = "Entities",
})

DarkRP.createEntity("JumpPack Remover", {
    ent = "jump_jet_remover",
    model = "models/lordtrilobite/starwars/props/crate_yavin01_phys.mdl",
    price = 0,
    max = 1,
    cmd = "jump2",
    allowed = {TEAM_212THARC, TEAM_ARCALPHA212th, TEAM_212THHEAVYTROOPER, TEAM_212THMEDOFFICER, TEAM_212THMEDTROOPER, TEAM_212THMCOMMANDER, TEAM_212THCOMMANDER, TEAM_212THEXECUTIVEOFFICER, TEAM_212THMAJOR, TEAM_212THGENERAL, TEAM_212THLIEUTENANT, TEAM_212THSERGEANT, TEAM_212THTROOPER, TEAM_212THOFFICER},
    category = "Entities",
})

DarkRP.createEntity("Laser Turret", {
    ent = "lazer_cannon",
    model = "models/props_c17/SuitCase001a.mdl",
    price = 0,
    max = 1,
    cmd = "lasercannon",
    allowed = {TEAM_ENEMYENGINEER, TEAM_RCFIXER, TEAM_RCATIN, TEAM_RCTECH, TEAM_CETROOPER, TEAM_CESPECIALIST, TEAM_CECHIEF, TEAM_CEMCOMMANDER, TEAM_CECOMMANDER, TEAM_CELIEUTENANT, TEAM_CEEXECUTIVEOFFICER, TEAM_CEFAB, TEAM_CEARC, TEAM_ARCALPHACE, TEAM_CEMEDOFFICER, TEAM_CEMEDTROOPER, TEAM_CEMEDOFFICER, TEAM_CEMEDTROOPER, TEAM_501STGENERAL, TEAM_212THGENERAL, TEAM_GREENGENERAL, TEAM_CGGENERAL, TEAM_GMGENERAL, TEAM_ARCGENERAL, TEAM_CEGENERAL, TEAM_CRGENERAL, TEAM_RCGENERAL, TEAM_SUPREMEGENERAL, TEAM_BATTALIONGENERAL, TEAM_ASSISTANTBATTALIONGENERAL,TEAM_MEDICALGENERAL,TEAM_WPGENERAL},
    category = "Entities",
})

DarkRP.createEntity("Ammo Chargepack", {
    ent = "ammo_chargepack_riggs",
    model = "models/cs574/objects/ammo_box.mdl",
    price = 0,
    max = 1,
    cmd = "charge",
    allowed = {},
    category = "Entities",
})

DarkRP.createEntity("Fortification Resources", {
    ent = "joefort_ressource_100",
    model = "models/kingpommes/starwars/misc/imp_crate_single_closed.mdl",
    price = 0,
    max = 1,
    cmd = "ftr",
    allowed = {TEAM_CEGENERAL,TEAM_CEMCOMMANDER,TEAM_CECOMMANDER,TEAM_CEEXECUTIVEOFFICER,TEAM_CECHIEF,TEAM_CEFAB},
    category = "Entities",
})

DarkRP.createEntity("Keypad Battery", {
    ent = "bkeypads_repair",
    model = "models/Items/battery.mdl",
    price = 0,
    max = 2,
    cmd = "kpb",
    allowed = {TEAM_CEMECHANIC, TEAM_CECHIEF, TEAM_CEMCOMMANDER, TEAM_CECOMMANDER, TEAM_CELIEUTENANT,TEAM_JEDICOUNCIL, TEAM_CESPECIALIST, TEAM_CEEXECUTIVEOFFICER, TEAM_CETROOPER, TEAM_CEFAB, TEAM_RCTECH,TEAM_RCATIN, TEAM_JEDISENTINEL, TEAM_JEDICOUNCIL, TEAM_CEGENERAL, TEAM_RCFIXER, TEAM_CEARC, TEAM_ARCALPHACE, TEAM_CEMEDOFFICER, TEAM_CEMEDTROOPER, TEAM_CEMEDOFFICER, TEAM_CEMEDTROOPER, TEAM_JEDIGENERALAAYLA, TEAM_JEDISENGUARD, TEAM_G,TEAM_FLEET_DRD,TEAM_FLEET_RD},
    category = "Entities",
})

DarkRP.createEntity("Keypad Shield Trooper", {
    ent = "bkeypads_shield",
    model = "models/Items/battery.mdl",
    price = 0,
    max = 1,
    cmd = "kpst",
    allowed = {TEAM_CEMECHANIC, TEAM_CETROOPER, TEAM_RCTECH, TEAM_RCFIXER,TEAM_RCATIN},
    category = "Entities",
})

DarkRP.createEntity("Keypad Shield", {
    ent = "bkeypads_shield",
    model = "models/Items/battery.mdl",
    price = 0,
    max = 2,
    cmd = "kps",
    allowed = {TEAM_CEMECHANIC, TEAM_CECHIEF, TEAM_CEMCOMMANDER, TEAM_CECOMMANDER,TEAM_RCTECH, TEAM_JEDICOUNCIL, TEAM_CELIEUTENANT, TEAM_CESPECIALIST, TEAM_CEFAB, TEAM_CEEXECUTIVEOFFICER, TEAM_JEDISENTINEL, TEAM_CEGENERAL, TEAM_CEARC, TEAM_ARCALPHACE, TEAM_CEMEDOFFICER, TEAM_CEMEDTROOPER, TEAM_JEDIGENERALAAYLA, TEAM_JEDISENGUARD,TEAM_FLEET_DRD,TEAM_FLEET_RD},
    category = "Entities",
})

DarkRP.createEntity("Hacking Tools", {
    ent = "hack_enabler",
    model = "models/props_c17/BriefCase001a.mdl",
    price = 0,
    max = 1,
    cmd = "hackingtools",
    allowed = {TEAM_CECHIEF, TEAM_RCECHO, TEAM_CEMCOMMANDER, TEAM_CECOMMANDER, TEAM_CEMECHANIC, TEAM_RCTECH, TEAM_CELIEUTENANT, TEAM_CESPECIALIST, TEAM_CEEXECUTIVEOFFICER, TEAM_CETROOPER, TEAM_CEFAB, TEAM_RCTECH, TEAM_JEDISENTINEL, TEAM_JEDICOUNCIL, TEAM_CEGENERAL, TEAM_RCFIXER, TEAM_CEARC, TEAM_ARCALPHACE, TEAM_CEMEDOFFICER, TEAM_CEMEDTROOPER, TEAM_JEDIGENERALAAYLA, TEAM_JEDISENGUARD},
    category = "Entities",
})

DarkRP.createEntity("Repair Plug", {
    ent = "touch_pickup_repairkit_admin",
    model = "models/props_c17/tools_wrench01a.mdl",
    price = 0,
    max = 2,
    cmd = "repair",
    allowed = {TEAM_CEMECHANIC, TEAM_CETROOPER, TEAM_RCECHO, TEAM_CESPECIALIST,TEAM_RCTECH, TEAM_CECHIEF, TEAM_CEMCOMMANDER, TEAM_CECOMMANDER, TEAM_CELIEUTENANT, TEAM_CEEXECUTIVEOFFICER, TEAM_CEFAB, TEAM_JEDISENTINEL, TEAM_JEDICOUNCIL, TEAM_JEDIGENERALAAYLA, TEAM_RCFIXER, TEAM_RCTECH, TEAM_CEGENERAL, TEAM_RCFIXER, TEAM_CEARC, TEAM_ARCALPHACE, TEAM_CEMEDOFFICER, TEAM_CEMEDTROOPER, TEAM_JEDISENGUARD,TEAM_FLEET_DRD,TEAM_FLEET_RD},
    category = "Entities",
})

DarkRP.createEntity("Light Armour Pack", {
    ent = "touch_pickup_752_medpack2",
    model = "models/starwars/items/shield.mdl",
    price = 0,
    max = 2,
    cmd = "lap",
allowed = {TEAM_GMMEDTROOPER,TEAM_VALTRP},
category = "Entities",
})

DarkRP.createEntity("Armour Pack", {
    ent = "50ap_witt",
    model = "models/starwars/items/shield_large.mdl",
    price = 0,
    max = 2,
    cmd = "ap",
    allowed = {TEAM_GMMEDOFFICER,TEAM_CGMEDOFFICER,TEAM_CGMEDTROOPER,TEAM_VALL },
    category = "Entities",
})

DarkRP.createEntity("Heavy Armour Pack", {
    ent = "100AP_CD",
    model = "models/starwars/items/shield_large.mdl",
    price = 0,
    max = 1,
    cmd = "hap",
    allowed = {TEAM_MARLEAD,TEAM_MARTRP },
    category = "Entities",
})

DarkRP.createEntity("Medium Bacta Tank", {
    ent = "50hp_bacta_witt",
    model = "models/starwars/items/bacta_small.mdl",
    price = 0,
    max = 2,
    cmd = "mbt",
    allowed = {TEAM_RCDIKUT, TEAM_RCECHO},
    category = "Entities",
})

--[[ DarkRP.createEntity("T-42 Fighter", {
    ent = "lunasflightschool_t42",
    model = "models/sfp_t42/sfp_t42.mdl",
    price = 0,
    max = 1,
    cmd = "t42",
    allowed = {TEAM_501STGENERAL, TEAM_212THGENERAL, TEAM_GREENGENERAL, TEAM_CGGENERAL, TEAM_GMGENERAL, TEAM_ARCGENERAL, TEAM_CEGENERAL, TEAM_CRGENERAL, TEAM_RCGENERAL, TEAM_SUPREMEGENERAL, TEAM_BATTALIONGENERAL, TEAM_ASSISTANTBATTALIONGENERAL, TEAM_CEGENERAL, TEAM_MEDICALGENERAL,TEAM_WPGENERAL},
    category = "Entities",
})

DarkRP.createEntity("Alligator Fighter", {
    ent = "lunasflightschool_alligator",
    model = "models/sweaw/ships/rep_alligator_servius.mdl",
    price = 0,
    max = 1,
    cmd = "alligator",
    allowed = {},
    category = "Entities",
}) ]]--

DarkRP.createEntity("V Wing", {
    ent = "lvs_starfighter_vwing",
    model = "models/blu/vwing.mdl",
    price = 0,
    max = 1,
    cmd = "vwing",
    allowed = {TEAM_SIMPILOT},
    category = "Entities",
})


DarkRP.createEntity("Hilt Chance", {
    ent = "hiltchance",
    model = "models/items/ammocrate_rockets.mdl",
    price = 0,
    max = 1,
    cmd = "hiltchan",
    allowed = {TEAM_JEDIGRANDMASTER, TEAM_JEDIGENERALTANO, TEAM_JEDIGENERALTIPLAR, TEAM_JEDIGENERALTIPLEE, TEAM_JEDIGENERALSKYWALKER, TEAM_JEDIGENERALOBI, TEAM_JEDIGENERALSHAAK, TEAM_JEDIGENERALLUMINARA, TEAM_JEDIGENERALAAYLA, TEAM_JEDIGENERALKIT, TEAM_JEDIGENERALPLO, TEAM_JEDIGENERALADI, TEAM_JEDIGENERALWINDU, TEAM_JEDIGENERALAAYLA, TEAM_SOD, TEAM_JEDIGENERALVOS},
    category = "Entities",
})

DarkRP.createEntity("XP Holocron", {
    ent = "xpholocron",
    model = "models/kingpommes/starwars/misc/jedi/jedi_holocron_2.mdl",
    price = 0,
    max = 1,
    cmd = "xphol",
    allowed = {TEAM_JEDIGRANDMASTER, TEAM_JEDIGENERALTANO, TEAM_JEDIGENERALSKYWALKER, TEAM_JEDIGENERALOBI, TEAM_JEDIGENERALSHAAK, TEAM_JEDIGENERALAAYLA, TEAM_JEDIGENERALKIT, TEAM_JEDIGENERALPLO, TEAM_JEDIGENERALLUMINARA, TEAM_JEDIGENERALADI, TEAM_JEDIGENERALWINDU, TEAM_JEDIGENERALAAYLA, TEAM_JEDIGENERALVOS,TEAM_JEDICOUNCIL,TEAM_JEDIGURDCHIEF},
    category = "Entities",
})

DarkRP.createEntity("XP Holocron 2", {
    ent = "extraxpholocron",
    model = "models/kingpommes/starwars/misc/jedi/jedi_holocron_2.mdl",
    price = 0,
    max = 1,
    cmd = "xxphol",
    allowed = {TEAM_JEDIGRANDMASTER, TEAM_JEDIGENERALTANO, TEAM_JEDIGENERALSKYWALKER, TEAM_JEDIGENERALOBI, TEAM_JEDIGENERALSHAAK, TEAM_JEDIGENERALLUMINARA, TEAM_JEDIGENERALAAYLA, TEAM_JEDIGENERALKIT, TEAM_JEDIGENERALPLO, TEAM_JEDIGENERALADI, TEAM_JEDIGENERALWINDU, TEAM_JEDIGENERALAAYLA, TEAM_JEDIGENERALVOS,TEAM_JEDICOUNCIL,TEAM_JEDIGURDCHIEF},
    category = "Entities",
})




DarkRP.createEntity("Multi Visor", {
    ent = "multi_visor",
    model = "models/starwars/items/medpack.mdl",
    price = 0,
    max = 1,
    cmd = "multivisor",
    allowed = {},
    category = "Entities",
})

DarkRP.createEntity("Multi Visor Remover", {
    ent = "multi_visor_remover",
    model = "models/starwars/items/medpack.mdl",
    price = 0,
    max = 1,
    cmd = "mvremove",
    allowed = {},
    category = "Entities",
})

DarkRP.createEntity("Bacta Tank", {
    ent = "100hp_bacta_vale",
    model = "models/starwars/items/bacta_large.mdl",
    price = 0,
    max = 2,
    cmd = "bactatank",
    allowed = {TEAM_RCVALE, TEAM_RCSARGE},
    category = "Entities",
})


DarkRP.createEntity("NBT-630", {
    ent = "lvs_starfighter_nbt630",
    model = "models/nbt630/rep_ntb630_servius.mdl",
    price = 0,
    max = 1,
    cmd = "nbt",
    allowed = {TEAM_SIMRBOMBER},
    category = "Entities",
})

DarkRP.createEntity("W-Wing", {
    ent = "lvs_starfighter_wwing",
    model = "models/wwing/rep_w-wing.mdl",
    price = 0,
    max = 1,
    cmd = "wwing",
    allowed = {TEAM_SIMPILOT},
    category = "Entities",
})


DarkRP.createEntity("ARC-170", {
    ent = "lvs_starfighter_arc170",
    model = "models/blu/arc170.mdl",
    price = 0,
    max = 1,
    cmd = "arc170",
    allowed = {TEAM_SIMPILOT},
    category = "Entities",
})

DarkRP.createEntity("V-19 Torrent Starfighter", {
    ent = "lvs_v19",
    model = "models/diggerthings/v19/4.mdl",
    price = 0,
    max = 1,
    cmd = "v19tor",
    allowed = {TEAM_SIMPILOT},
    category = "Entities",
})


DarkRP.createEntity("Spy Drone", {
    ent = "drone_sentity",
    model = "models/Gibs/helicopter_brokenpiece_06_body.mdl",
    price = 0,
    max = 1,
    cmd = "spydrone",
    allowed = {TEAM_FLEETDOFFICER,TEAM_CDGENERAL,TEAM_FLEET_RD,TEAM_FLEET_DRD, TEAM_RCECHO, TEAM_501STGENERAL, TEAM_212THGENERAL, TEAM_GREENGENERAL, TEAM_CGGENERAL, TEAM_GMGENERAL, TEAM_ARCGENERAL, TEAM_CEGENERAL, TEAM_CRGENERAL, TEAM_RCGENERAL, TEAM_CEMCOMMANDER, TEAM_CECOMMANDER, TEAM_JEDISENTINEL, TEAM_JEDICOUNCIL, TEAM_CECHIEF, TEAM_CEEXECUTIVEOFFICER, TEAM_GRANDADMIRAL, TEAM_FLEETADMIRAL, TEAM_FLEETCPT, TEAM_FLEETCMDR, TEAM_FLEETLTCMDR, TEAM_FLEETLT, TEAM_FLEETOFFICER, TEAM_FLEETENSIGN, TEAM_BATTALIONGENERAL, TEAM_ASSISTANTBATTALIONGENERAL, TEAM_SUPREMEGENERAL, TEAM_JEDIGENERALAAYLA, TEAM_FLEETDR, TEAM_CEGENERAL, TEAM_FLEETWARFARE, TEAM_FLEETCOM, TEAM_FLEETRECRUIT, TEAM_RCFIXER, TEAM_RCTECH, TEAM_501STOFFICER, TEAM_212THOFFICER, TEAM_GREENOFFICER, TEAM_GMOFFICER, TEAM_ARCOFFICER,TEAM_MEDICALGENERAL,TEAM_WPGENERAL,TEAM_JEDISENGUARD,TEAM_FLEET_COI,TEAM_FLEET_IO},
    category = "Entities"
})

DarkRP.createEntity("Spy Drone OD", {
    ent = "drone_sentityod",
    model = "models/Gibs/helicopter_brokenpiece_06_body.mdl",
    price = 0,
    max = 1,
    cmd = "spydroneod",
    allowed = {TEAM_FLEETDOFFICER,TEAM_CDGENERAL,TEAM_FLEET_RD,TEAM_FLEET_DRD,TEAM_GRANDADMIRAL, TEAM_FLEETADMIRAL, TEAM_FLEETCPT, TEAM_FLEETCMDR, TEAM_FLEETLTCMDR, TEAM_FLEETLT, TEAM_FLEETOFFICER, TEAM_FLEETENSIGN,TEAM_FLEETDR, TEAM_CEGENERAL, TEAM_FLEETWARFARE, TEAM_FLEETCOM, TEAM_FLEETRECRUIT,TEAM_FLEET_COI,TEAM_FLEET_IO},
    category = "Entities"
})

DarkRP.createEntity("Nano Drone", {
    ent = "drone_nentity",
    model = "models/Gibs/helicopter_brokenpiece_06_body.mdl",
    price = 0,
    max = 1,
    cmd = "nano",
    allowed = {TEAM_RCADVISOR,TEAM_CDGENERAL, TEAM_JEDISENTINEL, TEAM_501STGENERAL,TEAM_RCECHO, TEAM_212THGENERAL, TEAM_GREENGENERAL, TEAM_CGGENERAL, TEAM_GMGENERAL, TEAM_ARCGENERAL, TEAM_CEGENERAL, TEAM_CRGENERAL, TEAM_RCGENERAL, TEAM_GRANDADMIRAL, TEAM_FLEETENSIGN, TEAM_FLEETOFFICER, TEAM_BATTALIONGENERAL, TEAM_ASSISTANTBATTALIONGENERAL, TEAM_FLEETLT, TEAM_FLEETLTCMDR, TEAM_FLEETCMDR, TEAM_FLEETCPT, TEAM_FLEETADMIRAL, TEAM_FLEETHSO, TEAM_FLEETMO, TEAM_FLEETDR, TEAM_CETROOPER, TEAM_CECHIEF, TEAM_CEEXECUTIVEOFFICER, TEAM_CEMCOMMANDER, TEAM_CECOMMANDER, TEAM_CELIEUTENANT, TEAM_CESPECIALIST, TEAM_CEFAB, TEAM_ARCALPHACE, TEAM_CEARC, TEAM_CEMECHANIC, TEAM_CEGENERAL, TEAM_FLEETCOM, TEAM_FLEETWARFARE, TEAM_ARCMC, TEAM_ARCCOLT, TEAM_ARCHAVOC, TEAM_CEMEDOFFICER, TEAM_CEMEDTROOPER, TEAM_FLEETRECRUIT, TEAM_RCFIXER, TEAM_RCTECH, TEAM_501STOFFICER, TEAM_212THOFFICER, TEAM_GREENOFFICER, TEAM_GMOFFICER, TEAM_ARCOFFICER, TEAM_MEDICALGENERAL,TEAM_WPGENERAL,TEAM_JEDICOUNCIL,TEAM_JEDIGENERALAAYLA,TEAM_JEDISENGUARD,TEAM_FLEET_DRD,TEAM_FLEET_RD},
    category = "Entities",
})

DarkRP.createEntity("Nano Drone OD", {
    ent = "drone_nentityod",
    model = "models/Gibs/helicopter_brokenpiece_06_body.mdl",
    price = 0,
    max = 1,
    cmd = "nanodroneod",
    allowed = {TEAM_FLEETDOFFICER,TEAM_CDGENERAL,TEAM_FLEET_RD,TEAM_FLEET_DRD,TEAM_GRANDADMIRAL, TEAM_FLEETADMIRAL, TEAM_FLEETCPT, TEAM_FLEETCMDR, TEAM_FLEETLTCMDR, TEAM_FLEETLT, TEAM_FLEETOFFICER, TEAM_FLEETENSIGN,TEAM_FLEETDR, TEAM_CEGENERAL, TEAM_FLEETWARFARE, TEAM_FLEETCOM, TEAM_FLEETRECRUIT,TEAM_FLEET_COI,TEAM_FLEET_IO},
    category = "Entities"
})

DarkRP.createEntity("Laser Drone", {
    ent = "drone_lentity",
    model = "models/Gibs/helicopter_brokenpiece_06_body.mdl",
    price = 0,
    max = 1,
    cmd = "laserdrone",
    allowed = {TEAM_501STGENERAL, TEAM_212THGENERAL, TEAM_GREENGENERAL,TEAM_RCECHO, TEAM_CGGENERAL, TEAM_GMGENERAL, TEAM_ARCGENERAL, TEAM_CEGENERAL, TEAM_CRGENERAL, TEAM_RCGENERAL, TEAM_CESPECIALIST, TEAM_CEMECHANIC, TEAM_ARCALPHACE, TEAM_CEARC, TEAM_CELIEUTENANT, TEAM_CEMCOMMANDER, TEAM_CECOMMANDER, TEAM_CECHIEF, TEAM_CEEXECUTIVEOFFICER, TEAM_GRANDADMIRAL, TEAM_FLEETADMIRAL, TEAM_FLEETMEMBERSNR, TEAM_FLEETMEMBER, TEAM_FLEETCPT, TEAM_FLEETCMDR, TEAM_FLEETLTCMDR, TEAM_FLEETLT, TEAM_FLEETOFFICER, TEAM_FLEETENSIGN, TEAM_CESPECIALIST, TEAM_BATTALIONGENERAL, TEAM_ASSISTANTBATTALIONGENERAL, TEAM_SUPREMEGENERAL, TEAM_FLEETDR, TEAM_CEENERAL, TEAM_FLEETCOM, TEAM_FLEETWARFARE, TEAM_JEDISENTINEL, TEAM_JEDICOUNCIL, TEAM_MEDICALGENERAL,TEAM_WPGENERAL,TEAM_JEDISENGUARD,TEAM_FLEET_DRD,TEAM_FLEET_RD},
    category = "Entities",
})

DarkRP.createEntity("Repair Drone", {
    ent = "drone_rentity",
    model = "models/Gibs/helicopter_brokenpiece_06_body.mdl",
    price = 0,
    max = 1,
    cmd = "repairdrone",
    allowed = {TEAM_JEDISENTINEL,TEAM_CDGENERAL, TEAM_JEDICOUNCIL, TEAM_CELIEUTENANT, TEAM_CECHIEF, TEAM_CESPECIALIST, TEAM_CEEXECUTIVEOFFICER, TEAM_CEMCOMMANDER, TEAM_CECOMMANDER, TEAM_CEFAB, TEAM_ARCALPHACE, TEAM_CEARC, TEAM_CEMECHANIC, TEAM_CETROOPER, TEAM_CEGENERAL, TEAM_CEMEDOFFICER, TEAM_CEMEDTROOPER,TEAM_JEDISENGUARD},
    category = "Entities"
})

DarkRP.createEntity("Armoured Drone", {
    ent = "drone_aentity",
    model = "models/Gibs/helicopter_brokenpiece_06_body.mdl",
    price = 0,
    max = 1,
    cmd = "armoureddrone",
    allowed = {TEAM_CEMECHANIC, TEAM_CEEXECUTIVEOFFICER, TEAM_CEMCOMMANDER, TEAM_CECOMMANDER, TEAM_CEGENERAL,TEAM_CECHIEF},
    category = "Entities"
})

DarkRP.createEntity("Double Minigun Drone", {
    ent = "drone_dentity",
    model = "models/Gibs/helicopter_brokenpiece_06_body.mdl",
    price = 0,
    max = 1,
    cmd = "dminigundrone",
    allowed = {TEAM_CEEXECUTIVEOFFICER, TEAM_CEMCOMMANDER, TEAM_CECOMMANDER,TEAM_RCECHO, TEAM_CEGENERAL,TEAM_CECHIEF, TEAM_CEMECHANIC},
    category = "Entities"
})

DarkRP.createEntity("Minigun Drone", {
    ent = "drone_entity",
    model = "models/Gibs/helicopter_brokenpiece_06_body.mdl",
    price = 0,
    max = 1,
    cmd = "minigundrone",
    allowed = {TEAM_CEMECHANIC, TEAM_CELIEUTENANT, TEAM_CECHIEF, TEAM_CEEXECUTIVEOFFICER, TEAM_CEMCOMMANDER, TEAM_CECOMMANDER, TEAM_CEGENERAL,TEAM_FLEET_DRD,TEAM_FLEET_RD},
    category = "Entities"
})

DarkRP.createEntity("LAAT Transport", {
    ent = "lfs_fb_laatitransport",
    model = "models/fisher/laat/laatspace.mdl",
    price = 0,
    max = 1,
    cmd = "laattp",
    allowed = {TEAM_SIMPILOT},
    category = "Entities",
})

DarkRP.createEntity("Muunilinst LAAT", {
    ent = "lfs_fb_laatigunship_muunilinst",
    model = "models/fisher/laat/laatspace.mdl",
    price = 0,
    max = 1,
    cmd = "mlaat",
    allowed = {TEAM_SIMRBOMBER},
    category = "Entities",
})

--[[DarkRP.createEntity("AT-SW", {
    ent = "lunasflightschool_hosti_sentinel",
    model = "models/hosti/wh40k/ig/veh/sentinel.mdl",
    price = 0,
    max = 1,
    cmd = "327thwalker",
    allowed = {TEAM_CEFAB,TEAM_CEEXECUTIVEOFFICER,TEAM_CECOMMANDER,TEAM_CEGENERAL,TEAM_CECHIEF},
    category = "Entities",
})


DarkRP.createEntity("Vulture Droid", {
    ent = "lunasflightschool_vulturedroid",
    model = "models/salza/vulture_droid.mdl",
    price = 0,
    max = 1,
    cmd = "vulture",
    allowed = {TEAM_B1PILOT,TEAM_CISSIMPILOT},
    category = "Entities",
})

DarkRP.createEntity("Tri Fighter Droid", {
    ent = "lunasflightschool_tridroid",
    model = "models/salza/droidtrifighter.mdl",
    price = 0,
    max = 1,
    cmd = "tridroid",
    allowed = {TEAM_B1PILOT,TEAM_CISSIMPILOT},
    category = "Entities",
})

DarkRP.createEntity("Bomber Droid", {
    ent = "lunasflightschool_advdroid",
    model = "models/sfp_droidbomber/sfp_droidbomber.mdl",
    price = 0,
    max = 1,
    cmd = "bombdroid",
    allowed = {TEAM_B1PILOT, TEAM_CISSIMBOM},
    category = "Entities",
})

DarkRP.createEntity("Droid Gunship", {
    ent = "lunasflightschool_droidgunship",
    model = "models/megarexcis/gunship.mdl",
    price = 0,
    max = 1,
    cmd = "hmpgunship",
    allowed = {TEAM_B1PILOT,TEAM_CISSIMPILOT, TEAM_CISSIMBOM },
    category = "Entities",
})

DarkRP.createEntity("Pirate Ship", {
    ent = "lunasflightschool_havoc",
    model = "models/sweaw/ships/rep_havoc.mdl",
    price = 0,
    max = 1,
    cmd = "pirateship",
    allowed = {TEAM_B1PILOT, TEAM_CISSIMBOM},
    category = "Entities",
})

DarkRP.createEntity("Patrol Ship", {
    ent = "lunasflightschool_spiral",
    model = "models/sweaw/ships/rep_sharpspiral_servius.mdl",
    price = 0,
    max = 1,
    cmd = "patrolship",
    allowed = {TEAM_B1PILOT},
    category = "Entities",
})

DarkRP.createEntity("Vulture Droid CIS", {
    ent = "lunasflightschool_vulturedroid_cis",
    model = "models/blu/vulturedroid.mdl",
    price = 0,
    max = 1,
    cmd = "cisvulture",
    allowed = {TEAM_B1PILOT},
    category = "Entities",
})

DarkRP.createEntity("Mandalorian Gauntlet", {
    ent = "lfs_gauntlet",
    model = "models/sfp_gauntlet/sfp_gauntlet.mdl",
    price = 0,
    max = 1,
    cmd = "gauntlet",
    allowed = {TEAM_B1PILOT, TEAM_CISSIMBOM},
    category = "Entities",
})

--[[ DarkRP.createEntity("LAAT/c", {
    ent = "lunasflightschool_laatcgunship",
    model = "models/blu/laat_c.mdl",
    price = 0,
    max = 1,
    cmd = "laatc",
    allowed = {TEAM_CECOMMANDER, TEAM_CECHIEF, TEAM_CEEXECUTIVEOFFICER, TEAM_CEMECHANIC, TEAM_JEDISENTINEL, TEAM_JEDICOUNCIL, TEAM_JEDIGENERALAAYLA, TEAM_CEGENERAL, TEAM_FLEETEO, TEAM_SIMPILOT, TEAM_CELIEUTENANT, TEAM_CESPECIALIST},
    category = "Entities",
}) --]]


DarkRP.createEntity("Juggernaut Armour", {
    ent = "power_armor",
    model = "models/moxfort/501st-juggernaut.mdl",
    price = 0,
    max = 1,
    cmd = "jugger",
    allowed = {TEAM_501STJUGGERNAUT, TEAM_501STMCOMMANDER, TEAM_501STCOMMANDER, TEAM_501STEXECUTIVEOFFICER, TEAM_501STMAJOR, TEAM_501STGENERAL},
    category = "Entities",
    --customCheck = function(ply) return ply:GivenPowerArmor() end,
    --CustomCheckFailMsg = function(ply, entTable) return "You can only deploy 1 Juggernaut Armour" end,
})

DarkRP.createEntity("Juggernaut Armour Remover", {
    ent = "power_armor_remover",
    model = "models/moxfort/501st-juggernaut.mdl",
    price = 0,
    max = 1,
    cmd = "juggerremove",
    allowed = {TEAM_501STJUGGERNAUT, TEAM_501STMCOMMANDER, TEAM_501STCOMMANDER, TEAM_501STEXECUTIVEOFFICER, TEAM_501STMAJOR, TEAM_501STGENERAL},
    category = "Entities",
})






DarkRP.createEntity("Infrared Visor", {
    ent = "avp_mask",
    model = "models/props/starwars/weapons/repairkit.mdl",
    price = 0,
    max = 1,
    cmd = "inf",
    allowed = {},
    category = "Entities",
})

--[[ DarkRP.createEntity("Eta-2", {
    ent = "obi-wan_eta",
    model = "models/deno/jedi/jedieta.mdl",
    price = 0,
    max = 1,
    cmd = "eta2",
    allowed = {},
    category = "Entities",
})

DarkRP.createEntity("Guardian Eta-2", {
    ent = "aayla_eta",
    model = "models/deno/jedi/jedieta.mdl",
    price = 0,
    max = 1,
    cmd = "guardeta2",
    allowed = {TEAM_JEDIGUARDIAN},
    category = "Entities",
})

DarkRP.createEntity("Sentinel ETA-2", {
    ent = "anakin_eta",
    model = "models/deno/jedi/jedieta.mdl",
    price = 0,
    max = 1,
    cmd = "seneta2",
    allowed = {TEAM_JEDISENTINEL},
    category = "Entities",
})

DarkRP.createEntity("Consular Eta-2", {
    ent = "jedi_eta",
    model = "models/deno/jedi/jedieta.mdl",
    price = 0,
    max = 1,
    cmd = "conseta2",
    allowed = {TEAM_JEDICONSULAR,TEAM_SIMPILOT},
    category = "Entities",
})

DarkRP.createEntity("Eta-2", {
    ent = "windu_eta",
    model = "models/deno/jedi/jedieta.mdl",
    price = 0,
    max = 1,
    cmd = "cmeta2",
    allowed = {TEAM_JEDICOUNCIL, TEAM_JEDIGENERALTANO, TEAM_JEDIGENERALSKYWALKER, TEAM_JEDIGENERALOBI, TEAM_JEDIGENERALSHAAK, TEAM_JEDIGENERALLUMINARA, TEAM_JEDIGENERALAAYLA, TEAM_JEDIGENERALKIT, TEAM_JEDIGENERALPLO, TEAM_JEDIGENERALADI, TEAM_JEDIGENERALWINDU, TEAM_JEDIGENERALAAYLA, TEAM_JEDIGENERALVOS},
    category = "Entities",
})

DarkRP.createEntity("Tano ETA-2", {
    ent = "ahsoka_eta",
    model = "models/deno/jedi/jedieta.mdl",
    price = 0,
    max = 1,
    cmd = "tanoeta2",
    allowed = {TEAM_JEDIGENERALTANO},
    category = "Entities",
})

DarkRP.createEntity("Yoda's ETA", {
    ent = "yodaeta",
    model = "models/starwars/syphadias/ships/yoda_starfighter/yoda_starfighter_closed.mdl",
    price = 0,
    max = 1,
    cmd = "yodaeta",
    allowed = {TEAM_JEDIGRANDMASTER},
    category = "Entities",
}) ]]--

DarkRP.createEntity("Yoda's Chair", {
    ent = "lvs_hoverchair",
    model = "models/unconid/yoda_hoverchair/yoda_hoverchair.mdl",
    price = 0,
    max = 1,
    cmd = "yodachair",
    allowed = {TEAM_JEDIGRANDMASTER},
    category = "Entities",
})

DarkRP.createEntity("Knight Hilt Blueprint", {
    ent = "knightprint",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "knighthilt",
    allowed = {TEAM_JEDICOUNCIL,  TEAM_JEDIGENERALADI, TEAM_JEDIGENERALSHAAK, TEAM_JEDIGENERALAAYLA, TEAM_JEDIGENERALKIT, TEAM_JEDIGENERALPLO, TEAM_JEDIGENERALTANO, TEAM_JEDIGENERALWINDU, TEAM_JEDIGENERALOBI, TEAM_JEDIGENERALSKYWALKER, TEAM_JEDIGRANDMASTER, TEAM_JEDIGENERALVOS,TEAM_JEDIGURDCHIEF},
    category = "Entities",
})

DarkRP.createEntity("Aayla Secura Prep", {
    ent = "aaylahilt",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "aaylaprep",
    allowed = {TEAM_JEDIGRANDMASTER},
    category = "Entities",
})

DarkRP.createEntity("Ahsoka Tano Prep", {
    ent = "tanohilt",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "tanoprep",
    allowed = {TEAM_JEDIGRANDMASTER},
    category = "Entities",
})

DarkRP.createEntity("Ki Adi Mundi Prep", {
    ent = "mundihilt",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "mundiprep",
    allowed = {TEAM_JEDIGRANDMASTER},
    category = "Entities",
})

DarkRP.createEntity("Kit Fisto Prep", {
    ent = "kitfistohilt",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "fistoprep",
    allowed = {TEAM_JEDIGRANDMASTER},
    category = "Entities",
})

DarkRP.createEntity("Mace Windu Prep", {
    ent = "macehilt",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "maceprep",
    allowed = {TEAM_JEDIGRANDMASTER},
    category = "Entities",
})

DarkRP.createEntity("Obi Wan Prep", {
    ent = "kenobihilt",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "kenobiprep",
    allowed = {TEAM_JEDIGRANDMASTER},
    category = "Entities",
})

DarkRP.createEntity("Plo Koon Prep", {
    ent = "koonhilt",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "koonprep",
    allowed = {TEAM_JEDIGRANDMASTER},
    category = "Entities",
})

DarkRP.createEntity("Shaak Ti Prep", {
    ent = "shaakhilt",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "shaakprep",
    allowed = {TEAM_JEDIGRANDMASTER},
    category = "Entities",
})

DarkRP.createEntity("Skywalker Prep", {
    ent = "skywalkerhilt",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "skywalkerprep",
    allowed = {TEAM_JEDIGRANDMASTER},
    category = "Entities",
})

DarkRP.createEntity("Luminara Prep", {
    ent = "luminarahilt",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "luminaraprep",
    allowed = {TEAM_JEDIGRANDMASTER},
    category = "Entities",
})

DarkRP.createEntity("Yoda Prep", {
    ent = "yodahilt",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "yodaprep",
    allowed = {TEAM_JEDIGRANDMASTER},
    category = "Entities",
})

DarkRP.createEntity("PREV PLAYERS ONLY", {
    ent = "knighthilt",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "knightprep",
    allowed = {TEAM_JEDIGENERALADI, TEAM_JEDIGENERALSHAAK, TEAM_JEDIGENERALLUMINARA, TEAM_JEDIGENERALAAYLA, TEAM_JEDIGENERALKIT, TEAM_JEDIGENERALPLO, TEAM_JEDIGENERALTANO, TEAM_JEDIGENERALWINDU, TEAM_JEDIGENERALOBI, TEAM_JEDIGENERALSKYWALKER, TEAM_JEDIGRANDMASTER, TEAM_JEDIGENERALVOS},
    category = "Entities",
})

DarkRP.createEntity("Consular Prep", {
    ent = "consularspec",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "consularspec",
    allowed = {TEAM_JEDIGENERALADI, TEAM_JEDIGENERALSHAAK, TEAM_JEDIGENERALLUMINARA, TEAM_JEDIGENERALAAYLA, TEAM_JEDIGENERALKIT, TEAM_JEDIGENERALPLO, TEAM_JEDIGENERALTANO, TEAM_JEDIGENERALWINDU, TEAM_JEDIGENERALOBI, TEAM_JEDIGENERALSKYWALKER, TEAM_JEDIGRANDMASTER, TEAM_JEDIGENERALVOS, TEAM_JEDICOUNCIL,TEAM_JEDIGURDCHIEF},
    category = "Entities",
})

DarkRP.createEntity("Sentinel Prep", {
    ent = "sentinelspec",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "sentinelspec",
    allowed = {TEAM_JEDIGENERALADI, TEAM_JEDIGENERALSHAAK, TEAM_JEDIGENERALLUMINARA, TEAM_JEDIGENERALAAYLA, TEAM_JEDIGENERALKIT, TEAM_JEDIGENERALPLO, TEAM_JEDIGENERALTANO, TEAM_JEDIGENERALWINDU, TEAM_JEDIGENERALOBI, TEAM_JEDIGENERALSKYWALKER, TEAM_JEDIGRANDMASTER, TEAM_JEDIGENERALVOS, TEAM_JEDICOUNCIL, TEAM_JEDIGURDCHIEF},
    category = "Entities",
})

DarkRP.createEntity("Guardian Prep", {
    ent = "guardianspec",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "guardianspec",
    allowed = {TEAM_JEDIGENERALADI, TEAM_JEDIGENERALSHAAK, TEAM_JEDIGENERALLUMINARA, TEAM_JEDIGENERALAAYLA, TEAM_JEDIGENERALKIT, TEAM_JEDIGENERALPLO, TEAM_JEDIGENERALTANO, TEAM_JEDIGENERALWINDU, TEAM_JEDIGENERALOBI, TEAM_JEDIGENERALSKYWALKER, TEAM_JEDIGRANDMASTER, TEAM_JEDIGENERALVOS, TEAM_JEDICOUNCIL, TEAM_JEDIGURDCHIEF},
    category = "Entities",
})

DarkRP.createEntity("Temple Guard Prep", {
    ent = "templegaurd",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "guardprep",
    allowed = {TEAM_JEDIGENERALADI, TEAM_JEDIGENERALSHAAK, TEAM_JEDIGENERALLUMINARA, TEAM_JEDIGENERALAAYLA, TEAM_JEDIGENERALKIT, TEAM_JEDIGENERALPLO, TEAM_JEDIGENERALTANO, TEAM_JEDIGENERALWINDU, TEAM_JEDIGENERALOBI, TEAM_JEDIGENERALSKYWALKER, TEAM_JEDIGRANDMASTER, TEAM_JEDIGENERALVOS, TEAM_JEDICOUNCIL, TEAM_JEDIGURDCHIEF},
    category = "Entities",
})

DarkRP.createEntity("Temple Guard Twin Prep", {
    ent = "templegaurdtwin",
    model = "models/lt_c/sci_fi/light_spotlight.mdl",
    price = 0,
    max = 1,
    cmd = "guardtwinprep",
    allowed = {TEAM_JEDIGENERALADI, TEAM_JEDIGENERALSHAAK, TEAM_JEDIGENERALLUMINARA, TEAM_JEDIGENERALAAYLA, TEAM_JEDIGENERALKIT, TEAM_JEDIGENERALPLO, TEAM_JEDIGENERALTANO, TEAM_JEDIGENERALWINDU, TEAM_JEDIGENERALOBI, TEAM_JEDIGENERALSKYWALKER, TEAM_JEDIGRANDMASTER, TEAM_JEDIGENERALVOS, TEAM_JEDICOUNCIL, TEAM_JEDIGURDCHIEF},
    category = "Entities",
})

DarkRP.createEntity("Soulless One Escape Ship", {
    ent = "lvs_starfighter_soulless",
    model = "models/soulless/soulless1.mdl",
    price = 0,
    max = 1,
    cmd = "escape",
    allowed = {TEAM_CUSTOMENEMY, TEAM_COUNTDOOKU, TEAM_ASAJJVENTRESS, TEAM_GENERALGRIEVOUS, TEAM_PREVISZLA, TEAM_CADBANE, TEAM_HONDO, TEAM_BOSK, TEAM_DARTHMAUL, TEAM_SAVAGEOPRESS},
    category = "Entities",
})

DarkRP.createEntity("AAT", {
    ent = "lvs_fakehover_aat",
    model = "models/blu/aat.mdl",
    price = 0,
    max = 1,
    cmd = "aat",
    allowed = {TEAM_B1PILOT},
    category = "Entities",
})


--[[ DarkRP.createEntity("Merenzane Gold", {
    ent = "merenzanegold",
    model = "models/props_junk/PopCan01a.mdl",
    price = 0,
    max = 1,
    cmd = "merenzane",
    allowed = {TEAM_BARTENDER},
    category = "Entities",
})

DarkRP.createEntity("Ardees", {
    ent = "ardees",
    model = "models/props_junk/PopCan01a.mdl",
    price = 0,
    max = 1,
    cmd = "arde",
    allowed = {TEAM_BARTENDER},
    category = "Entities",
})

DarkRP.createEntity("Jabba Juice", {
    ent = "jabbajuice",
    model = "models/props_junk/PopCan01a.mdl",
    price = 0,
    max = 1,
    cmd = "jabbaj",
    allowed = {TEAM_BARTENDER},
    category = "Entities",
 --]]


--Catogories

DarkRP.createCategory{
name = "Micro",
categorises = "entities",
startExpanded = true,
color = Color(0, 107, 0, 255),
canSee = fp{fn.Id, true},
sortOrder = 99,
}

DarkRP.createCategory{
name = "Other",
categorises = "entities",
startExpanded = true,
color = Color(0, 107, 0, 255),
canSee = fp{fn.Id, true},
sortOrder = 255,
}

DarkRP.createCategory{
name = "Other",
categorises = "shipments",
startExpanded = true,
color = Color(0, 107, 0, 255),
canSee = fp{fn.Id, true},
sortOrder = 255,
}

DarkRP.createCategory{
name = "Rifles",
categorises = "shipments",
startExpanded = true,
color = Color(0, 107, 0, 255),
canSee = fp{fn.Id, true},
sortOrder = 100,
}

DarkRP.createCategory{
name = "Shotguns",
categorises = "shipments",
startExpanded = true,
color = Color(0, 107, 0, 255),
canSee = fp{fn.Id, true},
sortOrder = 101,
}

DarkRP.createCategory{
name = "Snipers",
categorises = "shipments",
startExpanded = true,
color = Color(0, 107, 0, 255),
canSee = fp{fn.Id, true},
sortOrder = 102,
}

DarkRP.createCategory{
name = "Pistols",
categorises = "weapons",
startExpanded = true,
color = Color(0, 107, 0, 255),
canSee = fp{fn.Id, true},
sortOrder = 100,
}

DarkRP.createCategory{
name = "Other",
categorises = "weapons",
startExpanded = true,
color = Color(0, 107, 0, 255),
canSee = fp{fn.Id, true},
sortOrder = 255,
}

DarkRP.createCategory{
name = "Other",
categorises = "vehicles",
startExpanded = true,
color = Color(0, 107, 0, 255),
canSee = fp{fn.Id, true},
sortOrder = 255,
}

DarkRP.createCategory{
name = "Cadet",
categorises = "jobs",
startExpanded =false,
color = Color(200, 222, 0, 255),
canSee = function(ply) return true end,
sortOrder = 10,
}

DarkRP.createCategory{
name = "Clone Troopers",
categorises = "jobs",
startExpanded =false,
color = Color(30, 165, 232, 255),
canSee = function(ply) return true end,
sortOrder = 11,
}

DarkRP.createCategory{
name = "501st Legion",
categorises = "jobs",
startExpanded =false,
color = Color(0, 51, 255, 255),
canSee = function(ply) return true end,
sortOrder = 12,
}

DarkRP.createCategory{
name = "Wolf Pack",
categorises = "jobs",
startExpanded =false,
color = Color(122, 122, 122, 255),
canSee = function(ply) return true end,
sortOrder = 100,
}

DarkRP.createCategory{
name = "212th Attack Battalion",
categorises = "jobs",
startExpanded =false,
color = Color(255, 221, 0, 255),
canSee = function(ply) return true end,
sortOrder = 13,
}

DarkRP.createCategory{
name = "Green Company",
categorises = "jobs",
startExpanded =false,
color = Color(0, 255, 64, 255),
canSee = function(ply) return true end,
sortOrder = 14,
}

DarkRP.createCategory{
name = "Medical Directive",
categorises = "jobs",
startExpanded =false,
color = Color(200, 20, 60, 255),
canSee = function(ply) return true end,
sortOrder = 29,
}

DarkRP.createCategory{
name = "Shock Trooper",
categorises = "jobs",
startExpanded =false,
color = Color(255, 77, 77, 255),
canSee = function(ply) return true end,
sortOrder = 16,
}

DarkRP.createCategory{
name = "21st Nova Corps",
categorises = "jobs",
startExpanded =false,
color = Color(209, 0, 209, 255),
canSee = function(ply) return true end,
sortOrder = 17,
}

DarkRP.createCategory{
name = "ARC",
categorises = "jobs",
startExpanded =false,
color = Color(0, 0, 255, 255),
canSee = function(ply) return true end,
sortOrder = 18,
}

DarkRP.createCategory{
name = "38th Engineering Division",
categorises = "jobs",
startExpanded =false,
color = Color(255, 157, 0, 255),
canSee = function(ply) return true end,
sortOrder = 19,
}

DarkRP.createCategory{
name = "Clan Rodarch",
categorises = "jobs",
startExpanded =false,
color = Color(219, 219, 219, 255),
canSee = function(ply) return true end,
sortOrder = 20,
}

DarkRP.createCategory{
name = "ARC Commanders",
categorises = "jobs",
startExpanded =false,
color = Color(0, 51, 255, 255),
canSee = function(ply) return true end,
sortOrder = 31,
}

DarkRP.createCategory{
name = "Regimental ARC",
categorises = "jobs",
startExpanded =false,
color = Color(0, 51, 255, 255),
canSee = function(ply) return true end,
sortOrder = 32,
}

DarkRP.createCategory{
name = "ION Squad",
categorises = "jobs",
startExpanded =false,
color = Color(255, 157, 0, 255),
canSee = function(ply) return true end,
sortOrder = 21,
}

DarkRP.createCategory{
name = "Delta Squad",
categorises = "jobs",
startExpanded =false,
color = Color(255, 157, 0, 255),
canSee = function(ply) return true end,
sortOrder = 22,
}

DarkRP.createCategory{
name = "Omega Squad",
categorises = "jobs",
startExpanded =false,
color = Color(255, 157, 0, 255),
canSee = function(ply) return true end,
sortOrder = 23,
}

DarkRP.createCategory{
name = "Republic Commandos",
categorises = "jobs",
startExpanded =false,
color = Color(255, 157, 0, 255),
canSee = function(ply) return true end,
sortOrder = 24,
}



DarkRP.createCategory{
name = "Battalion Generals",
categorises = "jobs",
startExpanded =false,
color = Color(122, 122, 122, 255),
canSee = function(ply) return true end,
sortOrder = 25,
}

DarkRP.createCategory{
name = "Fleet Officers",
categorises = "jobs",
startExpanded =false,
color = Color(122, 122, 122, 255),
canSee = function(ply) return true end,
sortOrder = 26,
}

DarkRP.createCategory{
name = "Fleet Admirals",
categorises = "jobs",
startExpanded =false,
color = Color(122, 122, 122, 255),
canSee = function(ply) return true end,
sortOrder = 27,
}

DarkRP.createCategory{
name = "Legacy Neutral Jobs",
categorises = "jobs",
startExpanded =false,
color = Color(0, 255, 128, 255),
canSee = function(ply) return true end,
sortOrder = 28,
}

DarkRP.createCategory{
name = "Jedi",
categorises = "jobs",
startExpanded = false,
color = Color(0, 166, 255, 255),
canSee = function(ply) return true end,
sortOrder = 99,
}

DarkRP.createCategory{
name = "Jedi Generals",
categorises = "jobs",
startExpanded = false,
color = Color(244, 66, 223),
canSee = function(ply) return true end,
sortOrder = 99,
}

DarkRP.createCategory{
name = "Entities",
categorises = "entities",
startExpanded = true,
color = Color(221, 255, 0, 255),
canSee = function(ply) return true end,
sortOrder = 20,
}

DarkRP.createCategory{
name = "Administrative",
categorises = "jobs",
startExpanded =false,
color = Color(204, 0, 0, 255),
canSee = function(ply) return true end,
sortOrder = 999,
}

DarkRP.createCategory{
name = "BX Commando Droids",
categorises = "jobs",
startExpanded =false,
color = Color(204, 0, 0, 255),
canSee = function(ply) return true end,
sortOrder = 989,
}

--Test

DarkRP.createCategory{
name = "Elite Characters[VIP]",
categorises = "jobs",
startExpanded =false,
color = Color(122, 122, 122, 255),
canSee = function(ply) return true end,
sortOrder = 30,
}
