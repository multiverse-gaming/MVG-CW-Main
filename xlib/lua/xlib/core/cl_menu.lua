xLib.Menu = xLib.Menu or {}

function xLib.CreateMenuBase(addontb, customhead)
	addontb = addontb or xLib

	addontb.Menu = addontb.Menu or {}

	if addontb.Menu.Background and IsValid(addontb.Menu.Background) then addontb.Menu.Background:Close() return end

	-- Menu base
	addontb.Menu.Background = vgui.Create("DFrame")
	addontb.Menu.Background:SetSize(ScrW(), ScrH())
	addontb.Menu.Background:Center()
	addontb.Menu.Background:SetDraggable(false)
	addontb.Menu.Background:SetTitle("")
	addontb.Menu.Background:ShowCloseButton(false)
	addontb.Menu.Background:MakePopup()
	function addontb.Menu.Background:Paint() end
	
	addontb.Menu.MainPanel = xLib.Utils.DoRoundedRectPanelCentered(addontb.Menu.Background,
		addontb.Menu.Background:GetWide() * 0.6,
		addontb.Menu.Background:GetTall() * 0.7,
		Color(24, 24, 24, 255),
		5
	)

	local headerbarh = xLib.Utils.ScreenScale(44, true)

	local off = 0
	if customhead then
		off = customhead(addontb.Menu.MainPanel, headerbarh, addontb.Menu.MainPanel:GetWide() * 0.2)
	end

	addontb.Menu.NavBar = xLib.Utils.DoGrid(addontb.Menu.MainPanel,
		0,
		headerbarh + off,
		addontb.Menu.MainPanel:GetWide() * 0.2,
		addontb.Menu.MainPanel:GetTall() - headerbarh - off,
		Color(0, 0, 0, 0),
		1,
		0,
		0,
		true
	)

	local col = Color(37, 37, 37, 255)
	function addontb.Menu.NavBar:Paint(w, h)
		local ax, ay = self:LocalToScreen()
		if xLib.Config.DisableMenuShadows then ax, ay = 0, 0 end

		xLib.Shadows.BeginShadow()
		xLib.Utils.RoundedRect(5, ax, ay, w, h, col, true, true, false, true)
		xLib.Shadows.EndShadow(1, 1, 1)
	end

	local headerbar = xLib.Utils.DoRoundedRectPanel(addontb.Menu.MainPanel,
		0,
		0,
		addontb.Menu.MainPanel:GetWide(),
		xLib.Utils.ScreenScale(44, true),
		col,
		5,
		false,
		false,
		true,
		true
	)

	local headerlbl = xLib.Utils.DoText(headerbar, addontb.Config.MenuName or addontb.Config.Name or xLib.Config.Name, "xLibHeaderFont", Color(255, 255, 255, 255))
	headerlbl:SetPos(xLib.Utils.ScreenScale(13), xLib.Utils.ScreenScale(5, true))

	local closebtn = xLib.Utils.DoCloseBtn(headerbar, headerbar:GetTall() - xLib.Utils.ScreenScale(20, true), headerbar:GetTall() - xLib.Utils.ScreenScale(20, true), addontb.Menu.Background, xLib.Utils.ScreenScale(10, true))

	addontb.Menu.ContentPanel = xLib.Utils.DoScrollPnl(addontb.Menu.MainPanel,
		addontb.Menu.NavBar:GetWide() + xLib.Utils.ScreenScale(10),
		headerbar:GetTall() + xLib.Utils.ScreenScale(10),
		addontb.Menu.MainPanel:GetWide() - (addontb.Menu.NavBar:GetWide() + xLib.Utils.ScreenScale(20)),
		addontb.Menu.MainPanel:GetTall() - (headerbar:GetTall() + xLib.Utils.ScreenScale(20))
	)

	for k, v in ipairs(addontb.Menu.Tabs) do
		if (v.ShowCheck and isfunction(v.ShowCheck) and (not v.ShowCheck())) then continue end

		local row = xLib.Utils.DoGridRow(addontb.Menu.NavBar,
			xLib.Utils.ScreenScale(54, true),
			Color(30, 30, 30, 255),
			v.Func and true or false,
			Color(35, 35, 35, 255)
		)

		function row:DoClick()
			if addontb == xGangs then xGangs.Menu.secselected = "" end
			xLib.ShowTab(addontb, v.Tit, v.Func)
		end

		local basebgcol = Color(35, 35, 35, 255)
		local barcol = v.Col or Color(53, 127, 156, 255)
		local barw = 3

		local gradientmat = Material("xlib/gradient-sq.png")
		function row:Paint(w, h)
			surface.SetDrawColor(basebgcol)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(barcol)
			surface.SetMaterial(gradientmat)
			surface.DrawTexturedRect(0, 0, barw, h)
		end

		function row:Think()
			barw = Lerp(0.05, barw, (self:IsHovered() and row:GetWide() or 3))
		end

		local lbl = xLib.Utils.DoText(row,
			v.Tit,
			"xLibSubHeaderFont",
			Color(255, 255, 255, 255)
		)
		lbl:SetPos(xLib.Utils.ScreenScale(13), row:GetTall() / 2 - lbl:GetTall() / 2)

		local oldhov = row.IsHovered
		function row:IsHovered()
			if addontb.Menu.CurrentTab == v.Tit then return true end
			return oldhov(self)
		end
	end

	local def
	for k, v in ipairs(addontb.Menu.Tabs) do
		if (v.ShowCheck and isfunction(v.ShowCheck) and (not v.ShowCheck())) then continue end
		def = v break
	end

	if def then xLib.ShowTab(addontb, def.Tit, def.Func) end
