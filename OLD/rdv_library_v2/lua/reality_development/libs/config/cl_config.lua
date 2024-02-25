hook.Add("RDV_LIB_Loaded", "RDV_LIB_MENUBind", function()
	RDV.LIBRARY.AddConfigOption("RDVL_menuCommand", {
		TYPE = RDV.LIBRARY.TYPE.ST, 
		CATEGORY = "Library", 
		DESCRIPTION = "Menu Command", 
		DEFAULT = "!rdv", 
		SECTION = "Menu Access",
		noNetwork = true,
	})
end )

local function CreateDivider(SP, PANEL, TEXT, UID, MENU)
	local OPTIONS = RDV.LIBRARY.CONFIG.OPTIONS

	if !OPTIONS[UID] then return end
	
	local TAB = OPTIONS[UID]

	local w, h = SP:GetSize()

    local TLABEL = vgui.Create("DLabel", PANEL)
    TLABEL:Dock(TOP)
	TLABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
    TLABEL:SetText(TEXT)
    TLABEL:SetFont("RDV_LIB_FRAME_TITLE")
    TLABEL:SetTextColor(COL_1)
	TLABEL:SetMouseInputEnabled(true)
	
	if TAB.DEFAULT and TAB.VALUE and ( TAB.VALUE ~= TAB.DEFAULT ) then
		local RESET = vgui.Create("RDV_LIBRARY_IMGUR", TLABEL)
		RESET:Dock(RIGHT)
		RESET:SetImgurID("bneYsxy")
		RESET.DoClick = function(s)
			if TAB.noNetwork then
				RDV.LIBRARY.SetConfigOption(UID, TAB.DEFAULT)
			else
				net.Start("RDV.LIBRARY.ResetConfigOption")
					net.WriteString(UID)
				net.SendToServer()
			end

			if IsValid(MENU) then
				MENU:Remove()
			end
		end
	end
end

local function Send(UID, VAL)
	local OPTIONS = RDV.LIBRARY.CONFIG.OPTIONS

	if !OPTIONS[UID] then return end
	
	local TAB = OPTIONS[UID]

	if TAB.noNetwork then
		RDV.LIBRARY.SetConfigOption(UID, VAL)
	else
		net.Start("RDV.LIBRARY.UpdaConfig")
			net.WriteString(UID)
			net.WriteType(VAL)
		net.SendToServer()
	end
end

local function CreateBind(SP, PANEL, UID)
	local w, h = SP:GetSize()

	local OPTIONS = RDV.LIBRARY.CONFIG.OPTIONS

	if !OPTIONS[UID] then return end
	
	local TAB = OPTIONS[UID]

	local VAL = RDV.LIBRARY.GetConfigOption(UID)
	
	local BINDER = vgui.Create("DBinder", PANEL)
	BINDER:SetText("")
	BINDER:SetHeight(h * 0.1)
	BINDER:Dock(TOP)
	BINDER:DockMargin(w * 0.025, 0, w * 0.025, h * 0.025)
	BINDER:SetMouseInputEnabled(true)
	BINDER.OnChange = function(self, but)
		BINDER:SetText(input.GetKeyName(but))

		Send(UID, but)
	end

	if VAL then
		BINDER:SetText(input.GetKeyName(VAL))
	end
end

local function CreateSelectMult(SP, PANEL, UID)
	local w, h = SP:GetSize()

	local OPTIONS = RDV.LIBRARY.CONFIG.OPTIONS

	if !OPTIONS[UID] then return end
	
	local TAB = OPTIONS[UID]

	local VAL = RDV.LIBRARY.GetConfigOption(UID) or {}

    local LABEL = vgui.Create("DLabel", PANEL)
	LABEL:SetText("")
	LABEL:SetHeight(h * 0.2)
	LABEL:Dock(TOP)
	LABEL:DockMargin(w * 0.025, 0, w * 0.025, h * 0.025)
	LABEL:SetMouseInputEnabled(true)
	LABEL.Paint = function(self, w, h)

	end
	
	local VALS = {}

	local DermaListView = vgui.Create("DListView", LABEL)
	DermaListView:Dock(FILL)
	DermaListView:SetMultiSelect(true)
	DermaListView:AddColumn(TAB.DESCRIPTION)
    DermaListView.OnRowRightClick = function(s, id, line)
        line:SetSelected(false)
    end

	for k, v in ipairs(TAB.LIST) do
		local LINE = DermaListView:AddLine(v) -- Add lines

		if VAL[v] then
			DermaListView:SelectItem(LINE)
		end

		VALS[LINE:GetID()] = v
	end

	DermaListView.OnRowSelected = function(self, rowind, row)
		local NT = {}

		for k, v in ipairs(self:GetSelected()) do
			local LINE = v:GetID()
		
			if !VALS[LINE] then continue end

			NT[VALS[LINE]] = true
		end

		Send(UID, NT)
	end
