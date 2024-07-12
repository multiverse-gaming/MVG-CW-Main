xLogs.Utils = xLogs.Utils or {}

--Blurring code modified from TDLib to allow for render stencils
local blur = Material("pp/blurscreen")

function xLogs.Utils.ScreenScale(num, h)
	local devw = 1920 --Development height
	local devh = 1080 --Development width
	
	return num * (h and (ScrH() / devh) or (ScrW() / devw))
end

-- Create xLogs fonts
function xLogs.Utils.CreateFonts()
	surface.CreateFont("xLogsSelawik18", {font = "Selawik Semilight", size = xLogs.Utils.ScreenScale(18, true), weight = 300, antialias = true})
	surface.CreateFont("xLogsSelawik20", {font = "Selawik Semilight", size = xLogs.Utils.ScreenScale(20, true), weight = 300, antialias = true})
	surface.CreateFont("xLogsSelawik22", {font = "Selawik Semilight", size = xLogs.Utils.ScreenScale(22, true), weight = 300, antialias = true})
	surface.CreateFont("xLogsSelawik28", {font = "Selawik Semilight", size = xLogs.Utils.ScreenScale(28, true), weight = 300, antialias = true})
	for x = 1, 6 do
		local s = 12 + (x * 10)
		surface.CreateFont("xLogsSelawik" .. s, {font = "Selawik Semilight", size = xLogs.Utils.ScreenScale(s, true), weight = 350, antialias = true})
	end
	surface.CreateFont("xLogsSelawikHeavy", {font = "Selawik Semilight", size = xLogs.Utils.ScreenScale(172, true), weight = 600, antialias = true})
end

xLogs.Utils.CreateFonts()

function xLogs.Utils.AddChatMessage(txt)
	local pref = xLogs.Config.ChatPrefix
	local col = xLogs.Config.ChatPrefixCol

	chat.AddText(col, pref, Color(200, 200, 200, 255), " ", txt)
end

-- Get a colour for text based on the colour of the background
function xLogs.Utils.CalculateTextCol(col)
	local newcol = Color(math.abs(col.r - 255), math.abs(col.g - 255), math.abs(col.b - 255))
	return newcol
end

-- Make scrollbars not ugly
function xLogs.Utils.EditScrollBarStyle(scrollpanel)
	local scrollbar = scrollpanel.VBar
	scrollbar.btnUp:SetVisible(false)
	scrollbar.btnDown:SetVisible(false)
	scrollbar.OnCursorEntered = function()
		scrollbar:SetCursor("hand")
	end
	function scrollbar:PerformLayout()
		local wide = scrollbar:GetWide()
		local scroll = scrollbar:GetScroll() / scrollbar.CanvasSize
		local barSize = math.max(scrollbar:BarScale() * (scrollbar:GetTall() - (wide * 2)), xLogs.Utils.ScreenScale(10))
		local track = scrollbar:GetTall() - (wide * 2) - barSize
		track = track + 1

		scroll = scroll * track

		scrollbar.btnGrip:SetPos(0, (wide + scroll) - xLogs.Utils.ScreenScale(15, true))
		scrollbar.btnGrip:SetSize(wide, barSize + xLogs.Utils.ScreenScale(30))
	end
	local colour = Color(10, 10, 10, 175)
	function scrollbar:Paint(w, h)
		xLogs.Utils.Rect(0, 0, scrollbar:GetWide() / 1.5, scrollbar:GetTall(), Color(colour.r, colour.g, colour.b, 100))
	end
	function scrollbar.btnGrip:Paint(w, h) 
		xLogs.Utils.Rect(0, 0, scrollbar.btnGrip:GetWide() / 1.5, scrollbar.btnGrip:GetTall(), colour or color_white)
	end
end

-- Make the scrollbar small enough not to hide anything
function xLogs.Utils.HideScrollBar(scrollpanel)
	local scrollbar = scrollpanel.VBar
	scrollbar.btnUp:SetVisible(false)
	scrollbar.btnDown:SetVisible(false)
	scrollbar.OnCursorEntered = function()
		scrollbar:SetCursor("hand")
	end

	scrollbar:SetWide(xLogs.Utils.ScreenScale(2))
	function scrollbar:PerformLayout()
		local wide = scrollbar:GetWide()
		local scroll = scrollbar:GetScroll() / scrollbar.CanvasSize
		local barSize = math.max(scrollbar:BarScale() * (scrollbar:GetTall() - (wide * 2)), xLogs.Utils.ScreenScale(10))
		local track = scrollbar:GetTall() - (wide * 2) - barSize
		track = track + 1

		scroll = scroll * track

		scrollbar.btnGrip:SetPos(0, (wide + scroll) - xLogs.Utils.ScreenScale(15, true))
		scrollbar.btnGrip:SetSize(wide, barSize + xLogs.Utils.ScreenScale(30))
	end

	local colour = Color(10, 10, 10, 255)

	function scrollbar:Paint(w, h)
		xLogs.Utils.Rect(0, 0, scrollbar:GetWide(), scrollbar:GetTall(), Color(colour.r, colour.g, colour.b, 100))
	end

	function scrollbar.btnGrip:Paint(w, h)
		xLogs.Utils.Rect(0, 0, scrollbar.btnGrip:GetWide(), scrollbar.btnGrip:GetTall(), colour or color_white)
	end
end

-- Draw a rectangle
function xLogs.Utils.Rect(x, y, w, h, col)
	surface.SetDrawColor(col)
	surface.DrawRect(x, y, w, h)
end

-- Draw a rounded rectangle
function xLogs.Utils.RoundedRect(rad, x, y, w, h, col)
	xLogs.Utils.Rect(x, y, w, h, col) -- We don't want to use rounded rectangles anymore, so any use of this function should just draw a normal rect
end

-- Draw a textured rectangle
function xLogs.Utils.TexturedRect(x, y, w, h, mat)
	surface.SetDrawColor(Color(255, 255, 255, 255))
	surface.SetMaterial(mat)
	surface.DrawTexturedRect(x, y, w, h)
end

-- Draw a hollow rect outline
function xLogs.Utils.HollowRect(x, y, w, h, col)
	surface.SetDrawColor(col)
	surface.DrawOutlinedRect(x, y, w, h)
end

-- Draw a rect with outline
function xLogs.Utils.OutlinedRect(x, y, w, h, fill, outline)
	xLogs.Utils.HollowRect(x, y, w, h, outline)
	xLogs.Utils.Rect(x + 1, y + 1, w - 1, h - 1, fill)
end

-- Draw a circle with a specific width and height
function xLogs.Utils.DrawStretchedCircle(x, y, w, h, col)
	local circle = {}

    for i = 1, 360 do
        circle[i] = {}
        circle[i].x = x + math.cos(math.rad(i * 360) / 360) * w
        circle[i].y = y + math.sin(math.rad(i * 360) / 360) * h
    end

    surface.SetDrawColor(col)
    draw.NoTexture()
    surface.DrawPoly(circle)
end

