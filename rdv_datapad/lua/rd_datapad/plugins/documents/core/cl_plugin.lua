local OBJ = NCS_DATAPAD.GetPlugin()

local COL_1 = Color(255,255,255)

function OBJ:DoClick(player, frame, PAGE)
    PAGE.PaintOver = function() end

    local w, h = PAGE:GetSize()

    local SCROLL = vgui.Create("DScrollPanel", PAGE)
    SCROLL:GetVBar():SetWide(0)
    SCROLL:Dock(FILL)
    SCROLL:DockMargin(w * 0.01, h * 0.01, w * 0.01, h * 0.01)
    SCROLL.Think = function(self)
        for k,v in pairs(OBJ.URLs) do
            local LABEL = self:Add("DButton")
            LABEL:Dock(TOP)
            LABEL:SetText("")
            LABEL:SetHeight(h * 0.1)
            LABEL:SetFont("RD_FONTS_CORE_LABEL_LOWER")
            LABEL:DockMargin(w * 0.01, h * 0.01, w * 0.01, h * 0.01)
            LABEL.Paint = function(self, w, h)
                surface.SetDrawColor(PIXEL.CopyColor(PIXEL.Colors.Header))
                surface.DrawRect(0, 0, w, h)
    
                draw.SimpleText(k, "RD_FONTS_CORE_LABEL_LOWER", w * 0.05, h * 0.5, COL_1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end
            local BUT = vgui.Create("PIXEL.TextButton", LABEL)
            BUT:Dock(RIGHT)
            BUT:SetText("View")
            BUT.DoClick = function()
                gui.OpenURL(v)
            end
        end

        self.Think = nil
    end
end