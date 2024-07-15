--Notifications
xLogs.Notifications = {}

local notifications = {}
local function UpdateNotifications(tim)
	local lastNotif

	for k, v in pairs(notifications) do
		if IsValid(v) then
			if lastNotif then
				local lastx, lasty = lastNotif:GetPos()
				v:SetPos(xLogs.Utils.ScreenScale(10), (lasty + lastNotif:GetTall()))
			else
				v:SetPos(xLogs.Utils.ScreenScale(10), xLogs.Utils.ScreenScale(10, true))
			end

			lastNotif = v

			if v:GetAlpha() < 255 then
				v:SetAlpha(math.Approach(v:GetAlpha(), 255, FrameTime() * 400))
			end

			if tim >= v.endTime then
				v:SetAlpha(math.Approach(v:GetAlpha(), 0, FrameTime() * 400))
				if v:GetAlpha() <= 0 then
					v:Remove()
					v = nil
				end
			end
		end
	end
end

-- Update notifications
hook.Add("Think", "xLogsNotificationThink", function()
	if table.Count(notifications) < 1 then
		return
	end
	UpdateNotifications(CurTime())
end)

function xLogs.GetMarkup(log, font)
	-- Strip instances of SteamName (SteamID) from content
	local formatPlayers = string.gmatch(log.Content, "([0-z]+ %(STEAM_[^ ]*%))")
	-- Strip instances of Entity (EntityID) from content
	local formatEntities = string.gmatch(log.Content, "([0-z]+ %([0-9]*%))")
	-- Format text contents
	local content = string.format("<font=%s>%s</font>", font, log.Content)
	
	local steamids = {}
	local entityids = {}

	for str in formatPlayers do
		local sid = ""
		-- Strip SteamIDs out of content
		for sids in string.gmatch(str, "STEAM_[^ ]*%)") do
			sid = string.Replace(sids, ")", "")
		end

		table.insert(steamids, {sid, string.Replace(str, string.format(" (%s)", sid), "")})

		local ply = player.GetBySteamID(sid)
		local col = (not sid) and Color(20, 200, 20, 255) or xLogs.Config.GetUserCol(ply)

		-- Colourise names and SteamIDs within content
		local formattedStr = string.format("<colour=%s,%s,%s>%s</colour>", col.r, col.g, col.b, string.Replace(str, string.format(" (%s)", sid), ""))
		content = string.Replace(content, str, formattedStr)
	end

	for str in formatEntities do
		local entid = ""
		-- Strip Entity IDs out of content
		for entids in string.gmatch(str, "[0-9]*%)") do
			entid = string.Replace(entids, ")", "")
		end

		table.insert(entityids, {entid, string.Replace(str, string.format(" (%s)", entid), "")})

		local ent = Entity(entid)
		local col = Color(255, 0, 0)

		-- Colourise entity classes and IDs within content
		local formattedStr = string.format("<colour=%s,%s,%s>%s</colour>", col.r, col.g, col.b, string.Replace(str, string.format(" (%s)", entid), ""))
		content = string.Replace(content, str, formattedStr)
	end

	return content
end

local notificationmat = Material("xlogs/016-bell.png")
function xLogs.Notify(text)
	if not text then return end

	local notif = vgui.Create("DPanel")
	notif:SetAlpha(255)
	notif:SetSize(ScrW() / 4, xLogs.Utils.ScreenScale(22, true))
	notif:SetPos(xLogs.Utils.ScreenScale(10), xLogs.Utils.ScreenScale(10, true) + (table.Count(notifications) * xLogs.Utils.ScreenScale(150)))

	notif.startTime = CurTime()
	notif.endTime = CurTime() + 5
	notif.moveToX = xLogs.Utils.ScreenScale(10)
	notif.Think = function()
		if CurTime() >= (notif.endTime + 5) then
			notif:Remove()
			notif = nil
			return
		end
	end

	local markupstr = string.format("<font=%s><color=%s>%s</color></font>", "xLogsSelawik18", "255,255,255,255", text)
	local markuptext = markup.Parse(markupstr, notif:GetWide() - (notif:GetTall() - xLogs.Utils.ScreenScale(24)))

	function notif.Paint(self, w, h)
		surface.SetDrawColor(Color(20, 20, 20, 200))
		surface.DrawRect(0, 0, self:GetWide(), self:GetTall())

		markuptext:Draw(xLogs.Utils.ScreenScale(5), xLogs.Utils.ScreenScale(3, true), nil, nil, self:GetAlpha())
	end

	function notif.PerformLayout(self, w, h)
		local tall = math.Clamp(markuptext:GetHeight(), xLogs.Utils.ScreenScale(20, true), xLogs.Utils.ScreenScale(400, true))
		self:SetTall(tall + xLogs.Utils.ScreenScale(6, true))
	end

	table.insert(notifications, notif)

	timer.Simple(10, function() xLogs.RemoveNotification(notif) end)

	return notif
end

function xLogs.RemoveNotification(pnl)
	table.RemoveByValue(notifications, pnl)
	if pnl and IsValid(pnl) then pnl:Remove() end
end

net.Receive("xLogsNetworkLog", function()
	local typ = net.ReadString()
	local content = net.ReadString()
	local tim = net.ReadInt(32)

	local cat = xLogs.LoggingTypes[typ].Cat
	table.insert(xLogs.Logs[cat], {Type = typ, Content = content, Time = tim})

	//MsgC(xLogs.LoggingTypes[typ].Col, string.format("[%s : %s] ", cat, typ), Color(200, 200, 200, 255), string.format("<%s> %s\n", os.date("%H:%M:%S - %d/%m/%Y", tim), content))

	local relaycvar = GetConVar("onscreenrelay")
	if relaycvar and relaycvar:GetBool() then
		local col = xLogs.LoggingTypes[typ].Col
		xLogs.Notify(string.format("<colour=%s,%s,%s>[%s : %s]</colour> <colour=255,255,255>%s</colour>", col.r, col.g, col.b, cat, typ, xLogs.GetMarkup({Type = typ, Content = content, Time = tim}, "xLogsSelawik18")))
	end
end)

net.Receive("xLogsNetworkLogs", function()
	local len = net.ReadUInt(32)
	for x = 1, len do
		local cat = net.ReadString()
		local typ = net.ReadString()
		local content = net.ReadString()
		local tim = net.ReadUInt(32)

		xLogs.Logs[cat] = xLogs.Logs[cat] or {}
		table.insert(xLogs.Logs[cat], {Type = typ, Content = content, Time = tim})
	end
end)

hook.Add("InitPostEntity", "xLogsRequestLogs", function()
	net.Start("xLogsRequestLogUpdate", true)
	net.SendToServer()
end)

net.Receive("xLogsUpdateSettingCl", function()
	local setting = net.ReadString()
	local val = net.ReadBool()

	xLogs.Settings[setting] = xLogs.Settings[setting] or {}
	xLogs.Settings[setting].Value = val
end)