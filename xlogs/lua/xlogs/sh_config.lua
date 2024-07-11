xLogs.Config = xLogs.Config or {}

-- No touchy
xLogs.Config.Name = "xLogs"
xLogs.Config.MajorVersion = 1
xLogs.Config.MinorVersion = 2
xLogs.Config.Patch = 5
xLogs.Config.Author = "TheXnator"
xLogs.Config.AddonID = 6700

------------------------------------------------------
-- Config start
------------------------------------------------------



--[[

    Core Config

]]--


-- Chat command to open logs menu
xLogs.Config.ChatCommand = "!logs"

-- Default menu background filepath
xLogs.Config.MenuBackground = "xlogs/background.png"

-- Chat prefix for xLogs notifications
xLogs.Config.ChatPrefix = "[xLogs]"
-- Chat prefix colour for xLogs notifications
xLogs.Config.ChatPrefixCol = Color(200, 50, 50)

-- Function for getting player's colour for log formatting
-- Edit this if you want to change the colour to use ranks, job colours, etc
function xLogs.Config.GetUserCol(ply)
	-- DarkRP job colours
	return (ply and DarkRP and IsValid(ply) and (isfunction(ply.getJobTable) and ply:getJobTable())) and ply:getJobTable().color or Color(0, 255, 0, 255)

	-- xAdmin rank colours
	-- return (ply and IsValid(ply)) and ply:xAdminGetColor() or Color(200, 200, 200, 255)
end

-- Function to determine whether or not to flag a log
-- By default, this checks for any terms found in the xLogs.Config.BadWords table
function xLogs.Config.ShouldFlag(log)
	for k, word in ipairs(xLogs.Config.BadWords) do
		if string.find(string.lower(log.Content), string.lower(word)) then return true end
	end

	return false
end

-- Fallback when using ULX
-- Due to ULX not having explicit support for targeting of offline players, this value will be used as the fallback if a user being targeted is offline
-- If true, staff will always be allowed to target an offline user, if false, they will never be allowed to
-- If you are not using ULX, you can ignore this option
xLogs.Config.ULXFallback = false

-- Set this to true if using a fastdl for content
xLogs.Config.UsingFastDL = false


--[[

	Bad Words List
	The words in this table will be used for the default flagging of logs

]]--


xLogs.Config.BadWords = {
	--"bad word",
	--"another bad word",
	--"really bad word",
}



--[[

    Languages Config
	Supported Languages: English

]]--


xLogs.Config.LANG = "English"

