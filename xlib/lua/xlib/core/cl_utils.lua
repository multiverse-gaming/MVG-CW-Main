xLib.Utils = xLib.Utils or {}

--Blurring code modified from TDLib to allow for render stencils
local blur = Material("pp/blurscreen")

function xLib.Utils.ScreenScale(num, h)
	local devw = 2560 --Development height
	local devh = 1440 --Development width
	
	return num * (h and (ScrH() / devh) or (ScrW() / devw))
end

-- Create xLib fonts
function xLib.Utils.CreateFonts()
	surface.CreateFont("xLibBigFont", {font = "Roboto", size = xLib.Utils.ScreenScale(64, true), weight = 300, antialias = true})
	surface.CreateFont("xLibLargeHeaderFont", {font = "Roboto", size = xLib.Utils.ScreenScale(42, true), weight = 300, antialias = true})
	surface.CreateFont("xLibHeaderFont", {font = "Roboto", size = xLib.Utils.ScreenScale(34, true), weight = 300, antialias = true})
	surface.CreateFont("xLibMidHeaderFont", {font = "Roboto", size = xLib.Utils.ScreenScale(28, true), weight = 300, antialias = true})
	surface.CreateFont("xLibSubHeaderFont", {font = "Roboto", size = xLib.Utils.ScreenScale(24, true), weight = 300, antialias = true})
	surface.CreateFont("xLibTitleFont", {font = "Roboto", size = xLib.Utils.ScreenScale(20, true), weight = 300, antialias = true})
	surface.CreateFont("xLibSubTitleFont", {font = "Roboto", size = xLib.Utils.ScreenScale(18, true), weight = 300, antialias = true})
	surface.CreateFont("xLibBodyFont", {font = "Roboto", size = xLib.Utils.ScreenScale(16, true), weight = 300, antialias = true})
	surface.CreateFont("xLibTinyFont", {font = "Roboto", size = xLib.Utils.ScreenScale(13, true), weight = 300, antialias = true})
end

xLib.Utils.CreateFonts()

function xLib.Utils.AddChatMessage(txt)
	local pref = xLib.Config.ChatPrefix
	local col = xLib.Config.ChatPrefixCol

	chat.AddText(col, pref, Color(200, 200, 200, 255), " ", txt)
end

-- Get a colour for text based on the colour of the background
function xLib.Utils.CalculateTextCol(col)
	local newcol = Color(math.abs(col.r - 255), math.abs(col.g - 255), math.abs(col.b - 255))
	return newcol
end

-- Make scrollbars not ugly
function xLib.Utils.EditScrollBarStyle(scrollpanel)
	local scrollbar = scrollpanel.VBar
	scrollbar.btnUp:SetVisible(false)
	scrollbar.btnDown:SetVisible(false)
	scrollbar.OnCursorEntered = function()
		scrollbar:SetCursor("hand")
	end
	function scrollbar:PerformLayout()
		local wide = scrollbar:GetWide()
		local scroll = scrollbar:GetScroll() / scrollbar.CanvasSize
		local barSize = math.max(scrollbar:BarScale() * (scrollbar:GetTall() - (wide * 2)), xLib.Utils.ScreenScale(10))
		local track = scrollbar:GetTall() - (wide * 2) - barSize
		track = track + 1

		scroll = scroll * track

		scrollbar.btnGrip:SetPos(0, (wide + scroll) - xLib.Utils.ScreenScale(15, true))
		scrollbar.btnGrip:SetSize(wide, barSize + xLib.Utils.ScreenScale(30))
	end
	local colour = Color(10, 10, 10, 175)
	function scrollbar:Paint(w, h)
		xLib.Utils.Rect(0, 0, scrollbar:GetWide() / 1.5, scrollbar:GetTall(), Color(colour.r, colour.g, colour.b, 100))
	end
	function scrollbar.btnGrip:Paint(w, h) 
		xLib.Utils.Rect(0, 0, scrollbar.btnGrip:GetWide() / 1.5, scrollbar.btnGrip:GetTall(), colour or color_white)
	end
end

-- Make the scrollbar small enough not to hide anything
function xLib.Utils.HideScrollBar(scrollpanel)
	local scrollbar = scrollpanel.VBar
	scrollbar.btnUp:SetVisible(false)
	scrollbar.btnDown:SetVisible(false)
	scrollbar.OnCursorEntered = function()
		scrollbar:SetCursor("hand")
	end

	scrollbar:SetWide(xLib.Utils.ScreenScale(2))
	function scrollbar:PerformLayout()
		local wide = scrollbar:GetWide()
		local scroll = scrollbar:GetScroll() / scrollbar.CanvasSize
		local barSize = math.max(scrollbar:BarScale() * (scrollbar:GetTall() - (wide * 2)), xLib.Utils.ScreenScale(10))
		local track = scrollbar:GetTall() - (wide * 2) - barSize
		track = track + 1

		scroll = scroll * track

		scrollbar.btnGrip:SetPos(0, (wide + scroll) - xLib.Utils.ScreenScale(15, true))
		scrollbar.btnGrip:SetSize(wide, barSize + xLib.Utils.ScreenScale(30))
	end

	local colour = Color(10, 10, 10, 255)

	function scrollbar:Paint(w, h)
		xLib.Utils.Rect(0, 0, scrollbar:GetWide(), scrollbar:GetTall(), Color(colour.r, colour.g, colour.b, 100))
	end

	function scrollbar.btnGrip:Paint(w, h)
		xLib.Utils.Rect(0, 0, scrollbar.btnGrip:GetWide(), scrollbar.btnGrip:GetTall(), colour or color_white)
	end
end

function xLib.Utils.SmallerScrollBar(scrollpanel)
	local scrollbar = scrollpanel.VBar
	scrollbar.btnUp:SetVisible(false)
	scrollbar.btnDown:SetVisible(false)
	scrollbar.OnCursorEntered = function()
		scrollbar:SetCursor("hand")
	end

	scrollbar:SetWide(xLib.Utils.ScreenScale(4))
	function scrollbar:PerformLayout()
		local wide = scrollbar:GetWide()
		local scroll = scrollbar:GetScroll() / scrollbar.CanvasSize
		local barSize = math.max(scrollbar:BarScale() * (scrollbar:GetTall() - (wide * 2)), xLib.Utils.ScreenScale(10))
		local track = scrollbar:GetTall() - (wide * 2) - barSize
		track = track + 1

		scroll = scroll * track

		scrollbar.btnGrip:SetPos(0, (wide + scroll) - xLib.Utils.ScreenScale(15, true))
		scrollbar.btnGrip:SetSize(wide, barSize + xLib.Utils.ScreenScale(30))
	end

	local colour = Color(10, 10, 10, 255)

	function scrollbar:Paint(w, h)
		xLib.Utils.Rect(0, 0, scrollbar:GetWide(), scrollbar:GetTall(), Color(colour.r, colour.g, colour.b, 100))
	end

	function scrollbar.btnGrip:Paint(w, h)
		xLib.Utils.Rect(0, 0, scrollbar.btnGrip:GetWide(), scrollbar.btnGrip:GetTall(), colour or color_white)
	end
end

-- Draw a rectangle
function xLib.Utils.Rect(x, y, w, h, col)
	surface.SetDrawColor(col)
	surface.DrawRect(x, y, w, h)
end

-- Draw a rounded rectangle
function xLib.Utils.RoundedRect(rad, x, y, w, h, bgcol, notopleft, notopright, nobottomleft, nobottomright)
	--xLib.Shadows.BeginShadow()
	draw.RoundedBoxEx(rad or 5, x, y, w, h, bgcol or Color(255, 255, 255, 255), (not notopleft), (not notopright), (not nobottomleft), (not nobottomright))
	--xLib.Shadows.EndShadow(1, 1, 1)
end

-- Draw a textured rectangle
function xLib.Utils.TexturedRect(x, y, w, h, mat)
	surface.SetDrawColor(Color(255, 255, 255, 255))
	surface.SetMaterial(mat)
	surface.DrawTexturedRect(x, y, w, h)
end

-- Draw a hollow rect outline
function xLib.Utils.HollowRect(x, y, w, h, col)
	surface.SetDrawColor(col)
	surface.DrawOutlinedRect(x, y, w, h)
end

function xLib.Utils.ThickHollowRect(x, y, w, h, thickness, bgcol)
    surface.SetDrawColor(bgcol)
    for i = 0, thickness - 1 do
        surface.DrawOutlinedRect(x + i, y + i, w - i * 2, h - i * 2)
    end
end

-- Draw a rect with outline
function xLib.Utils.OutlinedRect(x, y, w, h, fill, outline)
	xLib.Utils.HollowRect(x, y, w, h, outline)
	xLib.Utils.Rect(x + 1, y + 1, w - 1, h - 1, fill)
end

-- Draw a circle with a specific width and height
function xLib.Utils.DrawStretchedCircle(x, y, w, h, col)
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
function xLib.Utils.DrawCircle(x, y, r, col)
	xLib.Utils.DrawStretchedCircle(x, y, r, r, col)
end

function xLib.Utils.DrawHollowCircle(x, y, r, col)
	if not thickness then thickness = 1 end

	local x0 = -10
	local y0 = 0

	for i = 0, 360 do
        local c = math.cos(math.rad(i))
        local s = math.sin(math.rad(i))

        local newx = y0 * s - x0 * c
        local newy = y0 * c + x0 * s

        draw.NoTexture()
        surface.SetDrawColor(col)
        surface.DrawTexturedRectRotated(x + newx, y + newy, r / 2 - 2, r / 2 - 2, i)
    end
