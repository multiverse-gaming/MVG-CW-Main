--------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------
local PANEL = {}



function PANEL:Init()

    self.Points = nil

    self.Triangle_Fade = true

    self.Rectangle_Start_X = nil
    self.Rectangle_Start_Y = nil
    self.RectangleWidth = nil

    self.Triangle_Center_X = nil 
    self.Triangle_Center_Y = nil 
    self.Triangle_Center_Width = nil 


    
    self:SetSize( 100, 100 )

    --self:SetAlpha( 245 )
    self:SetPos(50,30)

end

local gradient_upward = Material( "materials/fox/CustomHUD/gradient_upward.png", "fox_fullgui_upward" )
local gradient_downward = Material( "materials/fox/CustomHUD/gradient_downward.png", "fox_fullgui_downward" )

function PANEL:Paint( width, height )

    -- USEFUL FOR DEBUGGING
	--[[
    if self.Points then
        for i,v in pairs (self.Points) do
            surface.DrawCircle(v.x, v.y, 5, Color( 0, 255, 0 ))
        end
    end
	surface.DrawCircle(self.Triangle_Center_X, self.Triangle_Center_Y, 5, Color( 255, 0, 0 ))

	]]
	-- END OF DEBUGGING





    surface.SetDrawColor(0,0,0,200)
	if self.Triangle_Fade == true then
		surface.DrawRect(self.Rectangle_Start_X, self.Rectangle_Start_Y, self.RectangleWidth, height )
		if self.FlippedHorzitonal == true and self.FlippedVerticle == true then
			surface.SetMaterial(gradient_upward)
			surface.DrawTexturedRectRotated(self.Triangle_Center_X, self.Triangle_Center_Y, self.Triangle_Center_Width, height, 180) 
		elseif self.FlippedHorzitonal == true then
			surface.SetMaterial(gradient_downward)
			surface.DrawTexturedRectRotated(self.Triangle_Center_X, self.Triangle_Center_Y, self.Triangle_Center_Width, height, 0)    
		elseif self.FlippedVerticle == true then
			surface.SetMaterial(gradient_downward)
			surface.DrawTexturedRectRotated(self.Triangle_Center_X, self.Triangle_Center_Y, self.Triangle_Center_Width, height, 180)    
		else
			surface.SetMaterial(gradient_upward)
			surface.DrawTexturedRectRotated(self.Triangle_Center_X, self.Triangle_Center_Y, self.Triangle_Center_Width, height, 0)    
		end
	else
		surface.DrawPoly(self.Points)
	end
end

if CLIENT then -- WHY IS THIS RUNNING ON THE CLIENT????
	vgui.Register( "Fox.BackgroundPanel.TriangleFade", PANEL, "Panel" ) -- https://wiki.facepunch.com/gmod/vgui.RegisterFile ?
end

--[[
	WHAT IT DOES: Allows to make module areas flipped or horizontal etc. You can use update to reset.
	-- Points is also used in format and not connected but probably should be if one gets updated the other needs to.
]]

function FoxLibs.GUI:Calculate_backgroundPanel_TriangleFade(element,verticle, horiztonal, reset) 
	local width, height = element:GetSize()

	if element.Points == nil or reset then

		local startSlopeFactor = 0.7
		element.Points = {
			{x = 0,  y = 0},
			{x = width * startSlopeFactor, y = 0},
			{x = width, y = 0},
			{x = width * startSlopeFactor, y = height},
			{x = 0, y = height},
		}
	end


	--FoxLibs.GUI.Transform:Reset(element)

	--#region Updates Coordinates

	if verticle == true then

		FoxLibs.GUI.Transform:Reflect(element, true, "V")
	end


	if horiztonal == true then
		FoxLibs.GUI.Transform:Reflect(element, true, "H")
	end

	--#endregion

	if element.FlippedVerticle and element.FlippedHorzitonal then 
		element.Rectangle_Start_X = element.Points[4].x
		element.Rectangle_Start_Y = element.Points[4].y
	elseif element.FlippedVerticle then 
		element.Rectangle_Start_X = element.Points[2].x
		element.Rectangle_Start_Y = element.Points[2].y
	elseif element.FlippedHorzitonal then
	    element.Rectangle_Start_X = element.Points[5].x
    	element.Rectangle_Start_Y = element.Points[5].y
	else
		element.Rectangle_Start_X = element.Points[1].x
		element.Rectangle_Start_Y = element.Points[1].y
	end

	element.Triangle_Center_X = element.Points[3].x + (element.Points[4].x - element.Points[3].x)/2
	element.Triangle_Center_Y = element.Points[3].y + (element.Points[4].y - element.Points[3].y)/2
	element.Triangle_Center_Width = math.abs(element.Points[4].x - element.Points[3].x)


	element.RectangleWidth = math.abs(element.Points[4].x - element.Points[1].x)



end
