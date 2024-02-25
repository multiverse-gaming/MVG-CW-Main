local COL_2 = Color(39,39,39,235)
local COL_3 = Color(36,36,36, 225)
local COL_4 = Color(68,131,171,255)

local PANEL = {
	Init = function(self)
        self.ACTIVE = false
        self.HOVERED = {}
        self.SELECTED = false

        local PARENT = self:GetParent()

        local w, h = PARENT:GetSize()

        self.SCROLL = vgui.Create("DScrollPanel", PARENT)
        self.SCROLL:Dock(LEFT)
        self.SCROLL:SetSize(w * 0.3, h)
        self.SCROLL:DockMargin(w * 0.02, h * 0.02, w * 0.02, h * 0.02)
        self.SCROLL.Paint = function(self, w, h)
            surface.SetDrawColor( Color(122,132,137, 180) )
            surface.DrawOutlinedRect( 0, 0, w, h )
        end
    end,
    AddPage = function(self, title, icon, cb)
        self.PAGES = self.PAGES or {}

        local COL = Color(122,132,137, 180)

        local BUTTON = self.SCROLL:Add("DButton")
        BUTTON:SetText("")
        
        local w, h = BUTTON:GetSize()
        BUTTON:Dock(TOP)
        BUTTON:SetHeight(h * 2)
        BUTTON:SetFont("RDV_DAP_FRAME_TITLE")
        BUTTON:SetText(title)
        BUTTON:SetTextColor(color_white)

        BUTTON.Paint = function(s, w, h)
            local S_W, S_H = s:GetSize()

            if ( self.ACTIVE == title ) or self.HOVERED[s] then
                COL = Color(252,180,9,255)
            else
                COL = Color(122,132,137, 180)
            end

            surface.SetDrawColor(COL)
            surface.DrawOutlinedRect( 0, 0, w, h )

            if icon then
                NCS_DATAPAD.DrawImgur(w * 0.05, S_H * 0.125, w * 0.125 + (h * 0.1), w * 0.125 + (h * 0.1), icon, COL)
            end
        end

        BUTTON.DoClick = function(s)
            if self.SELECTED and self.SELECTED ~= s then
                if self.HOVERED[self.SELECTED] then
                    self.HOVERED[self.SELECTED] = false
                end

                self.SELECTED:SetTextColor(color_white)
            end

            self.SELECTED = s

            surface.PlaySound("rdv/new/activate.mp3")

            self:SelectPage(title)
        end
        BUTTON.OnCursorEntered = function(s)
            surface.PlaySound("rdv/new/slider.mp3")

            s:SetTextColor(Color(252,180,9,255))

            self.HOVERED[s] = true
        end
        BUTTON.OnCursorExited = function(s)
            if self.SELECTED == s then return end

            s:SetTextColor(color_white)

            self.HOVERED[s] = nil
        end

        self.PAGES[title] = {
            BUTTON = BUTTON,
            CALLBACK = cb,
        }
    end,
    GetPage = function(self)
        self.ACTIVE = self.ACTIVE or false

        return self.ACTIVE
    end,
    SelectPage = function(self, title)
        local TAB = self.PAGES[title]

        if TAB then
            if TAB.CALLBACK then
                TAB:CALLBACK()
            end

            self.ACTIVE = title
        end
    end,
}

vgui.Register( "RDV_DAP_SIDEBAR", PANEL )