end

-- Modified from TDLib (cl_tdlib.lua DrawArc)
-- Draw part of a circle
function xLib.Utils.DrawPartCircle(x, y, rot, totang, w, h, col, seg)
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
function xLib.Utils.DrawPartCircleShadow(x, y, rot, totang, w, h, col, seg)
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
function xLib.Utils.DrawRectShadow(x, y, w, h)
	surface.DrawRect(x, y, w, h)
end

-- Draw a rectangle with rounded sides
function xLib.Utils.DrawRoundedSideRect(x, y, w, h, col)
	xLib.Utils.Rect(x - x / 2, y, w - (w * 0.25), h, col)
	xLib.Utils.DrawPartCircle(x - (w * 0.128), y + h / 2, 180, 180, w * 0.125, h / 2, col, 360)
	xLib.Utils.DrawPartCircle(x + (w * 0.625) - xLib.Utils.ScreenScale(2), y + h / 2, 0, 180, w * 0.125, h / 2, col, 360)
end

-- Draw a shadow for a rectangle with rounded sides
function xLib.Utils.DrawRoundedSideRectShadow(parentpnl, x, y, w, h)
	local x, y = parentpnl:LocalToScreen(0, 0)

	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)

	for i = 1, 3 do
		blur:SetFloat("$blur", (i / 3) * (amount or 8))
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end

	xLib.Utils.RectShadow(x - x / 2, y, w - (w * 0.25), h)
	xLib.Utils.DrawPartCircleShadow(x - w * 0.125, y + h / 2, 180, 180, w * 0.125, h / 2)
	xLib.Utils.DrawPartCircleShadow(x + (w * 0.625), y + h / 2, 0, 180, w * 0.125, h / 2)
end

-- Create a rect panel
function xLib.Utils.DoRectPanel(parent, x, y, w, h, bgcol, noshadow)
	local pnl = vgui.Create("DPanel", parent)
	pnl:SetSize(w, h)
	pnl:SetPos(x, y)
	function pnl.Paint(s, w, h)
		local ax, ay = pnl:LocalToScreen()
		if xLib.Config.DisableMenuShadows or noshadow then ax, ay = 0, 0 end

		if not noshadow then xLib.Shadows.BeginShadow() end
		xLib.Utils.Rect(ax, ay, w, h, bgcol)
		if not noshadow then xLib.Shadows.EndShadow(1, 1, 1) end
	end

	return pnl
end

-- Create a rect panel with rounded corners
function xLib.Utils.DoRoundedRectPanel(parent, x, y, w, h, bgcol, rad, notopleft, notopright, nobottomleft, nobottomright, noshadow)
	local pnl = vgui.Create("DPanel", parent)
	pnl:SetSize(w, h)
	pnl:SetPos(x, y)
	function pnl.Paint(s, w, h)
		local ax, ay = pnl:LocalToScreen()
		if noshadow or xLib.Config.DisableMenuShadows then ax, ay = 0, 0 end

		if not noshadow then xLib.Shadows.BeginShadow() end
		draw.RoundedBoxEx(rad or 5, ax, ay, w, h, bgcol, (not notopleft), (not notopright), (not nobottomleft), (not nobottomright))
		if not noshadow then xLib.Shadows.EndShadow(1, 1, 1) end
	end

	return pnl
end

-- Create a centered rect panel with rounded corners
function xLib.Utils.DoRoundedRectPanelCentered(parent, w, h, bgcol, rad)
	return xLib.Utils.DoRoundedRectPanel(parent, parent:GetWide() / 2 - w / 2, parent:GetTall() / 2 - h / 2, w, h, bgcol, rad)
end

-- Create a centered rect panel
function xLib.Utils.DoRectPanelCentered(parent, w, h, bgcol)
	local pnl = vgui.Create("DPanel", parent)
	pnl:SetSize(w, h)
	pnl:SetPos(parent:GetWide() / 2 - w / 2, parent:GetTall() / 2 - h / 2)
	function pnl.Paint(s, w, h)
		local ax, ay = pnl:LocalToScreen()
		if xLib.Config.DisableMenuShadows then ax, ay = 0, 0 end

		xLib.Shadows.BeginShadow()
		xLib.Utils.Rect(ax, ay, w, h, bgcol)
		xLib.Shadows.EndShadow(1, 1, 1)
	end

	return pnl
end

-- Create a textured and centered rect panel
function xLib.Utils.DoTexturedRectPanelCentered(parent, w, h, mat, ismaterial)
	local pnl = vgui.Create("DPanel", parent)
	pnl:SetSize(w, h)
	pnl:SetPos(parent:GetWide() / 2 - w / 2, parent:GetTall() / 2 - h / 2)

	pnl.material = ismaterial and mat or Material(mat)
	local defmat = Material(xLib.Config.MenuBackground)
	function pnl:Paint(w, h)
		xLib.Utils.TexturedRect(0, 0, w, h, self.material or defmat)
	end

	return pnl
end

-- Create a rectangular button
function xLib.Utils.DoButtonRect(parent, tx, font, x, y, w, h, bgcol, ortxcol)
	local btn = vgui.Create("DButton", parent)
	btn:SetSize(w, h)
	btn:SetPos(x, y)
	btn:SetText(tx)
	btn:SetFont(font)
	btn:SetTextColor(ortxcol or xLib.Utils.CalculateTextCol(bgcol))
	function btn:Paint(w, h)
		local ax, ay = self:LocalToScreen()
		if xLib.Config.DisableMenuShadows then ax, ay = 0, 0 end

		xLib.Shadows.BeginShadow()
		xLib.Utils.Rect(ax, ay, w, h, bgcol)
		xLib.Shadows.EndShadow(1, 1, 1)
	end

	return btn
end

function xLib.Utils.DoUnshadowedButton(parent, tx, font, x, y, w, h, bgcol, hovercol)
	local btn = vgui.Create("DButton", parent)
	btn:SetSize(w, h)
	btn:SetPos(x, y)
	btn:SetText(tx)
	btn:SetFont(font)
	btn:SetTextColor(Color(255, 255, 255, 255))
	local disabledcol = Color(20, 20, 20, 255)
	function btn:Paint(w, h)
		draw.RoundedBoxEx(5, 0, 0, w, h, self:GetDisabled() and disabledcol or (self:IsHovered() and hovercol or bgcol), true, true, true, true)
	end

	function btn:OnCursorEntered()
		self:SetCursor(self:GetDisabled() and "no" or "hand")
	end

	return btn
end

function xLib.Utils.DoButtonBase(parent, x, y, w, h)
	local btn = vgui.Create("DButton", parent)
	btn:SetSize(w, h)
	btn:SetPos(x, y)
	btn:SetText("")
	function btn:Paint(w, h) end

	return btn
end

-- Create a rounded button
function xLib.Utils.DoRoundedRectButton(parent, tx, font, x, y, w, h, bgcol, hovercol, ortxcol, doround, noshadow)
	local btn = vgui.Create("DButton", parent)
	btn:SetSize(w, h)
	btn:SetPos(x, y)
	btn:SetText(tx)
	btn:SetFont(font)
	btn:SetTextColor(ortxcol or xLib.Utils.CalculateTextCol(bgcol))
	function btn:Paint(w, h)
		local ax, ay = self:LocalToScreen()
		if xLib.Config.DisableMenuShadows then ax, ay = 0, 0 end

		if not noshadow then xLib.Shadows.BeginShadow() end
		draw.RoundedBoxEx(doround and 5 or 0, noshadow and 0 or ax, noshadow and 0 or ay, w, h, (self:IsHovered() or self:GetDisabled()) and hovercol or bgcol, true, true, true, true)
		if not noshadow then xLib.Shadows.EndShadow(1, 1, 1) end
	end

	function btn:OnCursorEntered()
		self:SetCursor(self:GetDisabled() and "no" or "hand")
	end

	return btn
end

-- Create a rounded button
function xLib.Utils.DoRoundedButton(parent, tx, font, x, y, w, h, bgcol, ortxcol)
	local btnshadow = vgui.Create("DButton", parent)
	btnshadow:SetSize(w + xLib.Utils.ScreenScale(10), h + xLib.Utils.ScreenScale(10))
	btnshadow:SetPos(x - xLib.Utils.ScreenScale(5) / 2, y)
	btnshadow:SetText("")
	function btnshadow.Paint(s, w, h)
		xLib.Utils.Rect(0, 0, w - xLib.Utils.ScreenScale(10), h - xLib.Utils.ScreenScale(10), Color(0, 0, 0, 175))

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
	btn:SetTextColor(ortxcol or xLib.Utils.CalculateTextCol(bgcol))
	function btn.Paint(s, w, h)
		xLib.Utils.Rect(0, 0, w, h, bgcol) -- We don't want to use rounded corners, so anything using this function should draw a normal rect
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
		s:SetPos(x, y - xLib.Utils.ScreenScale(2))
		btnshadow:SetVisible(true)
	end

	function btn.OnCursorExited(s)
		s:SetPos(x, y)
		btnshadow:SetVisible(false)
	end

	function btnshadow.OnCursorEntered(s)
		btn:SetPos(x, y - xLib.Utils.ScreenScale(2))
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
function xLib.Utils.DoCircleIcon(parent, steamid, x, y, w, h, size, circle, mask)
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

		local masksize = circle and 42 or 200
		if mask then masksize = mask end

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