-- Draw a circle with a consistent radius
function xLogs.Utils.DrawCircle(x, y, r, col)
	xLogs.Utils.DrawStretchedCircle(x, y, r, r, col)
end

-- Modified from TDLib (cl_tdlib.lua DrawArc)
-- Draw part of a circle
function xLogs.Utils.DrawPartCircle(x, y, rot, totang, w, h, col, seg)
	seg = seg or 80
    rot = (-rot) + 180
    local circle = {}

    table.insert(circle, {x = x, y = y})
    for i = 0, seg do
        local a = math.rad((i / seg) * -totang + rot)
        table.insert(circle, {x = x + math.sin(a) * w, y = y + math.cos(a) * h})
    end

    surface.SetDrawColor(col)
    draw.NoTexture()
    surface.DrawPoly(circle)
end

-- Draw the shadow for a partial circle
function xLogs.Utils.DrawPartCircleShadow(x, y, rot, totang, w, h, col, seg)
	seg = seg or 80
    rot = (-rot) + 180
    local circle = {}
    table.insert(circle, {x = x, y = y})
    for i = 0, seg do
        local a = math.rad((i / seg) * -totang + rot)
        table.insert(circle, {x = x + math.sin(a) * w, y = y + math.cos(a) * h})
    end
    surface.DrawPoly(circle)
end

-- Draw a shadow for a rect
function xLogs.Utils.DrawRectShadow(x, y, w, h)
	surface.DrawRect(x, y, w, h)
end

-- Draw a rectangle with rounded sides
function xLogs.Utils.DrawRoundedSideRect(x, y, w, h, col)
	xLogs.Utils.Rect(x - x / 2, y, w - (w * 0.25), h, col)
	xLogs.Utils.DrawPartCircle(x - (w * 0.128), y + h / 2, 180, 180, w * 0.125, h / 2, col, 360)
	xLogs.Utils.DrawPartCircle(x + (w * 0.625) - xLogs.Utils.ScreenScale(2), y + h / 2, 0, 180, w * 0.125, h / 2, col, 360)
end

-- Draw a shadow for a rectangle with rounded sides
function xLogs.Utils.DrawRoundedSideRectShadow(parentpnl, x, y, w, h)
	local x, y = parentpnl:LocalToScreen(0, 0)

	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)

	for i = 1, 3 do
		blur:SetFloat("$blur", (i / 3) * (amount or 8))
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end

	xLogs.Utils.RectShadow(x - x / 2, y, w - (w * 0.25), h)
	xLogs.Utils.DrawPartCircleShadow(x - w * 0.125, y + h / 2, 180, 180, w * 0.125, h / 2)
	xLogs.Utils.DrawPartCircleShadow(x + (w * 0.625), y + h / 2, 0, 180, w * 0.125, h / 2)
end

-- Create a rect panel
function xLogs.Utils.DoRectPanel(parent, x, y, w, h, bgcol)
	local pnl = vgui.Create("DPanel", parent)
	pnl:SetSize(w, h)
	pnl:SetPos(x, y)
	function pnl.Paint(s, w, h)
		xLogs.Utils.Rect(0, 0, w, h, bgcol)
	end

	return pnl
end

-- Create a centered rect panel
function xLogs.Utils.DoRectPanelCentered(parent, w, h, bgcol)
	local pnl = vgui.Create("DPanel", parent)
	pnl:SetSize(w, h)
	pnl:SetPos(parent:GetWide() / 2 - w / 2, parent:GetTall() / 2 - h / 2)
	function pnl.Paint(s, w, h)
		xLogs.Utils.Rect(0, 0, w, h, bgcol)
	end

	return pnl
end

-- Create a textured and centered rect panel
function xLogs.Utils.DoTexturedRectPanelCentered(parent, w, h, mat, ismaterial)
	local pnl = vgui.Create("DPanel", parent)
	pnl:SetSize(w, h)
	pnl:SetPos(parent:GetWide() / 2 - w / 2, parent:GetTall() / 2 - h / 2)

	pnl.material = ismaterial and mat or Material(mat)
	local defmat = Material(xLogs.Config.MenuBackground)
	function pnl.Paint(s, w, h)
		xLogs.Utils.TexturedRect(0, 0, w, h, s.material or defmat)
	end

	return pnl
end

-- Create a rectangular button
function xLogs.Utils.DoButtonRect(parent, tx, font, x, y, w, h, bgcol)
	local btn = vgui.Create("DButton", parent)
	btn:SetSize(w, h)
	btn:SetPos(x, y)
	btn:SetText(tx)
	btn:SetFont(font)
	btn:SetTextColor(xLogs.Utils.CalculateTextCol(bgcol))
	function btn.Paint(s, w, h)
		xLogs.Utils.Rect(2, 2, w - 2, h - 2, Color(0, 0, 0, 175))
		xLogs.Utils.Rect(0, 0, w - 2, h - 2, bgcol)
	end

	return btn
end

-- Create a rounded button
function xLogs.Utils.DoRoundedRectButton(parent, tx, font, x, y, w, h, bgcol, hovercol, ortxcol)
	local btn = vgui.Create("DButton", parent)
	btn:SetSize(w, h)
	btn:SetPos(x, y)
	btn:SetText(tx)
	btn:SetFont(font)
	btn:SetTextColor(ortxcol or xLogs.Utils.CalculateTextCol(bgcol))
	function btn.Paint(s, w, h)
		xLogs.Utils.Rect(0, 0, w, h, s:IsHovered() and hovercol or bgcol) -- We don't want to use rounded corners, so anything using this function should draw a normal rect
	end

	return btn
end

-- Create a rounded button
function xLogs.Utils.DoRoundedButton(parent, tx, font, x, y, w, h, bgcol, ortxcol)
	local btnshadow = vgui.Create("DButton", parent)
	btnshadow:SetSize(w + xLogs.Utils.ScreenScale(10), h + xLogs.Utils.ScreenScale(10))
	btnshadow:SetPos(x - xLogs.Utils.ScreenScale(5) / 2, y)
	btnshadow:SetText("")
	function btnshadow.Paint(s, w, h)
		xLogs.Utils.Rect(0, 0, w - xLogs.Utils.ScreenScale(10), h - xLogs.Utils.ScreenScale(10), Color(0, 0, 0, 175))

		local x, y = s:LocalToScreen(0, 0)
		surface.SetDrawColor(255, 255, 255)
		surface.SetMaterial(blur)

		for i = 1, 3 do
			blur:SetFloat("$blur", (i / 3) * 1.25)
			blur:Recompute()

			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
		end
	end
	btnshadow:SetVisible(false)

	local btn = vgui.Create("DButton", parent)
	btn:SetSize(w, h)
	btn:SetPos(x, y)
	btn:SetText(tx)
	btn:SetFont(font)
	btn:SetTextColor(ortxcol or xLogs.Utils.CalculateTextCol(bgcol))
	function btn.Paint(s, w, h)
		xLogs.Utils.Rect(0, 0, w, h, bgcol) -- We don't want to use rounded corners, so anything using this function should draw a normal rect
	end

	function btn.OnRemove()
		btnshadow:Remove()
	end

	local oldvis = btn.SetVisible
	function btn:SetVisible(bool)
		btnshadow:SetVisible(bool)
		oldvis(self, bool)
	end

	-- Move the button up a little and show the shadow when hovered
	function btn.OnCursorEntered(s)
		s:SetPos(x, y - xLogs.Utils.ScreenScale(2))
		btnshadow:SetVisible(true)
	end

	function btn.OnCursorExited(s)
		s:SetPos(x, y)
		btnshadow:SetVisible(false)
	end

	function btnshadow.OnCursorEntered(s)
		btn:SetPos(x, y - xLogs.Utils.ScreenScale(2))
		btnshadow:SetVisible(true)
	end

	function btnshadow.OnCursorExited(s)
		btn:SetPos(x, y)
		btnshadow:SetVisible(false)
	end

	function btnshadow.DoClick(s)
		btn:DoClick()
	end

	function btn.PerformLayout(s)
		local newx, newy = s:GetPos()

		if y < newy then
			y = newy
			btnshadow:SetPos(x, y)
		end
	end

	return btn
