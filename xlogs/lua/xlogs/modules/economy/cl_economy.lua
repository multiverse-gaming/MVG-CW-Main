xLogs.Economy = xLogs.Economy or {}
xLogs.Economy.Info = xLogs.Economy.Info or {}
xLogs.Economy.PlayerInfo = xLogs.Economy.PlayerInfo or {}

net.Receive("xLogsSendEconomyInfo", function()
	xLogs.Economy.Info = util.JSONToTable(util.Decompress(net.ReadData(net.ReadUInt(32))) or "")
end)

net.Receive("xLogsSendEconomyPlayerInfo", function()
	xLogs.Economy.PlayerInfo = util.JSONToTable(util.Decompress(net.ReadData(net.ReadUInt(32))) or "")
end)

function xLogs.Economy.ConvertGraphData()
	local keys = {}
	local vals = {}
	table.sort(xLogs.Economy.Info, function(a, b) return tonumber(a.Time) > tonumber(b.Time) end)

	local sortedvals = table.Copy(xLogs.Economy.Info) or {}

	local x = 1
	for k, v in pairs(sortedvals) do
		if x > 7 then break end

		table.insert(vals, v.Money)
		x = x + 1
	end

	local x = 1
	for k, v in pairs(sortedvals) do
		if x > 7 then break end

		table.insert(keys, os.date("%d/%m/%Y", v.Time))
		x = x + 1
	end

	keys = table.Reverse(keys)
	vals = table.Reverse(vals)

	return keys, vals
end

function xLogs.Economy.GetPrevWeekSorted()
	local vals = {}
	table.sort(xLogs.Economy.Info, function(a, b) return tonumber(a.Time) > tonumber(b.Time) end)

	local sortedvals = table.Copy(xLogs.Economy.Info) or {}

	local x = 1
	for k, v in pairs(sortedvals) do
		if x < 7 then x = x + 1 continue end
		if x >= 14 then break end

		table.insert(vals, v.Money)
		x = x + 1
	end

	return vals
end

function xLogs.Economy.EconomyTab()
	xLogs.Menu.SecondaryNav:Update({})
	local EconomyTab = xLogs.Utils.DoScrollPnl(xLogs.Menu.Content, 0, 0, xLogs.Menu.Content:GetWide(), xLogs.Menu.Content:GetTall())

	local xdat, ydat = xLogs.Economy.ConvertGraphData()
	local graph = xLogs.Utils.CreateGraph(EconomyTab, xLogs.Utils.ScreenScale(10), xLogs.Utils.ScreenScale(29, true), EconomyTab:GetWide() - xLogs.Utils.ScreenScale(20), EconomyTab:GetTall() - xLogs.Utils.ScreenScale(67, true), xLogs.GetLanguageString("economygraph"), xLogs.GetLanguageString("date"), xLogs.GetLanguageString("money"), xdat, ydat)
	
	local statsbtn = xLogs.Utils.DoRoundedRectButton(EconomyTab, xLogs.GetLanguageString("statistics"), "xLogsSelawik22", EconomyTab:GetWide() / 2 - (EconomyTab:GetWide() * 0.3) / 2, EconomyTab:GetTall() - xLogs.Utils.ScreenScale(47, true), EconomyTab:GetWide() * 0.3, xLogs.Utils.ScreenScale(32, true), Color(40, 40, 40, 255), Color(20, 20, 20, 255), Color(255, 255, 255, 255))
	function statsbtn:DoClick()
		xLogs.Menu.ShowTab(xLogs.Economy.StatisticsTab)
	end

	return EconomyTab
end

function xLogs.Economy.GetWeeklyAverage()
	local _, curweek = xLogs.Economy.ConvertGraphData()
		
	local avgs = {}
	for k, v in ipairs(curweek) do
		if k == 1 then continue end
		table.insert(avgs, v - curweek[k - 1])
	end

	local tot = 0
	for k, v in ipairs(avgs) do tot = tot + v end
	local avg = (tot or 0) / table.Count(avgs)

	return avg
end

function xLogs.Economy.GetDailyGrowth()
	local avg = xLogs.Economy.GetWeeklyAverage()

	return (avg or 0) / 7
end

function xLogs.Economy.GetProjectedNum()
	local _, curweek = xLogs.Economy.ConvertGraphData()
	curweek = curweek or {}

	local avg = xLogs.Economy.GetDailyGrowth()
	local cur = curweek[table.Count(curweek)]

	return (cur or 0) + (avg * 7)
end

local economystats = {
	{Tit = "weeklygrowth", Func = function()
		local _, curweek = xLogs.Economy.ConvertGraphData()
		table.sort(curweek, function(a, b) return a > b end)
		local max = curweek[1] or 0

		local prevweek = xLogs.Economy.GetPrevWeekSorted()
		local prevmax = prevweek[1] or 0

		local diff = max - prevmax
		local percent = (diff / prevmax) * 100
		local incr = diff > 0
		local col = incr and "0,255,0" or "255,0,0"
		local sign = incr and "+" or ""

		return string.format("<colour=%s>%s%s%s</colour>", col, sign, math.Round(percent, 3), "%")
	end},

	{Tit = "projectedgrowth", Func = function()
		local _, curweek = xLogs.Economy.ConvertGraphData()
		local cur = curweek[table.Count(curweek)] or 0

		local projectednum = xLogs.Economy.GetProjectedNum()

		local diff = projectednum - cur
		local percent = (diff / cur) * 100
		local incr = diff > 0
		local col = incr and "0,255,0" or "255,0,0"
		local sign = incr and "+" or ""

		return string.format("<colour=%s>%s%s%s</colour>", col, sign, math.Round(percent, 3), "%")
	end},

	{Tit = "weekaverage", Func = function()
		local avg = xLogs.Economy.GetWeeklyAverage()
		return DarkRP.formatMoney(math.Round(avg))
	end},

	{Tit = "lastweekaverage", Func = function()
		local prevweek = xLogs.Economy.GetPrevWeekSorted()

		local tot = 0
		for k, v in ipairs(prevweek) do
			tot = tot + v
		end

		return DarkRP.formatMoney(math.Round(tot / table.Count(prevweek)))
	end},

	{Tit = "avgdailygrowth", Func = function()
		return DarkRP.formatMoney(math.Round(xLogs.Economy.GetDailyGrowth()))
	end},

	{Tit = "weekprojection", Func = function()
		return DarkRP.formatMoney(math.Round(xLogs.Economy.GetProjectedNum()))
	end},
}

