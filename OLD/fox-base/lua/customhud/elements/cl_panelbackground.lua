local PANEL = {}
function PANEL:Init()
    
    self:SetPos(0,0)
    self:SetSize( ScrW(), ScrH() )

    --self:SetAlpha( 245 )


    self.Panels = nil

end



function PANEL:Paint( width, height )

    if self.Panels != nil then
        for i,v in pairs (self.Panels) do
            pos_x, pos_y = v[1], v[2]
            width, height = v[3], v[4]
            
            self:drawBlur(pos_x, pos_y, width, height, 1, 5, 255 )

            surface.SetDrawColor(Color(179,179,179,227))
            surface.DrawOutlinedRect(pos_x, pos_y, width, height, 2)
        end
    end

    



end

--			drawBlur( scrw / 2 - 125, scrh - 122, 250, 42, 4, 5, 255 )


local blur = Material( "pp/blurscreen" )



function PANEL:drawBlur( x, y, w, h, layers, density, alpha )


    surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( blur )

	for i = 1, layers do
		blur:SetFloat( "$blur", ( i / layers ) * density )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		render.SetScissorRect( x, y, x + w, y + h, true )
			surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		render.SetScissorRect( 0, 0, 0, 0, false )
	end

end


vgui.Register( "Fox.Panel.Background", PANEL, "Panel" ) 