end

-- Create a round steam icon
function xLogs.Utils.DoCircleIcon(parent, steamid, x, y, w, h, size)
	local pn = vgui.Create("DPanel", parent)
	pn:SetSize(w, h)
	pn:SetPos(x, y)
	pn:SetText("")

	local avt = vgui.Create("AvatarImage", pn)
	avt:SetSize(w, h)
	avt:SetPos(0, 0)
	avt:SetSteamID(steamid, size or 184)
	avt:SetPaintedManually(true)

	function pn:Paint(w, h)
	    render.ClearStencil() 
	    render.SetStencilEnable(true)

	    render.SetStencilWriteMask(1)
	    render.SetStencilTestMask(1)

	    render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
	    render.SetStencilPassOperation(STENCILOPERATION_ZERO)
	    render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
	    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
	    render.SetStencilReferenceValue(1)

		--local masksize = 27
		local masksize = 200 -- We don't want to use rounded corners, so anything using this function should draw the icon without rounded corners

		local circle = {}
		local t = 0
	    for i = 1, 360 do
	        t = math.rad(i * 720) / 720
	        circle[i] = {x = w / 2 + math.cos(t) * masksize, y = h / 2 + math.sin(t) * masksize}
	    end

		draw.NoTexture()
		surface.SetDrawColor(color_white)
		surface.DrawPoly(circle)

	    render.SetStencilFailOperation( STENCILOPERATION_ZERO )
	    render.SetStencilPassOperation( STENCILOPERATION_REPLACE )
	    render.SetStencilZFailOperation( STENCILOPERATION_ZERO )
	    render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
	    render.SetStencilReferenceValue(1)

	    avt:SetPaintedManually(false)
	    avt:PaintManual()
	    avt:SetPaintedManually(true)

	    render.SetStencilEnable(false)
	    render.ClearStencil() 
	end

	local btn = vgui.Create("DButton", avt)
	btn:SetSize(w, h)
	btn:SetPos(x, y)
	btn:SetText("")

	function btn:Paint(w, h) end

	function btn:DoClick()
		gui.OpenURL(string.format("https://steamcommunity.com/profiles/%s/", steamid)) -- Open steam profile when the avatar is clicked
	end

	return pn
end

-- Create a text panel
function xLogs.Utils.DoText(parent, txt, font, col, center, offset)
	local tx = vgui.Create("DLabel", parent)
	tx:SetFont(font)
	tx:SetText(txt)
	tx:SizeToContents()
	tx:SetTextColor(col)
	if center then tx:SetPos(parent:GetWide() / 2 - tx:GetWide() / 2, parent:GetTall() / 2 - tx:GetTall() / 2 - (offset or 0)) end
	
	return tx
end

-- Draw text
function xLogs.Utils.Text(tx, x, y, font, col, cx, cy)
	surface.SetFont(font)
	local tw, th = surface.GetTextSize(tx)
	surface.SetTextPos(x - (cx and tw / 2 or 0), y - (cy and th / 2 or 0))
	surface.SetTextColor(col or Color(255, 255, 255, 255))
	surface.DrawText(tx)
end

-- Create a scroll panel with edited scrollbar
function xLogs.Utils.DoScrollPnl(parent, x, y, w, h)
	local pnl = vgui.Create("DScrollPanel", parent)
	pnl:SetSize(w, h)
	pnl:SetPos(x, y)
	function pnl.Paint(s, w, h) end
	xLogs.Utils.EditScrollBarStyle(pnl)

	return pnl
end

-- Create a ThreeGrid
function xLogs.Utils.DoGrid(parent, x, y, w, h, cols, marginhor, marginver, nosb)
	local grid = vgui.Create("ThreeGrid", parent)
	grid:SetPos(x, y)
	grid:SetSize(w, h)
	function grid.Paint(s, w, h) end
	if not nosb then xLogs.Utils.EditScrollBarStyle(grid) else xLogs.Utils.HideScrollBar(grid) end

	grid:SetHorizontalMargin(marginhor or 0)
	grid:SetVerticalMargin(marginver or 0)
	grid:SetColumns(cols)

	return grid
end

-- Create a grid row
function xLogs.Utils.DoGridRow(parent, height, col, isbtn, hovercol, norounded)
	local pnl = vgui.Create(isbtn and "DButton" or "DPanel")
	pnl:SetTall(height)
	if isbtn then pnl:SetText("") end
	function pnl.Paint(s, w, h)
		xLogs.Utils.Rect(0, 0, w, h, (isbtn and s:IsHovered()) and hovercol or col)
	end

	parent:AddCell(pnl)

	return pnl
end

-- Create a rounded rect panel
function xLogs.Utils.DoRoundedRectPnl(parent, x, y, w, h, col)
	local pnl = vgui.Create("DPanel", parent)
	pnl:SetSize(w, h)
	pnl:SetPos(x, y)
	function pnl.Paint(s, w, h)
		xLogs.Utils.RoundedRect(xLogs.Utils.ScreenScale(0), 0, 0, w, h, col)
	end

	return pnl
end

-- Create an image panel
function xLogs.Utils.DoImage(parent, x, y, w, h, img, col)
	col = col or Color(255, 255, 255, 255)
	local mat = Material(img)
	local img = vgui.Create("DImage", parent)
	img:SetPos(x, y)
	img:SetSize(w, h)
	img:SetMaterial(mat)
	img:SetImageColor(col)

	return img
end

-- Create a button with an image
function xLogs.Utils.DoImageBtn(parent, x, y, w, h, img, spin)
	local mat = Material(img)
	local img = vgui.Create("DButton", parent)
	img:SetPos(x, y)
	img:SetSize(w, h)
	img:SetText("")

	img.Rotation = 0
	function img.Paint(s, w, h)
		surface.SetMaterial(mat)
		surface.SetDrawColor(Color(255, 255, 255, 255))

		if s:IsHovered() and spin then
			s.Rotation = Lerp(1 * FrameTime(), s.Rotation, s.Rotation + 100)
			if s.Rotation >= 360 then s.Rotation = 0 end
		end

		surface.DrawTexturedRectRotated(w / 2, h / 2, w, h, s.Rotation)
	end

	return img
