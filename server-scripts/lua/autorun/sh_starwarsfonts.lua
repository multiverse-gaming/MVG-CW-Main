--[[
				 _______.___________.    ___      .______
				/       |           |   /   \     |   _  \
			   |   (----`---|  |----`  /  ^  \    |  |_)  |
				\   \       |  |      /  /_\  \   |      /
			.----)   |      |  |     /  _____  \  |  |\  \----.
			|_______/       |__|    /__/     \__\ | _| `._____|
			____    __    ____  ___      .______          _______.
			\   \  /  \  /   / /   \     |   _  \        /       |
			 \   \/    \/   / /  ^  \    |  |_)  |      |   (----`
			  \            / /  /_\  \   |      /        \   \
			   \    /\    / /  _____  \  |  |\  \----.----)   |
				\__/  \__/ /__/     \__\ | _| `._____|_______/
				.___________. __________   ___ .___________.
				|           ||   ____\  \ /  / |           |
				`---|  |----`|  |__   \  V  /  `---|  |----
					|  |     |   __|   >   <       |  |
					|  |     |  |____ /  .  \      |  |
					|__|     |_______/__/ \__\     |__|
     _______.  ______ .______       _______  _______ .__   __.      _______.
    /       | /      ||   _  \     |   ____||   ____||  \ |  |     /       |
   |   (----`|  ,----'|  |_)  |    |  |__   |  |__   |   \|  |    |   (----`
    \   \    |  |     |      /     |   __|  |   __|  |  . `  |     \   \
.----)   |   |  `----.|  |\  \----.|  |____ |  |____ |  |\   | .----)   |
|_______/     \______|| _| `._____||_______||_______||__| \__| |_______/

	Brought to you by DankRabbit
	Need help? https://discord.gg/svY4AdSEtm

-------------------------------------------------------------------------------]]
--[[---------------------------------------------------------------------------]]
--[[---------------------------------------------------------------------------]]

local fastDL = false	-- false = workshopDL

local cfg = { -- name = font
	["Aurebesh"] = "Aurebesh",
	["Galactic"] = "Galactic Basic",
	["Mandoa"] = "Mandalorian",
	["SWTOR"] = "Old Republic Bold",
	["Jedi"] = "Star Jedi",
	["Jedi Hollow"] = "Star Jedi Hollow",
	["Jedi Outline"] = "Star Jedi Outline",
	["SW Euro"] = "SWEuro",
	["Sith"] = "Ur-Kittat",
}

local noOL = {
	["Aurebesh"] = true,
	["Galactic"] = true,
}

--[[---------------------------------------------------------------------------]]
--[[---------------------------------------------------------------------------]]
--[[---------------------------------------------------------------------------]]

if SERVER then
	if fastDL then
		local files = {
			"aurebesh", "galbasic", "mandalor", "old_r",
			"starjedi", "starjhol", "starjout",
			"sweuroregular", "ur-kittat"
		}
		for k,v in pairs(files) do
			resource.AddFile("resource/fonts/" .. v .. ".ttf")
		end
	end
end

--[[---------------------------------------------------------------------------]]

-- textscreenFonts = {} -- If you use lua refresh, enable this before saving
local function addFont(font, t)
	if CLIENT then
		t.size = 100
		surface.CreateFont(font, t)
		t.size = 50
		surface.CreateFont(font .. "_MENU", t)
	end

	table.insert(textscreenFonts, font)
end

--[[---------------------------------------------------------------------------]]

local w = 400
local function runCfg()
	if !textscreenFonts then return end

	for k,v in pairs(cfg) do
		addFont(k, {
			font = v,
			weight = w,
			antialias = false,
			outline = false,
		})

		if noOL[k] then continue end

		addFont(k .. " outlined", {
			font = v,
			weight = w,
			antialias = false,
			outline = true,
		})
	end
end timer.Simple(5, runCfg)

--[[---------------------------------------------------------------------------]]

print("Thank you for using Star Wars: Textscreens!")
print("May the force be with you, always.")