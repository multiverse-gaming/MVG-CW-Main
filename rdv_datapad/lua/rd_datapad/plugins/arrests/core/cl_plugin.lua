local OBJ = NCS_DATAPAD.GetPlugin()

function OBJ:DoClick(player, MENU, PAGE)
    local w, h = MENU:GetSize()

    local LANG = NCS_DATAPAD.GetLang(nil, "DAP_noEntriesSaved")

    local SCROLL = vgui.Create("RDV_DAP_SCROLL", PAGE)
    SCROLL:Dock(FILL)
    SCROLL:DockMargin(0, h * 0.02, w * 0.02, h * 0.02)
    SCROLL.Think = function(self)

        OBJ.SCROLL = SCROLL
        OBJ.MENU = MENU

        PAGE.PaintOver = function(self, w, h)
            draw.SimpleText(NCS_DATAPAD.GetLang(nil, "DAP_arrestAccess"), "NCS_DEF_FRAME_TITLE", w * 0.5, h * 0.4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end 

        NCS_DATAPAD.IsAdmin(player, function(ACCESS)
            if ACCESS or NCS_DATAPAD.CONFIG.SHOCK[team.GetName(player:Team())] then

            PAGE.PaintOver = function(self, w, h)
                draw.SimpleText(NCS_DATAPAD.GetLang(nil, "DAP_arrestReports"), "RDV_DAP_FRAME_TITLE", w * 0.5, h * 0.05, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
            end 
                local LANG = NCS_DATAPAD.GetLang(nil, "DAP_createEntryLabel")

                local but = vgui.Create("RDV_DAP_TextButton", PAGE)
                but:SetHeight(h * 0.125)
                but:Dock(BOTTOM)
                but:SetText(NCS_DATAPAD.GetLang(nil, "DAP_createArrestReport"))
                but:DockMargin(0, h * 0.02, w * 0.02, h * 0.02)

                but.DoClick = function()
                    MENU:SetVisible(false)
                    
                    OBJ:CreateEntryMenu(MENU)
                end

                self.Think = function() end           
            end
        end )


    end
end

