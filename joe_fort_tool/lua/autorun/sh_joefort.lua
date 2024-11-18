JoeFort = JoeFort or {}
/*

JoeFort:AddEnt("Barrier","Barriers",{
classname = string,
model = string,
health = int,
buildtime = int,
neededresources = int,
CanSpawn = function(ply, wep)

end,
OnSpawn = function(ply,ent)

end,
OnDamaged = function(ent, spawner, attacker)

end,
OnDestroyed = function(ent, spawner, attacker)

end,
OnRepaired = function(spawner, repairer, ent)

end,
OnRemoved = function(spawner, remover, ent)

end,
OnBuildEntitySpawned = function(spawner, ent)

end,
})

*/

JoeFort.structs = {}
function JoeFort:AddEnt(name,category,data)
if not name or not category or not data then return end
if not data.classname or not data.model then return end
JoeFort.structs[category] = JoeFort.structs[category] or {}

data.name = name
data.health = data.health or 100
data.buildtime = data.buildtime or 10
data.neededresources = data.neededresources or 25

table.insert(JoeFort.structs[category], data)
end

function JoeFort:GetRessourcePool()
return JoeFort.Ressources or 0
end

if file.Exists("sh_fort_config.lua", "LUA") then
if SERVER then
include("sh_fort_config.lua")
AddCSLuaFile("sh_fort_config.lua")
elseif CLIENT then
include("sh_fort_config.lua")
end
end

JoeFort.Ressources = JoeFort.Ressources or 500
if JoeFort.configoverride then return end

-- RESOURCE EDITS - +10 so far (fences only)

local multiplier = 1.5

-- Fences
JoeFort:AddEnt("Small Fence","Fence",{
classname = "",
model = "models/props_c17/fence02b.mdl",
health = 100,
buildtime = 10,
neededresources = multiplier * 25,
})
 
JoeFort:AddEnt("Fence","Fence",{
classname = "",
model = "models/props_c17/fence02a.mdl",
health = 150,
buildtime = 15,
neededresources = multiplier * 30,
})
 
JoeFort:AddEnt("Long Fence","Fence",{
classname = "",
model = "models/props_c17/fence03a.mdl",
health = 300,
buildtime = 20,
neededresources = multiplier * 50,
})
 
JoeFort:AddEnt("Fence Door","Fence",{
classname = "",
model = "models/props_wasteland/interior_fence002e.mdl",
health = 75,
buildtime = 5,
neededresources = multiplier * 20,
})
 
JoeFort:AddEnt("Tall Fence Small","Fence",{
classname = "",
model = "models/props_wasteland/exterior_fence002b.mdl",
health = 125,
buildtime = 12,
neededresources = multiplier * 30,
})
 
JoeFort:AddEnt("Tall Fence Medium","Fence",{
classname = "",
model = "models/props_wasteland/exterior_fence002c.mdl",
health = 200,
buildtime = 18,
neededresources = multiplier * 35,
})
 
JoeFort:AddEnt("Tall Fence Large","Fence",{
classname = "",
model = "models/props_wasteland/exterior_fence002d.mdl",
health = 250,
buildtime = 25,
neededresources = multiplier * 60,
})
 

-- Concrete Barricades
JoeFort:AddEnt("Small Concrete Barrier","Concrete Barricade",{
classname = "",
model = "models/fortifications/concrete_barrier_02.mdl",
health = 175,
buildtime = 5,
neededresources = multiplier * 15,
})
 
JoeFort:AddEnt("Large Concrete Barrier","Concrete Barricade",{
classname = "",
model = "models/props_c17/concrete_barrier001a.mdl",
health = 350,
buildtime = 12,
neededresources = multiplier * 35,
})
 
JoeFort:AddEnt("Concrete Wall","Concrete Barricade",{
classname = "",
model = "models/props_fortifications/concrete_wall001_96_reference.mdl",
health = 450,
buildtime = 18,
neededresources = multiplier * 45,
})
 
