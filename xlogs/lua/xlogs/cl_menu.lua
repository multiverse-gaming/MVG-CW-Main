xLogs.Menu = xLogs.Menu or {}

CreateClientConVar("xLogsBackgroundURL", "", true, false, "")

-- Open menu base
function xLogs.Menu.Open()
	if xLogs.Menu.Background and IsValid(xLogs.Menu.Background) then xLogs.Menu.Background:Close() return end

	local tabs = xLogs.Menu.MainTabs

	xLogs.Menu.Background = vgui.Create("DFrame")
	xLogs.Menu.Background:SetSize(ScrW(), ScrH())
	xLogs.Menu.Background:Center()
	xLogs.Menu.Background:SetDraggable(false)
	xLogs.Menu.Background:SetTitle("")
	xLogs.Menu.Background:ShowCloseButton(false)
	xLogs.Menu.Background:MakePopup()
	xLogs.Menu.Background.Paint = function(s) Derma_DrawBackgroundBlur(s) end

	xLogs.Menu.MainPanel = xLogs.Utils.DoTexturedRectPanelCentered(xLogs.Menu.Background,
		xLogs.Menu.Background:GetWide() * 0.6,
		xLogs.Menu.Background:GetTall() * 0.55,
		xLogs.Config.MenuBackground
	)

	local x, y = xLogs.Menu.MainPanel:GetPos()
	local rem = xLogs.Menu.MainPanel:GetTall() % 8
	xLogs.Menu.MainPanel:SetPos(x, y + ((xLogs.Menu.MainPanel:GetTall() / 8) / 2))
	if GetConVar("xLogsBackgroundURL") and GetConVar("xLogsBackgroundURL"):GetString() ~= "" then -- Make sure a background URL has been set
		-- Create a web material for the background
		xLogs.Utils.CreateWebMaterial(xLogs.Menu.MainPanel, GetConVar("xLogsBackgroundURL"):GetString(), GetConVar("xLogsBackgroundURL"):GetString())
	end

	local x, y = xLogs.Menu.MainPanel:GetPos()
	xLogs.Menu.PrimaryNav = xLogs.Utils.DoGrid(xLogs.Menu.Background,
		x,
		y - xLogs.Utils.ScreenScale(45, true),
		xLogs.Menu.MainPanel:GetWide(),
		xLogs.Utils.ScreenScale(45, true),
		table.Count(tabs),
		0,
		0
	)

	for k, v in ipairs(tabs) do
		local row = xLogs.Utils.DoGridRow(xLogs.Menu.PrimaryNav, xLogs.Menu.PrimaryNav:GetTall(), Color(40, 40, 40, 255), true, Color(33, 33, 33, 255), true)
		
		local hov = Color(33, 33, 33, 255)
		local bg = Color(40, 40, 40, 255)
		local bar = Color(20, 20, 20, 255)
		local barhov = Color(50, 50, 75, 255)

		function row:Paint(w, h)
			local ishov = self:IsHovered()
			local bgcol = ishov and hov or bg

			surface.SetDrawColor(bgcol)
			surface.DrawRect(0, 0, w, h)

			local barcol = ishov and barhov or bar
			surface.SetDrawColor(barcol)
			surface.DrawRect(0, h - xLogs.Utils.ScreenScale(3, true), w, xLogs.Utils.ScreenScale(3, true))
		end

		if k == #tabs then row:SetWide(row:GetWide() + rem) end --it doesn't fit so we gotta maths it
		local oldhov = row.IsHovered

		function row:IsHovered()
			if xLogs.Menu.CurrentTab == v.func then
				return true
			end

			return oldhov(self)
		end

		function row:DoClick()
			if v.NotTab then
				v.func()
			else
				xLogs.Menu.ShowTab(v.func)
			end
		end

		local tx = xLogs.Utils.DoText(row, v.Title, "xLogsSelawik28", Color(255, 255, 255, 255), false)
		tx:SetPos(row:GetWide() / 2 - tx:GetWide() / 2, row:GetTall() / 2 - tx:GetTall() / 2)
	end

	xLogs.Menu.SecondaryNav = xLogs.Utils.DoGrid(xLogs.Menu.MainPanel, 0, 0, 0, xLogs.Menu.MainPanel:GetTall() + 1, 1, 0, 0, true)
	xLogs.Menu.Content = xLogs.Utils.DoScrollPnl(xLogs.Menu.MainPanel,
		xLogs.Menu.SecondaryNav:GetWide(),
		0,
		xLogs.Menu.MainPanel:GetWide() - xLogs.Menu.SecondaryNav:GetWide(),
		xLogs.Menu.MainPanel:GetTall()
	)

	-- Update sub categories
	function xLogs.Menu.SecondaryNav:Update(subcats, forceselected)
		xLogs.Menu.SecondaryNav:SetSize(xLogs.Menu.MainPanel:GetTall() / 5, xLogs.Menu.MainPanel:GetTall() + 1)
		xLogs.Menu.Content:SetSize(xLogs.Menu.MainPanel:GetWide() - xLogs.Menu.SecondaryNav:GetWide(), xLogs.Menu.Content:GetTall())
		xLogs.Menu.SecondaryNav:Clear()

		if table.Count(subcats) <= 0 then
			xLogs.Menu.SecondaryNav:SetVisible(false)
			xLogs.Menu.Content:SetPos(0, 0)
			xLogs.Menu.Content:SetWide(xLogs.Menu.MainPanel:GetWide())
			return
		else
			xLogs.Menu.SecondaryNav:SetVisible(true)
			xLogs.Menu.Content:SetPos(xLogs.Menu.SecondaryNav:GetWide(), 0)
			xLogs.Menu.Content:SetSize(xLogs.Menu.MainPanel:GetWide() - xLogs.Menu.SecondaryNav:GetWide(), xLogs.Menu.Content:GetTall())
		end

		xLogs.Menu.CurrentSecondaryTab = subcats[1].Title
		for k, v in ipairs(subcats) do
			local row
			if table.Count(subcats) < 10 then
				local rem = xLogs.Menu.MainPanel:GetTall() % table.Count(subcats)
				row = xLogs.Utils.DoGridRow(xLogs.Menu.SecondaryNav,
					(xLogs.Menu.MainPanel:GetTall() / table.Count(subcats) + ((k == 1) and rem or 0)),
					Color(70, 70, 70, 175),
					true,
					Color(33, 33, 33, 175),
					true
				)
			else
				local rem = xLogs.Menu.MainPanel:GetTall() % 5
				row = xLogs.Utils.DoGridRow(xLogs.Menu.SecondaryNav,
					xLogs.Menu.MainPanel:GetTall() / 10 + ((k == 1) and rem or 0),
					Color(70, 70, 70, 175),
					true,
					Color(33, 33, 33, 175),
					true
				)
			end
			local oldhov = row.IsHovered

			function row:IsHovered()
				if xLogs.Menu.CurrentSecondaryTab == v.Title then
					return true
				end

				return oldhov(self)
			end

			function row:DoClick()
				if (not (v.IsPopup)) then xLogs.Menu.CurrentSecondaryTab = v.Title end
				if v.NotTab then
					v.func()
				else
					xLogs.Menu.ShowTab(v.func, v.Title, true)
				end
			end
			
			if v.Title then
				local tx = xLogs.Utils.DoText(row, v.Title, "xLogsSelawik20", v.TxCol or Color(200, 200, 200, 255), false)
				tx:SetPos(row:GetWide() / 2 - tx:GetWide() / 2, (v.Icon) and (row:GetTall() / 2 + xLogs.Utils.ScreenScale(20, true)) or (row:GetTall() / 2 - tx:GetTall() / 2))
			end
		end
	end

	xLogs.Menu.ShowTab(xLogs.Menu.LoggingTab, xLogs.GetLanguageString("logs"))

	xLogs.Menu.CloseBtn = xLogs.Utils.DoCloseBtn(xLogs.Menu.MainPanel, xLogs.Menu.Background)
