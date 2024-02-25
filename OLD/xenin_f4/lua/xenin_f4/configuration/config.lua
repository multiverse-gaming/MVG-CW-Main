-- Initialise config

local cfg = F4Menu:CreateConfig()



--	Set the language!

--	You can find the languages you can use here: https://github.com/PatrickRatzow/Xenin-Languages/tree/master/f4menu

--	You don't need to write the .json part

--

--	If you want to add your own language you can

--	1. Create a pull request (create new file) that will be uploaded to that website with the language

--	2. Use a second argument in the :SetLanguage function

--

--	How to do now #2. This will set the language without needing to use the version from a website.

--	cfg:SetLanguage("french", [[

--		{

--			"phrases": {

--				"dashboard": {

--

--				}

--			}

--		}

--	]])

--

--	So for example

--	cfg:SetLanguage("russian", [[

--		-- copy the contents of english.json and translate it here

--	]])

--

--	It's recommended you use method #1, but you can use method #2 till the file you upload have been approved

cfg:SetLanguage("english")



-- Set the title of the F4

-- This can be a string, e.g. "Xenin F4"

-- Or it can be a function

-- e.g. function() return "Xenin F4 - " .. LocalPlayer():getDarkRPVar("money") end

-- A function will refresh every 10 seconds, so you can have things that change

cfg:SetTitle("Multiverse Gaming")



-- Lets set the amount of columns per row for jobs & items

cfg:SetColumnsPerRow(1)



-- Should the menu close after changing job?

cfg:SetCloseMenuAfterJobChange(false)



-- Default sequence for jobs in the slideout menu?

-- Set to false if you want to disable

cfg:SetDefaultJobSequence("pose_standing_02")



-- Should models be rendered in real time?

-- If you have a ton of things in your F4 I recommend you changing this to false, it helps with performance a lot