function xLib.Utils.DoCircleMask(dodraw, masksize, w, h)
	render.ClearStencil() 
    render.SetStencilEnable(true)

    render.SetStencilWriteMask(1)
    render.SetStencilTestMask(1)

    render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
    render.SetStencilPassOperation(STENCILOPERATION_ZERO)
    render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
    render.SetStencilReferenceValue(1)

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

   	if dodraw then
		dodraw:SetPaintedManually(false)
		dodraw:PaintManual()
		dodraw:SetPaintedManually(true)
	end

    render.SetStencilEnable(false)
    render.ClearStencil() 
end

function xLib.Utils.DoCircleModelImage(parent, model, col, x, y, w, h)
	local bg = xLib.Utils.DoRoundedRectPnl(parent, x, y, w, h, col, xLib.Utils.ScreenScale(30))
	local bgsec = xLib.Utils.DoRoundedRectPnl(parent, xLib.Utils.ScreenScale(9), xLib.Utils.ScreenScale(9), w - xLib.Utils.ScreenScale(6), h - xLib.Utils.ScreenScale(6), Color(20, 20, 20, 255), xLib.Utils.ScreenScale(30))

	local pn = vgui.Create("DPanel", parent)
	pn:SetSize(w, h)
	pn:SetPos(x, y)
	pn:SetText("")

	local ico
	if model then
		ico = vgui.Create("ModelImage", pn)
		ico:SetSize(w, h)
		ico:SetPos(x, y)
		ico:SetModel(model)
		ico:SetPaintedManually(true)
	end

	local masksize = xLib.Utils.ScreenScale(26)
	function pn:Paint(w, h)
	   	xLib.Utils.DoCircleMask(ico, masksize, w, h)
	end

	return pn
end

-- Create a text panel
function xLib.Utils.DoText(parent, txt, font, col, center, offset)
	local tx = vgui.Create("DLabel", parent)
	tx:SetFont(font)
	tx:SetText(txt)
	tx:SizeToContents()
	tx:SetTextColor(col)
	if center then tx:SetPos(parent:GetWide() / 2 - tx:GetWide() / 2 - (offset or 0), parent:GetTall() / 2 - tx:GetTall() / 2 - (offset or 0)) end
	
	return tx
end