end

function xLib.ReloadCurrentTab(addontb)
	if (not (addontb.Menu.ContentPanel and IsValid(addontb.Menu.ContentPanel))) then return end

	for k, v in ipairs(addontb.Menu.Tabs) do
		if v.Tit == addontb.Menu.CurrentTab then xLib.ShowTab(addontb, addontb.Menu.CurrentTab, v.Func) end
	end
end

function xLib.ShowTab(addontb, tit, func)
	addontb.Menu.ContentPanel:Clear()

	func()

	if tit then addontb.Menu.CurrentTab = tit end
end

function xLib.RegisterMenuTab(addontb, tit, col, func, showcheck)
	addontb.Menu = addontb.Menu or {}
	addontb.Menu.Tabs = addontb.Menu.Tabs or {}

	local tb = {Tit = tit, Col = col, Func = func, ShowCheck = showcheck}

	for k, v in ipairs(addontb.Menu.Tabs) do
		if v.Tit == tit then
			addontb.Menu.Tabs[k] = tb
			return
		end
	end

	table.insert(addontb.Menu.Tabs, tb)
end

function xLib.OpenMenu()
	xLib.CreateMenuBase()
end
concommand.Add("xLibToggleMenu", xLib.OpenMenu)

function xLib.Menu.CreateAddonInfoTab(addontb)
	local pnl = xLib.Utils.DoScrollPnl(xLib.Menu.ContentPanel,
		0,
		0,
		xLib.Menu.ContentPanel:GetWide(),
		xLib.Menu.ContentPanel:GetTall()
	)

	local versionlb = xLib.Utils.DoText(pnl,
		string.format("%s: %s.%s.%s", xLib.GetLanguageString("addonversion"), addontb.Config.MajorVersion or 1, addontb.Config.MinorVersion or 0, addontb.Config.Patch or 0),
		"xLibHeaderFont",
		Color(255, 255, 255, 255)
	)
	versionlb:SetPos(0, 0)

	local uptodate = true
	if addontb.Config.AddonID then
		xLib.FetchAddonVersions(addontb, function(dat)
			local islatest = xLib.IsLatestVersion(addontb, dat)
			if versionlb and IsValid(versionlb) then
				versionlb:SetTextColor(islatest and Color(200, 255, 200, 255) or Color(255, 200, 200, 255))
			end
		end)
	end

	local authorlb = xLib.Utils.DoText(pnl,
		string.format("%s: %s", xLib.GetLanguageString("by"), addontb.Config.Author or xLib.Config.Author),
		"xLibSubHeaderFont",
		Color(200, 200, 200, 255)
	)
	authorlb:SetPos(0, versionlb:GetTall() + xLib.Utils.ScreenScale(5, true))

	return pnl
end

local function ChangeLogsToString(changelog)
	if not changelog then return "Initial version." end

	local str = ""

	for k, v in ipairs(changelog.ops) do
		str = str .. string.Replace(v.insert, "\n", " ")
	end

	if string.len(str) >= 105 then str = string.sub(str, 1, 105) .. "..." end

	return str
end

