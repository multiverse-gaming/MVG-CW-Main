hook.Add("NCS_SHARED_LanguageRegistered", "LanguageRegisteredCore", function()
    local T = {}

    for k, v in pairs(NCS_SHARED.GetLangs()) do
        table.insert(T, k)
    end 

    NCS_SHARED.CreateDataOption("Language", {
        dataCategory = "Library",
        saveData = true,
        multiSelect = false,
        selectData = T,
        dataType = TYPE_TABLE,
        defaultValue = "en",
        sortValue = 4,
    })
end )

--[[------------------------------------]]--
--  Currency System Options
--[[------------------------------------]]--

local T = {}

for k, v in pairs(NCS_SHARED.CURRENCIES) do
    table.insert(T, k)
end 

NCS_SHARED.CreateDataOption("Currency", {
    dataCategory = "Library",
    saveData = true,
    multiSelect = false,
    selectData = T,
    dataType = TYPE_TABLE,
    defaultValue = "darkrp",
    sortValue = 3,
})

--[[------------------------------------]]--
--  Character System Options
--[[------------------------------------]]--

NCS_SHARED.CreateDataOption("Character System Enabled", {
    dataCategory = "Library",
    saveData = true,
    dataType = TYPE_BOOL,
    defaultValue = false,
    sortValue = 2,
})

local T = {}

for k, v in pairs(NCS_SHARED.CharSystems) do
    table.insert(T, k)
end

NCS_SHARED.CreateDataOption("Character System", {
    dataCategory = "Library",
    saveData = true,
    multiSelect = false,
    selectData = T,
    dataType = TYPE_TABLE,
    defaultValue = "helix",
    sortValue = 1,
})

--[[------------------------------------]]--
--  Admin Groups
--[[------------------------------------]]--

NCS_SHARED.CreateDataOption("Admin Groups", {
    dataCategory = "Library",
    saveData = true,
    multiSelect = true,
    selectData = T,
    dataType = TYPE_TABLE,
    defaultValue = {
        ["superadmin"] = "World",
    },
    sortValue = 5,
    verifyData = function(TAB, DATA)
        if !DATA["superadmin"] then
            DATA["superadmin"] = "World"

            TAB:setInternalData(DATA)

            return false
        end
    end,
    customMenuFunction = function(TAB, S)
        local currentValues = table.Copy(TAB.currentValue) or {}
        local w, h = S:GetParent():GetSize()

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
            if !istable(currentValues) then return end

            local UG = TX_USERGROUP:GetValue()
    
            if ( !UG or UG == "" ) then return end
    
            local LINE = TX_UGLIST:AddLine(UG, LocalPlayer():SteamID64())
            LINE.USERGROUP = UG

            currentValues[UG] = LocalPlayer():SteamID64()

            TX_USERGROUP:SetText("")
            
            TAB:setInternalData(currentValues)
        end
    
        TX_USERGROUP = vgui.Create("DTextEntry", LABEL_TOP)
        TX_USERGROUP:Dock(LEFT)
        TX_USERGROUP:SetKeyboardInputEnabled(true)
        TX_USERGROUP:SetPlaceholderText("Admin Groups")
        TX_USERGROUP:SetWide(TX_USERGROUP:GetWide() * 2)
    
        local LABEL = vgui.Create("DLabel", S)
        LABEL:SetText("")
        LABEL:SetHeight(h * 0.3)
        LABEL:Dock(TOP)
        LABEL:SetMouseInputEnabled(true)
        LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        LABEL:SetMouseInputEnabled(true)

        TX_UGLIST = vgui.Create("DListView", LABEL)
        TX_UGLIST:Dock(FILL)
        TX_UGLIST:AddColumn( "Admin Groups", 1 )
        TX_UGLIST:AddColumn( "Added By", 2 )

        TX_UGLIST.OnRowRightClick = function(sm, ID, LINE)
            local UG = LINE.USERGROUP
            
            if ( UG == "superadmin" ) then return end

            if currentValues[UG] then
                currentValues[UG] = nil
            end
    
            TX_UGLIST:RemoveLine(ID)

            TAB:setInternalData(currentValues)
        end
        TX_UGLIST.OnRowSelected = function(_, I, ROW)
            ROW:SetSelected(false)
        end

        if currentValues then
            for k, v in pairs(currentValues) do
                local LINE = TX_UGLIST:AddLine(k, v)
                LINE.USERGROUP = k
            end
        end
    end,
})