function xLogs.Economy.StatisticsTab()
	local StatisticsTab = xLogs.Utils.DoScrollPnl(xLogs.Menu.Content, 0, 0, xLogs.Menu.Content:GetWide(), xLogs.Menu.Content:GetTall())
	local _, dat = xLogs.Economy.ConvertGraphData()
	dat = dat or {}

	local tit = xLogs.Utils.DoText(StatisticsTab, xLogs.GetLanguageString("economystats"), "xLogsSelawik32", Color(255, 255, 255, 255), false)
	tit:SetPos(xLogs.Utils.ScreenScale(10, true), xLogs.Utils.ScreenScale(10, true))

	local PlayersColHead = xLogs.Utils.DoText(StatisticsTab, xLogs.GetLanguageString("richestplayers"), "xLogsSelawik28", Color(255, 255, 255, 255))
	PlayersColHead:SetPos(xLogs.Utils.ScreenScale(10, true), tit:GetTall() + xLogs.Utils.ScreenScale(15, true))

	local PlayersCol = xLogs.Utils.DoScrollPnl(StatisticsTab, xLogs.Utils.ScreenScale(10, true), tit:GetTall() + PlayersColHead:GetTall() + xLogs.Utils.ScreenScale(20, true), StatisticsTab:GetWide() / 3 - xLogs.Utils.ScreenScale(20, true), StatisticsTab:GetTall() - PlayersColHead:GetTall() - tit:GetTall() - xLogs.Utils.ScreenScale(30, true))
	xLogs.Utils.HideScrollBar(PlayersCol)

	table.sort(xLogs.Economy.PlayerInfo or {}, function(a, b) return a.Money > b.Money end)

	local y = 0
	for k, v in ipairs(xLogs.Economy.PlayerInfo or {}) do
		local money = v.Money
		local perc = math.Round((money / (dat[table.Count(dat)] or 1)) * 100, 3)
		
		local tx = markup.Parse(string.format("<font=xLogsSelawik22><colour=255,255,255>%s:</colour> <colour=200,200,200>%s (<colour=0,255,0>%s%s</colour>)</colour></font>", v.Name, DarkRP.formatMoney(tonumber(money)), perc, "%"), PlayersCol:GetWide() - xLogs.Utils.ScreenScale(10))
		local statrow = xLogs.Utils.DoRectPanel(PlayersCol, 0, y, PlayersCol:GetWide(), xLogs.Utils.ScreenScale(32, true), Color(0, 0, 0, 255))

		function statrow:Paint(w, h)
			tx:Draw(0, h / 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end

		PlayersCol:AddItem(statrow)

		y = y + statrow:GetTall() + xLogs.Utils.ScreenScale(5, true)
	end

	local StatsColHead = xLogs.Utils.DoText(StatisticsTab, xLogs.GetLanguageString("information"), "xLogsSelawik28", Color(255, 255, 255, 255))
	StatsColHead:SetPos(StatisticsTab:GetWide() / 2, tit:GetTall() + xLogs.Utils.ScreenScale(15, true))

	local StatsCol = xLogs.Utils.DoScrollPnl(StatisticsTab, StatisticsTab:GetWide() / 2, tit:GetTall() + StatsColHead:GetTall() + xLogs.Utils.ScreenScale(20, true), StatisticsTab:GetWide() / 3 - xLogs.Utils.ScreenScale(20, true), StatisticsTab:GetTall() - StatsColHead:GetTall() - tit:GetTall() - xLogs.Utils.ScreenScale(30, true))
	xLogs.Utils.HideScrollBar(StatsCol)
	
	local y = 0
	for k, v in ipairs(economystats or {}) do
		local tx = markup.Parse(string.format("<font=xLogsSelawik22><colour=255,255,255>%s:</colour> <colour=200,200,200>%s</colour></font>", xLogs.GetLanguageString(v.Tit), v.Func()), StatsCol:GetWide() - xLogs.Utils.ScreenScale(10))
		local inforow = xLogs.Utils.DoRectPanel(StatsCol, 0, y, StatsCol:GetWide(), xLogs.Utils.ScreenScale(32, true), Color(0, 0, 0, 255))

		function inforow:Paint(w, h)
			tx:Draw(0, h / 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end

		StatsCol:AddItem(inforow)

		y = y + inforow:GetTall() + xLogs.Utils.ScreenScale(5, true)
	end

	return StatisticsTab
end

hook.Add("InitPostEntity", "xLogsLoadEconomyTab", function()
	if DarkRP then
		xLogs.Menu.RegisterTab("xlogs/paperlist.png", xLogs.GetLanguageString("economy"), xLogs.Economy.EconomyTab)
	end
end)