function xLib.Menu.CreateUpdatesPanel(addontb, parent)
	local pnl = xLib.Utils.DoScrollPnl(parent,
		0,
		0,
		parent:GetWide(),
		parent:GetTall()
	)

	local updatesgrid = xLib.Utils.DoGrid(parent,
		0,
		0,
		pnl:GetWide(),
		pnl:GetTall(),
		Color(0, 0, 0, 0),
		1,
		0,
		xLib.Utils.ScreenScale(5, true),
		true
	)

	local updates = xLib.FetchAddonVersions(addontb, function(dat)
		if (not (updatesgrid and IsValid(updatesgrid))) then return end

		for k, v in ipairs(dat) do
			local row = xLib.Utils.DoGridRow(updatesgrid,
				xLib.Utils.ScreenScale(82, true),
				Color(30, 30, 30, 255),
				addontb.Config.AddonID,
				Color(35, 35, 35, 255)
			)

			function row:DoClick()
				if addontb.Config.AddonID then gui.OpenURL(string.format("https://www.gmodstore.com/market/view/%s/versions", addontb.Config.AddonID)) end
			end

			local vername = xLib.Utils.DoHeadedText(row,
				row:GetWide() - xLib.Utils.ScreenScale(10),
				xLib.Utils.ScreenScale(5),
				xLib.Utils.ScreenScale(5, true),
				string.format("v%s", v.name),
				string.format("(%s)", v.release_type),
				"xLibSubHeaderFont",
				true,
				false
			)
			vername.DoClick = row.DoClick

			local releasedate = xLib.Utils.DoText(row,
				v.updated_at,
				"xLibTitleFont",
				Color(200, 200, 200, 255)
			)
			releasedate:SetPos(xLib.Utils.ScreenScale(5), vername:GetTall() + xLib.Utils.ScreenScale(10, true))
			releasedate.DoClick = row.DoClick

			local contents = xLib.Utils.DoText(row,
				ChangeLogsToString(util.JSONToTable(v.changelog)),
				"xLibTitleFont",
				Color(200, 200, 200, 255)
			)
			contents:SetPos(xLib.Utils.ScreenScale(5), row:GetTall() - contents:GetTall() - xLib.Utils.ScreenScale(5, true))
			contents.DoClick = row.DoClick

			local oldhov = row.IsHovered
			function row:IsHovered()
				if vername:IsHovered() or releasedate:IsHovered() then return true end
				return oldhov(self)
			end
		end
	end)

	return pnl
end

function xLib.Menu.CreateConfigOption(parent, x, y, w, h, addonname, configID, curval)
	if (not xLib.ConfigOptions[addonname] and xLib.ConfigOptions[addonname][configID]) then return end

	local optionDat = xLib.ConfigOptions[addonname][configID]
	local inputTyp = optionDat.InputType

	if not xLib.ConfigTypes[optionDat.InputType] then return end

	local inputDat = xLib.ConfigTypes[optionDat.InputType]

	local namelb = xLib.Utils.DoText(parent, optionDat.Name, "xLibTitleFont", Color(255, 255, 255, 255))
	namelb:SetPos(xLib.Utils.ScreenScale(5), parent:GetTall() / 2 - namelb:GetTall() / 2)

	local confirmbtn = xLib.Utils.DoRoundedRectButton(parent,
		xLib.GetLanguageString("save"),
		"xLibTitleFont", parent:GetWide() - (parent:GetWide() * 0.1),
		0,
		parent:GetWide() * 0.1,
		parent:GetTall(),
		Color(35, 35, 35, 255),
		Color(30, 30, 30, 255),
		Color(255, 255, 255, 255),
		false,
		true
	)

	return inputDat.InputFunc(parent, namelb:GetWide() + xLib.Utils.ScreenScale(10), y, w - namelb:GetWide() - confirmbtn:GetWide() - xLib.Utils.ScreenScale(10), h, addonname, configID, curval), confirmbtn
end

function xLib.Menu.CreateConfigPanel(addontb, parent)
	local pnl = xLib.Utils.DoScrollPnl(parent,
		0,
		0,
		parent:GetWide(),
		parent:GetTall()
	)

	local configgrid = xLib.Utils.DoGrid(parent,
		0,
		0,
		pnl:GetWide(),
		pnl:GetTall(),
		Color(0, 0, 0, 0),
		1,
		0,
		xLib.Utils.ScreenScale(5, true),
		true
	)

	for k, v in pairs(xLib.ConfigOptions[addontb.Config.Name] or {}) do
		local row = xLib.Utils.DoGridRow(configgrid,
			xLib.Utils.ScreenScale(32, true),
			Color(25, 25, 25, 255)
		)

		local inputpnl, confirmbtn = xLib.Menu.CreateConfigOption(row, 0, 0, configgrid:GetWide(), xLib.Utils.ScreenScale(34, true), addontb.Config.Name, k, addontb.Config[k])

		local optionDat = xLib.ConfigOptions[addontb.Config.Name][k]
		local inputTyp = optionDat.InputType
		local inputDat = xLib.ConfigTypes[optionDat.InputType]

		function confirmbtn:DoClick()
			inputDat.OnSave(inputpnl, addontb.Config.Name, k)
		end

		inputDat.ExtraFuncs(inputpnl, addontb.Config.Name, k)
	end

	return pnl
end

local navoptions = {
	{Tit = xLib.GetLanguageString("updates"), Func = function(addontb, parent)
		xLib.Menu.CreateUpdatesPanel(addontb, parent)
	end, ShouldDisplay = function(addontb) return addontb.Config.AddonID end},
	{Tit = xLib.GetLanguageString("config"), Func = function(addontb, parent)
		xLib.Menu.CreateConfigPanel(addontb, parent)
	end},
}