end

-- Create keyboard input
function xLogs.Utils.DoKeyboardInput(parent, def, x, y, w, h, isnumeric, font)
	local txpnl = vgui.Create("DTextEntry", parent)
	txpnl:SetFont(font or "xLogsSelawik32")
	txpnl:SetPos(x, y)
	txpnl:SetTextColor(Color(255, 255, 255, 255))
	txpnl:SetPlaceholderColor(Color(200, 200, 200, 255))
	txpnl:SetPlaceholderText(def)
	txpnl:SetSize(w, h)
	function txpnl.Paint(s, w, h)
		xLogs.Utils.RoundedRect(xLogs.Utils.ScreenScale(10), 0, 0, w, h, Color(0, 0, 0, 100))
		if (s:GetText() and (s:GetText() ~= "")) or s:HasFocus() then
			s:DrawTextEntryText(Color(255, 255, 255, 255), Color(0, 0, 255), Color(0, 0, 0, 255))
		else
			surface.SetTextColor(s:GetPlaceholderColor())
			surface.SetFont(font or "xLogsSelawik32")
			local tw, th = surface.GetTextSize(def)
			surface.SetTextPos(xLogs.Utils.ScreenScale(5, true), h / 2 - th / 2)
			surface.DrawText(def)
		end
	end

	return txpnl
end

-- Create colour input
function xLogs.Utils.DoColorInput(parent, def, x, y, w, h)
	local colorpnl = vgui.Create("DColorMixer", parent)
	colorpnl:SetPos(x, y)
	colorpnl:SetSize(w, h)
	colorpnl:SetColor(def)
	colorpnl:SetAlphaBar(false)

	return colorpnl
end

-- Create a checkbox
function xLogs.Utils.DoCheckbox(parent, x, y, w, h, col, bgcol, def, callback)
	local box = vgui.Create("DCheckBox", parent)
	box:SetPos(x, y)
	box:SetSize(w, h)
	box:TDLib()
	box:ClearPaint()
		:SquareCheckbox(bgcol, col)
	box:SetValue(def)
	box.OnChange = callback

	return box
end

-- Create an input panel
function xLogs.Utils.DoInput(tittx)
	local inputbtnw = xLogs.Utils.ScreenScale(275)
	local inputbtnh = xLogs.Utils.ScreenScale(52, true)

	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW(), ScrH())
	frame:Center()
	frame:SetDraggable(false)
	frame:SetTitle("")
	frame:ShowCloseButton(false)
	frame:MakePopup()
	frame.Paint = function(s) Derma_DrawBackgroundBlur(s) end

	local inputpnl = xLogs.Utils.DoRoundedRectPnl(frame, frame:GetWide() / 2 - ((ScrW() * 0.4) / 2), frame:GetTall() / 2 - ((ScrH() * 0.2) / 2), ScrW() * 0.4, ScrH() * 0.2, Color(30, 30, 30, 255))

	local tit = xLogs.Utils.DoText(inputpnl, tittx, "xLogsSelawik42", Color(255, 255, 255, 255), false)
	tit:SetPos(inputpnl:GetWide() / 2 - tit:GetWide() / 2, xLogs.Utils.ScreenScale(10, true))

	local confirm = xLogs.Utils.DoRoundedButton(inputpnl, "Confirm", "xLogsSelawik32", inputpnl:GetWide() / 2 - inputbtnw - xLogs.Utils.ScreenScale(15), inputpnl:GetTall() - inputbtnh - xLogs.Utils.ScreenScale(10), inputbtnw, inputbtnh, Color(61, 150, 61, 255), Color(255, 255, 255, 255))
	function confirm.DoClick()
		frame:Close()
	end

	local cancel = xLogs.Utils.DoRoundedButton(inputpnl, "Cancel", "xLogsSelawik32", inputpnl:GetWide() / 2 + xLogs.Utils.ScreenScale(15), inputpnl:GetTall() - inputbtnh - xLogs.Utils.ScreenScale(10), inputbtnw, inputbtnh, Color(200, 61, 61, 255), Color(255, 255, 255, 255))
	function cancel.DoClick()
		frame:Close()
	end

	function frame.PerformLayout(s)
		inputpnl:SetPos(frame:GetWide() / 2 - inputpnl:GetWide() / 2, frame:GetTall() / 2 - inputpnl:GetTall() / 2)
		confirm:SetPos(inputpnl:GetWide() / 2 - inputbtnw - xLogs.Utils.ScreenScale(15), inputpnl:GetTall() - inputbtnh - xLogs.Utils.ScreenScale(10))
		cancel:SetPos(inputpnl:GetWide() / 2 + xLogs.Utils.ScreenScale(15), inputpnl:GetTall() - inputbtnh - xLogs.Utils.ScreenScale(10))
	end

	return inputpnl, confirm
end

-- Request confirmation for actions
function xLogs.Utils.RequestConfirmation(tit, callback, sub)
	local inputpnl, confirmbtn = xLogs.Utils.DoInput(tit)

	local subtx = xLogs.Utils.DoText(inputpnl, sub or xLogs.GetLanguageString("noundo"), "xLogsSelawik32", Color(255, 255, 255, 255), false)
	subtx:SetPos(inputpnl:GetWide() / 2 - subtx:GetWide() / 2, xLogs.Utils.ScreenScale(62, true))

	local confirmtx = "76561198093398631"
	local old = confirmbtn.DoClick
	function confirmbtn:DoClick()
		callback()
		old(self)
	end
end

-- Create string input popup
function xLogs.Utils.StrInput(tit, current, callback)
	local inputpnl, confirmbtn = xLogs.Utils.DoInput(tit)
	local txbox = xLogs.Utils.DoKeyboardInput(inputpnl, current, xLogs.Utils.ScreenScale(10), xLogs.Utils.ScreenScale(72, true), inputpnl:GetWide() - xLogs.Utils.ScreenScale(20), xLogs.Utils.ScreenScale(52, true))

	local old = confirmbtn.DoClick
	function confirmbtn:DoClick()
		if (txbox:GetValue()) then callback((txbox:GetValue() ~= "") and txbox:GetValue() or current) else xLogs.AddNotification("Invalid input!", xLogs.NotificationERROR) end
		old(self)
	end
end

-- Create string input panel
function xLogs.Utils.DoStrInput(parent, placeholder, x, y, w, h)
	local txbox = xLogs.Utils.DoKeyboardInput(parent, placeholder, x, y, w, h)
	return txbox
end