end
concommand.Add("xLogsToggleMenu", xLogs.Menu.Open)

function xLogs.Menu.ShowTab(func, tit, sec)
	xLogs.Menu.Content:Clear()

	func()

	if sec then
		xLogs.Menu.CurrentSecTab = func
	else
		xLogs.Menu.CurrentTab = func
	end

	xLogs.Menu.CurrentPnl = func
end

function xLogs.GetFlaggedLogs()
	local logs = {}

	for k, v in pairs(xLogs.Logs) do
		for k1, v1 in ipairs(v) do
			if xLogs.Config.ShouldFlag(v1) then
				table.insert(logs, v1)
			end
		end
	end

	return logs
end

--Get table values within a specified range
local function GetTableFromRange(tb, mn, mx)
    local rtn = {}
    
    tb = table.ClearKeys(tb)
    for x = mn, mx do
        table.insert(rtn, tb[x])
    end
    
    return rtn
end

--Sort logs for a specific page
local function SortLogs(logs, page)
    local rtn = {}
    local mn = ((page - 1) * 20) + 1
    local mx = (page * 20)
    
    table.sort(logs or {}, function(a, b) return a.Time > b.Time end)

    for k, v in pairs(GetTableFromRange(logs or {}, mn, mx)) do
    	table.insert(rtn, v)
    end
    
    return rtn
