concommand.Add("ncs_configurationmenu", function()
    local aGroups = NCS_SHARED.GetDataOption("admingroups_library")

    if !aGroups then
        if !LocalPlayer():IsSuperAdmin() then NCS_SHARED.AddText(Color(255,0,0), "[NCS] ", color_white, "No permission, please contact system administrator.") return end
    elseif !aGroups[LocalPlayer():GetUserGroup()] then
        return
    end

    local F = vgui.Create("NCS_SHARED_FRAME")
    F:SetSize(ScrW() * 0.4, ScrH() * 0.5)
    F:Center()
    F:MakePopup(true)
    F:SetMouseInputEnabled(true)

    local w, h = F:GetSize()

    local S = F:Add("NCS_SHARED_SCROLL")
    S:Dock(FILL)
    S:SetMouseInputEnabled(true)
    S:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
    
    local SIDE = vgui.Create("NCS_SHARED_SIDEBAR", F)
    SIDE:SetMouseInputEnabled(true)

    local CATEGORIES = {}

    local HandleCategories
    local firstName
    for k, v in pairs(NCS_SHARED.SavedDataOptions) do
        if CATEGORIES[v.dataCategory] then continue end

        if !firstName then firstName = v.dataCategory end

        CATEGORIES[v.dataCategory] = true
        
        SIDE:AddPage(v.dataCategory, "JokvF2A", function()
            if IsValid(S) then
                S:Clear()
            end

            HandleCategories(v.dataCategory)
        end )
    end

    SIDE.Think = function(s)
        SIDE:SelectPage(firstName)

        s.Think = function() end
    end

    HandleCategories = function(categoryName)
            for k, v in SortedPairsByMemberValue(NCS_SHARED.SavedDataOptions, "sortValue", true) do
                if v.dataCategory ~= categoryName then continue end

                local M_LABEL = S:Add("DLabel")
                M_LABEL:SetText(v.dataName)
                M_LABEL:Dock(TOP)
                M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
                M_LABEL:SetFont("NCS_SHARED_DESCRIPTION")
                M_LABEL:SetTall(M_LABEL:GetTall() * 1.4)
                M_LABEL:SetMouseInputEnabled(true)

                if v.customMenuFunction then
                    v:customMenuFunction(S)
                    continue
                end
                
                if ( v.dataType == TYPE_BOOL ) then
                    local LABEL = S:Add("DLabel")
                    LABEL:SetText("")
                    LABEL:SetHeight(h * 0.05)
                    LABEL:Dock(TOP)
                    LABEL:DockMargin(w * 0.025, h * 0.005, w * 0.025, 0)
                    LABEL:SetMouseInputEnabled(true)

                    local CHECK_L = LABEL:Add("DLabel")
                    CHECK_L:SetMouseInputEnabled(true)
                    CHECK_L:Dock(RIGHT)
                    CHECK_L:SetText("")
                    
                    local CHECK = CHECK_L:Add("DCheckBox")
                    CHECK:SetSize(CHECK:GetWide() * 1.5, CHECK:GetWide() * 1.5)
                    CHECK:Center()
                    CHECK:SetMouseInputEnabled(true)

                    CHECK.OnChange = function(s, val)
                        if v.verifyData then
                            local verifyData = v:verifyData(val)

                            if ( verifyData == false ) then s:SetChecked(!val) return end
                        end

                        net.Start("NCS_SHARED_SetConfigOption")
                            net.WriteString(k)
                            net.WriteType(val)
                        net.SendToServer()
                    end
                    
                    if NCS_SHARED.GetDataOption(k) then
                        CHECK:SetChecked(true)
                    end
                elseif ( v.dataType == TYPE_TABLE ) then
                    if v.multiSelect then
                        local TEAMS = S:Add("DLabel")
                        TEAMS:Dock(TOP)
                        TEAMS:SetTall(F:GetTall() * 0.3)
                        TEAMS:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
                        TEAMS:SetMouseInputEnabled(true)
                        TEAMS:SetText("")

                        TEAMS.Paint = function(s, w, h)
                            surface.SetDrawColor(Color(32,32,32,255))
                            surface.DrawOutlinedRect( 0, 0, w, h)
                        end

                        for k1, v2 in ipairs(v.selectData) do
                            local LINE = TEAMS:Add("DLabel")
                            LINE:Dock(TOP)
                            LINE:SetText("")
                            LINE:SetTall(TEAMS:GetTall() * 0.125)
                            LINE:SetMouseInputEnabled(true)
                            LINE.Paint = function(s, w, h)
                                if (k1 % 2 == 0) then
                                    draw.RoundedBox(0, 0, 0, w, h, Color(32,32,32,255))
                                else
                                    draw.RoundedBox(0, 0, 0, w, h, Color(48,48,48,255))
                                end
                                    
                                draw.SimpleText(v2, "NCS_SHARED_DESCRIPTION", w * 0.01, h * 0.5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                            end

                            local CHECK_L = vgui.Create("DLabel", LINE)
                            CHECK_L:Dock(RIGHT)
                            CHECK_L:SetText("")
                            CHECK_L:SetMouseInputEnabled(true)

                            CHECK_L.Think = function()
                                local CHECK = vgui.Create("DCheckBox", CHECK_L)
                                CHECK:SetSize(CHECK:GetWide() * 1.5, CHECK:GetTall() * 1.5)
                                CHECK:Center()
                                CHECK:SetMouseInputEnabled(true)

                                local dataOption = NCS_SHARED.GetDataOption(k)

                                if istable(dataOption) then
                                    for c, d in ipairs(dataOption) do
                                        if v2 == d then
                                            CHECK:SetValue(true)
                                        end
                                    end
                                end

                                CHECK.OnChange = function(s, val)
                                    if v.verifyData then
                                        local verifyData = v:verifyData(val)
        
                                        if ( verifyData == false ) then s:SetChecked(!val) return end
                                    end

                                    TEAMS.VALUES = TEAMS.VALUES or {}

                                    if val then
                                        table.insert(TEAMS.VALUES, v2)
                                    else
                                        for a, b in ipairs(TEAMS.VALUES) do
                                            if ( b == v2 ) then
                                                table.remove(TEAMS.VALUES, a)
                                            end
                                        end
                                    end

                                    net.Start("NCS_SHARED_SetConfigOption")
                                        net.WriteString(k)
                                        net.WriteType(TEAMS.VALUES)
                                    net.SendToServer()
                                end

                                CHECK_L.Think = function() end
                            end
                        end
                    else
                        local PANEL_sort = S:Add("DPanel")
                        PANEL_sort:Dock(TOP)
                        PANEL_sort:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
                        PANEL_sort.Paint = function() end

                        local combobox_Sort = PANEL_sort:Add("DComboBox")
                        combobox_Sort:Dock(FILL)

                        
                        for _, v in pairs(v.selectData) do
                            local IND = combobox_Sort:AddChoice(v)

                            if ( NCS_SHARED.GetDataOption(k) ~= nil ) and ( NCS_SHARED.GetDataOption(k) == v ) then
                                combobox_Sort:ChooseOptionID(IND)
                            end
                        end
                        
                        combobox_Sort.OnSelect = function(s, IND, val, S_VAL)
                            if v.verifyData then
                                local verifyData = v:verifyData(val)

                                if ( verifyData == false ) then s:SetText("Broken") return end
                            end

                            print("EYYYYO")
                            net.Start("NCS_SHARED_SetConfigOption")
                                net.WriteString(k)
                                net.WriteType(val)
                            net.SendToServer()
                        end
                    end
            end
        end
    end
end )

net.Receive("NCS_SHARED_SendConfigOptions", function()
    local TAB = net.ReadTable()

    for k, v in pairs(TAB) do
        NCS_SHARED.SavedDataOptions[tostring(k)].currentValue = v
    end

    hook.Run("NCS_SHARED_ConfigurationModuleLoaded")
end )

net.Receive("NCS_SHARED_SetConfigOption", function()
    NCS_SHARED.SavedDataOptions[net.ReadString()].currentValue = net.ReadType()
end )