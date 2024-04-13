--------------------------------------------------------------------------------------------------------------------
math.Clamp = math.Clamp 

--------------------------------------------------------------------------------------------------------------------


local PANEL = {}



function PANEL:Init()

    self:SetSize(100, 100 )
    self:SetAlpha(245)
    self:SetPos(50,30)
    
    self.Val = nil



end



function PANEL:Paint( width, height )


    surface.SetDrawColor(Color(255,255,255))
    surface.DrawLine(0.03*width, 0.5*height, 0.97*width, 0.5*height)




    -- TODO: IMPROVE THIS BY PUTTING IN MAIN.LUA
    self.triangleL = {
        { x = 0, y = height * 0.5 },
    
        { x = width * 0.03, y = (0.4*height) },
        { x = (width * 0.03), y = (0.6 * height)},
    }

    self.triangleR = {
        { x = width, y = height * 0.5 },
        { x = (width * 0.97), y = (0.6 * height)},

        { x = width * 0.97, y = (0.4*height) },

    }


    surface.SetDrawColor( 255, 255, 255)
	draw.NoTexture()
	surface.DrawPoly( self.triangleL )

    surface.SetDrawColor( 255, 255, 255)
	draw.NoTexture()
	surface.DrawPoly( self.triangleR )



end

vgui.Register( "Fox.Compass", PANEL, "Panel" )



-----------------------------------------------------------------------------------------------------

local PANEL = {}



function PANEL:Init()

    self:SetSize(100, 100 )
    self:SetAlpha(245)
    self:SetPos(50,30)
    
    self.currentDirection = nil

    self.LeftMaxDirection = nil 
    self.RightMaxDirection = nil
    self.fov = nil

    self.directions = {
        {360, "N"},
        {45, "NE"},
        {90, "E"},
        {135, "SE"},
        {180, "S"},
        {225, "SW"},
        {270, "W"},
        {315, "NW"},
    }
end


function PANEL:Paint( width, height )


    local fov = self.fov
    
    if not isnumber(fov) then return end -- Failed to get FOV.

    for i = 0,fov do

        local curInterValDirection = self.LeftMaxDirection + i

        local current = self:ReCalculateDegrees(curInterValDirection)


        local spacingBetweenEach = width/fov

        
        if (current % 3 == 0) then
            surface.SetDrawColor( 255, 255, 255)

            surface.DrawLine(spacingBetweenEach * i, 0, spacingBetweenEach * i, height * 0.2)

        end 

        
        for k, v in pairs (self.directions) do
            
            if v[1] == current then
                

                surface.SetDrawColor( 255, 255, 255)

                surface.DrawLine(spacingBetweenEach * i, 0, spacingBetweenEach * i, height * 0.4)

                draw.DrawText(v[2], "Fox.Main.Default", spacingBetweenEach * i, height * 0.4 , color_white, TEXT_ALIGN_CENTER )


            end
        end
    end
end



function PANEL:ReCalculateDegrees(degree)
	if degree > 360 then
		return degree - 360
	elseif degree <= 0 then
		return degree + 360
	else
		return degree
	end
end

vgui.Register( "Fox.Compass.DirectionPart", PANEL, "Panel" )