function xLib.Utils.DoHeadedText(parent, maxw, x, y, main, sub, font, nocolon, aspanel, nospace, headcol, subfont)
	local markupobj = markup.Parse(string.format("<font=%s><colour=%s>%s%s%s</colour></font><font=%s><colour=200,200,200>%s</colour></font>", font, headcol or "255,255,255", main, nocolon and "" or ":", nospace and "" or " ", subfont or font, sub), maxw)
	local textpnl = aspanel and xLib.Utils.DoPnl(parent, x, y, maxw, markupobj:GetHeight()) or xLib.Utils.DoButtonBase(parent, x, y, maxw, markupobj:GetHeight())
	function textpnl:Paint(w, h)
		markupobj:Draw(0, 0, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

	if not aspanel then
		local oldhov = parent.IsHovered
		function parent:IsHovered()
			if textpnl:IsHovered() then return true end
			return oldhov(self)
		end

		textpnl.DoClick = parent.DoClick
	end

	return textpnl
end

-- Draw text
function xLib.Utils.Text(tx, x, y, font, col, cx, cy)
	surface.SetFont(font)
	local tw, th = surface.GetTextSize(tx)
	surface.SetTextPos(x - (cx and tw / 2 or 0), y - (cy and th / 2 or 0))
	surface.SetTextColor(col or Color(255, 255, 255, 255))
	surface.DrawText(tx)
end

-- Create a scroll panel with edited scrollbar
function xLib.Utils.DoScrollPnl(parent, x, y, w, h)
	local pnl = vgui.Create("DScrollPanel", parent)
	pnl:SetSize(w, h)
	pnl:SetPos(x, y)
	function pnl:Paint(w, h) end
	xLib.Utils.EditScrollBarStyle(pnl)

	return pnl
end

function xLib.Utils.DoPnl(parent, x, y, w, h)
	local pnl = vgui.Create("DPanel", parent)
	pnl:SetSize(w, h)
	pnl:SetPos(x, y)
	function pnl:Paint(w, h) end

	return pnl
end

local function GetContentsForCol(contents, col, cols)
	local rtn = {}

	for k, v in ipairs(contents) do
		local colrequired = ((k - 1) % cols) + 1
		if colrequired == col then
			table.insert(rtn, v)
		end
	end

	return rtn
end

-- Create grid which can be easily modified and rebuilt
function xLib.Utils.CreateRebuildableGrid(parent, x, y, w, h, cols, marginhor, marginver)
	local grid = vgui.Create("DScrollPanel", parent)
	grid:SetPos(x, y)
	grid:SetSize(w, h)
	function grid:Paint(w, h) end
	xLib.Utils.HideScrollBar(grid)

	grid.Contents = {}

	function grid:DoRebuild()
		local xpos = 0
		for x = 1, cols do
			local col = vgui.Create("DPanel", grid)
			col:SetSize(w / cols - (marginhor * cols), h)
			col:SetPos(xpos, 0)
			xpos = xpos + col:GetWide() + marginver
			function col:Paint(w, h) end

			grid:AddItem(col)

			local ypos = 0
			local colh = 0
			for k, v in ipairs(GetContentsForCol(grid.Contents, x, cols)) do
				if (not (v and IsValid(v))) then continue end

				v:SetParent(col)
				v:SetPos(0, ypos)
				v:SetSize(col:GetWide(), v:GetTall())

				colh = colh + v:GetTall() + marginhor
				ypos = ypos + v:GetTall() + marginhor
			end

			col:SetSize(col:GetWide(), colh)
		end
	end

	function grid:AddContents(item, nobuild)
		table.insert(self.Contents, item)
		if not nobuild then self:DoRebuild() end
	end

	return grid
end

-- Create a ThreeGrid
function xLib.Utils.DoGrid(parent, x, y, w, h, bgcol, cols, marginhor, marginver, nosb)
	local grid = vgui.Create("ThreeGrid", parent)
	grid:SetPos(x, y)
	grid:SetSize(w, h)
	if not nosb then xLib.Utils.EditScrollBarStyle(grid) else xLib.Utils.HideScrollBar(grid) end

	grid:SetHorizontalMargin(marginhor or 0)
	grid:SetVerticalMargin(marginver or 0)
	grid:SetColumns(cols)

	function grid:Paint(w, h)
		xLib.Utils.Rect(0, 0, w, h, bgcol)
	end

	return grid
end

-- Create a grid row
function xLib.Utils.DoGridRow(parent, height, col, isbtn, hovercol, norounded)
	local pnl = vgui.Create(isbtn and "DButton" or "DPanel")
	pnl:SetTall(height)
	pnl.CurrentBGCol = Color(col.r, col.g, col.b, 255)
	if isbtn then pnl:SetText("") end
	function pnl.Paint(s, w, h)
		if norounded then xLib.Utils.Rect(0, 0, w, h, (isbtn and s:IsHovered()) and hovercol or col) else xLib.Utils.RoundedRect(xLib.Utils.ScreenScale(5), 0, 0, w, h, (isbtn and s:IsHovered()) and hovercol or col) end
	end

	function pnl:OnCursorEntered()
		pnl.CurrentBGCol = hovercol and Color(hovercol.r, hovercol.g, hovercol.b, 255) or Color(col.r, col.g, col.b, 255)
	end

	function pnl:OnCursorExited()
		pnl.CurrentBGCol = Color(col.r, col.g, col.b, 255)
	end

	parent:AddCell(pnl)

	return pnl
end

-- Create a rounded rect panel
function xLib.Utils.DoRoundedRectPnl(parent, x, y, w, h, col, rad)
	local pnl = vgui.Create("DPanel", parent)
	pnl:SetSize(w, h)
	pnl:SetPos(x, y)
	function pnl.Paint(s, w, h)
		xLib.Utils.RoundedRect(rad or xLib.Utils.ScreenScale(0), 0, 0, w, h, col)
	end

	return pnl
end

-- Create an image panel
function xLib.Utils.DoImage(parent, x, y, w, h, img, col)
	col = col or Color(255, 255, 255, 255)
	local mat = isstring(img) and Material(img, "noclamp smooth") or img
	local img = vgui.Create("DImage", parent)
	img:SetPos(x, y)
	img:SetSize(w, h)
	img:SetMaterial(mat)
	img:SetImageColor(col)

	return img
end

-- Create a button with an image
function xLib.Utils.DoImageBtn(parent, x, y, w, h, texture, spin)
	local img = vgui.Create("DButton", parent)
	img:SetPos(x, y)
	img:SetSize(w, h)
	img:SetText("")
	img.mat = Material(texture, "noclamp smooth")

	img.Col = Color(255, 255, 255, 255)

	img.Rotation = 0
	function img.Paint(s, w, h)
		surface.SetMaterial(s.mat)
		surface.SetDrawColor(img.Col)

		if s:IsHovered() and spin then
			s.Rotation = Lerp(1 * FrameTime(), s.Rotation, s.Rotation + 100)
			if s.Rotation >= 360 then s.Rotation = 0 end
		end

		surface.DrawTexturedRectRotated(w / 2, h / 2, w, h, s.Rotation)
	end

	return img
end

-- Create keyboard input
function xLib.Utils.DoKeyboardInput(parent, def, x, y, w, h, isnumeric, font, col, dorounded)
	if (isnumeric == nil) then isnumeric = false end
	if not font then font = "xLibSubTitleFont" end

	local txpnl = vgui.Create("DTextEntry", parent)
	txpnl:SetFont(font)
	txpnl:SetPos(x, y)
	txpnl:SetTextColor(Color(255, 255, 255, 255))
	txpnl:SetPlaceholderColor(Color(200, 200, 200, 255))
	txpnl:SetPlaceholderText(def)
	txpnl.CurrentValue = def
	txpnl:SetSize(w, h)
	txpnl:SetNumeric(isnumeric)

	col = col or Color(0, 0, 0, 100)
	function txpnl.Paint(s, w, h)
		if dorounded then
			local ax, ay = s:LocalToScreen()
			if xLib.Config.DisableMenuShadows then ax, ay = 0, 0 end

			xLib.Shadows.BeginShadow()
			draw.RoundedBoxEx(5, ax, ay, w, h, col, true, true, true, true)
			xLib.Shadows.EndShadow(1, 1, 1)
		else
			xLib.Utils.RoundedRect(0, 0, 0, w, h, col)
		end

		if (s:GetText() and (s:GetText() ~= "")) or s:HasFocus() then
			s:DrawTextEntryText(Color(255, 255, 255, 255), Color(0, 0, 255), Color(0, 0, 0, 255))
		else
			surface.SetTextColor(s:GetPlaceholderColor())
			surface.SetFont(font)
			local tw, th = surface.GetTextSize(tostring(def))
			surface.SetTextPos(xLib.Utils.ScreenScale(5, true), h / 2 - th / 2)
			surface.DrawText(tostring(def))
		end
	end

	txpnl:SetUpdateOnType(true)
	function txpnl:OnValueChange(val)
		self.CurrentValue = val
	end

	function txpnl:GetValue()
		return self.CurrentValue or ""
	end

	return txpnl
end

function xLib.Utils.DoLabelledKeyboardInput(parent, lbl, def, x, y, w, h, isnumeric, font, addpnl)
	if (isnumeric == nil) then isnumeric = false end
	if not font then font = "xLibMidHeaderFont" end

	local maincol = Color(35, 35, 35, 255)
	local subcol = Color(0, 0, 0, 100)

	local base = vgui.Create("DPanel", parent)
	base:SetPos(x, y)
	base:SetSize(w, h)
	function base:Paint(w, h)
		draw.RoundedBox(5, 0, 0, w, h, maincol)
	end

	local lblpnl = vgui.Create("DLabel", base)
	lblpnl:SetFont(font)
	lblpnl:SetText(lbl)
	lblpnl:SetTextColor(Color(255, 255, 255, 255))
	lblpnl:SizeToContents()
	lblpnl:SetPos(xLib.Utils.ScreenScale(10), base:GetTall() / 2 - lblpnl:GetTall() / 2)

	local txpnl = vgui.Create("DTextEntry", base)
	txpnl:SetFont(font)
	txpnl:SetPos(lblpnl:GetWide() + xLib.Utils.ScreenScale(20), 0)
	txpnl:SetTextColor(Color(255, 255, 255, 255))
	txpnl:SetPlaceholderColor(Color(225, 225, 225, 75))
	txpnl:SetPlaceholderText(def)
	txpnl.CurrentValue = def
	txpnl:SetSize(w - lblpnl:GetWide() - xLib.Utils.ScreenScale(20), h)
	txpnl:SetNumeric(isnumeric)
	function txpnl.Paint(s, w, h)
		draw.RoundedBoxEx(5, 0, 0, w, h, subcol, false, true, false, true)
		if (s:GetText() and (s:GetText() ~= "")) or s:HasFocus() then
			s:DrawTextEntryText(Color(255, 255, 255, 255), Color(0, 0, 255), Color(0, 0, 0, 255))
		else
			surface.SetTextColor(s:GetPlaceholderColor())
			surface.SetFont(font)
			local tw, th = surface.GetTextSize(tostring(def))
			surface.SetTextPos(xLib.Utils.ScreenScale(5, true), h / 2 - th / 2)
			surface.DrawText(tostring(def))
		end
	end

	txpnl:SetUpdateOnType(true)
	function txpnl:OnValueChange(val)
		self.CurrentValue = val
	end

	function txpnl:GetValue()
		return (txpnl.CurrentValue and txpnl.CurrentValue ~= "") and txpnl.CurrentValue or def
	end

	base.GetValue = txpnl.GetValue
	base.txpnl = txpnl

	if addpnl then
		local addh = addpnl(base, lblpnl:GetWide() + xLib.Utils.ScreenScale(20), txpnl)
		base:SetSize(w, h + addh + xLib.Utils.ScreenScale(10, true))
	end

	return base
end

function xLib.Utils.DoLabelledDropdown(parent, lbl, options, x, y, w, h, font, def)
	if not font then font = "xLibMidHeaderFont" end

	local maincol = Color(35, 35, 35, 255)
	local subcol = Color(0, 0, 0, 100)

	local base = vgui.Create("DPanel", parent)
	base:SetPos(x, y)
	base:SetSize(w, h)
	function base:Paint(w, h)
		draw.RoundedBox(5, 0, 0, w, h, maincol)
	end

	local lblpnl = vgui.Create("DLabel", base)
	lblpnl:SetFont(font)
	lblpnl:SetText(lbl)
	lblpnl:SetTextColor(Color(255, 255, 255, 255))
	lblpnl:SizeToContents()
	lblpnl:SetPos(xLib.Utils.ScreenScale(10), base:GetTall() / 2 - lblpnl:GetTall() / 2)

	local dropdown = xLib.Utils.DoOptionInput(base, lblpnl:GetWide() + xLib.Utils.ScreenScale(20), 0, w - lblpnl:GetWide() - xLib.Utils.ScreenScale(20), h, options, def or (options[1] and options[1].Val or lbl), font, def)

	base.GetValue = dropdown.GetValue
	base.dropdown = dropdown

	return base
end

function xLib.Utils.DoLabelledCheckbox(parent, lbl, x, y, w, h, font, def)
	if not font then font = "xLibMidHeaderFont" end

	local maincol = Color(35, 35, 35, 255)
	local subcol = Color(0, 0, 0, 100)

	local base = vgui.Create("DPanel", parent)
	base:SetPos(x, y)
	base:SetSize(w, h)
	function base:Paint(w, h)
		draw.RoundedBox(5, 0, 0, w, h, maincol)
	end

	local lblpnl = vgui.Create("DLabel", base)
	lblpnl:SetFont(font)
	lblpnl:SetText(lbl)
	lblpnl:SetTextColor(Color(255, 255, 255, 255))
	lblpnl:SizeToContents()
	lblpnl:SetPos(xLib.Utils.ScreenScale(10), base:GetTall() / 2 - lblpnl:GetTall() / 2)

	local switch = xLib.Utils.DoInputSwitch(base, lblpnl:GetWide() + xLib.Utils.ScreenScale(20), xLib.Utils.ScreenScale(5), xLib.Utils.ScreenScale(72), h - xLib.Utils.ScreenScale(10, true), def or false)

	base.GetValue = switch.GetValue
	base.switch = switch

	return base
end

function xLib.Utils.DoLabelledPlayerInput(parent, lbl, x, y, w, h, font)
	local options = {}

	for k, v in ipairs(player.GetAll()) do
		table.insert(options, {Val = v:Nick(), Dat = v:SteamID()})
	end

	return xLib.Utils.DoLabelledDropdown(parent, lbl, options, x, y, w, h, font)
end

-- Create fancy colour input
function xLib.Utils.DoLabelledColorInput(parent, lbl, def, x, y, w, h, combow, comboh)
	local maincol = Color(35, 35, 35, 255)
	local subcol = Color(0, 0, 0, 100)

	local base = vgui.Create("DPanel", parent)
	base:SetPos(x, y)
	base:SetSize(w, h)
	function base:Paint(w, h)
		draw.RoundedBox(5, 0, 0, w, h, maincol)
	end

	local lblpnl = vgui.Create("DLabel", base)
	lblpnl:SetFont("xLibMidHeaderFont")
	lblpnl:SetText(lbl)
	lblpnl:SetTextColor(Color(255, 255, 255, 255))
	lblpnl:SizeToContents()
	lblpnl:SetPos(xLib.Utils.ScreenScale(10), base:GetTall() / 2 - lblpnl:GetTall() / 2)

	local colorpnl = vgui.Create("xLibColorMixer", base)
	colorpnl:SetPos(x + lblpnl:GetWide() + xLib.Utils.ScreenScale(20), xLib.Utils.ScreenScale(5, true))
	colorpnl:SetSize(combow, comboh)
	colorpnl:SetColor(def)
	base.ColorPnl = colorpnl

	base:SetSize(w, comboh + xLib.Utils.ScreenScale(10, true))

	function colorpnl:GetValue()
		local col = self:GetColor()
		return Color(col.r, col.g, col.b)
	end

	return base
end

function xLib.Utils.DoLabelledInput(parent, lbl, x, y, w, h, func)
	local maincol = Color(35, 35, 35, 255)
	local subcol = Color(0, 0, 0, 100)

	local base = vgui.Create("DPanel", parent)
	base:SetPos(x, y)
	base:SetSize(w, h)
	function base:Paint(w, h)
		draw.RoundedBox(5, 0, 0, w, h, maincol)
	end

	local lblpnl = vgui.Create("DLabel", base)
	lblpnl:SetFont("xLibMidHeaderFont")
	lblpnl:SetText(lbl)
	lblpnl:SetTextColor(Color(255, 255, 255, 255))
	lblpnl:SizeToContents()
	lblpnl:SetPos(xLib.Utils.ScreenScale(10), base:GetTall() / 2 - lblpnl:GetTall() / 2)

	local pnl = func(base, x + lblpnl:GetWide() + xLib.Utils.ScreenScale(20), xLib.Utils.ScreenScale(5, true), w - lblpnl:GetWide() - xLib.Utils.ScreenScale(20))
	base:SetSize(w, pnl:GetTall() + xLib.Utils.ScreenScale(10, true))

	return base
end

function xLib.Utils.DoInputSwitch(parent, x, y, w, h, def, oncol, offcol, basecol)
	oncol = oncol or Color(31, 140, 103, 255)
	offcol = offcol or Color(120, 12, 12, 255)
	basecol = basecol or Color(25, 25, 25, 255)

	local pnl = vgui.Create("DButton", parent)
	pnl.IsOn = def
	pnl.CirclePos = h/2
	pnl.CircleToPos = pnl.IsOn and (w - h/2) or h/2
	pnl:SetText("")
	pnl:SetPos(x, y)
	pnl:SetSize(w, h)
	function pnl:Paint(w, h)
		draw.RoundedBox(h/4, xLib.Utils.ScreenScale(4), xLib.Utils.ScreenScale(4), w - xLib.Utils.ScreenScale(8), h - xLib.Utils.ScreenScale(8, true), basecol)
		xLib.Utils.DrawCircle(pnl.CirclePos, h/2, h/2, self.IsOn and oncol or offcol)
	end

	function pnl:DoClick()
		self.IsOn = (not self.IsOn)
		pnl.CircleToPos = self.IsOn and (self:GetWide() - self:GetTall()/2) or self:GetTall()/2

		self:OnChanged(self.IsOn)
	end

	function pnl:OnChanged() end

	function pnl:Think()
		pnl.CirclePos = Lerp(0.07, pnl.CirclePos, pnl.CircleToPos)
	end

	function pnl:GetValue()
		return self.IsOn
	end

	return pnl
end

-- Create colour input
function xLib.Utils.DoColorInput(parent, def, x, y, w, h)
	local colorpnl = vgui.Create("DColorMixer", parent)
	colorpnl:SetPos(x, y)
	colorpnl:SetSize(w, h)
	colorpnl:SetColor(def)
	colorpnl:SetAlphaBar(false)

	function colorpnl:GetValue()
		local col = self:GetColor()
		return Color(col.r, col.g, col.b)
	end

	return colorpnl
end

-- Create a checkbox
function xLib.Utils.DoCheckbox(parent, x, y, w, h, col, bgcol, def, callback)
	local box = vgui.Create("DCheckBox", parent)
	box:SetPos(x, y)
	box:SetSize(w, h)
	box:TDLib()
	box:ClearPaint()
		:SquareCheckbox(bgcol, col)
	box:SetValue(def)
	box.OnChange = callback
	box.GetValue = box.GetChecked

	return box
end

-- Create an input panel
function xLib.Utils.DoInput(tittx)
	local inputbtnw = xLib.Utils.ScreenScale(275)
	local inputbtnh = xLib.Utils.ScreenScale(28, true)

	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW(), ScrH())
	frame:Center()
	frame:SetDraggable(false)
	frame:SetTitle("")
	frame:ShowCloseButton(false)
	frame:MakePopup()
	frame.Paint = function(s) Derma_DrawBackgroundBlur(s) end

	local inputpnl = xLib.Utils.DoRoundedRectPnl(frame, frame:GetWide() / 2 - ((ScrW() * 0.3) / 2), frame:GetTall() / 2 - ((ScrH() * 0.2) / 2), ScrW() * 0.3, xLib.Utils.ScreenScale(168, true), Color(30, 30, 30, 255))

	local tit = xLib.Utils.DoText(inputpnl, tittx, "xLibMidHeaderFont", Color(255, 255, 255, 255), false)
	tit:SetPos(inputpnl:GetWide() / 2 - tit:GetWide() / 2, xLib.Utils.ScreenScale(15, true))

	local confirm = xLib.Utils.DoUnshadowedButton(inputpnl, "Confirm", "xLibSubTitleFont", inputpnl:GetWide() / 2 - inputbtnw - xLib.Utils.ScreenScale(15), inputpnl:GetTall() - inputbtnh - xLib.Utils.ScreenScale(15), inputbtnw, inputbtnh, Color(31, 140, 103, 255), Color(31, 190, 103, 255))
	function confirm.DoClick()
		frame:Close()
	end

	local cancel = xLib.Utils.DoUnshadowedButton(inputpnl, "Cancel", "xLibSubTitleFont", inputpnl:GetWide() / 2 + xLib.Utils.ScreenScale(15), inputpnl:GetTall() - inputbtnh - xLib.Utils.ScreenScale(15), inputbtnw, inputbtnh, Color(140, 31, 54, 255), Color(190, 31, 54, 255))
	function cancel.DoClick()
		frame:Close()
	end

	function frame.PerformLayout(s)
		inputpnl:SetPos(frame:GetWide() / 2 - inputpnl:GetWide() / 2, frame:GetTall() / 2 - inputpnl:GetTall() / 2)
		confirm:SetPos(inputpnl:GetWide() / 2 - inputbtnw - xLib.Utils.ScreenScale(15), inputpnl:GetTall() - inputbtnh - xLib.Utils.ScreenScale(10))
		cancel:SetPos(inputpnl:GetWide() / 2 + xLib.Utils.ScreenScale(15), inputpnl:GetTall() - inputbtnh - xLib.Utils.ScreenScale(10))
	end

	return inputpnl, confirm
