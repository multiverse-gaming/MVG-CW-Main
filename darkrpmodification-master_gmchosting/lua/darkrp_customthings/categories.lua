--[[-----------------------------------------------------------------------
Categories
---------------------------------------------------------------------------
The categories of the default F4 menu.

Please read this page for more information:
https://darkrp.miraheze.org/wiki/DarkRP:Categories

In case that page can't be reached, here's an example with explanation:

DarkRP.createCategory{
    name = "Citizens", -- The name of the category.
    categorises = "jobs", -- What it categorises. MUST be one of "jobs", "entities", "shipments", "weapons", "vehicles", "ammo".
    startExpanded = true, -- Whether the category is expanded when you open the F4 menu.
    color = Color(0, 107, 0, 255), -- The color of the category header.
    canSee = function(ply) return true end, -- OPTIONAL: whether the player can see this category AND EVERYTHING IN IT.
    sortOrder = 100, -- OPTIONAL: With this you can decide where your category is. Low numbers to put it on top, high numbers to put it on the bottom. It's 100 by default.
}


Add new categories under the next line!
---------------------------------------------------------------------------]]

DarkRP.createCategory{
	name = "Recruits",
	categorises = "jobs",
	startExpanded =false,
	color = Color(200, 222, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 10,
}

DarkRP.createCategory{
	name = "Clone Trooper",
	categorises = "jobs",
	startExpanded =false,
	color = Color(3, 177, 252, 255),
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
	name = "212th Attack Battalion",
	categorises = "jobs",
	startExpanded =false,
	color = Color(255, 157, 0, 255),
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
	name = "Coruscant Guard",
	categorises = "jobs",
	startExpanded =false,
	color = Color(255, 77, 77, 255),
	canSee = function(ply) return true end,
	sortOrder = 16,
}

DarkRP.createCategory{
	name = "Galactic Marines",
	categorises = "jobs",
	startExpanded =false,
    color = Color(119, 63, 202),
	canSee = function(ply) return true end,
	sortOrder = 17,
}

DarkRP.createCategory{
	name = "Wolfpack Battalion",
	categorises = "jobs",
	startExpanded =false,
	color = Color(153, 144, 144, 255),
	canSee = function(ply) return true end,
	sortOrder = 18,
}

DarkRP.createCategory{
	name = "327th Engineering Corps",
	categorises = "jobs",
	startExpanded =false,
	color = Color(204, 204, 0),
	canSee = function(ply) return true end,
	sortOrder = 19,
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
	name = "ARC Directive",
	categorises = "jobs",
	startExpanded =false,
	color = Color(255, 255, 255, 255),
	canSee = function(ply) return true end,
	sortOrder = 21,
}

DarkRP.createCategory{
	name = "Omega Squad",
	categorises = "jobs",
	startExpanded =false,
	color = Color(255, 157, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 24,
}

DarkRP.createCategory{
	name = "Epsilon Squad",
	categorises = "jobs",
	startExpanded =false,
	color = Color(255, 157, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 23,
}

DarkRP.createCategory{
	name = "Shadow",
	categorises = "jobs",
	startExpanded =false,
	color = Color(130,16,8),
	canSee = function(ply) return true end,
	sortOrder = 21,
}

DarkRP.createCategory{
	name = "Covert",
	categorises = "jobs",
	startExpanded =false,
	color = Color(130,16,8),
	canSee = function(ply) return true end,
	sortOrder = 22,
}

DarkRP.createCategory{
	name = "Delta Squad",
	categorises = "jobs",
	startExpanded =false,
	color = Color(255, 157, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 23,
}

DarkRP.createCategory{
	name = "Bad Batch Squad",
	categorises = "jobs",
	startExpanded =false,
	color = Color(255, 157, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 24,
}

DarkRP.createCategory{
	name = "H.O.P.E Squad",
	categorises = "jobs",
	startExpanded =false,
	color = Color(255, 157, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 24,
}

DarkRP.createCategory{
	name = "Aiwha Squad",
	categorises = "jobs",
	startExpanded =false,
	color = Color(255, 157, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 24,
}


DarkRP.createCategory{
	name = "Aquila Squad",
	categorises = "jobs",
	startExpanded =false,
	color = Color(255, 157, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 24,
}

DarkRP.createCategory{
	name = "Ion Squad",
	categorises = "jobs",
	startExpanded =false,
	color = Color(255, 157, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 24,
}

DarkRP.createCategory{
	name = "Yayax Squad",
	categorises = "jobs",
	startExpanded =false,
	color = Color(255, 157, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 24,
}

DarkRP.createCategory{
	name = "Rancor Squad",
	categorises = "jobs",
	startExpanded =false,
	color = Color(255, 157, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 24,
}


DarkRP.createCategory{
	name = "Republic Commandos",
	categorises = "jobs",
	startExpanded =false,
	color = Color(255, 157, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 25,
}

DarkRP.createCategory{
	name = "Battalion Generals",
	categorises = "jobs",
	startExpanded =false,
	color = Color(122, 122, 122, 255),
	canSee = function(ply) return true end,
	sortOrder = 26,
}

DarkRP.createCategory{
	name = "Fleet Officers",
	categorises = "jobs",
	startExpanded =false,
	color = Color(122, 122, 122, 255),
	canSee = function(ply) return true end,
	sortOrder = 27,
}


DarkRP.createCategory{
	name = "Fleet Branches",
	categorises = "jobs",
	startExpanded =false,
	color = Color(122, 122, 122, 255),
	canSee = function(ply) return true end,
	sortOrder = 28,
}

DarkRP.createCategory{
	name = "NSO Command",
	categorises = "jobs",
	startExpanded =false,
	color = Color(76, 90, 117),
	canSee = function(ply) return true end,
	sortOrder = 29,
}

DarkRP.createCategory{
	name = "Legacy Neutral Jobs",
	categorises = "jobs",
	startExpanded =false,
	color = Color(0, 255, 128, 255),
	canSee = function(ply) return true end,
	sortOrder = 31,
}

DarkRP.createCategory{
	name = "Clone Reinforcements",
	categorises = "jobs",
	startExpanded =false,
	color = Color(0, 255, 128, 255),
	canSee = function(ply) return true end,
	sortOrder = 32,
}

DarkRP.createCategory{
	name = "Jedi",
	categorises = "jobs",
	startExpanded = false,
	color = Color(0, 166, 255, 255),
	canSee = function(ply) return true end,
	sortOrder = 33,
}

DarkRP.createCategory{
	name = "Jedi Temple Guard",
	categorises = "jobs",
	startExpanded = false,
	color = Color(216, 237, 24, 255),
	canSee = function(ply) return true end,
	sortOrder = 34,
}

DarkRP.createCategory{
	name = "Jedi Generals",
	categorises = "jobs",
	startExpanded = false,
	color = Color(244, 66, 223),
	canSee = function(ply) return true end,
	sortOrder = 35,
}

DarkRP.createCategory{
	name = "Entities",
	categorises = "entities",
	startExpanded =true,
	color = Color(221, 255, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 36,
}

DarkRP.createCategory{
	name = "Other",
	categorises = "jobs",
	startExpanded =false,
	color = Color(204, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 999,
}

DarkRP.createCategory{
	name = "Confederacy of Independent Systems",
	categorises = "jobs",
	startExpanded =false,
	color = Color(204, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 37,
}

DarkRP.createCategory{
	name = "Event Enemy",
	categorises = "jobs",
	startExpanded =false,
	color = Color(204, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 38,
}

DarkRP.createCategory{
	name = "Event Characters",
	categorises = "jobs",
	startExpanded =false,
	color = Color(204, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 39,
}

DarkRP.createCategory{
	name = "Malus Testing",
	categorises = "jobs",
	startExpanded =false,
	color = Color(204, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 40,
}
