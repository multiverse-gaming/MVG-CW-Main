local color_Gold = Color(252,180,9,255)
local color_Grey = Color(122,132,137, 180)

local main_Menu = false
local inDefconScreen = false
local sidebarEntity = false

local function AddDefcon(UID, OF, COPY)
    local DATA = {
        sound = "buttons/blip1.wav",
    }
    
    local LIST = NCS_DEFCON.CONFIG.defconList
    
    if UID and LIST[UID] then
        DATA = table.Copy(LIST[UID])
    end

    if COPY then DATA.uid = nil end

    DATA.teams = DATA.teams or {}

    local F = vgui.Create("NCS_DEF_FRAME")
    F:SetSize(ScrW() * 0.2, ScrH() * 0.5)
    F:Center()
    F:MakePopup()
    F.OnRemove = function(s)
        if IsValid(OF) then OF:SetVisible(true) end
    end

    local w, h = F:GetSize()

    local S = vgui.Create("NCS_DEF_SCROLL", F)
    S:Dock(FILL)

    -- Name
    
    local M_LABEL = S:Add("DLabel")
    M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_defconName"))
    M_LABEL:Dock(TOP)
    M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
    
    local d_NAME = S:Add("DTextEntry")
    d_NAME:Dock(TOP)
    d_NAME:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
    d_NAME.OnTextChanged = function(s)
        DATA.name = s:GetValue()
    end
    
    if DATA.name then
        d_NAME:SetValue(DATA.name)
    end

    -- Desc
    
    local M_LABEL = S:Add("DLabel")
    M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_description"))
    M_LABEL:Dock(TOP)
    M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
    
    local d_DESC = S:Add("DTextEntry")
    d_DESC:Dock(TOP)
    d_DESC:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
    d_DESC.OnTextChanged = function(s)
        DATA.desc = s:GetValue()
    end
    
    if DATA.desc then
        d_DESC:SetValue(DATA.desc)
    end

    -- Change Sound
    
    local M_LABEL = S:Add("DLabel")
    M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_changeSoundIndiv"))
    M_LABEL:Dock(TOP)
    M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
    
    local d_SOUND = S:Add("DTextEntry")
    d_SOUND:Dock(TOP)
    d_SOUND:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
    d_SOUND.OnTextChanged = function(s)
        DATA.sound = s:GetValue()
    end
    
    if DATA.sound then
        d_SOUND:SetValue(DATA.sound)
    end

    -- Color
    
    local M_LABEL = S:Add("DLabel")
    M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_color"))
    M_LABEL:Dock(TOP)
    M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
    
    local d_COL = S:Add("DColorMixer")
    d_COL:Dock(TOP)
    d_COL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
    
    if DATA.col then
        local C = DATA.col
    
        if C.r and C.g and C.b then
            C = Color(C.r, C.g, C.b)
            d_COL:SetColor(DATA.col)
        end
    else
        d_COL:SetColor(Color(255,0,0))
    end
    
    d_COL.Think = function(s)
        DATA.col = s:GetColor()
    end

    -- Teams Disabled
    local M_LABEL = S:Add("DLabel")
    M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_allTeamsAccessible"))
    M_LABEL:Dock(TOP)
    M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)

    local LABEL = S:Add("DLabel")
    LABEL:SetText("")
    LABEL:SetHeight(h * 0.1)
    LABEL:Dock(TOP)
    LABEL:DockMargin(w * 0.025, 0, w * 0.025, h * 0.025)
    LABEL:SetMouseInputEnabled(true)

    local CHECK_L = LABEL:Add("DLabel")
    CHECK_L:SetMouseInputEnabled(true)
    CHECK_L:Dock(RIGHT)
    CHECK_L:SetText("")

    local CHECK = CHECK_L:Add("DCheckBox")
    CHECK:Center()
    CHECK.OnChange = function(s, val)
        DATA.allteams = val
    end

    if DATA.allteams then
        CHECK:SetChecked(true)
    end

    local d_TEAMS = S:Add("DListView")
    d_TEAMS:Dock(TOP)
    d_TEAMS:SetTall(h * 0.3)
    d_TEAMS:AddColumn(NCS_DEFCON.GetLang(nil, "DEF_defconName"), 1)
    d_TEAMS:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)

    for k, v in ipairs(team.GetAllTeams()) do
        local L = d_TEAMS:AddLine(v.Name)
        L.teamName = v.Name

        if DATA.teams[v.Name] then
            L:SetSelected(true)
        end
    end

    d_TEAMS.OnRowSelected = function(s, ind, row)
            
        DATA.teams[row.teamName] = true
    end
    
    d_TEAMS.OnRowRightClick = function(s, ind, row)
        DATA.teams[row.teamName] = nil
    end

    local SUBMIT = vgui.Create("NCS_DEF_TextButton", F)
    SUBMIT:Dock(BOTTOM)
    SUBMIT:SetText(NCS_DEFCON.GetLang(nil, "DEF_submit"))
    SUBMIT:SetTall(h * 0.1)
    SUBMIT:DockMargin(w * 0.025, h * 0.02, w * 0.025, h * 0.025)
    SUBMIT.DoClick = function(s)
        if !DATA.desc or !DATA.name then return end

        DATA.desc = string.Trim(DATA.desc)
        DATA.name = string.Trim(DATA.name)

        if DATA.desc == "" or DATA.name == "" then return end

        local json = util.TableToJSON(DATA)
        local compressed = util.Compress(json)
        local length = compressed:len()
    
        net.Start("NCS_DEFCON_AddDefcon")
            net.WriteUInt(length, 32)
            net.WriteData(compressed, length)
        net.SendToServer()

        F:Remove()
    end
