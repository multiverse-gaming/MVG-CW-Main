--------------------------------------------------------------------------------------------------------------------

math.Clamp = math.Clamp 
math.Round = math.Round

--------------------------------------------------------------------------------------------------------------------


local PANEL = {}



function PANEL:Init()

    self:SetSize(100, 100 )
    self:SetAlpha(245)
    self:SetPos(50,30)
    
    self.Points = nil

    self.icon_sizeAndPos = nil
    self.bar_sizeAndPos = nil
    self.text_sizeAndPos = nil

    self.Icon = nil

    self.Val = 50
    self.MaxVal = 100

    self.CharactersUseTable = nil -- How many characters of each type allowed when providing score value.

    self.Color = nil -- for inside box??? Idek, dont think will be needed.

end

-- Mode 1 - Default, Value icon, value and bar
-- Mode 2 - Compacted, Value and Bar
-- Mode 3 - Smallest, Value Icon and value

-- https://meyerweb.com/eric/tools/color-blend/#FF7171:EBB027:1:rgbd


function PANEL:Paint( width, height )

    -- CLAMP FOR 1 NOW TILL IF I DO OVERHEAL STUFF

    local currentValue
    if isnumber(self.IDType) then
        currentValue = self.Points[4].y
    else
        currentValue = self.Val
    end

    local barData = self.bar_sizeAndPos
    local iconData = self.icon_sizeAndPos
    local textData = self.text_sizeAndPos
    local scalePercent = math.Clamp((currentValue/self.MaxVal), 0, 1)


    local color2 = self.Color2

    
    

    -- USEFUL FOR DEBUGGING
    --[[    
            for i,v in pairs (self.Points) do
        surface.DrawCircle(v.x, v.y, 5, Color( 0, 255, 0 ))
    end
    surface.DrawCircle(width, 0, 5, Color( 0, 255, 0 ))

    surface.DrawCircle(150, 0, 5, Color( 238, 255, 0))

    surface.DrawCircle(barData.startPos.x, barData.startPos.y, 5, Color( 184, 53, 59))

    surface.DrawCircle(barData.startPos.x + barData.size.x, barData.startPos.y + barData.size.y, 5, Color( 0, 255, 0 ))
    ]]



    -- Icon

    if iconData == nil then return end
    surface.SetDrawColor( self.Color ) 
    surface.SetMaterial( self.Icon )
    surface.DrawTexturedRect(iconData.startPos, iconData.startPos, iconData.size, iconData.size )

    
    -- Text

    -- TODO: ADD GOLDEN MIX BETWEEN MAIN COLOUR FOR OVERHEALING



    if isnumber(self.IDType) then -- MAYBE ADD IN LERPING CAN ADD EXTRA POINTS??
        local lerpValue = self.Lerping_Points[4].y

        local scaleLVPercent = math.Clamp((lerpValue/self.MaxVal), 0, 1)
        local scaleDiffAbs = math.abs((scalePercent - scaleLVPercent))


        draw.SimpleText( lerpValue, "Trebuchet24", textData.startPos.x, textData.startPos.y, self.Color, TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

        if currentValue > lerpValue then

            surface.SetDrawColor( Color(255,107,107) ) 
            surface.DrawRect(barData.size.x * scaleLVPercent + barData.startPos.x, barData.startPos.y, math.Round(scaleDiffAbs * barData.size.x, 0), barData.size.y )

            surface.SetDrawColor( self.Color ) -- Set the drawing color
            surface.DrawRect(barData.startPos.x, barData.startPos.y, math.Round(scaleLVPercent * barData.size.x, 0), barData.size.y )
    
        elseif currentValue < lerpValue then
            surface.SetDrawColor( self.Color ) -- Set the drawing color
            surface.DrawRect(barData.startPos.x, barData.startPos.y, (scalePercent * barData.size.x), barData.size.y )

            surface.SetDrawColor( Color(132,255,107) ) 
            surface.DrawRect(math.Round(barData.size.x * scalePercent, 0) + barData.startPos.x - 1, barData.startPos.y, math.Round(scaleDiffAbs * barData.size.x, 0) - 1, barData.size.y )
  
        else
            surface.SetDrawColor( self.Color ) -- Set the drawing color
            surface.DrawRect(barData.startPos.x, barData.startPos.y, math.Round(scalePercent * barData.size.x, 0), barData.size.y )
        end


    else

        draw.SimpleText( self.Val, "Trebuchet24", textData.startPos.x, textData.startPos.y, self.Color, TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

        surface.SetDrawColor( self.Color ) -- Set the drawing color
        surface.DrawRect(barData.startPos.x, barData.startPos.y, (scalePercent * barData.size.x), barData.size.y )
    end

    surface.SetDrawColor( self.Color ) -- Set the drawing color
    surface.DrawOutlinedRect(barData.startPos.x, barData.startPos.y, barData.size.x, barData.size.y, 1)
end


vgui.Register( "Fox.PercentagePanel.Text", PANEL, "Panel" )

--[[
	WHAT IT DOES: Allows to make module areas flipped or horizontal etc. You can use update to reset.
	-- Points is also used in format and not connected but probably should be if one gets updated the other needs to.
]]


function FoxLibs.GUI:Calculate_percentagePanel(element,forceMode, reset) 
	local width, height = element:GetSize()

    local border = 0.3 -- 0.1 = 10% so 5% on each side etc.

    if element.Points == nil or reset then
        element.Points = {
            {x = 0, y = 0},
            {x = height, y = 0},
            {x = width * 0.5, y = 0},
            {x = 0, y = 0}, -- USED FOR SPECIAL CASE OF LERPING
        }
        element.icon_sizeAndPos = {}
        element.icon_sizeAndPos.size = nil
        element.icon_sizeAndPos.startPos = nil

        element.bar_sizeAndPos = {}
        element.bar_sizeAndPos.size = {}
        element.bar_sizeAndPos.startPos = {}

        element.text_sizeAndPos = {}
        element.text_sizeAndPos.startPos = {}
	end

    -- Calculating icon_sizeAndPos


    element.icon_sizeAndPos.size = math.abs(element.Points[2].x - element.Points[1].x) * (1 - border) -- do I need to start using abs more often?
    
    element.icon_sizeAndPos.startPos = element.Points[2].x * ((border) / 2)

    -- Calculating text_sizeAndPos

    element.text_sizeAndPos.startPos = { x = ( element.Points[2].x + (element.Points[3].x - element.Points[2].x)/2), y = (height/2)}


    -- Calculating bar_sizeAndPos





    local widthOfHealthPart = math.abs(width - element.Points[3].x) 



    
    element.bar_sizeAndPos.size.x = widthOfHealthPart * 0.8

    element.bar_sizeAndPos.size.y = (height/2)

    element.bar_sizeAndPos.startPos.x = element.Points[3].x + widthOfHealthPart * 0.1
    element.bar_sizeAndPos.startPos.y = (height - element.bar_sizeAndPos.size.y)/2









	--local width, height = FoxLibs.GUI:GetSizeOfText(element.Val, "Fox.Default")

	
end