JoeFort:AddEnt("Short Wall","Concrete Barricade",{
classname = "",
model = "models/elitelukas/imp/128x_wall.mdl",
health = 500,
buildtime = 20,
neededresources = multiplier * 50,
})
     
JoeFort:AddEnt("Large Wall","Concrete Barricade",{
classname = "",
model = "models/elitelukas/imp/256x_wall.mdl",
health = 750,
buildtime = 30,
neededresources = multiplier * 75,
})
-- Metal Barricades
JoeFort:AddEnt("Small Shooting Barrier","Metal Barricade",{
classname = "",
model = "models/fortifications/metal_barrier_02.mdl",
health = 500,
buildtime = 15,
neededresources = multiplier * 35,
})
 
JoeFort:AddEnt("Big Shooting Barrier","Metal Barricade",{
classname = "",
model = "models/fortifications/metal_barrier_04.mdl",
health = 1000,
buildtime = 20,
neededresources = multiplier * 50,
})
 
JoeFort:AddEnt("Shooting Barricade","Metal Barricade",{
classname = "",
model = "models/elitelukas/imp/barricade.mdl",
health = 750,
buildtime = 18,
neededresources = multiplier * 45,
 
})
 
JoeFort:AddEnt("Reinforced Fence","Metal Barricade",{
classname = "",
model = "models/fortifications/metal_barrier.mdl",
health = 1500,
buildtime = 30,
neededresources = multiplier * 100,
})
 
-- Buildings
JoeFort:AddEnt("FOB","Buildings",{
classname = "",
model = "models/elitelukas/imp/shocktrooper_base.mdl",
health = 8000,
buildtime = 60,
neededresources = multiplier * 1000,
})
JoeFort:AddEnt("Bunker","Buildings",{
classname = "", 
model = "models/starwars/syphadias/props/sw_tor/bioware_ea/props/neutral/neu_bunker.mdl", 
health = 4000, 
buildtime = 30, 
neededresources = 750, 
})
JoeFort:AddEnt("Small Tent","Buildings",{
classname = "", 
model = "models/starwars/syphadias/props/sw_tor/bioware_ea/props/republic/rep_tent_leanto.mdl", 
health = 500, 
buildtime = 20, 
neededresources = 600, 
})
     
JoeFort:AddEnt("Tent","Buildings",{
classname = "", 
model = "models/starwars/syphadias/props/sw_tor/bioware_ea/props/neutral/neu_tent_large.mdl", 
health = 1000, 
buildtime = 40, 
neededresources = 1200, 
})
     
JoeFort:AddEnt("Large Tent","Buildings",{
classname = "", 
model = "models/starwars/syphadias/props/sw_tor/bioware_ea/props/republic/rep_tent_opensided.mdl", 
health = 8000, 
buildtime = 60, 
neededresources = 1500, 
})
     
JoeFort:AddEnt("Big Platform","Buildings",{
classname = "", 
model = "models/elitelukas/imp/platform_big.mdl", 
health = 2000, 
buildtime = 20, 
neededresources = 500, 
})

JoeFort:AddEnt("Large Fob","Buildings",{
classname = "", 
model = "models/lordtrilobite/starwars/props/imp_prefabbase_stairs04.mdl", 
health = 12000, 
buildtime = 90, 
neededresources = 2000, 
})
-- Sandbags
JoeFort:AddEnt("Sandbag","Sandbag",{
classname = "",
model = "models/props_fortifications/sandbags_corner1.mdl",
health = 250,
buildtime = 10,
neededresources = multiplier * 25,
})
 
JoeFort:AddEnt("Sandbag Wide","Sandbag",{
classname = "",
model = "models/props_fortifications/sandbags_corner2.mdl",
health = 300,
buildtime = 15,
neededresources = multiplier * 30,
})
 
JoeFort:AddEnt("Sandbag Wide Tall","Sandbag",{
classname = "",
model = "models/props_fortifications/sandbags_corner2_tall.mdl",
health = 400,
buildtime = 18,
neededresources = multiplier * 40,
})
 
