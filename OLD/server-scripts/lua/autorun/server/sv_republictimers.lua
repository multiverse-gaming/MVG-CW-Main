---Precaching network messages---
util.AddNetworkString("start_countdown")
util.AddNetworkString("abort_countdown")
util.AddNetworkString("cd_check")
util.AddNetworkString("cd_start")
util.AddNetworkString("cd_abort")
---------Main functions----------

local Countdown = {}
	Countdown.Start = function ()
		fixed_time	= SVTable.Time
		cd_in_progress = true
		MsgC (Color (17,236,116,255),"[Republic Countdowns] ",Color(255,255,255), "Countdown \""..SVTable.Title.."\"started for "..fixed_time.." seconds with <"..SVTable.Command.."> concommand to be executed!\n")
		timer.Create ("countdown", SVTable.Time, 1, function ()
			comtable = string.Explode(" ", SVTable.Command)
			SVTable.Starter:ConCommand (comtable[1], unpack(comtable,2))
			MsgC (Color(17,236,116,255),"[Republic Countdowns] ",Color(255,255,255), "Countdown \""..SVTable.Title.."\" for "..fixed_time.." seconds with <"..SVTable.Command.."> concommand has just finished!\n")
			cd_in_progress = false
		end)
		timeleft = SVTable.Time
		timer.Create ("countdown4connected", 1, timeleft, function ()
			timeleft = timeleft - 1
			if timeleft == 0 then 
				timer.Stop ("countdown4connected")
			end
		end)
		net.Start ("cd_start")
		net.WriteTable (SVTable)
		net.Broadcast ()
	end
	Countdown.Stop = function ()
		timer.Stop ("countdown")
		timer.Stop ("countdown4connected")
		if cd_in_progress == true then MsgC (Color (255,130,100,255),"[SERVER COUNTDOWNER] Countdown was aborted!\n") end
		cd_in_progress = false
		net.Start ("cd_abort")
		net.Broadcast ()
	end
------------Messaging-------------
net.Receive ("start_countdown", function (len, ply)
	if CAMI and CAMI.PlayerHasAccess(ply, "Republic Timers", nil) then
		SVTable = net.ReadTable ()
		Countdown.Start ()
	elseif ply:IsAdmin() or ply:IsSuperAdmin() then 
		SVTable = net.ReadTable ()
		Countdown.Start ()
	end 
end)

net.Receive ("abort_countdown", function (len, ply)
	if ply:IsAdmin() or ply:IsSuperAdmin() then 
		Countdown.Stop ()
	end 
end)

net.Receive ("cd_check", function (len, ply)
	if cd_in_progress == true then 
		net.Start ("cd_start")
		SVTable.Time = timeleft
		net.WriteTable (SVTable)
		net.Send(ply)
	end
end)
------------Concommands------------
concommand.Add ("countdown_start", function (ply, cmd, args)
	--if ply:IsAdmin() or ply:IsSuperAdmin() then
	if CAMI and CAMI.PlayerHasAccess(ply, "Republic Timers", nil) then
		SVTable = {}
		SVTable.Starter = ply
		SVTable.Time = tonumber (args[1])
		SVTable.Title = args[2]
		SVTable.Command = args[3]
		if SVTable.Command == nil then SVTable.Command = "" end
		if not ply:IsAdmin() or not ply:IsSuperAdmin() then SVTable.Command = "" end
		SVTable.Color = Color (100,130,255,255)
		SVTable.Theme = "Dark"
		SVTable.Warning = true
		Countdown.Start()
	else
		MsgC (Color (17,236,116,255),"[Republic Countdowns] ",Color(255,255,255), "You do not have permission to run a timer!\n")
	end
end, nil, "First argument sets the time, second sets the text to display, third is a concommand should be ran. \nExample - countdown_start 60 Cleanup gmod_admin_cleanup")

concommand.Add ("countdown_stop", function () Countdown.Stop() end, nil, "Aborts the countdown.")
