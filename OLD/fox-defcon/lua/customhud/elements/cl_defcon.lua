
local PANEL = {}

function PANEL:Init()

end


function PANEL:Paint( width, height )

    local currentValue = self.Val

    surface.SetDrawColor( self.Colors[currentValue] ) 
    surface.DrawRect(1,1, width - 1, height - 1)

    draw.DrawText("Defcon " .. currentValue, "Fox.Main.Defcon.Default", width * 0.5, height * 0.3 , color_white, TEXT_ALIGN_CENTER )

end

vgui.Register( "Fox.Defcon", PANEL, "Panel" )