end

local function SearchCat(logs, query)
	local match = {}

	for k, v in pairs(logs or {}) do
		if string.find(string.lower(v.Content), string.lower(query)) then table.insert(match, v) end
	end

	return match
end

local function SearchTypeInCat(logs, typ)
	local match = {}

	for k, v in pairs(logs or {}) do
		if (v.Type == typ) then table.insert(match, v) end
	end

	return match
end

local function RunAdvancedSearch(cats, types, plys, query)
	local match = {}

	for k, v in pairs(xLogs.Logs) do
		for k1, v1 in pairs(v) do
			if (((table.Count(cats) == 0) or table.HasValue(cats, xLogs.LoggingCats[k])) and ((table.Count(types) == 0) or table.HasValue(types, xLogs.LoggingTypes[v1.Type]))) then
				local content = v1.Content
				if table.Count(plys) > 0 then
					for _, ply in ipairs(plys) do
						local plyStr = ply:SteamID()
						if string.find(content, plyStr) and ((not query) or (string.find(content, query))) then
							table.insert(match, v1)
						end
					end
				else
					if ((not query) or (string.find(content, query))) then
						table.insert(match, v1)
					end
				end
			end
		end
	end

	return match
end

local currentcat = ""
function xLogs.Menu.LoggingTab()
	local subcats = {}
	for k, v in pairs(xLogs.LoggingCats) do
		if not xLogs.Settings["enable" .. v.Name].Value then continue end
		if v.NeedsPermissions and (not xLogs.HasPermission(LocalPlayer(), string.format("xlogs_%s", string.lower(v.Name)))) then continue end

		local subcat = {Title = v.Name, TxCol = v.Col, func = function() xLogs.Menu.UpdateLogsTab(1, v.Name) end, NotTab = true}
		table.insert(subcats, subcat)
	end

	local flaggedSubcat = {Title = xLogs.GetLanguageString("flagged"), TxCol = Color(255, 0, 0), func = function() xLogs.Menu.UpdateLogsTab(1, "flaggedlogs") end, NotTab = true}
	table.insert(subcats, flaggedSubcat)

	xLogs.Menu.SecondaryNav:Update(subcats)

	local LoggingTab = xLogs.Utils.DoScrollPnl(xLogs.Menu.Content, 0, 0, xLogs.Menu.Content:GetWide(), xLogs.Menu.Content:GetTall())

	local SearchBox = xLogs.Utils.DoKeyboardInput(LoggingTab, xLogs.GetLanguageString("searchcategory"), xLogs.Utils.ScreenScale(5), xLogs.Utils.ScreenScale(10), LoggingTab:GetWide() * 0.4, xLogs.Utils.ScreenScale(28, true), false, "xLogsSelawik18")
	SearchBox:SetUpdateOnType(true)

	local types = {""}
	local TypeBox = xLogs.Utils.DoOptionInput(LoggingTab, SearchBox:GetWide() + xLogs.Utils.ScreenScale(10), xLogs.Utils.ScreenScale(10), LoggingTab:GetWide() * 0.4, xLogs.Utils.ScreenScale(28, true), types, xLogs.GetLanguageString("selecttype"), "xLogsSelawik18")

	local logrow = xLogs.Utils.DoRectPanel(LoggingTab, xLogs.Utils.ScreenScale(5), xLogs.Utils.ScreenScale(10) + xLogs.Utils.ScreenScale(38, true), LoggingTab:GetWide() - xLogs.Utils.ScreenScale(10), xLogs.Utils.ScreenScale(32, true), Color(30, 30, 30, 255))
		
	local typetx = xLogs.Utils.DoText(logrow, xLogs.GetLanguageString("type"), "xLogsSelawik22", Color(255, 255, 255, 255), false)
	typetx:SetPos(xLogs.Utils.ScreenScale(10, true), xLogs.Utils.ScreenScale(5, true))

	local timetx = xLogs.Utils.DoText(logrow, xLogs.GetLanguageString("time"), "xLogsSelawik22", Color(255, 255, 255, 255), false)
	timetx:SetPos(logrow:GetWide() * 0.125, xLogs.Utils.ScreenScale(5, true))

	local contenttx = xLogs.Utils.DoText(logrow, xLogs.GetLanguageString("logcontent"), "xLogsSelawik22", Color(255, 255, 255, 255), false)
	contenttx:SetPos(logrow:GetWide() * 0.35, xLogs.Utils.ScreenScale(5, true))

	local LogsGrid = xLogs.Utils.DoGrid(LoggingTab, xLogs.Utils.ScreenScale(5), xLogs.Utils.ScreenScale(10) + logrow:GetTall() + xLogs.Utils.ScreenScale(43, true), LoggingTab:GetWide() - xLogs.Utils.ScreenScale(10), LoggingTab:GetTall() - xLogs.Utils.ScreenScale(10) - logrow:GetTall() - xLogs.Utils.ScreenScale(82, true), 1, xLogs.Utils.ScreenScale(5), xLogs.Utils.ScreenScale(5))

	function xLogs.Menu.UpdateLogsTab(page, loggingcat)
		function SearchBox:OnValueChange(val)
			local logs = SearchCat(xLogs.Logs[currentcat], val)
			xLogs.Menu.UpdateLogsTab(1, logs)
		end

		local unsortedlogs = {}
		local logs = {}

		if istable(loggingcat) then
			unsortedlogs = loggingcat or {}
			logs = SortLogs(loggingcat, page) or {}
		else
			unsortedlogs = (loggingcat == "flaggedlogs") and xLogs.GetFlaggedLogs() or xLogs.Logs[loggingcat] or {}
			logs = (loggingcat == "flaggedlogs") and SortLogs(xLogs.GetFlaggedLogs(), page) or SortLogs(xLogs.Logs[loggingcat], page) or {}
			currentcat = loggingcat

			local types = {}
			for k, v in pairs(xLogs.LoggingTypes) do
				if (v.Cat == currentcat) then
					table.insert(types, v.Name)
				end
			end
			TypeBox:UpdateOptions(types)

			SearchBox:SetValue("")
		end

		function TypeBox:OnSelect(index, val)
			local logs = SearchTypeInCat(xLogs.Logs[currentcat], val)
			xLogs.Menu.UpdateLogsTab(1, logs)
		end

		LogsGrid:Clear()

		if table.Count(logs) > 0 then
			-- Logging table header
			for k, v in ipairs(logs) do
				if not xLogs.LoggingTypes[v.Type] then continue end

				-- Strip instances of SteamName (SteamID) from content
				local formatPlayers = string.gmatch(v.Content, "([0-z]+ %(STEAM_[^ ]*%))")
				-- Strip instances of Entity (EntityID) from content
				local formatEntities = string.gmatch(v.Content, "([0-z]+ %([0-9]*%))")
				-- Format text contents
				local content = string.format("<font=xLogsSelawik20>%s</font>", v.Content)
				
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

				local markup = markup.Parse(content, logrow:GetWide() * 0.64)

				local logrow = xLogs.Utils.DoGridRow(LogsGrid, markup:GetHeight() + xLogs.Utils.ScreenScale(10, true), (k % 2 == 0) and Color(50, 50, 50, 255) or Color(45, 45, 45, 255), true, Color(40, 40, 40, 255))
				
				local typetx = xLogs.Utils.DoText(logrow, v.Type, "xLogsSelawik20", xLogs.LoggingTypes[v.Type].Col or Color(255, 255, 255, 255), false)
				typetx:SetPos(xLogs.Utils.ScreenScale(10, true), xLogs.Utils.ScreenScale(5, true))
				
				local timetx = xLogs.Utils.DoText(logrow, os.date("%H:%M:%S - %d/%m/%Y", v.Time or 0), "xLogsSelawik20", Color(255, 255, 255, 255), false)
				timetx:SetPos(logrow:GetWide() * 0.125, xLogs.Utils.ScreenScale(5, true))

				local contenttx = vgui.Create("DButton", logrow)
				contenttx:SetText("")
				contenttx:SetPos(logrow:GetWide() * 0.35, xLogs.Utils.ScreenScale(5, true))
				contenttx:SetSize(logrow:GetWide() * 0.65, markup:GetHeight())

				function contenttx:Paint(w, h)
					markup:Draw(0, h / 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end

				function logrow:DoClick()
					local options = DermaMenu()

					options:AddOption(xLogs.GetLanguageString("copylog"), function()
						SetClipboardText(string.format("%s: %s", os.date("%H:%M:%S - %d/%m/%Y", v.Time), v.Content))
					end)

					if (table.Count(steamids) > 0) then
						local assoc, parent = options:AddSubMenu(xLogs.GetLanguageString("associatedplayers"))

						for k, info in ipairs(steamids) do
							local sid = info[1]
							local nick = info[2]

							assoc:AddOption(nick, function()
								xLogs.Utils.UserInfoPanel(nick, sid)
							end)
						end
					end

					if (table.Count(entityids) > 0) then
						local assoc, parent = options:AddSubMenu(xLogs.GetLanguageString("associatedentities"))

						for k, info in ipairs(entityids) do
							local entityid = info[1]
							local entityclass = info[2]

							assoc:AddOption(string.format("%s (%s)", entityclass, entityid))
						end
					end

					options:Open()
	                
					for x = 1, options:ChildCount() do
						local pnl = options:GetChild(x)
						function pnl:Paint(w, h)
							local col = Color(200, 200, 200)
							local back = Color(35, 35, 35)

							if pnl.Hovered then
								col = Color(255, 255, 255)
								back = Color(20, 20, 20)
							end

							draw.RoundedBox(0, 0, 0, w, h, back)
							draw.SimpleText(pnl:GetText(), "xLogsSelawik18", xLogs.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
							
							return true
						end
					end
				end

				-- Ensure we can still hover over the text
				local old = logrow.IsHovered
				function contenttx:OnCursorEntered()
					function logrow:IsHovered()
						return true
					end
				end

				function contenttx:OnCursorExited()
					logrow.IsHovered = old
				end

				contenttx.DoClick = logrow.DoClick
			end
		else
			-- If no players are found, let the user know
			local logrow = xLogs.Utils.DoGridRow(LogsGrid, xLogs.Utils.ScreenScale(30, true), Color(45, 45, 45, 255))
			local logtx = xLogs.Utils.DoText(logrow, "No logs found!", "xLogsSelawik20", Color(255, 255, 255, 255), false)
			logtx:SetPos(xLogs.Utils.ScreenScale(10, true), xLogs.Utils.ScreenScale(5, true))
		end

		-- Pagination
		local pagepnl = xLogs.Utils.DoRoundedRectPnl(LoggingTab, xLogs.Utils.ScreenScale(5), LoggingTab:GetTall() - xLogs.Utils.ScreenScale(32, true), LoggingTab:GetWide() - xLogs.Utils.ScreenScale(10), xLogs.Utils.ScreenScale(28, true), Color(20, 20, 20, 266))
		local pgs = (table.Count(unsortedlogs) / 20)
		local tit = xLogs.Utils.DoText(pagepnl, string.format("Page %i of %i", page, (pgs == 0) and 1 or pgs), "xLogsSelawik18", Color(255, 255, 255, 255), true, 0)
		
		-- Only draw page next page button if there is a next page
		if table.Count(unsortedlogs) > (20 * (page + 1)) then
			local nxt = xLogs.Utils.DoRoundedRectButton(pagepnl, ">", "xLogsSelawik18", pagepnl:GetWide() - xLogs.Utils.ScreenScale(28, true), 0, xLogs.Utils.ScreenScale(28, true), xLogs.Utils.ScreenScale(28, true), Color(40, 40, 40, 0), Color(40, 40, 40, 255), Color(255, 255, 255, 255))
			function nxt.DoClick()
				page = page + 1
				xLogs.Menu.UpdateLogsTab(page, loggingcat)
			end
		end

		-- Only draw previous page button if there is a previous page
		if page > 1 then
			local prev = xLogs.Utils.DoRoundedRectButton(pagepnl, "<", "xLogsSelawik18", 0, 0, xLogs.Utils.ScreenScale(28, true), xLogs.Utils.ScreenScale(28, true), Color(40, 40, 40, 0), Color(40, 40, 40, 255), Color(255, 255, 255, 255))
			function prev.DoClick()
				page = page - 1
				xLogs.Menu.UpdateLogsTab(page, loggingcat)
			end
		end
	end

	xLogs.Menu.UpdateLogsTab(1, subcats[1].Title)

	return LoggingTab
end

function xLogs.Menu.SearchingTab()
	xLogs.Menu.SecondaryNav:Update({})

	local SearchingTab = xLogs.Utils.DoScrollPnl(xLogs.Menu.Content, 0, 0, xLogs.Menu.Content:GetWide(), xLogs.Menu.Content:GetTall())

	local CategoryCol = xLogs.Utils.DoScrollPnl(SearchingTab, xLogs.Utils.ScreenScale(10, true), xLogs.Utils.ScreenScale(57, true), SearchingTab:GetWide() / 3 - xLogs.Utils.ScreenScale(20, true), SearchingTab:GetTall() - xLogs.Utils.ScreenScale(109, true))
	local TypeCol = xLogs.Utils.DoScrollPnl(SearchingTab, xLogs.Utils.ScreenScale(10, true) + CategoryCol:GetWide(), xLogs.Utils.ScreenScale(57, true), SearchingTab:GetWide() / 3 - xLogs.Utils.ScreenScale(20, true), SearchingTab:GetTall() - xLogs.Utils.ScreenScale(109, true))
	local PlayerCol = xLogs.Utils.DoScrollPnl(SearchingTab, xLogs.Utils.ScreenScale(10, true) + CategoryCol:GetWide() + TypeCol:GetWide(), xLogs.Utils.ScreenScale(57, true), SearchingTab:GetWide() / 3 - xLogs.Utils.ScreenScale(20, true), SearchingTab:GetTall() - xLogs.Utils.ScreenScale(109, true))

	local catboxes = {}
	local y = 0

	local headerCat = xLogs.Utils.DoText(SearchingTab, xLogs.GetLanguageString("categories"), "xLogsSelawik32", Color(255, 255, 255, 255))
	headerCat:SetPos(xLogs.Utils.ScreenScale(10, true), xLogs.Utils.ScreenScale(57, true) / 2 - headerCat:GetTall() / 2)

	for k, v in pairs(xLogs.LoggingCats) do
		if not xLogs.Settings["enable" .. v.Name].Value then continue end

		local checkbox = xLogs.Utils.DoCheckbox(CategoryCol, 0, y, xLogs.Utils.ScreenScale(32, true), xLogs.Utils.ScreenScale(32, true), Color(35, 35, 35), Color(20, 150, 20), false, function() end)
		checkbox.Content = v
		local tx = xLogs.Utils.DoText(CategoryCol, v.Name, "xLogsSelawik22", Color(255, 255, 255, 255))
		tx:SetPos(xLogs.Utils.ScreenScale(42, true), y + checkbox:GetTall() / 2 - tx:GetTall() / 2)

		table.insert(catboxes, checkbox)

		y = y + checkbox:GetTall() + xLogs.Utils.ScreenScale(5, true)
	end

	local logboxes = {}
	local y = 0

	local headerTyp = xLogs.Utils.DoText(SearchingTab, xLogs.GetLanguageString("types"), "xLogsSelawik32", Color(255, 255, 255, 255))
	headerTyp:SetPos(xLogs.Utils.ScreenScale(10, true) + CategoryCol:GetWide(), xLogs.Utils.ScreenScale(57, true) / 2 - headerTyp:GetTall() / 2)

	for k, v in pairs(xLogs.LoggingTypes) do
		local checkbox = xLogs.Utils.DoCheckbox(TypeCol, 0, y, xLogs.Utils.ScreenScale(32, true), xLogs.Utils.ScreenScale(32, true), Color(35, 35, 35), Color(20, 150, 20), false, function() end)
		checkbox.Content = v
		local tx = xLogs.Utils.DoText(TypeCol, v.Name, "xLogsSelawik22", Color(255, 255, 255, 255))
		tx:SetPos(xLogs.Utils.ScreenScale(42, true), y + checkbox:GetTall() / 2 - tx:GetTall() / 2)

		table.insert(logboxes, checkbox)

		y = y + checkbox:GetTall() + xLogs.Utils.ScreenScale(5, true)
	end

	local plyboxes = {}
	local y = 0

	local headerPly = xLogs.Utils.DoText(SearchingTab, xLogs.GetLanguageString("players"), "xLogsSelawik32", Color(255, 255, 255, 255))
	headerPly:SetPos(xLogs.Utils.ScreenScale(10, true) + CategoryCol:GetWide() + TypeCol:GetWide(), xLogs.Utils.ScreenScale(57, true) / 2 - headerPly:GetTall() / 2)

	for k, v in ipairs(player.GetAll()) do
		local checkbox = xLogs.Utils.DoCheckbox(PlayerCol, 0, y, xLogs.Utils.ScreenScale(32, true), xLogs.Utils.ScreenScale(32, true), Color(35, 35, 35), Color(20, 150, 20), false, function() end)
		checkbox.Content = v
		local tx = xLogs.Utils.DoText(PlayerCol, v:Nick(), "xLogsSelawik22", Color(255, 255, 255, 255))
		tx:SetPos(xLogs.Utils.ScreenScale(42, true), y + checkbox:GetTall() / 2 - tx:GetTall() / 2)

		table.insert(plyboxes, checkbox)

		y = y + checkbox:GetTall() + xLogs.Utils.ScreenScale(5, true)
	end

	local query = xLogs.Utils.DoKeyboardInput(SearchingTab, xLogs.GetLanguageString("searchquery"), xLogs.Utils.ScreenScale(10), SearchingTab:GetTall() - xLogs.Utils.ScreenScale(10, true) - xLogs.Utils.ScreenScale(32, true), SearchingTab:GetWide() * 0.75 - xLogs.Utils.ScreenScale(30), xLogs.Utils.ScreenScale(32, true), false, "xLogsSelawik22")

	local searchbtn = xLogs.Utils.DoRoundedButton(SearchingTab, xLogs.GetLanguageString("runsearch"), "xLogsSelawik22", SearchingTab:GetWide() - (SearchingTab:GetWide() * 0.25) - xLogs.Utils.ScreenScale(10), SearchingTab:GetTall() - xLogs.Utils.ScreenScale(10, true) - xLogs.Utils.ScreenScale(32, true), SearchingTab:GetWide() * 0.25, xLogs.Utils.ScreenScale(32, true), Color(40, 75, 40, 255), Color(255, 255, 255))
	function searchbtn:DoClick()
		local cats = {}
		for k, v in ipairs(catboxes) do
			if v:GetChecked() then
				table.insert(cats, v.Content)
			end
		end

		local types = {}
		for k, v in ipairs(logboxes) do
			if v:GetChecked() then
				table.insert(types, v.Content)
			end
		end

		local plys = {}
		for k, v in ipairs(plyboxes) do
			if v:GetChecked() then
				table.insert(plys, v.Content)
			end
		end

		local q = query:GetText()

		local logs = RunAdvancedSearch(cats, types, plys, q)
		xLogs.Menu.ShowTab(xLogs.Menu.LoggingTab, xLogs.GetLanguageString("logs"))
		currentcat = ""
		xLogs.Menu.UpdateLogsTab(1, logs)
	end

	return SearchingTab
end

local function GetSettings()
	local clientside = {}
	local serverside = {}

	for k, v in pairs(xLogs.Settings) do
		table.insert(v.ServerSide and serverside or clientside, v)
	end

	return clientside, serverside
end

function xLogs.Menu.SettingsTab()
	xLogs.Menu.SecondaryNav:Update({})

	local SettingsTab = xLogs.Utils.DoScrollPnl(xLogs.Menu.Content, 0, 0, xLogs.Menu.Content:GetWide(), xLogs.Menu.Content:GetTall())
	local ClientCol = xLogs.Utils.DoScrollPnl(SettingsTab, xLogs.Utils.ScreenScale(10, true), xLogs.Utils.ScreenScale(57, true), SettingsTab:GetWide() / 2 - xLogs.Utils.ScreenScale(20, true), SettingsTab:GetTall() - xLogs.Utils.ScreenScale(77, true))
	local ServerCol = xLogs.Utils.DoScrollPnl(SettingsTab, xLogs.Utils.ScreenScale(10, true) + ClientCol:GetWide(), xLogs.Utils.ScreenScale(57, true), SettingsTab:GetWide() / 2 - xLogs.Utils.ScreenScale(20, true), SettingsTab:GetTall() - xLogs.Utils.ScreenScale(77, true))

	local clientSettings, serverSettings = GetSettings()

	local headerClient = xLogs.Utils.DoText(SettingsTab, xLogs.GetLanguageString("clientside"), "xLogsSelawik32", Color(255, 255, 255, 255))
	headerClient:SetPos(xLogs.Utils.ScreenScale(10, true), xLogs.Utils.ScreenScale(57, true) / 2 - headerClient:GetTall() / 2)

	local y = 0
	for k, v in ipairs(clientSettings) do		
		local checkbox = xLogs.Utils.DoCheckbox(ClientCol, 0, y, xLogs.Utils.ScreenScale(32, true), xLogs.Utils.ScreenScale(32, true), Color(35, 35, 35), Color(20, 150, 20), v.Value or false, function(self, val)
			v.Func(val)
		end)
		local tx = xLogs.Utils.DoText(ClientCol, v.Name, "xLogsSelawik22", Color(255, 255, 255, 255))
		tx:SetPos(xLogs.Utils.ScreenScale(42, true), y + checkbox:GetTall() / 2 - tx:GetTall() / 2)

		y = y + checkbox:GetTall() + xLogs.Utils.ScreenScale(5, true)
	end

	local headerServer = xLogs.Utils.DoText(SettingsTab, xLogs.GetLanguageString("serverside"), "xLogsSelawik32", Color(255, 255, 255, 255))
	headerServer:SetPos(xLogs.Utils.ScreenScale(10, true) + ClientCol:GetWide(), xLogs.Utils.ScreenScale(57, true) / 2 - headerServer:GetTall() / 2)

	local y = 0
	for k, v in ipairs(serverSettings) do
		if not xLogs.HasPermission(LocalPlayer(), v.Permission) then continue end

		local checkbox = xLogs.Utils.DoCheckbox(ServerCol, 0, y, xLogs.Utils.ScreenScale(32, true), xLogs.Utils.ScreenScale(32, true), Color(35, 35, 35), Color(20, 150, 20), v.Value or false, function(self, val)
			net.Start("xLogsUpdateSetting", true)
				net.WriteString(v.ID)
				net.WriteBool(val)
			net.SendToServer()
		end)

		local tx = xLogs.Utils.DoText(ServerCol, v.Name, "xLogsSelawik22", Color(255, 255, 255, 255))
		tx:SetPos(xLogs.Utils.ScreenScale(42, true), y + checkbox:GetTall() / 2 - tx:GetTall() / 2)

		y = y + checkbox:GetTall() + xLogs.Utils.ScreenScale(5, true)
	end

	return SettingsTab
end

xLogs.Menu.MainTabs = xLogs.Menu.MainTabs or {
	{ Icon = "xlogs/folder.png", Title = xLogs.GetLanguageString("logs"), func = xLogs.Menu.LoggingTab },
	{ Icon = "xlogs/search.png", Title = xLogs.GetLanguageString("search"), func = xLogs.Menu.SearchingTab },
	{ Icon = "xlogs/002-settings.png", Title = xLogs.GetLanguageString("settings"), func = xLogs.Menu.SettingsTab },
}

function xLogs.Menu.RegisterTab(icon, title, f)
	table.insert(xLogs.Menu.MainTabs, 2, {Icon = icon, Title = title, func = f})
end