end

local function CreateNumber(SP, PANEL, UID)
	local w, h = SP:GetSize()

	local OPTIONS = RDV.LIBRARY.CONFIG.OPTIONS

	if !OPTIONS[UID] then return end
	
	local TAB = OPTIONS[UID]

	local VAL = RDV.LIBRARY.GetConfigOption(UID)

	local NUMBER = vgui.Create("DNumSlider", PANEL)
	NUMBER:Dock(TOP)
	NUMBER:SetText( "" )
	NUMBER:DockMargin(w * 0.025, 0, w * 0.025, h * 0.025)

	if TAB.MIN then
		NUMBER:SetMin( TAB.MIN )
	end

	if TAB.MAX then
		NUMBER:SetMax( TAB.MAX )
	end

	if TAB.DECIMALS then
		NUMBER:SetDecimals( TAB.DECIMALS )
	else
		NUMBER:SetDecimals( 0 )
	end

	NUMBER:GetTextArea():SetKeyBoardInputEnabled(true)
	NUMBER:GetChildren()[3]:SetFont("RD_FONTS_CORE_LABEL_LOWER")
	NUMBER:GetTextArea():SetFont("RD_FONTS_CORE_LABEL_LOWER")
	NUMBER:GetTextArea():SetTextColor(color_white)

	if VAL then
		NUMBER:SetValue(VAL)
	end

	NUMBER:SetMouseInputEnabled(true)

	NUMBER.OnValueChanged = function( self, value )
		Send(UID, value)
	end
end

local function CreateSelect(SP, PANEL, UID)
	local w, h = SP:GetSize()

	local OPTIONS = RDV.LIBRARY.CONFIG.OPTIONS

	if !OPTIONS[UID] then return end
	
	local TAB = OPTIONS[UID]

	local VAL = RDV.LIBRARY.GetConfigOption(UID)

	local HEADER = vgui.Create("DComboBox", PANEL)
	HEADER:Dock(TOP)
	HEADER:SetSortItems(false)
	HEADER:DockMargin(0, 0, 0, h * 0.025)

	for k, v in ipairs(TAB.LIST) do
		HEADER:AddChoice(v, k)
	end

	if VAL then
		for k, v in ipairs(HEADER.Choices) do
			if v == VAL then
				HEADER:ChooseOptionID(k)
				
				break
			end
		end
	end

	HEADER.OnSelect = function(self, index, value)
		Send(UID, value)
	end
	HEADER.PerformLayout = function(s)
		s:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
		s:CenterHorizontal()
	end
end

local function CreateCheck(SP, PANEL, UID)
	local w, h = SP:GetSize()

	local OPTIONS = RDV.LIBRARY.CONFIG.OPTIONS

	if !OPTIONS[UID] then return end
	
	local TAB = OPTIONS[UID]

	local VAL = RDV.LIBRARY.GetConfigOption(UID)

	local LABEL = vgui.Create("DLabel", PANEL)
	LABEL:SetText("")
	LABEL:SetHeight(h * 0.1)
	LABEL:Dock(TOP)
	LABEL:DockMargin(w * 0.025, 0, w * 0.025, h * 0.025)
	LABEL:SetMouseInputEnabled(true)

	local CHECK_L = vgui.Create("DLabel", LABEL)
	CHECK_L:SetMouseInputEnabled(true)
	CHECK_L:Dock(RIGHT)
	CHECK_L:SetText("")


	local CHECK = vgui.Create("DCheckBox", CHECK_L)
	CHECK:Center()

	if VAL then
		CHECK:SetChecked(VAL)
	end

	CHECK.OnChange = function(self, tog)
		local V = (tog and 1) or 0

		Send(UID, V)
	end	
end

local function CreateColor(SP, PANEL, UID)
	local w, h = SP:GetSize()

	local OPTIONS = RDV.LIBRARY.CONFIG.OPTIONS

	if !OPTIONS[UID] then return end
	
	local TAB = OPTIONS[UID]

	local LABEL = vgui.Create("DLabel", PANEL)
	LABEL:SetText("")
	LABEL:SetHeight(h * 0.2)
	LABEL:Dock(TOP)
	LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
	LABEL:SetMouseInputEnabled(true)
    
	LABEL.Paint = function(self, w, h)
	end

    local C = vgui.Create("DColorMixer", LABEL)
    C:SetWide(w * 0.175)
    C:Dock(FILL)
    C:SetPalette(false)
    C:SetAlphaBar(false)
    C:SetWangs(true)

	local VAL = RDV.LIBRARY.GetConfigOption(UID)
	local LColor

    if VAL then
		LColor = Color(VAL.r, VAL.g, VAL.b, VAL.a)

        C:SetColor(LColor)
    end

	C.Think = function(s)
		if input.IsMouseDown( MOUSE_LEFT ) then return end

		local CR = s:GetColor()
		CR = Color(CR.r, CR.g, CR.b, CR.a)

		if ( LColor == CR ) then
			return
		end

		Send(UID, CR)

		LColor = CR
	end