JoeFort:AddEnt("Sandbag Line","Sandbag",{
classname = "",
model = "models/props_fortifications/sandbags_line1.mdl",
health = 300,
buildtime = 12,
neededresources = multiplier * 30,
})
 
JoeFort:AddEnt("Sand Block","Sandbag",{
classname = "",
model = "models/iraq/ir_hesco_basket_01.mdl",
health = 300,
buildtime = 15,
neededresources = multiplier * 30,
})
 
JoeFort:AddEnt("Sand Block Climable","Sandbag",{
classname = "",
model = "models/iraq/ir_hesco_basket_01b.mdl",
health = 300,
buildtime = 15,
neededresources = multiplier * 30,
})
 
 
-- Field Check Ups
JoeFort:AddEnt("Table","Field Check Ups",{
classname = "",
model = "models/haxxer/normandy/kitchentable.mdl",
health = 100,
buildtime = 1,
neededresources = multiplier * 25,
})

JoeFort:AddEnt("Check in Desk","Field Check Ups",{
classname = "",
model = "models/lt_c/sci_fi/desk_reception.mdl",
health = 100,
buildtime = 1,
neededresources = multiplier * 25,
})

JoeFort:AddEnt("Scanner","Field Check Ups",{
classname = "",
model = "models/lt_c/holo_wall_unit.mdl",
health = 100,
buildtime = 1,
neededresources = multiplier * 25,
})

-- RP
JoeFort:AddEnt("Cone","RP",{
classname = "",
model = "models/props_junk/TrafficCone001a.mdl",
health = 25,
buildtime = 1,
neededresources = multiplier * 5,
})
 
JoeFort:AddEnt("Barricade A","RP",{
classname = "",
model = "models/props_wasteland/barricade001a.mdl",
health = 25,
buildtime = 1,
neededresources = multiplier * 5,
})
 
JoeFort:AddEnt("Barricade B ","RP",{
classname = "",
model = "models/props_wasteland/barricade002a.mdl",
health = 25,
buildtime = 1,
neededresources = multiplier * 5,
})
 
JoeFort:AddEnt("Ladder","RP",{
classname = "",
model = "models/lt_c/sci_fi/stairs_144.mdl",
health = 100,
buildtime = 10,
neededresources = multiplier * 25,
})
 
JoeFort:AddEnt("Droid Station","RP",{
classname = "",
model = "models/epsilon/cwa_furniture/workshop/eps_workshop_droid1.mdll",
health = 50,
buildtime = 2,
neededresources = multiplier * 25,
})

JoeFort:AddEnt("Sensor Node","RP",{
classname = "",
model = "models/starwars/syphadias/props/sw_tor/bioware_ea/items/harvesting/slicing/electronic_brain.mdl",
health = 50,
buildtime = 2,
neededresources = multiplier * 25,
})

JoeFort:AddEnt("Sensor Relay","RP",{
classname = "",
model = "models/starwars/syphadias/props/sw_tor/bioware_ea/props/neutral/neu_industrial_tower.mdl",
health = 50,
buildtime = 2,
neededresources = multiplier * 25,
})
    
JoeFort:AddEnt("Computer","RP",{
classname = "",
model = "models/props/starwars/tech/hoth_console2.mdl",
health = 250,
buildtime = 2,
neededresources = multiplier * 25,
})
        
JoeFort:AddEnt("Small Computer","RP",{
classname = "",
model = "models/kingpommes/starwars/misc/palp_panel1.mdl",
health = 100,
buildtime = 2,
neededresources = multiplier * 25,
})
        
JoeFort:AddEnt("Bacta Tank","RP",{
classname = "",
model = "models/props/starwars/medical/bacta_tank.mdl",
health = 100,
buildtime = 2,
neededresources = multiplier * 25,
})
        
JoeFort:AddEnt("Medical Bed","RP",{
classname = "",
model = "models/props/starwars/medical/medical_bed.mdl",
health = 250,
buildtime = 2,
neededresources = multiplier * 25,
})