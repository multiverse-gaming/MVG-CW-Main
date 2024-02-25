LDT_Polls.Config.Scrw, LDT_Polls.Config.Scrh = ScrW(), ScrH()
LDT_Polls.SubmitedPolls = {}
LDT_Polls.Polls = {}

LDT_Polls.RunningPolls = {}
LDT_Polls.RunningSubmitedPolls = {}

LDT_Polls.FinishedPolls = {}
LDT_Polls.FinishedSubmitedPolls = {}

LDT_Polls.YourPolls = {}
LDT_Polls.YourSubmitedPolls = {}

LDT_Polls.submitedIcon = Material("ldt_polls/envelope-circle.png", "noclamp smooth")
LDT_Polls.minusIcon = Material("ldt_polls/minus.png","noclamp smooth")

-- This functio returns size values for 1080p monitor
function LDT_Polls.GetHeight(num)
    return (LDT_Polls.Config.Scrh*(num / 1080))
end

-- This functio returns size values for 1920 width monitor
function LDT_Polls.GetWidth(num)
    return (LDT_Polls.Config.Scrw*(num / 1920))
end

-- Create fonts with correct size
local fontSize = {20, 24, 26, 30, 36, 50}
local fontSizeBold = {24, 30, 36, 40, 46}
local function CreateFonts()
	for k,v in ipairs(fontSize) do 
		surface.CreateFont("WorkSans"..v, {font = "Work Sans Regular", size = LDT_Polls.GetWidth(v),  weight = 500, antialias = true})
	end
	for k,v in ipairs(fontSizeBold) do 
		surface.CreateFont("WorkSans"..v.."-Bold", {font = "Work Sans Bold", size = LDT_Polls.GetWidth(v), weight = 500})
	end
end
CreateFonts()


-- Returns formated time 
function LDT_Polls.DispTime(t)
    local d = math.floor(t / 86400)
    local h = math.floor((t % 86400) / 3600)
    local m = math.floor((t % 3600) / 60)
    local s = math.floor((t % 60))
    return string.format("%d:%02d:%02d:%02d", d, h, m, s)
end

-- Returns the difference between now and the poll end time
function LDT_Polls.GetDiff(t)
    return os.difftime(t, os.time())
end

-- Creates a Set
function LDT_Polls.Set (list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

-- This function returns current interval text.
function LDT_Polls.GetInterval()
    local text = ""
    if string.lower(LDT_Polls.Config.StatisticsInterval) == "1m" then
        text = LDT_Polls.GetLanguange("OneMonth")
    elseif string.lower(LDT_Polls.Config.StatisticsInterval) == "3m" then 
        text = LDT_Polls.GetLanguange("ThreeMonths")
    elseif string.lower(LDT_Polls.Config.StatisticsInterval) == "6m" then 
        text = LDT_Polls.GetLanguange("SixMonths")
    elseif string.lower(LDT_Polls.Config.StatisticsInterval) == "1y" then 
        text = LDT_Polls.GetLanguange("OneYear")
    elseif string.lower(LDT_Polls.Config.StatisticsInterval) == "all" then 
        text = LDT_Polls.GetLanguange("AllTime")
    end

    return text
end

hook.Add( "OnScreenSizeChanged", "LDT_Polls.OnScreenSizeChanged_ChnageFont", function()
    LDT_Polls.Config.Scrw, LDT_Polls.Config.Scrh = ScrW(), ScrH()
    CreateFonts()
end)