end

local function CreateString(SP, PANEL, UID)
	local w, h = SP:GetSize()

	local OPTIONS = RDV.LIBRARY.CONFIG.OPTIONS

	if !OPTIONS[UID] then return end
	
	local TAB = OPTIONS[UID]

    local T = vgui.Create("RDV_LIBRARY_TextEntry", PANEL)
    T:SetHeight(h * 0.075)
	T:Dock(TOP)
	T:DockMargin(w * 0.025, 0, w * 0.025, h * 0.025)
    T:SetPlaceholderText(TAB.DESCRIPTION)
    T:SetKeyBoardInputEnabled(true)
    T.OnChange = function(self)
		Send(UID, self:GetText())
    end

	local VAL = RDV.LIBRARY.GetConfigOption(UID)

    if VAL then
        T:SetValue(VAL)
    end
end

net.Receive("RDV.LIBRARY.SendConfig", function()
	local INITIAL = net.ReadBool()
    local COUNT = net.ReadUInt(16)

    for i = 1, COUNT do
        local UID = net.ReadString()
        local TAB = RDV.LIBRARY.CONFIG.OPTIONS

        if !TAB[UID] then continue end
        TAB = TAB[UID]

        local V = net.ReadType()

        RDV.LIBRARY.CONFIG.OPTIONS[UID].VALUE = V
    end

	if INITIAL then
		hook.Run("RDV_LIB_ConfigSyncComplete", LocalPlayer())
	end
end )