end

-- Request confirmation for actions
function xLib.Utils.RequestConfirmation(tit, callback, sub)
	local inputpnl, confirmbtn = xLib.Utils.DoInput(tit)

	local subtx = xLib.Utils.DoText(inputpnl, sub or xLib.GetLanguageString("noundo"), "xLibSubHeaderFont", Color(255, 255, 255, 255), false)
	subtx:SetPos(inputpnl:GetWide() / 2 - subtx:GetWide() / 2, xLib.Utils.ScreenScale(54, true))

	local confirmtx = "76561198093392227"
	local old = confirmbtn.DoClick
	function confirmbtn:DoClick()
		callback()
		old(self)
	end
end

-- Create string input popup
function xLib.Utils.StrInput(tit, current, callback)
	local inputpnl, confirmbtn = xLib.Utils.DoInput(tit)
	local txbox = xLib.Utils.DoKeyboardInput(inputpnl, current, xLib.Utils.ScreenScale(10), xLib.Utils.ScreenScale(62, true), inputpnl:GetWide() - xLib.Utils.ScreenScale(20), xLib.Utils.ScreenScale(28, true))

	local old = confirmbtn.DoClick
	function confirmbtn:DoClick()
		if (txbox:GetValue() or current) then callback((txbox:GetValue() and (txbox:GetValue() ~= "")) and txbox:GetValue() or current) end
		old(self)
	end
end

-- Create string input panel
function xLib.Utils.DoStrInput(parent, placeholder, x, y, w, h)
	local txbox = xLib.Utils.DoKeyboardInput(parent, placeholder, x, y, w, h)
	return txbox
end

-- Create input with multiple fields
function xLib.Utils.DoMultiInput(tit, fields, callback)
	local inputpnl, confirmbtn = xLib.Utils.DoInput(tit)

	local inputfields = {}
	local y = xLib.Utils.ScreenScale(72, true)
	local xpos = 0
	tall = inputpnl:GetTall() - xLib.Utils.ScreenScale(57, true)
	for k, v in ipairs(fields) do
		local fieldlb = xLib.Utils.DoText(inputpnl, v[2] .. ": ", "xLibSubHeaderFont", Color(255, 255, 255, 255), false)
		fieldlb:SetPos(xLib.Utils.ScreenScale(10), y + xLib.Utils.ScreenScale(5, true))
		if fieldlb:GetWide() > xpos then xpos = fieldlb:GetWide() end

		local field =
		((v[1] == "String") or (v[1] == "Int")) and
		xLib.Utils.DoKeyboardInput(inputpnl, v[3], xLib.Utils.ScreenScale(15) + fieldlb:GetWide(), y, inputpnl:GetWide() - xLib.Utils.ScreenScale(30) - fieldlb:GetWide(), xLib.Utils.ScreenScale(34, true)) 
		or (v[1] == "Combobox") and
		xLib.Utils.DoOptionInput(inputpnl, xLib.Utils.ScreenScale(15) + fieldlb:GetWide(), y, inputpnl:GetWide() - xLib.Utils.ScreenScale(30) - fieldlb:GetWide(), xLib.Utils.ScreenScale(52, true), v[3])
		or (v[1] == "Checkbox") and
		xLib.Utils.DoCheckbox(inputpnl, xLib.Utils.ScreenScale(15) + fieldlb:GetWide(), y, fieldlb:GetTall() + xLib.Utils.ScreenScale(10, true), fieldlb:GetTall() + xLib.Utils.ScreenScale(10, true), Color(40, 40, 40, 255), Color(40, 75, 40, 255), v[3], function() end)
		or (v[1] == "Color") and
		xLib.Utils.DoColorInput(inputpnl, v[3], xLib.Utils.ScreenScale(15) + fieldlb:GetWide(), y, inputpnl:GetWide() - xLib.Utils.ScreenScale(30) - fieldlb:GetWide(), xLib.Utils.ScreenScale(208, true))
		
		if v[1] == "Int" then field:SetNumeric(true) end
		if v[1] == "Checkbox" then field.IsCheckbox = true end
		y = y + field:GetTall() + xLib.Utils.ScreenScale(35, true)
		tall = tall + field:GetTall() + xLib.Utils.ScreenScale(35, true)

		function field:GetInfo()
			if (((v[1] == "String") or (v[1] == "Int") or (v[1] == "Combobox"))) then
				return ((field:GetValue() ~= "") and field:GetValue() or v[3])
			elseif (v[1] == "Checkbox") then
				return field:GetChecked()
			else
				return Color(field:GetColor().r, field:GetColor().g, field:GetColor().b, 255)
			end
		end

		table.insert(inputfields, field)
	end

	inputpnl:SetSize(inputpnl:GetWide(), tall)

	for k, v in ipairs(inputfields) do
		local x, y = v:GetPos()
		v:SetPos(xLib.Utils.ScreenScale(15) + xpos, y)
		if not v.IsCheckbox then v:SetWide(inputpnl:GetWide() - xLib.Utils.ScreenScale(30) - xpos) end
	end

	local old = confirmbtn.DoClick
	function confirmbtn:DoClick()
		local data = {}
		for k, v in ipairs(inputfields) do
			if (v:GetInfo() ~= nil) then table.insert(data, v:GetInfo()) else xLib.DoNotification(xLib.GetLanguageString("invalidinput")) return end
		end

		callback(data)
		old(self)
	end