xLogs.Config.Languages = {}
xLogs.Config.Languages["English"] = {}
xLogs.Config.Languages["English"]["logs"] = "Logs"
xLogs.Config.Languages["English"]["time"] = "Time"
xLogs.Config.Languages["English"]["type"] = "Type"
xLogs.Config.Languages["English"]["logcontent"] = "Content"
xLogs.Config.Languages["English"]["flagged"] = "Flagged"
xLogs.Config.Languages["English"]["search"] = "Search"
xLogs.Config.Languages["English"]["associatedplayers"] = "Associated Players"
xLogs.Config.Languages["English"]["associatedentities"] = "Associated Entities"
xLogs.Config.Languages["English"]["arrested"] = "%s arrested %s for %s seconds"
xLogs.Config.Languages["English"]["unarrested"] = "%s unarrested %s"
xLogs.Config.Languages["English"]["spawned"] = "%s spawned %s %s"
xLogs.Config.Languages["English"]["tooluse"] = "%s attempted to use tool %s"
xLogs.Config.Languages["English"]["connected"] = "%s connected from %s"
xLogs.Config.Languages["English"]["disconnected"] = "%s disconnected from the server"
xLogs.Config.Languages["English"]["openprofile"] = "Open Steam Profile"
xLogs.Config.Languages["English"]["copysteamid"] = "Copy SteamID\n%s"
xLogs.Config.Languages["English"]["copysteamid64"] = "Copy SteamID64\n%s"
xLogs.Config.Languages["English"]["copylog"] = "Copy Log"
xLogs.Config.Languages["English"]["killed"] = "%s was killed by %s with %s"
xLogs.Config.Languages["English"]["damaged"] = "%s was hit by %s for %s damage with %s"
xLogs.Config.Languages["English"]["changedjob"] = "%s changed job to %s"
xLogs.Config.Languages["English"]["pickup"] = "%s picked up %s"
xLogs.Config.Languages["English"]["advert"] = "%s placed advert: %s"
xLogs.Config.Languages["English"]["batteringram"] = "%s used battering ram"
xLogs.Config.Languages["English"]["dropcheque"] = "%s dropped a check of %s for %s"
xLogs.Config.Languages["English"]["pickupcheque"] = "%s picked up a cheque of %s for %s"
xLogs.Config.Languages["English"]["torecheque"] = "%s tore up a cheque of %s for %s"
xLogs.Config.Languages["English"]["demoted"] = "%s demoted %s for %s"
xLogs.Config.Languages["English"]["buydoor"] = "%s purchased door %s for %s"
xLogs.Config.Languages["English"]["selldoor"] = "%s sold door %s for %s"
xLogs.Config.Languages["English"]["dropmoney"] = "%s dropped %s"
xLogs.Config.Languages["English"]["givemoney"] = "%s gave %s %s"
xLogs.Config.Languages["English"]["pickupmoney"] = "%s picked up %s"
xLogs.Config.Languages["English"]["acceptedhit"] = "%s accepted %s's hit on %s"
xLogs.Config.Languages["English"]["completedhit"] = "%s completed %s's hit on %s"
xLogs.Config.Languages["English"]["failedhit"] = "%s failed the hit on %s for %s"
xLogs.Config.Languages["English"]["lockpickstart"] = "%s started lockpicking %s"
xLogs.Config.Languages["English"]["lockpickcomplete"] = "%s finished lockpicking %s"
xLogs.Config.Languages["English"]["pocketadd"] = "%s pocketed %s"
xLogs.Config.Languages["English"]["pocketadd"] = "%s dropped %s from pocket"
xLogs.Config.Languages["English"]["namechanged"] = "%s changed name from %s to %s"
xLogs.Config.Languages["English"]["wanted"] = "%s was wanted by %s for %s"
xLogs.Config.Languages["English"]["unwanted"] = "%s was unwanted by %s"
xLogs.Config.Languages["English"]["warranted"] = "%s was warrented by %s for %s"
xLogs.Config.Languages["English"]["weaponcheck"] = "%s was weapon checked by %s"
xLogs.Config.Languages["English"]["purchased"] = "%s purchased %s for %s"
xLogs.Config.Languages["English"]["warned"] = "%s was warned by %s for %s"
xLogs.Config.Languages["English"]["rancommandtarget"] = "%s ran command %s on %s with arguments: %s"
xLogs.Config.Languages["English"]["rancommand"] = "%s ran command %s with arguments: %s"
xLogs.Config.Languages["English"]["rancommandtargetnoargs"] = "%s ran command %s on %s"
xLogs.Config.Languages["English"]["rancommandnoargs"] = "%s ran command %s"
xLogs.Config.Languages["English"]["groupchanged"] = "%s's group was changed from %s to %s"
xLogs.Config.Languages["English"]["searchcategory"] = "Search Category..."
xLogs.Config.Languages["English"]["searchquery"] = "Search Query..."
xLogs.Config.Languages["English"]["selecttype"] = "Filter Type..."
xLogs.Config.Languages["English"]["settings"] = "Settings"
xLogs.Config.Languages["English"]["categories"] = "Categories:"
xLogs.Config.Languages["English"]["types"] = "Types:"
xLogs.Config.Languages["English"]["players"] = "Players:"
xLogs.Config.Languages["English"]["runsearch"] = "Run Search"
xLogs.Config.Languages["English"]["onscreenrelay"] = "On-Screen Log Relay"
xLogs.Config.Languages["English"]["enablecat"] = "Enable Category: %s"
xLogs.Config.Languages["English"]["serverside"] = "Server Settings"
xLogs.Config.Languages["English"]["clientside"] = "Client Settings"
xLogs.Config.Languages["English"]["economy"] = "Economy"
xLogs.Config.Languages["English"]["economygraph"] = "Economy Growth"
xLogs.Config.Languages["English"]["date"] = "Date"
xLogs.Config.Languages["English"]["money"] = "Total Money"
xLogs.Config.Languages["English"]["statistics"] = "Statistics"
xLogs.Config.Languages["English"]["economystats"] = "Economy Statistics"
xLogs.Config.Languages["English"]["richestplayers"] = "Richest Players:"
xLogs.Config.Languages["English"]["information"] = "Information:"
xLogs.Config.Languages["English"]["weeklygrowth"] = "Weekly Growth"
xLogs.Config.Languages["English"]["weekaverage"] = "Weekly Average"
xLogs.Config.Languages["English"]["lastweekaverage"] = "Previous Week Average"
xLogs.Config.Languages["English"]["weekprojection"] = "Next Week Projection"
xLogs.Config.Languages["English"]["projectedgrowth"] = "Projected Growth"
xLogs.Config.Languages["English"]["avgdailygrowth"] = "Average Daily Growth"
xLogs.Config.Languages["English"]["hitaccepted"] = "%s accepted a hit on %s for %s"
xLogs.Config.Languages["English"]["hitdeclined"] = "%s declined a hit on %s for %s"
xLogs.Config.Languages["English"]["hitcompleted"] = "%s completed a hit on %s for %s"
xLogs.Config.Languages["English"]["hitfailed"] = "%s's hit failed - target disconnected"
xLogs.Config.Languages["English"]["hitdisconnected"] = "%s arrested %s - %s's hit failed"
xLogs.Config.Languages["English"]["hitarrested"] = "%s accepted a hit on %s for %s"
xLogs.Config.Languages["English"]["hitexpired"] = "%s's hit on %s has expired"
xLogs.Config.Languages["English"]["knockedout"] = "%s knocked out %s"
xLogs.Config.Languages["English"]["restrained"] = "%s restrained %s"
xLogs.Config.Languages["English"]["unrestrained"] = "%s unrestrained %s"
xLogs.Config.Languages["English"]["blindfolded"] = "%s blindfolded %s"
xLogs.Config.Languages["English"]["unblindfolded"] = "%s unblindfolded %s"
xLogs.Config.Languages["English"]["gagged"] = "%s gagged %s"
xLogs.Config.Languages["English"]["ungagged"] = "%s ungagged %s"
xLogs.Config.Languages["English"]["woslog"] = "%s picked up entity %s, and got %s"