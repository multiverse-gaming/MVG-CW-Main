hook.Add("NCS_DEF_AddonLoaded", "RDV_DATAPAD_DefLoadedCL", function()
    local OBJ = NCS_DATAPAD.GetPlugin()

    if !OBJ then return end

    local COL_1 = Color(255,255,255)

    function OBJ:DoClick(player, MENU, PAGE)
        local d_Count = 0
        
        PAGE.PaintOver = function(s, w, h)
            if d_Count > 0 then return end
    
            draw.SimpleText(NCS_DEFCON.GetLang(nil, "DEF_noAccessConsole"), "NCS_DEF_FRAME_TITLE", w * 0.5, h * 0.4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        local w, h = PAGE:GetSize()

        NCS_DEFCON.IsStaff(LocalPlayer(), function(checkPassed)
            local SCROLL = vgui.Create("RDV_DAP_SCROLL", PAGE)
            SCROLL:Dock(FILL)
            SCROLL:DockMargin(0, h * 0.02, w * 0.02, h * 0.02)
            SCROLL.Think = function(self)
                local w, h = self:GetSize()

                for k, v in pairs(NCS_DEFCON.CONFIG.defconList) do
                    if checkPassed or ( v.teams and v.teams[team.GetName(LocalPlayer():Team())] ) or v.allteams then
                        d_Count = d_Count + 1

                        local LABEL = self:Add("DButton")
                        LABEL:Dock(TOP)
                        LABEL:SetText("")
                        LABEL:SetHeight(h * 0.1)
                        LABEL:SetFont("RDV_DAP_FRAME_TITLE")
                        LABEL:DockMargin(0, 0, 0, h * 0.02)

                        LABEL.Paint = function(self, w, h)
                            surface.SetDrawColor(v.col)
                            surface.DrawRect(0, 0, w, h)
                    
                            surface.SetDrawColor(COL_1)
                            surface.DrawOutlinedRect(0, 0, w, h)

                            draw.SimpleText((v.name or k), "RDV_DAP_FRAME_TITLE", w * 0.5, h * 0.5, COL_1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        end
                        LABEL.DoClick = function(self)
                            net.Start("NCS_DEFCON_CHANGE")
                                net.WriteUInt(k, 8)
                            net.SendToServer()
                        end
                    end
                end

                self.Think = nil
            end
        end )
    end
end)