end

-- Create input with multiple strings
function xLib.Utils.DoMultiStrInput(tit, fields, callback)
	local inputpnl, confirmbtn = xLib.Utils.DoInput(tit)
	inputpnl:SetSize(inputpnl:GetWide(), inputpnl:GetTall() + ((table.Count(fields) - 1) * xLib.Utils.ScreenScale(62, true)))

	local txfields = {}
	local y = xLib.Utils.ScreenScale(72, true)
	for k, v in ipairs(fields) do
		local current = v
		local txbox = xLib.Utils.DoKeyboardInput(inputpnl, current, xLib.Utils.ScreenScale(15), y, inputpnl:GetWide() - xLib.Utils.ScreenScale(30), xLib.Utils.ScreenScale(52, true))
		table.insert(txfields, txbox)

		y = y + xLib.Utils.ScreenScale(62, true)
	end

	local old = confirmbtn.DoClick
	function confirmbtn:DoClick()
		local data = {}
		for k, v in ipairs(txfields) do
			if (v:GetValue() and (v:GetValue() ~= "")) then table.insert(data, v:GetValue()) else xLib.AddNotification("Invalid input!", xLib.NotificationERROR) return end
		end

		callback(data)
		old(self)
	end
end

-- Create input popup for integers
function xLib.Utils.IntInput(tit, current, callback)
	local inputpnl, confirmbtn = xLib.Utils.DoInput(tit)
	local txbox = xLib.Utils.DoKeyboardInput(inputpnl, current, xLib.Utils.ScreenScale(15), xLib.Utils.ScreenScale(62, true), inputpnl:GetWide() - xLib.Utils.ScreenScale(30), xLib.Utils.ScreenScale(28, true))
	txbox:SetNumeric(true)

	local old = confirmbtn.DoClick
	function confirmbtn:DoClick()
		if (txbox:GetValue() and tonumber(txbox:GetValue())) then callback(tonumber(txbox:GetValue())) else callback(tonumber(current)) end
		old(self)
	end
end

-- Create input panel for integers
function xLib.Utils.DoIntInput(parent, placeholder, x, y, w, h)
	local txbox = xLib.Utils.DoKeyboardInput(parent, placeholder, x, y, w, h)
	txbox:SetNumeric(true)

	return txbox
end

-- Create input popup for colours
function xLib.Utils.ColInput(tit, current, callback)
	local inputpnl, confirmbtn = xLib.Utils.DoInput(tit)
	inputpnl:SetTall(inputpnl:GetTall() * 2)
	local colbox = xLib.Utils.DoColorInput(inputpnl, current, xLib.Utils.ScreenScale(15), xLib.Utils.ScreenScale(62, true), inputpnl:GetWide() - xLib.Utils.ScreenScale(30), inputpnl:GetTall() - xLib.Utils.ScreenScale(62, true) * 2 - xLib.Utils.ScreenScale(30))

	local old = confirmbtn.DoClick
	function confirmbtn:DoClick()
		if colbox:GetColor() then callback(colbox:GetColor()) else xLib.AddNotification("Invalid input!", xLib.NotificationERROR) end
		old(self)
	end
end