-- It does look worse, and not every model might have an icon (it's the models fault)

cfg:SetRealtimeModelsEnabled(false)



-- Should models be hidden? If true it'll hide no matter if realtime or not models.

cfg:SetHideModels(false)



-- Should weapons use the addon Easy Skins to skin weapons if you have any equipped?

cfg:SetEasySkins(false)



-- How long should it take between typing the last letter of a search to it happens

-- This is so it doesn't constantly update & lags while you search for something

cfg:SetDebounceLength(0.2)



-- Empty the search bar when you switch tabs in the items menu?

cfg:SetEmptySearchOnTabSwitch(true)



-- Should categories start expanded?

cfg:SetCategoriesStartExpanded(false)



-- Should the category color be the color of the category box?

-- Example of how true looks: https://i.imgur.com/VB5rHXd.png

cfg:SetCategoriesBackgroundFullyColored(false)



-- Should the canSee property on categories have priority?

-- If this is set to true, if canSee returns true/false it wont care for other checks for the category

cfg:SetPrioritizeCanSee(true)



-- Should jobs that use NeedToChangeFrom be shown even if they can't become that job?

cfg:SetShowNeedToChangeFrom(false)



-- Should jobs that fail customCheck **NOT** be shown

cfg:SetHideOnCustomCheckFail(false)



-- Should jobs have level indictators enabled when you're browsing jobs?

cfg:SetJobLevelIndictatorEnabled(true)



-- Should items have level indicators enabled?

cfg:SetItemsLevelIndicatorEnabled(false)



-- Shall jobs be rerendered when somebody opens the menu again?

-- If you have addons like BWhitelist that change customCheck field you need this to be true

cfg:SetRebuildJobsOnOpen(false)



-- What are the default states of the checkboxes at the top of their respective tabs?

-- True = enabled

-- False = disabled

cfg:SetCheckboxStates({

	jobFavourite = true,

	jobRecent = true,

	itemsFavourite = true

})



-- Should the states of checkboxes be saved across sessions (disconnects)?

cfg:SetSaveCheckboxStates(true)



-- Should "Total Money" circle in the dashboard also count people that's offline?

cfg:SetUseOfflineMoney(true)



-- For the total money.

cfg:SetMoneyConfig({

	-- How often should it cache the total amount of money?

	-- This is in seconds

	CacheInterval = 120,

	-- Only count active players money

	-- Set to false to disable, and any number to determine the amount of days since last login to count as active

	DaysSinceLastLogin = 14,

	-- Should Blue's ATM/SlownLS ATM data be included? Only works if installed

	IncludeBATM = true

})



cfg:SetRichestPlayerConfig({

	-- How often should it cache the total amount of money?

	-- This is in seconds

	CacheInterval = 1800,

	-- Should Blue's ATM/SlownLS ATM data be included? Only works if installed

	IncludeBATM = true

})



-- Setup the order of how tabs should be in the items menu

cfg:SetItemsOrder({

	"Entities"
	-- Removed "Weapons", "Shipments", "Ammo", "Food" and "Vehicles"

})



-- Sort order for jobs. This will determine the order of "sort by" dropdown for jobs

-- The first part will also be the selected sort when you open menu

-- "default" is DarkRP sortOrder btw.

cfg:SetJobSortOrder({

	"default", "alphabetically", "highestSalary", "lowestSalary", "mostPeople", "leastPeople"

})



-- Same concept as the one above, just for items page

cfg:SetItemsSortOrder({

	"default", "alphabetically", "highestPrice", "lowestPrice"

})



-- Sort order for the dashboard tabs.

-- If you want to remove a tab, just remove the "string" here

cfg:SetDashboardTabOrder({

	"General", "Economy"

})



-- Sort order for the circle graphs in the dashboard in the general tab

-- If you want to remove a certain graph, just remove the "string" here

cfg:SetDashboardGeneralInfoOrder({

	"Online", "Money", "Jobs", "Richest Player"

})



-- The sidebar colors. These are gradients. The first part is the start color, the second is the end color

cfg:SetSidebarColors({

	Player = { Color(208, 62, 106), Color(200, 60, 123) },

	PlayerAvatar = { Color(251, 211, 50), Color(69, 198, 103) },

	Commands = { Color(200, 60, 123), Color(176, 55, 180) },

})



-- You can change the colours of the menu slightly.

-- The defaults values you can just replace with Color(r, g, b), it will work

cfg:SetColors({

	Top = XeninUI.Theme.Primary,

	Sidebar = XeninUI.Theme.Primary,

	Background = XeninUI.Theme.Background

})





-- Add staff

-- :AddStaff(usergroup, display_name, color [optional], sortOrder [optional, default = 1])

-- Essentially, you could do:

-- cfg:AddStaff("owner", "Owner", Color(255, 0, 0), 999)

-- That would make it so owner would always be at the top, unless you have another rank with a sortOrder above 999

cfg:AddStaff("superadmin", "Senior Staff", Color(255, 0, 0), 1)
cfg:AddStaff("headadmin", "Head Administrator", Color(4, 84, 252), 2)
cfg:AddStaff("activedeveloper", "Developer", Color(252, 148, 4), 7)
cfg:AddStaff("admin", "Administrator", Color(220, 36, 252), 3)
cfg:AddStaff("mod", "Moderator", Color(60, 188, 236), 4)
cfg:AddStaff("trialmod", "Trial-Moderator", Color(4, 252, 156), 5)
cfg:AddStaff("advisor", "Advisor", Color(246, 201, 103), 6)
cfg:AddStaff("developer", "Developer", Color(252, 148, 4), 7)


-- Set the tab that'll it will open up on when you open the menu first time

cfg:SetActiveTab("Dashboard")



-- Set the resolution of the addon

-- width, height

-- If the resolution is higher than a users resolution it will be scaled down to 100% of the users resolution.

-- So if you set it to 1920x1080, but a user got 1280x720 resolution it will be 1280x720.

-- You can set this to 9999, 9999 and it'll be fullscreen no matter what

--

-- This can also be a function!

-- If it's a function it HAS to return a fraction (0-1)

-- 1 = fullscreen

-- 0 = nothing

-- Please be aware that the smallest it can go is 960x600. This is due to a lack of pixels, it simply doesn't have space to draw anything.

--

-- Example function:

-- This is equal to the default aspect ratio that 1280x750 pixels provide on 1080p

-- cfg:SetResolution(function()

-- 	return 0.67, 0.7

-- end)

--

cfg:SetResolution(1280, 750)



-- Add custom commands easily.

-- Advanced custom commands beyond just a simple chat command can be added in commands.lua with Lua knowledge

-- Commands are not translated, so you can type what you want.



-- If you want to you can create a custom category.

------

-- cfg:AddCategory("My Category")

------



-- Add a command

-- The first parameter is the name of the category it belongs to. Check commands.lua for default categories names

-- The second parameter is the text shown in the menu

-- The third parameter is the chat message you make the player say.

------

-- cfg:AddCommand("options.general.name", "Say Hi", "/ooc hi")

------



--------------------------

-- The sidebar content  --

--------------------------



-- Add a divider from the top player part

-- You can make it a custom color by doing :AddDivider(Color(r, g, b), Color(r, g, b))

-- If you don't add any colours, it'll use the default colour

cfg:AddDivider()



-- Add the first tab

-- name = the display name of the tab

-- desc = the description

-- panel = the Lua VGUI panel. This can be used for custom tabs easily if the addon uses vgui.Register for UI

-- icon is optional, if you don't want an icon just remove the field

-- If you want an icon it uses imgur id, so if you want "https://i.imgur.com/0HYmtUy.png" you will need to set icon to "0HYmtUy"

-- colors is optional, if you don't use this it will use the default tab colors

-- If you want to use custom colors, add this: colors = { Color(255, 0, 0), Color(0, 0, 255) },

-- Of course remember to change the colors as you like.

-- recreateOnSwitch is optional, you should probably enable this for most custom panels (not Xenin addons)

-- This will allow the menu to work with addons that don't update the UI if it ain't open (most addons)



cfg:AddTab({

	name = "Dashboard",

	desc = "Server stats & more",

	panel = "F4Menu.Dashboard",

	-- If your server/players are Turkish, you need to set it up differently as Imgur is blocked in Turkey

	-- You can set it up as a table with different URLs.

	-- An example for Imgur + non Imgur fallback

	--	{

	--		If you don't setup any URL it'll use imgur. If you don't setup any type it'll use png. You can use png/jpg

	--		{ id = "Tpm965d" },

	--		{ id = "va1Y1D", url = "https://i.hizliresim.com", type = "png" }

	--	}

	icon = "Tpm965d"

})

cfg:AddTab({

	name = "Jobs",

	desc = "Get a career!",

	panel = "F4Menu.Jobs",

	icon = "MsBaa8Y"

})

cfg:AddTab({

	name = "Items",

	desc = "Entities",

	panel = "F4Menu.Items",

	icon = "iCAiL7W"

})



--[[

-- You can have URLs

-- It will try to open the URL in the Steam Browser upon pressing the tab.

cfg:AddURL({

	name = "Donate",

	desc = "Give me shekels",

	-- Used to display title once you have pressed on the tab.

	tabName = "Donation Shop",

	url = "https://store.xeningaming.com"

})



-- You can also add a website that'll be shown in the F4 menu itself instead of Steam Browser

-- You don't need a tab name here.

cfg:AddWebsite({

	name = "Donate website",

	desc = "Give me shekels",

	url = "https://store.xeningaming.com"

})

--]]

cfg:AddURL({

	name = "Donate",

	desc = "If you wish to support MVG",

	tabName = "Donation Shop",

	url = "https://multiverse-gaming.uk/store",

	icon = "HVnAVBY",
})



-- If you have Xenin Inventory you can set enabled to true

-- You don't need panel for these

cfg:SetXeninInventory({

	enabled = false,

	name = "Inventory",

	desc = "Store your things",

	icon = "iCAiL7W"

})



-- If you have Xenin Battle Pass you can set enabled to true

-- Requires Battle Pass 1.0.7a or higher!

cfg:SetXeninBattlePass({

	enabled = false,

	name = "Battle Pass",

	desc = "Rewards & challenges",

	icon = "hnalpdT"

})



-- If you have Xenin Coinflips you can set enabled to true

-- At least version 1.0.8b

cfg:SetXeninCoinflips({

	enabled = false,

	name = "Coinflips",

	desc = "Flip a coin",

	icon = "C3MyKJE"

})



-- If you have Xenin Deathscreen you can enable this

cfg:SetXeninDeathscreen({

	enabled = false,

	name = "Deathscreen",

	desc = "Buy & equip cards",

	icon = "eQg85qn"

})



cfg:AddDivider()

cfg:AddURL({

	name = "Discord",

	desc = "Join our Discord",

	tabName = "Join the Multiverse Gaming discord!",

	url = "https://discord.gg/sUcHks5",

	icon = "vHESvbx"

})

cfg:AddWebsite({

	name = "Steam Group",

	desc = "Join our Steam Group",

	url = "https://steamcommunity.com/groups/MultiverseGamingSteam",

	icon = "jvjxAQK"

})

--[[ Standalone commands

cfg:AddTab({

	name = "Commands",

	panel = "F4Menu.Commands.Standalone"

})

--]]