local function OpenMenu()
	local function CreateCategory(SCROLL, TEXT)
		local w, h = SCROLL:GetSize()

		local D_CATEGORY = SCROLL:Add("RDV_LIBRARY_CollapsibleCategory")

		local CAT_LABEL = D_CATEGORY:GetChildren()[1]

		D_CATEGORY:Dock(TOP)
		D_CATEGORY:SetLabel( TEXT )
		D_CATEGORY:DockMargin(w * 0.035, h * 0.035, w * 0.035, h * 0.035)
		D_CATEGORY:SetTall(D_CATEGORY:GetTall() * 1.25)
		D_CATEGORY:DockPadding(0, 0, 0, h * 0.025)

		return D_CATEGORY
	end

	local COUNT = 0

	local MENU = vgui.Create("RDV_LIBRARY_FRAME")
    MENU:SetSize(ScrW() * 0.5, ScrH() * 0.7)
    MENU:Center()
    MENU:MakePopup()
    MENU:SetTitle("Config")
	MENU:SetMouseInputEnabled(true)
	MENU.PaintOver = function(s, w, h)
		if COUNT <= 0 then
			draw.SimpleText("No Addon Configuration Available", "RD_FONTS_CORE_LABEL_LOWER", w * 0.65, h * 0.4, COL_1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end

	local w, h = MENU:GetSize()

	local SIDE = vgui.Create("RDV_LIBRARY_SIDEBAR", MENU)

	local SCROLL

	local SCATS = {}
	local OCATS = {}
	local FIRST

	for k, v in pairs(RDV.LIBRARY.CONFIG.OPTIONS) do
		if OCATS[v.CATEGORY] then continue end
		if !FIRST then FIRST = v.CATEGORY end
		
		OCATS[v.CATEGORY] = true

		table.insert(SCATS, (v.CATEGORY or "Uncategorized"))
	end
	
	for k, v in ipairs(RDV.LIBRARY.CONFIG.SBUTTONS) do
		if OCATS[v.ADDON] then continue end

		if ( v.CA and v.CA(LocalPlayer()) == false ) then continue end 
		if !FIRST then FIRST = v.ADDON end
		
		OCATS[v.ADDON] = true

		table.insert(SCATS, (v.ADDON or "Uncategorized"))
	end

	for k, v in ipairs(SCATS) do
		local NAME = v
		local LOOKUP = RDV.LIBRARY.GetProduct(v)
		local ICON = nil 
		
		if LOOKUP and LOOKUP.Icon then
			ICON = LOOKUP.Icon
		elseif string.find(NAME, "Library") then
			ICON = "vcgHxA9"
		end

		SIDE:AddPage(v, ICON, function()
			if IsValid(SCROLL) then
				SCROLL:Clear()
			end

			SCROLL = vgui.Create("RDV_LIBRARY_SCROLL", MENU)
			SCROLL:Dock(FILL)
			SCROLL:SetMouseInputEnabled(true)
			SCROLL:DockMargin(0, 0, 0, h * 0.025)

			SCROLL.Think = function(self)
				local w, h = self:GetSize()

				local CATS = {}

				if RDV.LIBRARY.CONFIG.BUTTONS[NAME] then
					for k, v in ipairs(RDV.LIBRARY.CONFIG.SBUTTONS) do
						if v.ADDON ~= NAME then continue end
						if ( v.CA and v.CA(LocalPlayer()) == false ) then continue end 

						if !v.SECTION then
							P = SCROLL
						else
							if !CATS[v.SECTION] then
								P = CreateCategory(SCROLL, v.SECTION)
	
								CATS[v.SECTION] = P
							else
								P = CATS[v.SECTION]
							end
						end

						COUNT = COUNT + 1

						
						local BUTTON = vgui.Create("DButton", P)
						BUTTON:Dock(TOP)
						BUTTON:SetFont("RDV_LIB_FRAME_TITLE")
						BUTTON:SetTall(BUTTON:GetTall() * 1.5)
						BUTTON:SetText( (v.SECTION or "Invalid") )
						BUTTON:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)

						BUTTON:SetTextColor(color_white)

						BUTTON.Paint = function(s, w, h)
							if !s:IsHovered() then
								surface.SetDrawColor( RDV.LIBRARY.THEME.GREY )
								surface.DrawOutlinedRect( 0, 0, w, h )
							else
								surface.SetDrawColor( RDV.LIBRARY.THEME.YELLOW )
								surface.DrawOutlinedRect( 0, 0, w, h )
							end
						end
						BUTTON.OnCursorEntered = function(s)
							surface.PlaySound("rdv/new/slider.mp3")
				
							s:SetTextColor(RDV.LIBRARY.THEME.YELLOW)
						end
						BUTTON.OnCursorExited = function(s)
							s:SetTextColor(color_white)
						end


						BUTTON.DoClick = function(s)
							if v.CB then v.CB(LocalPlayer()) end

							if v.NW then
								net.Start("RDV_LIB_CFG_BTN")
									net.WriteUInt(k, 8)
								net.SendToServer()
							end
						end
					end
				end

				CATS = {}

				for k, v in ipairs(RDV.LIBRARY.CONFIG.SOPTIONS) do
					if v.CATEGORY then 
						if v.CATEGORY ~= NAME then continue end
					end

					if !v.noNetwork and !RDV.LIBRARY.CanChangeConfig(LocalPlayer()) then
						continue
					end

					COUNT = COUNT + 1
					
					local P

					if !v.SECTION then
						P = SCROLL
					else
						if !CATS[v.SECTION] then
							P = CreateCategory(SCROLL, v.SECTION)

							CATS[v.SECTION] = P
						else
							P = CATS[v.SECTION]
						end
					end


					local function Run()
						CreateDivider(SCROLL, P, v.DESCRIPTION, v.UID, MENU)

						if v.TYPE == RDV.LIBRARY.TYPE.CO then
							CreateColor(SCROLL, P, v.UID)
						elseif v.TYPE == RDV.LIBRARY.TYPE.ST then
							CreateString(SCROLL, P, v.UID)
						elseif v.TYPE == RDV.LIBRARY.TYPE.SE then
							CreateSelect(SCROLL, P, v.UID)
						elseif v.TYPE == RDV.LIBRARY.TYPE.BL then
							CreateCheck(SCROLL, P, v.UID)
						elseif v.TYPE == RDV.LIBRARY.TYPE.SM then
							CreateSelectMult(SCROLL, P, v.UID)
						elseif v.TYPE == RDV.LIBRARY.TYPE.NM then
							CreateNumber(SCROLL, P, v.UID)
						elseif v.TYPE == RDV.LIBRARY.TYPE.BN then
							CreateBind(SCROLL, P, v.UID)
						end
					end

					Run()
				end

				self.Think = function() end
			end
		end)
	end

	return true
end 

hook.Add("OnPlayerChat", "RDV.LIBRARY.CONFIG", function(P, text)
	if ( P == LocalPlayer() ) then
		local CMD = RDV.LIBRARY.GetConfigOption("RDVL_menuCommand")

		if CMD and CMD == text then	
			OpenMenu()
		end
	end
end)

concommand.Add("rdv_menu", function(ply, cmd, args)
	OpenMenu()
end )