-- Create input popup for players
function xLib.Utils.PlayerInput(tit, blacklist, callback)
	local inputpnl, confirmbtn = xLib.Utils.DoInput(tit)

	local selected = ""
	local inputbox = vgui.Create("DComboBox", inputpnl)
	inputbox:SetPos(xLib.Utils.ScreenScale(15), xLib.Utils.ScreenScale(72, true))
	inputbox:SetSize(inputpnl:GetWide() - xLib.Utils.ScreenScale(30), xLib.Utils.ScreenScale(28, true))
	inputbox:SetValue("Select a Player")
	inputbox:SetFont("xLibSubTitleFont")

	local options = {}
	for k, v in ipairs(player.GetAll()) do
		if table.HasValue(blacklist, v) then continue end

		inputbox:AddChoice(v:Nick(), v:SteamID())
		table.insert(options, v)
	end
	if table.Count(options) <= 0 then inputbox:AddChoice(xLib.GetLanguageString("noplayers"), "") end

	inputbox.OnSelect = function(self, index, value)
		selected = value
	end

	function inputbox:Paint(w, h)
		local col = Color(200, 200, 200)
		local back = Color(20, 20, 20)
				
		draw.RoundedBox(0, 0, 0, w, h, back )
		draw.SimpleText(inputbox:GetText(), "xLibSubTitleFont", xLib.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
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
				draw.SimpleText(v:GetText(), "xLibBodyFont", xLib.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
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
function xLib.Utils.DoPlayerInput(parent, def, x, y, w, h, font)
	local inputbox = vgui.Create("DComboBox", parent)
	inputbox:SetPos(x, y)
	inputbox:SetSize(w, h)
	inputbox:SetValue("Select a Player")
	inputbox:SetFont(font or "xLibSubTitleFont")

	for k, v in ipairs(player.GetAll()) do
		inputbox:AddChoice(v:Nick(), v:SteamID())
	end

	function inputbox:Paint(w, h)
		local col = Color(200, 200, 200)
		local back = Color(20, 20, 20)
				
		draw.RoundedBox(0, 0, 0, w, h, back )
		draw.SimpleText(inputbox:GetText(), font or "xLibSubTitleFont", xLib.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
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
				draw.SimpleText(v:GetText(), "xLibBodyFont", xLib.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				return true
			end
		end
	end

	return inputbox
end

-- Create input popup for options
function xLib.Utils.OptionInput(tit, tx, options, callback)
	local inputpnl, confirmbtn = xLib.Utils.DoInput(tit)

	local selected = ""
	local inputbox = vgui.Create("DComboBox", inputpnl)
	inputbox:SetPos(xLib.Utils.ScreenScale(15), xLib.Utils.ScreenScale(72, true))
	inputbox:SetSize(inputpnl:GetWide() - xLib.Utils.ScreenScale(30), xLib.Utils.ScreenScale(52, true))
	inputbox:SetValue(tx)
	inputbox:SetFont("xLibSelawik32")

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
		draw.SimpleText(inputbox:GetText(), "xLibSelawik32", xLib.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
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
				draw.SimpleText(v:GetText(), "xLibBodyFont", xLib.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
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
function xLib.Utils.DoOptionInput(parent, x, y, w, h, options, placeholder, font, useplaceholder)
	local inputbox = vgui.Create("DComboBox", parent)
	inputbox:SetPos(x, y)
	inputbox:SetSize(w, h)
	inputbox:SetValue(placeholder or options[1].Val)
	inputbox.SelectedValue = placeholder or options[1].Dat
	inputbox:SetFont(font or "xLibSubTitleFont")
	inputbox:SetSortItems(false)

	for k, v in ipairs(options) do
		inputbox:AddChoice(v.Val, v.Dat)
	end

	function inputbox:UpdateOptions(new)
		inputbox:Clear()
		for k, v in ipairs(new) do
			inputbox:AddChoice(v.Val, v.Dat)
		end

		inputbox:SetValue(placeholder or new[1].Val)
		inputbox.SelectedValue = new[1].Dat
	end

	function inputbox:Paint(w, h)
		local col = Color(200, 200, 200)
		local back = Color(0, 0, 0, 100)
				
		draw.RoundedBox(0, 0, 0, w, h, back )
		draw.SimpleText(inputbox:GetText(), font or "xLibSubTitleFont", xLib.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
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
				draw.SimpleText(v:GetText(), "xLibBodyFont", xLib.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				return true
			end
		end
	end

	inputbox.SelectedValue = useplaceholder and placeholder or (options[1].Dat or placeholder)

	function inputbox:OnSelect(index, value, dat)
		inputbox.SelectedValue = dat or value
	end

	function inputbox:GetValue()
		return inputbox.SelectedValue
	end

	return inputbox
end

-- Create input panel for maps
function xLib.Utils.DoMapInput(parent, def, x, y, w, h)
	local options = {}
	for k, v in pairs(xLib.Utilities.Maps or {}) do
		table.insert(options, {Val = k, Dat = k})
	end

	return xLib.Utils.DoOptionInput(parent, x, y, w, h, options, game.GetMap())
end

-- Create input panel for gamemodes
function xLib.Utils.DoGamemodeInput(parent, def, x, y, w, h)
	local options = {}
	for k, v in pairs(engine.GetGamemodes()) do
		table.insert(options, {Val = v.title, Dat = v.name})
	end

	return xLib.Utils.DoOptionInput(parent, x, y, w, h, options, engine.ActiveGamemode())
end

-- Create close button
function xLib.Utils.DoCloseBtn(parent, w, h, toclose, off, noycenter)
	local btn = xLib.Utils.DoImageBtn(parent, parent:GetWide() - w - (off or xLib.Utils.ScreenScale(5)), noycenter and xLib.Utils.ScreenScale(10, true) or (parent:GetTall() / 2 - h / 2), w, h, "xlib/closebtn.png")
	btn.Col = Color(200, 200, 200, 255)
	function btn:OnCursorEntered() self.Col = Color(245, 200, 200, 255) end
	function btn:OnCursorExited() self.Col = Color(200, 200, 200, 255) end

	function btn:DoClick()
		toclose:Close()
	end

	return btn
end

-- Create a material from a URL and apply it to a panel
function xLib.Utils.CreateWebMaterial(pnl, url, callback)
	if (not (string.find(url, "imgur.com", 1, true) and (string.EndsWith(url, ".jpg") or string.EndsWith(url, ".png")))) then return end

	if not file.IsDir("xlibmaterials", "DATA") then
		file.CreateDir("xlibmaterials")
	end

	local matid = util.CRC(url) .. ".png"
	local basepath = "xlibmaterials/" .. matid

	local function DoWebMat(matid)
		local mat = Material("../data/xlibmaterials/" .. matid)
		if callback and isfunction(callback) then
			callback(mat)
		end
	end

	if file.Exists(basepath, "DATA") then
		DoWebMat(matid)
	else
		http.Fetch(url, function(body, len, headers, code)
			file.Write(basepath, body)
			DoWebMat(matid)
		end)
	end
end

-- Open panel with user information from SteamID
function xLib.Utils.UserInfoPanel(nick, sid)
	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW() * 0.25, xLib.Utils.ScreenScale(300, true))
	frame:Center()
	frame:SetTitle("")
	frame:SetDraggable(true)
	frame:ShowCloseButton(false)
	frame:MakePopup()

	local ply = player.GetBySteamID(sid)

	local inputpnl = xLib.Utils.DoRoundedRectPnl(frame, 0, 0, frame:GetWide(), frame:GetTall(), Color(30, 30, 30, 255))
	xLib.Utils.DoCloseBtn(inputpnl, frame)

	function frame:OnFocusChanged(focus)
		if not focus then
			self:Close()
		end
	end

	local tit = xLib.Utils.DoText(inputpnl, nick, "xLibSelawik32", Color(255, 255, 255, 255), false)
	tit:SetPos(xLib.Utils.ScreenScale(10), xLib.Utils.ScreenScale(10, true))

	local icon = xLib.Utils.DoCircleIcon(inputpnl, util.SteamIDTo64(sid), xLib.Utils.ScreenScale(10), xLib.Utils.ScreenScale(15, true) + tit:GetTall(), inputpnl:GetTall() * 0.5, inputpnl:GetTall() * 0.5)
	
	local iconpos = icon:GetPos()
	local iconendpos = iconpos + icon:GetTall()
	local remainingh = inputpnl:GetTall() - iconendpos

	local usergroup = xLib.Utils.DoText(inputpnl, xLib.GetUserGroup(sid), "xLibSelawik22", Color(255, 255, 255, 255), false)
	usergroup:SetPos(xLib.Utils.ScreenScale(10) + icon:GetWide() / 2 - usergroup:GetWide() / 2, iconendpos + remainingh / 2 - (DarkRP and (usergroup:GetTall() / 2) or 0))

	-- If we're not running DarkRP, we don't care about jobs	
	if DarkRP then
		local userjob = xLib.Utils.DoText(inputpnl, ply and IsValid(ply) and ply:getJobTable().name or "disconnected", "xLibSelawik22", ply and IsValid(ply) and ply:getJobTable().color or Color(255, 255, 255, 255), false)
		userjob:SetPos(xLib.Utils.ScreenScale(10) + icon:GetWide() / 2 - userjob:GetWide() / 2, iconendpos + remainingh / 2 + userjob:GetTall() / 2)
	end

	local steamid = xLib.Utils.DoRoundedRectButton(inputpnl, string.format(xLib.GetLanguageString("copysteamid"), sid), "xLibSelawik22", xLib.Utils.ScreenScale(20) + icon:GetWide(), xLib.Utils.ScreenScale(15, true) + tit:GetTall(), inputpnl:GetWide() - icon:GetWide() - xLib.Utils.ScreenScale(25, true), xLib.Utils.ScreenScale(47, true), Color(40, 75, 40, 255), Color(30, 65, 30, 255), Color(255, 255, 255, 255))
	function steamid:DoClick()
		SetClipboardText(sid)
	end

	local steamid64 = xLib.Utils.DoRoundedRectButton(inputpnl, string.format(xLib.GetLanguageString("copysteamid64"), util.SteamIDTo64(sid)), "xLibSelawik22", xLib.Utils.ScreenScale(20) + icon:GetWide(), xLib.Utils.ScreenScale(25, true) + tit:GetTall() + steamid:GetTall(), inputpnl:GetWide() - icon:GetWide() - xLib.Utils.ScreenScale(25, true), xLib.Utils.ScreenScale(47, true), Color(40, 75, 40, 255), Color(30, 65, 30, 255), Color(255, 255, 255, 255))
	function steamid64:DoClick()
		SetClipboardText( util.SteamIDTo64(sid))
	end

	local steamprof = xLib.Utils.DoRoundedRectButton(inputpnl, xLib.GetLanguageString("openprofile"), "xLibSelawik22", xLib.Utils.ScreenScale(20) + icon:GetWide(), inputpnl:GetTall() - xLib.Utils.ScreenScale(37, true), inputpnl:GetWide() - icon:GetWide() - xLib.Utils.ScreenScale(25, true), xLib.Utils.ScreenScale(32, true), Color(40, 40, 75, 255), Color(30, 30, 65, 255), Color(255, 255, 255, 255))
	function steamprof:DoClick()
		gui.OpenURL(string.format("https://steamcommunity.com/profiles/%s/", util.SteamIDTo64(sid)))
	end
end

-- Open panel with entity information from entity class
function xLib.Utils.EntityInfoPanel(class, model)
	local entRef = ents.CreateClientside(class)
	model = model or ((entRef and IsValid(entRef)) and entRef:GetModel() or "")

	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW() * 0.15, ScrW() * 0.15)
	frame:Center()
	frame:SetTitle("")
	frame:SetDraggable(true)
	frame:ShowCloseButton(false)
	frame:MakePopup()

	local inputpnl = xLib.Utils.DoRoundedRectPnl(frame, 0, 0, frame:GetWide(), frame:GetTall(), Color(30, 30, 30, 255))
	xLib.Utils.DoCloseBtn(inputpnl, frame)

	function frame:OnFocusChanged(focus)
		if not focus then
			self:Close()
		end
	end

	local tit = xLib.Utils.DoText(inputpnl, class, "xLibSelawik32", Color(255, 255, 255, 255), false)
	tit:SetPos(xLib.Utils.ScreenScale(10), xLib.Utils.ScreenScale(10, true))

	local icon = vgui.Create("DModelPanel", inputpnl)
	icon:SetSize(inputpnl:GetWide() - xLib.Utils.ScreenScale(100, true), inputpnl:GetWide() - xLib.Utils.ScreenScale(100, true))
	icon:SetPos(xLib.Utils.ScreenScale(50, true), xLib.Utils.ScreenScale(50, true))
	icon:SetModel(model)
end

-- Create a line graph
function xLib.Utils.CreateGraph(parent, x, y, w, h, title, xlb, ylb, xdat, ydat)
	local graphbase = xLib.Utils.DoRectPanel(parent, x, y, w, h, Color(0, 0, 0, 0))

	local lbx = xLib.Utils.DoText(graphbase, xlb, "xLibSelawik18", Color(255, 255, 255, 255))
	lbx:SetPos(graphbase:GetWide() - lbx:GetWide(), graphbase:GetTall() - lbx:GetTall())

	local lby = xLib.Utils.DoText(graphbase, ylb, "xLibSelawik18", Color(255, 255, 255, 255))
	lby:SetPos(0, 0)

	local graph = xLib.Utils.DoRectPanel(graphbase, lby:GetWide() + xLib.Utils.ScreenScale(5), lby:GetTall(), graphbase:GetWide() - lby:GetWide() - xLib.Utils.ScreenScale(5), graphbase:GetTall() - lbx:GetTall() - lby:GetTall(), Color(0, 0, 0, 0))

	local maxy = 0
	for k, v in pairs(ydat) do
		if v > maxy then
			maxy = v
		end
	end

	graphbase.divnum = 8

	graph.divisions = math.Round(maxy / graphbase.divnum)
	if graph.divisions < 1000 then graph.divisions = 1000 end

	surface.SetFont("xLibSelawik18")
	local twoff, thoff = surface.GetTextSize(DarkRP and DarkRP.formatMoney(graph.divisions * x) or (graph.divisions * x))
	local takew, takeh = surface.GetTextSize(xdat[table.Count(xdat)])
	twoff = twoff + xLib.Utils.ScreenScale(5)

	function graphbase.UpdateDivNum(num)
		graphbase.divnum = num

		graph.divisions = math.Round(maxy / graphbase.divnum)
		if graph.divisions < 1000 then graph.divisions = 1000 end

		surface.SetFont("xLibSelawik18")
		twoff, thoff = surface.GetTextSize(DarkRP and DarkRP.formatMoney(graph.divisions * x) or (graph.divisions * x))
		takew, takeh = surface.GetTextSize(xdat[table.Count(xdat)])

		twoff = twoff + xLib.Utils.ScreenScale(5)
	end

	function graph:Paint(w, h)
		surface.SetFont("xLibSelawik18")

		xLib.Utils.Rect(twoff, thoff / 2, 2, h - xLib.Utils.ScreenScale(18, true) - (thoff / 2), Color(255, 255, 255, 255))
		xLib.Utils.Rect(twoff, h - xLib.Utils.ScreenScale(18, true) - 2, w - twoff - xLib.Utils.ScreenScale(7) - (takew / 2), 2, Color(255, 255, 255, 255))

		local last = 0
		for x = 1, graphbase.divnum do
			surface.SetFont("xLibSelawik18")
			
			xLib.Utils.Rect(twoff, (h - xLib.Utils.ScreenScale(18, true)) * ((graphbase.divnum - x) / graphbase.divnum) + (thoff / 2), w - twoff - xLib.Utils.ScreenScale(7) - (takew / 2), 1, Color(255, 255, 255, 150))

			local num = DarkRP and DarkRP.formatMoney(graph.divisions * x) or (graph.divisions * x)
			xLib.Utils.Text(num, 0, (h - xLib.Utils.ScreenScale(18, true)) * ((graphbase.divnum - x) / graphbase.divnum), "xLibSelawik18", Color(255, 255, 255, 255))
		end

		local x = 0
		local lasty = 0
		local lastx = 0
		for k, v in pairs(xdat) do
			surface.SetFont("xLibSelawik18")
			local tw, th = surface.GetTextSize(v)
			local basex = twoff + (x * ((w - twoff) / 6.25))

			xLib.Utils.Rect(basex, thoff / 2, 1, h - xLib.Utils.ScreenScale(18, true) - (thoff / 2), Color(255, 255, 255, 150))

			xLib.Utils.Text(v, basex - (tw / 2), h - xLib.Utils.ScreenScale(18, true), "xLibSelawik18", Color(255, 255, 255, 255))

			-- Draw data points
			local data = ydat[x + 1]
			local divs = data / graph.divisions

			local cury = (divs * ((h - xLib.Utils.ScreenScale(18, true) - (thoff / 2)) / graphbase.divnum) - divs - 2)

			xLib.Utils.DrawCircle(basex, (h - xLib.Utils.ScreenScale(18, true) - (thoff / 2)) - cury, xLib.Utils.ScreenScale(3), Color(255, 0, 0, 255))

			if x > 0 then
				surface.DrawLine(lastx, (h - xLib.Utils.ScreenScale(18, true) - (thoff / 2)) - lasty, basex, (h - xLib.Utils.ScreenScale(18, true) - (thoff / 2)) - cury)
			end

			lastx = basex
			lasty = cury

			x = x + 1
		end
	end

	return graphbase
end

function xLib.Utils.DoDermaMenu(addoptions)
	local options = DermaMenu()

	for k, v in ipairs(addoptions) do
		options:AddOption(v.Tit, v.Func)
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
			draw.SimpleText(pnl:GetText(), "xLibSubTitleFont", xLib.Utils.ScreenScale(10), h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			
			return true
		end
	end
end

function xLib.Utils.DoFrame(x, y, w, h, bgcol)
	local frame = vgui.Create("DFrame")
	frame:SetSize(w, h)
	frame:SetPos(x, y)
	frame:SetTitle("")
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:MakePopup()

	function frame:Paint() end

	return frame
end

function xLib.Utils.DoPopupPanel(w, h, doblur, bgcol)
	local frame = vgui.Create("DFrame")
	frame:SetSize(w, h)
	frame:Center()
	frame:SetTitle("")
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:MakePopup()

	function frame:Paint()
		if doblur then Derma_DrawBackgroundBlur(self) end
	end

	return frame, xLib.Utils.DoRoundedRectPnl(frame, 0, 0, frame:GetWide(), frame:GetTall(), bgcol or Color(30, 30, 30, 255), 5)
end

function xLib.Utils.DoHeadedPopupPanel(w, h, tx, doblur, bgcol)
	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW(), ScrH())
	frame:Center()
	frame:SetTitle("")
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:MakePopup()

	function frame:Paint()
		if doblur then Derma_DrawBackgroundBlur(self) end
	end

	local offsetx = frame:GetWide() / 2 - w / 2
	local pnl = xLib.Utils.DoRoundedRectPanel(frame, offsetx, frame:GetTall() / 2 - h / 2 + xLib.Utils.ScreenScale(54, true) / 2, w, h - xLib.Utils.ScreenScale(54, true), bgcol or Color(30, 30, 30, 255), 5, true, true, false, false)

	local col = Color(37, 37, 37, 255)
	local headerbar = xLib.Utils.DoRoundedRectPanel(frame,
		offsetx,
		frame:GetTall() / 2 - h / 2 - xLib.Utils.ScreenScale(54, true) / 2,
		w,
		xLib.Utils.ScreenScale(54, true),
		col,
		5,
		false,
		false,
		true,
		true
	)

	local headerlbl = xLib.Utils.DoText(headerbar, tx, "xLibHeaderFont", Color(255, 255, 255, 255))
	headerlbl:SetPos(xLib.Utils.ScreenScale(10), xLib.Utils.ScreenScale(10, true))

	local closebtn = xLib.Utils.DoCloseBtn(headerbar, headerbar:GetTall() - xLib.Utils.ScreenScale(20, true), headerbar:GetTall() - xLib.Utils.ScreenScale(20, true), frame, xLib.Utils.ScreenScale(10, true))

	return frame, pnl
end

function xLib.Utils.DrawItem(item, card, full, vec)
	if not (xLib.Items[item] or xLib.Cards[item]) then return end
	if card.ItemPnl and IsValid(card.ItemPnl) then card.ItemPnl:Remove() end

	local dat = xLib.Items[item] or xLib.Items[xLib.Cards[item].Item]

	if dat.Model then
		card.ItemPnl = vgui.Create("DModelPanel", card)
		card.ItemPnl:SetSize(card:GetWide(), full and card:GetTall() or card:GetTall() / 2)
		card.ItemPnl:SetPos(0, full and 0 or (card:GetTall() / 2 - xLib.Utils.ScreenScale(5, true)))
		card.ItemPnl:SetModel(dat.Model)

		local PrevMins, PrevMaxs = card.ItemPnl.Entity:GetRenderBounds()
		card.ItemPnl:SetCamPos(PrevMins:Distance(PrevMaxs) * (full and (vec or Vector(0.45, 0.45, 0.45)) or Vector(0.75, 0.75, 0.75)))
		card.ItemPnl:SetLookAt((PrevMaxs + PrevMins) / 2)

		local oldhov = card.IsHovered
		function card:IsHovered()
			if card.ItemPnl:IsHovered() then
				return true
			end

			return oldhov(self)
		end

		if card.DoClick then card.ItemPnl.DoClick = card.DoClick end
	end
end

function xLib.Utils.DoModelPanel(model, base, full, vec, fov)
	if base.ItemPnl and IsValid(base.ItemPnl) then base.ItemPnl:Remove() end

	base.ItemPnl = vgui.Create("DModelPanel", base)
	base.ItemPnl:SetSize(base:GetWide() - xLib.Utils.ScreenScale(10), full and (base:GetTall() - xLib.Utils.ScreenScale(10, true)) or base:GetTall() / 2)
	base.ItemPnl:SetPos(xLib.Utils.ScreenScale(5), full and xLib.Utils.ScreenScale(5, true) or (base:GetTall() / 2 - xLib.Utils.ScreenScale(5, true)))
	base.ItemPnl:SetModel(model)
	
	local mn, mx = base.ItemPnl.Entity:GetRenderBounds()
	local size = 0

	size = math.max(size, math.abs(mn.x) + math.abs(mx.x))
	size = math.max(size, math.abs(mn.y) + math.abs(mx.y))
	size = math.max(size, math.abs(mn.z) + math.abs(mx.z))

	base.ItemPnl:SetFOV(fov or 35)
	base.ItemPnl:SetCamPos(Vector(size, size, size))
	base.ItemPnl:SetLookAt((mn + mx) * 0.5)

	function base.ItemPnl:LayoutEntity(ent) end

	local oldhov = base.IsHovered
	function base:IsHovered()
		if base.ItemPnl:IsHovered() then
			return true
		end

		return oldhov(self)
	end

	if base.DoClick then base.ItemPnl.DoClick = base.DoClick end
end