-- Create input with multiple fields
function xLogs.Utils.DoMultiInput(tit, fields, callback)
	local inputpnl, confirmbtn = xLogs.Utils.DoInput(tit)

	local inputfields = {}
	local y = xLogs.Utils.ScreenScale(72, true)
	local xpos = 0
	tall = inputpnl:GetTall() - xLogs.Utils.ScreenScale(57, true)
	for k, v in ipairs(fields) do
		local fieldlb = xLogs.Utils.DoText(inputpnl, v[2] .. ": ", "xLogsSelawik42", Color(255, 255, 255, 255), false)
		fieldlb:SetPos(xLogs.Utils.ScreenScale(10), y)
		if fieldlb:GetWide() > xpos then xpos = fieldlb:GetWide() end

		local field = ((v[1] == "String") or (v[1] == "Int")) and xLogs.Utils.DoKeyboardInput(inputpnl, v[3], xLogs.Utils.ScreenScale(15) + fieldlb:GetWide(), y, inputpnl:GetWide() - xLogs.Utils.ScreenScale(30) - fieldlb:GetWide(), xLogs.Utils.ScreenScale(52, true)) or (v[1] == "Combobox") and xLogs.Utils.DoOptionInput(inputpnl, xLogs.Utils.ScreenScale(15) + fieldlb:GetWide(), y, inputpnl:GetWide() - xLogs.Utils.ScreenScale(30) - fieldlb:GetWide(), xLogs.Utils.ScreenScale(52, true), v[3]) or (v[1] == "Color") and xLogs.Utils.DoColorInput(inputpnl, v[3], xLogs.Utils.ScreenScale(15) + fieldlb:GetWide(), y, inputpnl:GetWide() - xLogs.Utils.ScreenScale(30) - fieldlb:GetWide(), xLogs.Utils.ScreenScale(208, true))
		if v[1] == "Int" then field:SetNumeric(true) end
		y = y + field:GetTall() + xLogs.Utils.ScreenScale(35, true)
		tall = tall + field:GetTall() + xLogs.Utils.ScreenScale(35, true)

		function field:GetInfo()
			if ((v[1] == "String") or (v[1] == "Int") or v[1] == "Combobox") then
				if field:GetValue() then
					return (field:GetValue() ~= "") and field:GetValue() or v[3]
				else
					return
				end
			else
				if field:GetColor() then
					return Color(field:GetColor().r, field:GetColor().g, field:GetColor().b, 255)
				else
					return
				end
			end
		end

		table.insert(inputfields, field)
	end

	inputpnl:SetSize(inputpnl:GetWide(), tall)

	for k, v in ipairs(inputfields) do
		local x, y = v:GetPos()
		v:SetPos(xLogs.Utils.ScreenScale(15) + xpos, y)
		v:SetWide(inputpnl:GetWide() - xLogs.Utils.ScreenScale(30) - xpos)
	end

	local old = confirmbtn.DoClick
	function confirmbtn:DoClick()
		local data = {}
		for k, v in ipairs(inputfields) do
			if (v:GetInfo()) then table.insert(data, v:GetInfo()) else xLogs.AddNotification("Invalid input!", xLogs.NotificationERROR) return end
		end

		callback(data)
		old(self)
	end
end

-- Create input with multiple strings
function xLogs.Utils.DoMultiStrInput(tit, fields, callback)
	local inputpnl, confirmbtn = xLogs.Utils.DoInput(tit)
	inputpnl:SetSize(inputpnl:GetWide(), inputpnl:GetTall() + ((table.Count(fields) - 1) * xLogs.Utils.ScreenScale(62, true)))

	local txfields = {}
	local y = xLogs.Utils.ScreenScale(72, true)
	for k, v in ipairs(fields) do
		local current = v
		local txbox = xLogs.Utils.DoKeyboardInput(inputpnl, current, xLogs.Utils.ScreenScale(15), y, inputpnl:GetWide() - xLogs.Utils.ScreenScale(30), xLogs.Utils.ScreenScale(52, true))
		table.insert(txfields, txbox)

		y = y + xLogs.Utils.ScreenScale(62, true)
	end

	local old = confirmbtn.DoClick
	function confirmbtn:DoClick()
		local data = {}
		for k, v in ipairs(txfields) do
			if (v:GetValue() and (v:GetValue() ~= "")) then table.insert(data, v:GetValue()) else xLogs.AddNotification("Invalid input!", xLogs.NotificationERROR) return end
		end

		callback(data)
		old(self)
	end
end

-- Create input popup for integers
function xLogs.Utils.IntInput(tit, current, callback)
	local inputpnl, confirmbtn = xLogs.Utils.DoInput(tit)
	local txbox = xLogs.Utils.DoKeyboardInput(inputpnl, current, xLogs.Utils.ScreenScale(15), xLogs.Utils.ScreenScale(72, true), inputpnl:GetWide() - xLogs.Utils.ScreenScale(30), xLogs.Utils.ScreenScale(52, true))
	txbox:SetNumeric(true)

	local old = confirmbtn.DoClick
	function confirmbtn:DoClick()
		if (txbox:GetValue() and tonumber(txbox:GetValue())) then callback(tonumber(txbox:GetValue())) else callback(tonumber(current)) end
		old(self)
	end
end

-- Create input panel for integers
function xLogs.Utils.DoIntInput(parent, placeholder, x, y, w, h)
	local txbox = xLogs.Utils.DoKeyboardInput(parent, placeholder, x, y, w, h)
	txbox:SetNumeric(true)

	return txbox
end

-- Create input popup for colours
function xLogs.Utils.ColInput(tit, current, callback)
	local inputpnl, confirmbtn = xLogs.Utils.DoInput(tit)
	inputpnl:SetTall(inputpnl:GetTall() * 2)
	local colbox = xLogs.Utils.DoColorInput(inputpnl, current, xLogs.Utils.ScreenScale(15), xLogs.Utils.ScreenScale(62, true), inputpnl:GetWide() - xLogs.Utils.ScreenScale(30), inputpnl:GetTall() - xLogs.Utils.ScreenScale(62, true) * 2 - xLogs.Utils.ScreenScale(30))

	local old = confirmbtn.DoClick
	function confirmbtn:DoClick()
		if colbox:GetColor() then callback(colbox:GetColor()) else xLogs.AddNotification("Invalid input!", xLogs.NotificationERROR) end
		old(self)
	end
end

