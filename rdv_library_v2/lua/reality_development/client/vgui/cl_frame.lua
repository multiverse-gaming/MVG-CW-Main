local COL_1 = Color(33,33,33, 235)
local COL_2 = Color(255,255,255)
local COL_3 = Color(255,0,0)
local COL_4 = Color(36,36,36, 255)

local PANEL = {
	Init = function(self)
		self.Header = vgui.Create("Panel", self)
		self.Header:Dock(TOP)

		self.Header.Paint = function(pnl, w, h)
			draw.RoundedBoxEx(0, 0, 0, w, h, COL_1, true, true, false, false)

	        draw.SimpleText((self:GetTitle() or ""), "RD_FONTS_CORE_LABEL_LOWER", w * 0.01, h * 0.5, COL_2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end

		self.CloseButton = vgui.Create("DButton", self.Header)
		self.CloseButton:Dock(RIGHT)
		self.CloseButton:SetText("X")
	    self.CloseButton:SetFont("RD_FONTS_CORE_LABEL_LOWER")

		self.CloseButton.DoClick = function(pnl)
			self:Remove()
		end
		self.CloseButton.Paint = function(pnl, w ,h)
	        if pnl:IsHovered() then
	        	pnl:SetTextColor(COL_3)
	        else
	            pnl:SetTextColor(COL_2)
	        end
		end
	end,

	Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, COL_4)
	end
}

AccessorFunc(PANEL, "m_rd_titletext", "Title", FORCE_STRING)

vgui.Register( "RD_PANEL_MAIN", PANEL, "EditablePanel" )
vgui.Register( "EpsilonUI.Frame", PANEL, "EditablePanel"  )