function xLib.Menu.DoAddonTab(addontb, parent)
	local nav = xLib.Utils.DoGrid(parent,
		xLib.Utils.ScreenScale(15),
		xLib.Utils.ScreenScale(80, true),
		parent:GetWide() - xLib.Utils.ScreenScale(30),
		xLib.Utils.ScreenScale(34, true),
		Color(0, 0, 0, 0),
		5,
		0,
		0,
		true
	)

	local contents = xLib.Utils.DoScrollPnl(parent,
		xLib.Utils.ScreenScale(15),
		xLib.Utils.ScreenScale(85, true) + nav:GetTall(),
		nav:GetWide(),
		parent:GetTall() - (xLib.Utils.ScreenScale(85, true) + nav:GetTall() + xLib.Utils.ScreenScale(15, true))
	)

	local selected = ""
	for k, v in ipairs(navoptions) do
		if (v.ShouldDisplay and (not v.ShouldDisplay(addontb))) then continue end

		local row = xLib.Utils.DoGridRow(nav,
			xLib.Utils.ScreenScale(34, true),
			Color(30, 30, 30, 0),
			true,
			Color(35, 35, 35, 255)
		)

		local hovbarcol = Color(29, 82, 119, 255)
		local bgcol = Color(35, 35, 35, 255)
		local barw = 0

		function row:Think()
			barw = Lerp(0.05, barw, (self:IsHovered() and row:GetWide() or 0))
		end

		function row:Paint(w, h)
			surface.SetDrawColor(hovbarcol)
			surface.DrawRect(w / 2 - barw / 2, h - 3, barw, 3)
		end

		function row:DoClick()
			selected = v.Tit
			contents:Clear()
			v.Func(addontb, contents)
		end

		if selected == "" then
			row.DoClick()
		end

		local lbl = xLib.Utils.DoText(row,
			v.Tit,
			"xLibSubHeaderFont",
			Color(255, 255, 255, 255)
		)
		lbl:SetPos(row:GetWide() / 2 - lbl:GetWide() / 2, row:GetTall() / 2 - lbl:GetTall() / 2)

		function lbl:Think()
			if (row:IsHovered()) then
				lbl:SetTextColor(Color(255, 255, 255, 255))
			else
				lbl:SetTextColor(Color(200, 200, 200, 255))
			end
		end

		local oldhov = row.IsHovered
		function row:IsHovered()
			if selected == v.Tit then return true end
			return oldhov(self)
		end
	end
end

function xLib.Menu.xLibTab()
	local pnl = xLib.Menu.CreateAddonInfoTab(xLib)

	xLib.Menu.DoAddonTab(xLib, pnl)

	return pnl
end

function xLib.Menu.xAdminTab()
	local pnl = xLib.Menu.CreateAddonInfoTab(xAdmin)

	xLib.Menu.DoAddonTab(xAdmin, pnl)

	return pnl
end

function xLib.Menu.xStoreTab()
	local pnl = xLib.Menu.CreateAddonInfoTab(xStore)

	xLib.Menu.DoAddonTab(xStore, pnl)

	return pnl
end

function xLib.Menu.xWhitelistTab()
	local pnl = xLib.Menu.CreateAddonInfoTab(xWhitelist)

	xLib.Menu.DoAddonTab(xWhitelist, pnl)

	return pnl
end

function xLib.Menu.xWarnTab()
	local pnl = xLib.Menu.CreateAddonInfoTab(xWarn)

	xLib.Menu.DoAddonTab(xWarn, pnl)

	return pnl
end

function xLib.Menu.xLogsTab()
	local pnl = xLib.Menu.CreateAddonInfoTab(xLogs)

	xLib.Menu.DoAddonTab(xLogs, pnl)

	return pnl
end

xLib.RegisterMenuTab(xLib, "xLib", Color(20, 20, 200, 255), xLib.Menu.xLibTab)
--[[xLib.RegisterMenuTab(xLib, "xAdmin", xAdmin.Config.ChatPrefixCol, xLib.Menu.xAdminTab)
xLib.RegisterMenuTab(xLib, "xStore", Color(87, 101, 151, 255), xLib.Menu.xStoreTab)
xLib.RegisterMenuTab(xLib, "xWhitelist", Color(255, 156, 0, 255), xLib.Menu.xWhitelistTab)
xLib.RegisterMenuTab(xLib, "xWarn", Color(0, 156, 255, 255), xLib.Menu.xWarnTab)
xLib.RegisterMenuTab(xLib, "xLogs", Color(255, 27, 27, 255), xLib.Menu.xLogsTab)]]--