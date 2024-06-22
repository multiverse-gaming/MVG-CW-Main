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
JoeFort:AddEnt("Concrete Barrier","Concrete Barricade",{
classname = "",
model = "models/fortifications/concrete_barrier_01.mdl",
health = 150,
buildtime = 8,
neededresources = multiplier * 15,
})
 
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
 

-- Metal Barricades
JoeFort:AddEnt("Metal Cover","Metal Barricade",{
classname = "",
model = "models/props_debris/metal_panel02a.mdl",
health = 150,
buildtime = 5,
neededresources = multiplier * 15,
})
 
JoeFort:AddEnt("Small Shooting Barrier","Metal Barricade",{
classname = "",
model = "models/fortifications/metal_barrier_02.mdl",
health = 350,
buildtime = 15,
neededresources = multiplier * 35,
})
 
JoeFort:AddEnt("Big Shooting Barrier","Metal Barricade",{
classname = "",
model = "models/fortifications/metal_barrier_04.mdl",
health = 500,
buildtime = 20,
neededresources = multiplier * 50,
})
 
JoeFort:AddEnt("Shooting Barricade","Metal Barricade",{
classname = "",
model = "models/elitelukas/imp/barricade.mdl",
health = 450,
buildtime = 18,
neededresources = multiplier * 45,
 
})
 
JoeFort:AddEnt("Reinforced Fence","Metal Barricade",{
classname = "",
model = "models/fortifications/metal_barrier.mdl",
health = 1250,
buildtime = 60,
neededresources = multiplier * 100,
})
 
-- FOB
JoeFort:AddEnt("FOB","FOB",{
classname = "",
model = "models/elitelukas/imp/shocktrooper_base.mdl",
health = 8000,
buildtime = 180,
neededresources = multiplier * 1000,
})
JoeFort:AddEnt("Bunker","FOB",{
classname = "", 
model = "models/starwars/syphadias/props/sw_tor/bioware_ea/props/neutral/neu_bunker.mdl", 
health = 4000, 
buildtime = 90, 
neededresources = 750, 
})
JoeFort:AddEnt("Small Tent","FOB",{
classname = "", 
model = "models/starwars/syphadias/props/sw_tor/bioware_ea/props/republic/rep_tent_leanto.mdl", 
health = 500, 
buildtime = 60, 
neededresources = 600, 
})
     
JoeFort:AddEnt("Tent","FOB",{
classname = "", 
model = "models/starwars/syphadias/props/sw_tor/bioware_ea/props/neutral/neu_tent_large.mdl", 
health = 1000, 
buildtime = 120, 
neededresources = 1200, 
})
     
JoeFort:AddEnt("Large Tent","FOB",{
classname = "", 
model = "models/starwars/syphadias/props/sw_tor/bioware_ea/props/republic/rep_tent_opensided.mdl", 
health = 8000, 
buildtime = 180, 
neededresources = 1500, 
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
 
JoeFort:AddEnt("Sandbag Line Large","Sandbag",{
classname = "",
model = "models/props_fortifications/sandbags_line2.mdl",
health = 350,
buildtime = 15,
neededresources = multiplier * 35,
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
 
 
-- Walls
JoeFort:AddEnt("Short Wall","Walls",{
classname = "",
model = "models/elitelukas/imp/128x_wall.mdl",
health = 500,
buildtime = 20,
neededresources = multiplier * 50,
})
 
JoeFort:AddEnt("Large Wall","Walls",{
classname = "",
model = "models/elitelukas/imp/256x_wall.mdl",
health = 750,
buildtime = 30,
neededresources = multiplier * 75,
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
 
JoeFort:AddEnt("Table","RP",{
classname = "",
model = "models/haxxer/normandy/kitchentable.mdl",
health = 100,
buildtime = 1,
neededresources = multiplier * 25,
})