-- Create input popup for players
function xLogs.Utils.PlayerInput(tit, blacklist, callback)
	local inputpnl, confirmbtn = xLogs.Utils.DoInput(tit)

	local selected = ""
	local inputbox = vgui.Create("DComboBox", inputpnl)
	inputbox:SetPos(xLogs.Utils.ScreenScale(15), xLogs.Utils.ScreenScale(72, true))
	inputbox:SetSize(inputpnl:GetWide() - xLogs.Utils.ScreenScale(30), xLogs.Utils.ScreenScale(52, true))
	inputbox:SetValue("Select a Player")
	inputbox:SetFont("xLogsSelawik32")

	local options = {}
	for k, v in ipairs(player.GetAll()) do
		if table.HasValue(blacklist, v) then continue end

		inputbox:AddChoice(v:Nick(), v:SteamID())
		table.insert(options, v)
	end
	if table.Count(options) <= 0 then inputbox:AddChoice(xLogs.GetLanguageString("noplayers"), "") end

	inputbox.OnSelect = function(self, index, value)
		selected = value
	end

	function inputbox:Paint(w, h)
		local col = Color(200, 200, 200)
		local back = Color(20, 20, 20)
				
		draw.RoundedBox(0, 0, 0, w, h, back )
		draw.SimpleText(inputbox:GetText(), "xLogsSelawik32", xLogs.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		return true
	end

	inputbox.OldOpen = inputbox.OldOpen or inputbox.OpenMenu
	function inputbox:OpenMenu(...)
		inputbox.OldOpen(self, ...)
		local tables = self.Menu:GetCanvas():GetChildren()

		for k, v in pairs(tables) do 
			function v:Paint(w,h)
				local col = Color(200, 200, 200)
				local back = Color(40, 40, 40)
				
				if v.Hovered then 
					col = Color(255, 255, 255)
					back = Color(20, 20, 20)
				end				
				
				draw.RoundedBox(0, 0, 0, w, h, back )
				draw.SimpleText(v:GetText(), "xLogsSelawik18", xLogs.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				return true
			end
		end
	end

	local old = confirmbtn.DoClick
	function confirmbtn:DoClick()
		if selected and (selected ~= "") then
			callback(selected)
			old(self)
		end
	end
end

-- Create input panel for players
function xLogs.Utils.DoPlayerInput(parent, x, y, w, h)
	local inputbox = vgui.Create("DComboBox", parent)
	inputbox:SetPos(x, y)
	inputbox:SetSize(w, h)
	inputbox:SetValue("Select a Player")
	inputbox:SetFont("xLogsSelawik32")

	for k, v in ipairs(player.GetAll()) do
		inputbox:AddChoice(v:Nick(), v:SteamID())
	end

	function inputbox:Paint(w, h)
		local col = Color(200, 200, 200)
		local back = Color(20, 20, 20)
				
		draw.RoundedBox(0, 0, 0, w, h, back )
		draw.SimpleText(inputbox:GetText(), "xLogsSelawik32", xLogs.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		return true
	end

	inputbox.OldOpen = inputbox.OldOpen or inputbox.OpenMenu
	function inputbox:OpenMenu(...)
		inputbox.OldOpen(self, ...)
		local tables = self.Menu:GetCanvas():GetChildren()

		for k, v in pairs(tables) do 
			function v:Paint(w, h)
				local col = Color(200, 200, 200)
				local back = Color(40, 40, 40)
				
				if v.Hovered then 
					col = Color(255, 255, 255)
					back = Color(20, 20, 20)
				end				
				
				draw.RoundedBox(0, 0, 0, w, h, back)
				draw.SimpleText(v:GetText(), "xLogsSelawik18", xLogs.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				return true
			end
		end
	end

	return inputbox
end

-- Create input popup for options
function xLogs.Utils.OptionInput(tit, tx, options, callback)
	local inputpnl, confirmbtn = xLogs.Utils.DoInput(tit)

	local selected = ""
	local inputbox = vgui.Create("DComboBox", inputpnl)
	inputbox:SetPos(xLogs.Utils.ScreenScale(15), xLogs.Utils.ScreenScale(72, true))
	inputbox:SetSize(inputpnl:GetWide() - xLogs.Utils.ScreenScale(30), xLogs.Utils.ScreenScale(52, true))
	inputbox:SetValue(tx)
	inputbox:SetFont("xLogsSelawik32")

	for k, v in ipairs(options) do
		inputbox:AddChoice(v)
	end

	inputbox.OnSelect = function(self, index, value)
		selected = value
	end

	function inputbox:Paint(w, h)
		local col = Color(200, 200, 200)
		local back = Color(20, 20, 20)
				
		draw.RoundedBox(0, 0, 0, w, h, back )
		draw.SimpleText(inputbox:GetText(), "xLogsSelawik32", xLogs.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		return true
	end

	inputbox.OldOpen = inputbox.OldOpen or inputbox.OpenMenu
	function inputbox:OpenMenu(...)
		inputbox.OldOpen(self, ...)
		local tables = self.Menu:GetCanvas():GetChildren()

		for k, v in pairs(tables) do 
			function v:Paint(w,h)
				local col = Color(200, 200, 200)
				local back = Color(40, 40, 40)
				
				if v.Hovered then 
					col = Color(255, 255, 255)
					back = Color(20, 20, 20)
				end				
				
				draw.RoundedBox(0, 0, 0, w, h, back )
				draw.SimpleText(v:GetText(), "xLogsSelawik18", xLogs.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				return true
			end
		end
	end

	local old = confirmbtn.DoClick
	function confirmbtn:DoClick()
		if selected and (selected ~= "") then
			callback(selected)
			old(self)
		end
	end
end

-- Create input panel for options
function xLogs.Utils.DoOptionInput(parent, x, y, w, h, options, placeholder, font)
	local inputbox = vgui.Create("DComboBox", parent)
	inputbox:SetPos(x, y)
	inputbox:SetSize(w, h)
	inputbox:SetValue(placeholder or options[1])
	inputbox:SetFont(font or "xLogsSelawik22")

	for k, v in ipairs(options) do
		inputbox:AddChoice(v)
	end

	function inputbox:UpdateOptions(new)
		inputbox:Clear()
		for k, v in ipairs(new) do
			inputbox:AddChoice(v)
		end

		inputbox:SetValue(placeholder or new[1])
	end

	function inputbox:Paint(w, h)
		local col = Color(200, 200, 200)
		local back = Color(0, 0, 0, 100)
				
		draw.RoundedBox(0, 0, 0, w, h, back )
		draw.SimpleText(inputbox:GetText(), font or "xLogsSelawik22", xLogs.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		return true
	end

	inputbox.OldOpen = inputbox.OldOpen or inputbox.OpenMenu
	function inputbox:OpenMenu(...)
		inputbox.OldOpen(self, ...)
		if not self.Menu then return end
		
		local tables = self.Menu:GetCanvas():GetChildren()

		for k, v in pairs(tables) do 
			function v:Paint(w, h)
				local col = Color(200, 200, 200)
				local back = Color(40, 40, 40)
				
				if v.Hovered then 
					col = Color(255, 255, 255)
					back = Color(20, 20, 20)
				end				
				
				draw.RoundedBox(0, 0, 0, w, h, back)
				draw.SimpleText(v:GetText(), "xLogsSelawik18", xLogs.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				return true
			end
		end
	end

	return inputbox
end

-- Create close button
function xLogs.Utils.DoCloseBtn(parent, toclose)
	local btn = vgui.Create("DButton", parent)
	btn:SetSize(xLogs.Utils.ScreenScale(32, true), xLogs.Utils.ScreenScale(32, true))
	btn:SetPos(parent:GetWide() - btn:GetWide() - xLogs.Utils.ScreenScale(5), xLogs.Utils.ScreenScale(5))
	btn:SetText("X")
	btn:SetFont("xLogsSelawik32")
	btn:SetTextColor(Color(255, 200, 200, 255))
	function btn.Paint(s, w, h) end
	function btn.OnCursorEntered(s) s:SetTextColor(Color(255, 125, 125, 255)) end
	function btn.OnCursorExited(s) s:SetTextColor(Color(255, 200, 200, 255)) end

	function btn.DoClick()
		toclose:Close()
	end

	return btn
end

-- Create a material from a URL and apply it to a panel
function xLogs.Utils.CreateWebMaterial(pnl, url, name)
	if xLogs.refpnl and IsValid(xLogs.refpnl) then xLogs.refpnl:Remove() end
	xLogs.refpnl = vgui.Create("DHTML")
	xLogs.refpnl:Dock(FILL)
	timer.Simple(1, function()
		xLogs.refpnl:OpenURL(url)
		xLogs.refpnl:SetAlpha(0)
		xLogs.refpnl:SetMouseInputEnabled(false)
		function xLogs.refpnl:ConsoleMessage(msg) end

		local htmlmat = xLogs.refpnl:GetHTMLMaterial()
		if not htmlmat then return end -- If it's failed to create the material, abort
		local scalex, scaley = ScrW() / 2048, ScrH() / 2048 -- "Scaley"

		local matdata = {
			["$basetexture"] = htmlmat:GetName(),
			["$basetexturetransform"] = "center 0 0 scale " .. scalex .. " " .. scaley .. " rotate 0 translate 0 0",
		}

		pnl.material = CreateMaterial("xLogsWebMaterial" .. string.Replace(htmlmat:GetName(), "__vgui_texture_", ""), "UnlitGeneric", matdata)
		if pnl.material:IsError() then pnl.material = Material(xLogs.Config.MenuBackground) end
	end)
end

-- Open panel with user information from SteamID
function xLogs.Utils.UserInfoPanel(nick, sid)
	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW() * 0.25, xLogs.Utils.ScreenScale(300, true))
	frame:Center()
	frame:SetTitle("")
	frame:SetDraggable(true)
	frame:ShowCloseButton(false)
	frame:MakePopup()

	local ply = player.GetBySteamID(sid)

	local inputpnl = xLogs.Utils.DoRoundedRectPnl(frame, 0, 0, frame:GetWide(), frame:GetTall(), Color(30, 30, 30, 255))
	xLogs.Utils.DoCloseBtn(inputpnl, frame)

	function frame:OnFocusChanged(focus)
		if not focus then
			self:Close()
		end
	end

	local tit = xLogs.Utils.DoText(inputpnl, nick, "xLogsSelawik32", Color(255, 255, 255, 255), false)
	tit:SetPos(xLogs.Utils.ScreenScale(10), xLogs.Utils.ScreenScale(10, true))

	local icon = xLogs.Utils.DoCircleIcon(inputpnl, util.SteamIDTo64(sid), xLogs.Utils.ScreenScale(10), xLogs.Utils.ScreenScale(15, true) + tit:GetTall(), inputpnl:GetTall() * 0.5, inputpnl:GetTall() * 0.5)
	
	local iconpos = icon:GetPos()
	local iconendpos = iconpos + icon:GetTall()
	local remainingh = inputpnl:GetTall() - iconendpos

	local usergroup = xLogs.Utils.DoText(inputpnl, xLogs.GetUserGroup(sid), "xLogsSelawik22", Color(255, 255, 255, 255), false)
	usergroup:SetPos(xLogs.Utils.ScreenScale(10) + icon:GetWide() / 2 - usergroup:GetWide() / 2, iconendpos + remainingh / 2 - (DarkRP and (usergroup:GetTall() / 2) or 0))

	-- If we're not running DarkRP, we don't care about jobs	
	if DarkRP then
		local userjob = xLogs.Utils.DoText(inputpnl, ply and IsValid(ply) and ply:getJobTable().name or "disconnected", "xLogsSelawik22", ply and IsValid(ply) and ply:getJobTable().color or Color(255, 255, 255, 255), false)
		userjob:SetPos(xLogs.Utils.ScreenScale(10) + icon:GetWide() / 2 - userjob:GetWide() / 2, iconendpos + remainingh / 2 + userjob:GetTall() / 2)
	end

	local steamid = xLogs.Utils.DoRoundedRectButton(inputpnl, string.format(xLogs.GetLanguageString("copysteamid"), sid), "xLogsSelawik22", xLogs.Utils.ScreenScale(20) + icon:GetWide(), xLogs.Utils.ScreenScale(15, true) + tit:GetTall(), inputpnl:GetWide() - icon:GetWide() - xLogs.Utils.ScreenScale(25, true), xLogs.Utils.ScreenScale(47, true), Color(40, 75, 40, 255), Color(30, 65, 30, 255), Color(255, 255, 255, 255))
	function steamid:DoClick()
		SetClipboardText(sid)
	end

	local steamid64 = xLogs.Utils.DoRoundedRectButton(inputpnl, string.format(xLogs.GetLanguageString("copysteamid64"), util.SteamIDTo64(sid)), "xLogsSelawik22", xLogs.Utils.ScreenScale(20) + icon:GetWide(), xLogs.Utils.ScreenScale(25, true) + tit:GetTall() + steamid:GetTall(), inputpnl:GetWide() - icon:GetWide() - xLogs.Utils.ScreenScale(25, true), xLogs.Utils.ScreenScale(47, true), Color(40, 75, 40, 255), Color(30, 65, 30, 255), Color(255, 255, 255, 255))
	function steamid64:DoClick()
		SetClipboardText( util.SteamIDTo64(sid))
	end

	local steamprof = xLogs.Utils.DoRoundedRectButton(inputpnl, xLogs.GetLanguageString("openprofile"), "xLogsSelawik22", xLogs.Utils.ScreenScale(20) + icon:GetWide(), inputpnl:GetTall() - xLogs.Utils.ScreenScale(37, true), inputpnl:GetWide() - icon:GetWide() - xLogs.Utils.ScreenScale(25, true), xLogs.Utils.ScreenScale(32, true), Color(40, 40, 75, 255), Color(30, 30, 65, 255), Color(255, 255, 255, 255))
	function steamprof:DoClick()
		gui.OpenURL(string.format("https://steamcommunity.com/profiles/%s/", util.SteamIDTo64(sid)))
	end
end

-- Open panel with entity information from entity class
function xLogs.Utils.EntityInfoPanel(class, model)
	local entRef = ents.CreateClientside(class)
	model = model or ((entRef and IsValid(entRef)) and entRef:GetModel() or "")

	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW() * 0.15, ScrW() * 0.15)
	frame:Center()
	frame:SetTitle("")
	frame:SetDraggable(true)
	frame:ShowCloseButton(false)
	frame:MakePopup()

	local inputpnl = xLogs.Utils.DoRoundedRectPnl(frame, 0, 0, frame:GetWide(), frame:GetTall(), Color(30, 30, 30, 255))
	xLogs.Utils.DoCloseBtn(inputpnl, frame)

	function frame:OnFocusChanged(focus)
		if not focus then
			self:Close()
		end
	end

	local tit = xLogs.Utils.DoText(inputpnl, class, "xLogsSelawik32", Color(255, 255, 255, 255), false)
	tit:SetPos(xLogs.Utils.ScreenScale(10), xLogs.Utils.ScreenScale(10, true))

	local icon = vgui.Create("DModelPanel", inputpnl)
	icon:SetSize(inputpnl:GetWide() - xLogs.Utils.ScreenScale(100, true), inputpnl:GetWide() - xLogs.Utils.ScreenScale(100, true))
	icon:SetPos(xLogs.Utils.ScreenScale(50, true), xLogs.Utils.ScreenScale(50, true))
	icon:SetModel(model)
end

-- Create a line graph
function xLogs.Utils.CreateGraph(parent, x, y, w, h, title, xlb, ylb, xdat, ydat)
	local graphbase = xLogs.Utils.DoRectPanel(parent, x, y, w, h, Color(0, 0, 0, 0))

	local lbx = xLogs.Utils.DoText(graphbase, xlb, "xLogsSelawik18", Color(255, 255, 255, 255))
	lbx:SetPos(graphbase:GetWide() - lbx:GetWide(), graphbase:GetTall() - lbx:GetTall())

	local lby = xLogs.Utils.DoText(graphbase, ylb, "xLogsSelawik18", Color(255, 255, 255, 255))
	lby:SetPos(0, 0)

	local graph = xLogs.Utils.DoRectPanel(graphbase, lby:GetWide() + xLogs.Utils.ScreenScale(5), lby:GetTall(), graphbase:GetWide() - lby:GetWide() - xLogs.Utils.ScreenScale(5), graphbase:GetTall() - lbx:GetTall() - lby:GetTall(), Color(0, 0, 0, 0))

	local maxy = 0
	for k, v in pairs(ydat) do
		if tonumber(v) > tonumber(maxy) then
			maxy = v
		end
	end

	graphbase.divnum = 8

	graph.divisions = math.Round((maxy / graphbase.divnum) + 1)
	if graph.divisions < 1000 then graph.divisions = 1000 end

	surface.SetFont("xLogsSelawik18")
	local twoff, thoff = surface.GetTextSize(DarkRP and DarkRP.formatMoney(graph.divisions * x) or (graph.divisions * x))
	local takew, takeh = surface.GetTextSize(xdat[table.Count(xdat)] or "")
	twoff = twoff + xLogs.Utils.ScreenScale(5)

	function graph:Paint(w, h)
		surface.SetFont("xLogsSelawik18")

		xLogs.Utils.Rect(twoff, thoff / 2, 2, h - xLogs.Utils.ScreenScale(18, true) - (thoff / 2), Color(255, 255, 255, 255))
		xLogs.Utils.Rect(twoff, h - xLogs.Utils.ScreenScale(18, true) - 2, w - twoff - xLogs.Utils.ScreenScale(7) - (takew / 2), 2, Color(255, 255, 255, 255))

		local last = 0
		for x = 1, graphbase.divnum do
			surface.SetFont("xLogsSelawik18")
			
			xLogs.Utils.Rect(twoff, (h - xLogs.Utils.ScreenScale(18, true)) * ((graphbase.divnum - x) / graphbase.divnum) + (thoff / 2), w - twoff - xLogs.Utils.ScreenScale(7) - (takew / 2), 1, Color(255, 255, 255, 150))

			local num = DarkRP and DarkRP.formatMoney(graph.divisions * x) or (graph.divisions * x)
			xLogs.Utils.Text(num, 0, (h - xLogs.Utils.ScreenScale(18, true)) * ((graphbase.divnum - x) / graphbase.divnum), "xLogsSelawik18", Color(255, 255, 255, 255))
		end

		local x = 0
		local lasty = 0
		local lastx = 0
		for k, v in pairs(xdat) do
			surface.SetFont("xLogsSelawik18")
			local tw, th = surface.GetTextSize(v)
			local basex = twoff + (x * ((w - twoff) / (table.Count(xdat) - 0.75)))

			xLogs.Utils.Rect(basex, thoff / 2, 1, h - xLogs.Utils.ScreenScale(18, true) - (thoff / 2), Color(255, 255, 255, 150))

			xLogs.Utils.Text(v, basex - (tw / 2), h - xLogs.Utils.ScreenScale(18, true), "xLogsSelawik18", Color(255, 255, 255, 255))

			-- Draw data points
			local data = tonumber(ydat[x + 1])
			local divs = data / graph.divisions

			local cury = (divs * ((h - xLogs.Utils.ScreenScale(18, true) - (thoff / 2)) / graphbase.divnum) - divs - 2)

			xLogs.Utils.DrawCircle(basex, (h - xLogs.Utils.ScreenScale(18, true) - (thoff / 2)) - cury, xLogs.Utils.ScreenScale(3), Color(255, 0, 0, 255))

			if x > 0 then
				surface.DrawLine(lastx, (h - xLogs.Utils.ScreenScale(18, true) - (thoff / 2)) - lasty, basex, (h - xLogs.Utils.ScreenScale(18, true) - (thoff / 2)) - cury)
			end

			lastx = basex
			lasty = cury

			x = x + 1
		end
	end

	local x = 0
	for k, v in pairs(xdat) do
		local data = tonumber(ydat[x + 1])
		local divs = data / graph.divisions

		local w, h = graph:GetSize()
		local basex = twoff + (x * ((w - twoff) / (table.Count(xdat) - 0.75)))
		local cury = (divs * ((h - xLogs.Utils.ScreenScale(18, true) - (thoff / 2)) / graphbase.divnum) - divs - 2)

		local node = vgui.Create("DButton", graph)
		node:SetText("")

		node:SetPos(basex - xLogs.Utils.ScreenScale(6), (h - xLogs.Utils.ScreenScale(18, true) - (thoff / 2)) - cury - xLogs.Utils.ScreenScale(6))
		node:SetSize(xLogs.Utils.ScreenScale(12), xLogs.Utils.ScreenScale(12))
		function node:Paint(w, h) end

		local tx = xLogs.Utils.DoText(graph, DarkRP.formatMoney(data), "xLogsSelawik18", Color(255, 255, 255, 255))
		local txpos = ((basex + tx:GetWide()) > w) and (basex - tx:GetWide() - xLogs.Utils.ScreenScale(6)) or (basex + xLogs.Utils.ScreenScale(6))
		tx:SetPos(txpos, (h - xLogs.Utils.ScreenScale(18, true) - (thoff / 2)) - cury + xLogs.Utils.ScreenScale(3))
		tx:SetVisible(false)

		function node:OnCursorEntered()
			tx:SetVisible(true)
		end

		function node:OnCursorExited()
			tx:SetVisible(false)
		end

		x = x + 1
	end

	return graphbase
end