end

local function OpenMenu()
    local lastPage

    if main_Menu then
        if IsValid(sidebarEntity) then
            lastPage =  sidebarEntity:GetPage()
        end

        main_Menu:Remove()
    end

    local F = vgui.Create("NCS_DEF_FRAME")
    F:SetSize(ScrW() * 0.4, ScrH() * 0.5)
    F:Center()
    F:MakePopup()

    main_Menu = F

    local w, h = F:GetSize()

    local SIDE = vgui.Create("NCS_DEF_SIDEBAR", F)

    sidebarEntity = SIDE

    local PANEL = vgui.Create("DPanel", F)
    PANEL:Dock(FILL)
    PANEL.Paint = function(s) 
        SIDE:SelectPage(NCS_DEFCON.GetLang(nil, "DEF_settings"))
        s.Paint = function() end
    end

    SIDE:AddPage(NCS_DEFCON.GetLang(nil, "DEF_settings"), "svNpHqn", function()
        if IsValid(PANEL) then
            PANEL:Clear()
        end

        local DATA = table.Copy(NCS_DEFCON.CONFIG)
        DATA.defconList = nil

        local S = vgui.Create("NCS_DEF_SCROLL", PANEL)
        S:Dock(FILL)


        -- Language Systems
        local M_LABEL = S:Add("DLabel")
        M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_language"))
        M_LABEL:Dock(TOP)
        M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
    
        local LANG = S:Add("DComboBox")
        LANG:Dock(TOP)
        LANG:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        
        LANG.OnSelect = function(s, IND, VAL)
            DATA.languageSet = VAL
        end
    
        for k, v in pairs(NCS_DEFCON.GetLanguages()) do
            local OPT = LANG:AddChoice(k)
    
            if ( DATA.languageSet == k ) then
                LANG:ChooseOption(k, OPT)
            end
        end

        -- Default Defcon
        local M_LABEL = S:Add("DLabel")
        M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_defaultDefcon"))
        M_LABEL:Dock(TOP)
        M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
    
        local DEFAULT = S:Add("DComboBox")
        DEFAULT:Dock(TOP)
        DEFAULT:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        
        DEFAULT.OnSelect = function(s, IND, VAL, DT)
            if DT == 0 then
                DATA.defaultdefcon = false
            else
                DATA.defaultdefcon = DT
            end
        end
        
        local OPT = DEFAULT:AddChoice("No Default", 0)

        for k, v in pairs(NCS_DEFCON.CONFIG.defconList) do
            local OPT = DEFAULT:AddChoice(v.name, v.uid)
        
            if ( DATA.defaultdefcon == v.uid ) then
                DEFAULT:ChooseOptionID(OPT)
            end
        end

        if ( !DATA.defaultdefcon ) then
            DEFAULT:ChooseOptionID(OPT)
        end

        -- Config Command
        
        local M_LABEL = S:Add("DLabel")
        M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_cfgcommand"))
        M_LABEL:Dock(TOP)
        M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        
        local d_COMMAND = S:Add("DTextEntry")
        d_COMMAND:Dock(TOP)
        d_COMMAND:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        d_COMMAND.OnTextChanged = function(s)
            DATA.command = s:GetValue()
        end
        
        if DATA.command then
            d_COMMAND:SetValue(DATA.command)
        end


        -- Save Command
        
        local M_LABEL = S:Add("DLabel")
        M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_savecommand"))
        M_LABEL:Dock(TOP)
        M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        
        local d_saveCommand = S:Add("DTextEntry")
        d_saveCommand:Dock(TOP)
        d_saveCommand:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        d_saveCommand.OnTextChanged = function(s)
            DATA.savecommand = s:GetValue()
        end
        
        if DATA.savecommand then
            d_saveCommand:SetValue(DATA.savecommand)
        end

        -- Menu Command
        
        local M_LABEL = S:Add("DLabel")
        M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_menucommand"))
        M_LABEL:Dock(TOP)
        M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        
        local d_MCOMMAND = S:Add("DTextEntry")
        d_MCOMMAND:Dock(TOP)
        d_MCOMMAND:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        d_MCOMMAND.OnTextChanged = function(s)
            DATA.m_command = s:GetValue()
        end
        
        if DATA.m_command then
            d_MCOMMAND:SetValue(DATA.m_command)
        end

        -- Adjust Width
        local M_LABEL = S:Add("DLabel")
        M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_adjustWidth"))
        M_LABEL:Dock(TOP)
        M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)

        local ADJUSTW = S:Add("DNumSlider")
        ADJUSTW:Dock(TOP)
        ADJUSTW:SetMax(1)
        ADJUSTW:SetMin(-1)

        ADJUSTW:SetDecimals(1)
        ADJUSTW:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        ADJUSTW.OnValueChanged = function(s)
            DATA.adjustw = s:GetValue()
        end

        if DATA and DATA.adjustw then
            ADJUSTW:SetValue(DATA.adjustw)
        end

        -- Adjust Height
        local M_LABEL = S:Add("DLabel")
        M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_adjustHeight"))
        M_LABEL:Dock(TOP)
        M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)

        local ADJUSTH = S:Add("DNumSlider")
        ADJUSTH:Dock(TOP)
        ADJUSTH:SetMax(1)
        ADJUSTH:SetMin(-1)
        ADJUSTH:SetDecimals(1)
        ADJUSTH:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        ADJUSTH.OnValueChanged = function(s)
            DATA.adjusth = s:GetValue()
        end

        if DATA and DATA.adjusth then
            ADJUSTH:SetValue(DATA.adjusth)
        end

        -- Console Model
        
        local M_LABEL = S:Add("DLabel")
        M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_consolemodel"))
        M_LABEL:Dock(TOP)
        M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        
        local d_consoleModel = S:Add("DTextEntry")
        d_consoleModel:Dock(TOP)
        d_consoleModel:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        d_consoleModel.OnTextChanged = function(s)
            DATA.consolemodel = s:GetValue()
        end
        
        if DATA.consolemodel then
            d_consoleModel:SetValue(DATA.consolemodel)
        end

        -- Defcon Change Sound
        
        local M_LABEL = S:Add("DLabel")
        M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_changeSound"))
        M_LABEL:Dock(TOP)
        M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        
        local d_changeSound = S:Add("DTextEntry")
        d_changeSound:Dock(TOP)
        d_changeSound:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        d_changeSound.OnTextChanged = function(s)
            DATA.changesound = s:GetValue()
        end
        
        if DATA.changesound then
            d_changeSound:SetValue(DATA.changesound)
        end

        -- Change Sound Enabled
        local M_LABEL = S:Add("DLabel")
        M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_changeSoundEnabled"))
        M_LABEL:Dock(TOP)
        M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)

        local LABEL = S:Add("DLabel")
        LABEL:SetText("")
        LABEL:SetHeight(h * 0.1)
        LABEL:Dock(TOP)
        LABEL:DockMargin(w * 0.025, 0, w * 0.025, h * 0.025)
        LABEL:SetMouseInputEnabled(true)

        local CHECK_L = LABEL:Add("DLabel")
        CHECK_L:SetMouseInputEnabled(true)
        CHECK_L:Dock(RIGHT)
        CHECK_L:SetText("")

        local CHECK = CHECK_L:Add("DCheckBox")
        CHECK:Center()
        CHECK.OnChange = function(s, val)
            DATA.changesounden = val
        end

        if DATA.changesounden then
            CHECK:SetChecked(true)
        end

        -- Dissapear when Dead
        local M_LABEL = S:Add("DLabel")
        M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_disappearwhenDead"))
        M_LABEL:Dock(TOP)
        M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)

        local LABEL = S:Add("DLabel")
        LABEL:SetText("")
        LABEL:SetHeight(h * 0.1)
        LABEL:Dock(TOP)
        LABEL:DockMargin(w * 0.025, 0, w * 0.025, h * 0.025)
        LABEL:SetMouseInputEnabled(true)

        local CHECK_L = LABEL:Add("DLabel")
        CHECK_L:SetMouseInputEnabled(true)
        CHECK_L:Dock(RIGHT)
        CHECK_L:SetText("")

        local CHECK = CHECK_L:Add("DCheckBox")
        CHECK:Center()
        CHECK.OnChange = function(s, val)
            DATA.disablehuddead = val
        end

        if DATA.disablehuddead then
            CHECK:SetChecked(true)
        end

        -- No Box
        local M_LABEL = S:Add("DLabel")
        M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_noboxEnabled"))
        M_LABEL:Dock(TOP)
        M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)

        local LABEL = S:Add("DLabel")
        LABEL:SetText("")
        LABEL:SetHeight(h * 0.1)
        LABEL:Dock(TOP)
        LABEL:DockMargin(w * 0.025, 0, w * 0.025, h * 0.025)
        LABEL:SetMouseInputEnabled(true)

        local CHECK_L = LABEL:Add("DLabel")
        CHECK_L:SetMouseInputEnabled(true)
        CHECK_L:Dock(RIGHT)
        CHECK_L:SetText("")

        local CHECK = CHECK_L:Add("DCheckBox")
        CHECK:Center()
        CHECK.OnChange = function(s, val)
            DATA.nobox = val
        end

        if DATA.nobox then
            CHECK:SetChecked(true)
        end

        -- No Box
        local M_LABEL = S:Add("DLabel")
        M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_displayChangerEnabled"))
        M_LABEL:Dock(TOP)
        M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)

        local LABEL = S:Add("DLabel")
        LABEL:SetText("")
        LABEL:SetHeight(h * 0.1)
        LABEL:Dock(TOP)
        LABEL:DockMargin(w * 0.025, 0, w * 0.025, h * 0.025)
        LABEL:SetMouseInputEnabled(true)

        local CHECK_L = LABEL:Add("DLabel")
        CHECK_L:SetMouseInputEnabled(true)
        CHECK_L:Dock(RIGHT)
        CHECK_L:SetText("")

        local CHECK = CHECK_L:Add("DCheckBox")
        CHECK:Center()
        CHECK.OnChange = function(s, val)
            DATA.displaychanger = val
        end

        if DATA.displaychanger then
            CHECK:SetChecked(true)
        end

        -- Prefix
        
        local M_LABEL = S:Add("DLabel")
        M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_prefixtext"))
        M_LABEL:Dock(TOP)
        M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        
        local d_PREFIXT = S:Add("DTextEntry")
        d_PREFIXT:Dock(TOP)
        d_PREFIXT:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        d_PREFIXT.OnTextChanged = function(s)
            DATA.prefixtext = s:GetValue()
        end
        
        if DATA.prefixtext then
            d_PREFIXT:SetValue(DATA.prefixtext)
        end

        -- Color
        
        local M_LABEL = S:Add("DLabel")
        M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_prefixcolor"))
        M_LABEL:Dock(TOP)
        M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        
        local d_prefixColor = S:Add("DColorMixer")
        d_prefixColor:Dock(TOP)
        d_prefixColor:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        
        if DATA.prefixcolor then
            local C = DATA.prefixcolor
        
            if C.r and C.g and C.b then
                C = Color(C.r, C.g, C.b)
                d_prefixColor:SetColor(DATA.prefixcolor)
            end
        else
            d_prefixColor:SetColor(Color(255,0,0))
        end
        
        d_prefixColor.Think = function(s)
            DATA.prefixcolor = s:GetColor()
        end

        local SUBMIT = vgui.Create("NCS_DEF_TextButton", PANEL)
        SUBMIT:Dock(BOTTOM)
        SUBMIT:SetTall(h * 0.1)
        SUBMIT:DockMargin(w * 0.025, h * 0.02, w * 0.025, h * 0.025)
        SUBMIT:SetText(NCS_DEFCON.GetLang(nil, "DEF_submit"))
        SUBMIT.DoClick = function()
            local json = util.TableToJSON(DATA)
            local compressed = util.Compress(json)
            local length = compressed:len()
        
            net.Start("NCS_DEFCON_ChangeSettings")
                net.WriteUInt(length, 32)
                net.WriteData(compressed, length)
            net.SendToServer()
        end
    end )

    SIDE:AddPage(NCS_DEFCON.GetLang(nil, "DEF_adminLabel"), "6JrFWlz", function()
        if IsValid(PANEL) then
            PANEL:Clear()
        end

        local DATA = table.Copy(NCS_DEFCON.CONFIG)
        DATA.defconList = nil

        local NoCAMIFuckU
        local NoCAMIDerma = {}

        local w, h = F:GetSize()

        local S = vgui.Create("NCS_DEF_SCROLL", PANEL)
        S:Dock(FILL)

        -- Cami Time
        local M_LABEL = S:Add("DLabel")
        M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_camiEnabled"))
        M_LABEL:Dock(TOP)
        M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)

        local LABEL = S:Add("DLabel")
        LABEL:SetText("")
        LABEL:SetHeight(h * 0.1)
        LABEL:Dock(TOP)
        LABEL:DockMargin(w * 0.025, 0, w * 0.025, h * 0.025)
        LABEL:SetMouseInputEnabled(true)

        local CHECK_L = LABEL:Add("DLabel")
        CHECK_L:SetMouseInputEnabled(true)
        CHECK_L:Dock(RIGHT)
        CHECK_L:SetText("")

        local CHECK = CHECK_L:Add("DCheckBox")
        CHECK:Center()
        CHECK.OnChange = function(s, val)
            DATA.camienabled = val

            if !val then
                NoCAMIFuckU()
            else
                for k, v in ipairs(NoCAMIDerma) do
                    if IsValid(v) then v:Remove() end
                end

                NoCAMIDerma = {}
            end
        end

        if DATA.camienabled then
            CHECK:SetChecked(true)
        end

        -- No Cami
        
        NoCAMIFuckU = function()
            local M_LABEL = S:Add("DLabel")
            M_LABEL:SetText(NCS_DEFCON.GetLang(nil, "DEF_adminGroups"))
            M_LABEL:Dock(TOP)
            M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
            M_LABEL:SetMouseInputEnabled(true)

            local TX_USERGROUP
            local TX_UGLIST
        
            local LABEL_TOP = S:Add("DLabel")
            LABEL_TOP:Dock(TOP)
            LABEL_TOP:SetTall(LABEL_TOP:GetTall() * 1.5)
            LABEL_TOP:SetText("")
            LABEL_TOP:SetMouseInputEnabled(true)
            LABEL_TOP:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)

            local ADD = LABEL_TOP:Add("DButton")
            ADD:SetImage("icon16/add.png")
            ADD:Dock(LEFT)
            ADD:SetText("")
            ADD:SetWide(ADD:GetWide() * 0.4)
            ADD.DoClick = function(s)
                local UG = TX_USERGROUP:GetValue()
        
                if ( !UG or UG == "" ) then return end
        
                local LINE = TX_UGLIST:AddLine(UG, LocalPlayer():SteamID64())
                LINE.USERGROUP = UG

                DATA.admins[UG] = LocalPlayer():SteamID64()

                TX_USERGROUP:SetText("")
            end
        
            TX_USERGROUP = vgui.Create("DTextEntry", LABEL_TOP)
            TX_USERGROUP:Dock(LEFT)
            TX_USERGROUP:SetKeyboardInputEnabled(true)
            TX_USERGROUP:SetPlaceholderText(NCS_DEFCON.GetLang(nil, "DEF_adminGroups"))
            TX_USERGROUP:SetWide(TX_USERGROUP:GetWide() * 2)
        
            local LABEL = vgui.Create("DLabel", S)
            LABEL:SetText("")
            LABEL:SetHeight(h * 0.3)
            LABEL:Dock(TOP)
            LABEL:SetMouseInputEnabled(true)
            LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
            LABEL:SetMouseInputEnabled(true)

            table.insert(NoCAMIDerma, M_LABEL)
            table.insert(NoCAMIDerma, LABEL_TOP)
            table.insert(NoCAMIDerma, LABEL)

            TX_UGLIST = vgui.Create("DListView", LABEL)
            TX_UGLIST:Dock(FILL)
            TX_UGLIST:AddColumn( NCS_DEFCON.GetLang(nil, "DEF_adminGroups"), 1 )
            TX_UGLIST:AddColumn( NCS_DEFCON.GetLang(nil, "DEF_addedBy"), 2 )

            TX_UGLIST.OnRowRightClick = function(sm, ID, LINE)
                local UG = LINE.USERGROUP
                
                if ( UG == "superadmin" ) then return end

                if DATA.admins[UG] then
                    DATA.admins[UG] = nil
                end
        
                TX_UGLIST:RemoveLine(ID)
            end
            TX_UGLIST.OnRowSelected = function(_, I, ROW)
                ROW:SetSelected(false)
            end

            if DATA.admins then
                for k, v in pairs(DATA.admins) do
                    local LINE = TX_UGLIST:AddLine(k, v)
                    LINE.USERGROUP = k
                    LINE.ADDEDBY = v
                end
            end
        end

        if !DATA.camienabled then
            NoCAMIFuckU()
        end

        local SUBMIT = vgui.Create("NCS_DEF_TextButton", PANEL)
        SUBMIT:Dock(BOTTOM)
        SUBMIT:SetTall(h * 0.1)
        SUBMIT:DockMargin(w * 0.025, h * 0.02, w * 0.025, h * 0.025)
        SUBMIT:SetText(NCS_DEFCON.GetLang(nil, "DEF_submit"))
        SUBMIT.DoClick = function()
            local json = util.TableToJSON(DATA)
            local compressed = util.Compress(json)
            local length = compressed:len()
        
            net.Start("NCS_DEFCON_ChangeSettings")
                net.WriteUInt(length, 32)
                net.WriteData(compressed, length)
            net.SendToServer()
        end
    end )

    SIDE:AddPage(NCS_DEFCON.GetLang(nil, "DEF_defconsLabel"), "Gmj9DYO", function()
        if IsValid(PANEL) then
            PANEL:Clear()
        end

        inDefconScreen = true

        local d_Count = 0

        local SCROLL = vgui.Create("NCS_DEF_SCROLL", PANEL)
        SCROLL:Dock(FILL)
        SCROLL.Paint = function(s, w, h)
            if d_Count > 0 then return end

            draw.SimpleText(NCS_DEFCON.GetLang(nil, "DEF_noDefcons"), "NCS_DEF_FRAME_TITLE", w * 0.5, h * 0.4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        SCROLL.OnRemove = function()
            inDefconScreen = false
        end

        for k, v in pairs(NCS_DEFCON.CONFIG.defconList) do
            d_Count = d_Count + 1

            local UNIQUE_ID = tonumber(v.uid)

            local L = SCROLL:Add("DLabel")
            L:Dock(TOP)
            L:SetHeight(PANEL:GetTall() * 0.15)
            L:DockMargin(w * 0.025, h * 0.02, w * 0.025, h * 0.025)
            L:SetText("")
            L:SetTooltip(NCS_DEFCON.GetLang(nil, "DEF_rightClickOpt"))
            L:SetMouseInputEnabled(true)
            L.Paint = function(s, w, h)
                local boxColor = s:IsHovered() and color_Gold or color_Grey

                surface.SetDrawColor( boxColor )
                surface.DrawOutlinedRect( 0, 0, w, h )

                draw.SimpleText(v.name, "NCS_DEF_FRAME_TITLE", w * 0.1, h * 0.375, ( s:IsHovered() and color_Gold or v.col ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(v.desc.." ("..UNIQUE_ID..")", "NCS_DEF_FRAME_TITLE", w * 0.1, h * 0.625, ( s:IsHovered() and color_Gold or color_white ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                
                surface.SetDrawColor( boxColor )

                surface.DrawRect(w * 0.1, h * 0.775, w * 0.1, h * 0.035)
                surface.DrawRect(w * 0.21, h * 0.775, w * 0.1, h * 0.035)
                surface.DrawRect(w * 0.21, h * 0.825, w * 0.1, h * 0.035)
            end
            L.OnCursorEntered = function()
                surface.PlaySound("ncs/ui/slider.mp3")
            end

            L.DoClick = function(s)
                local MenuButtonOptions = DermaMenu()
        
                MenuButtonOptions:AddOption(NCS_DEFCON.GetLang(nil, "DEF_editLabel"), function()
                    if !UNIQUE_ID then return end

                    AddDefcon(k, F)

                    F:SetVisible(false)

                end)

                MenuButtonOptions:AddOption(NCS_DEFCON.GetLang(nil, "DEF_copyLabel"), function()
                    if !UNIQUE_ID then return end

                    AddDefcon(k, F, true)

                    F:SetVisible(false)

                end)

                MenuButtonOptions:AddOption(NCS_DEFCON.GetLang(nil, "DEF_deleteLabel"), function()
                    if !UNIQUE_ID then return end

                    net.Start("NCS_DEF_RemoveDefcon")
                        net.WriteUInt(UNIQUE_ID, 16)
                    net.SendToServer()

                    L:Remove()

                end)
                MenuButtonOptions:Open()
            end
        end 

        local CREATE = vgui.Create("NCS_DEF_TextButton", PANEL)
        CREATE:Dock(BOTTOM)
        CREATE:SetTall(h * 0.1)
        CREATE:DockMargin(w * 0.025, h * 0.02, w * 0.025, h * 0.025)
        CREATE:SetText(NCS_DEFCON.GetLang(nil, "DEF_createLabel"))
        CREATE.DoClick = function()
            AddDefcon(nil, F)

            F:SetVisible(false)
        end
    end )

    SIDE:AddPage(NCS_DEFCON.GetLang(nil, "DEF_support"), "A5YPY4p", function()
        if IsValid(PANEL) then
            PANEL:Clear()
        end

        local DISCORD = vgui.Create("NCS_DEF_IMGUR", PANEL)
        DISCORD:Dock(FILL)
        DISCORD:SetImgurID("A5YPY4p")
        DISCORD:DockMargin(w * 0.025, h * 0.02, w * 0.025, h * 0.025)
        DISCORD:SetImageSize(3)

        local SUBMIT = vgui.Create("NCS_DEF_TextButton", PANEL)
        SUBMIT:Dock(BOTTOM)
        SUBMIT:SetTall(h * 0.15)
        SUBMIT:DockMargin(w * 0.025, h * 0.02, w * 0.025, h * 0.025)
        SUBMIT:SetText(NCS_DEFCON.GetLang(nil, "DEF_clickToOpen"))
        SUBMIT.DoClick = function()
            gui.OpenURL("https://discord.gg/Th6xu4xybb")
        end
    end )

    if lastPage then
        SIDE.Think = function()
            SIDE:SelectPage(lastPage)
            SIDE.Think = function() end
        end
    end
end

net.Receive("NCS_DEFCON_ConfigCommand", function()
    OpenMenu()
end )

net.Receive("NCS_DEFCON_AddDefcon", function(_, P)
    local i_Creator = net.ReadUInt(8)
    local length = net.ReadUInt(32)
	local data = net.ReadData(length)
	local uncompressed = util.Decompress(data)

	if (!uncompressed) then
		return
	end

	local D = util.JSONToTable(uncompressed)

    local FOUND = false

    for k, v in pairs(NCS_DEFCON.CONFIG.defconList) do
        if D.uid ~= v.uid then continue end

        NCS_DEFCON.CONFIG.defconList[k] = D
        FOUND = true
        break
    end

    if !FOUND then
        table.insert(NCS_DEFCON.CONFIG.defconList, D)
    end

    if ( i_Creator and ( i_Creator == LocalPlayer():EntIndex() ) ) then
        OpenMenu()
    end
end )

net.Receive("NCS_DEFCON_ChangeSettings", function()
    local length = net.ReadUInt(32)
	local data = net.ReadData(length)
	local uncompressed = util.Decompress(data)

	if (!uncompressed) then
		return
	end

	local D = util.JSONToTable(uncompressed)

    for k, v in pairs(D) do
        NCS_DEFCON.CONFIG[k] = v
    end
end )

net.Receive("NCS_DEFCON_LoadPlayer", function()
    local length = net.ReadUInt(32)
	local data = net.ReadData(length)
	local uncompressed = util.Decompress(data)

	if (!uncompressed) then
		return
	end

	local D = util.JSONToTable(uncompressed)

    NCS_DEFCON.CONFIG = D
end )

net.Receive("NCS_DEF_RemoveDefcon", function()
    local UID = net.ReadUInt(16)

    for k, v in pairs(NCS_DEFCON.CONFIG.defconList) do
        if ( tonumber(v.uid) == tonumber(UID) ) then
            NCS_DEFCON.CONFIG.defconList[k] = nil
        end
    end
end )