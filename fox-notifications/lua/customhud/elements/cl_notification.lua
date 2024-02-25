
local PANEL = {}



function PANEL:Init()

end


function PANEL:Paint( width, height )
    -- CLAMP FOR 1 NOW TILL IF I DO OVERHEAL STUFF
    
    local currentValueString = self.currentValueString
    local originalValue = self.originalValue -- Where to go back to.
    local colorVal = self.colorVal
    local lerpValue = self.lerpValue
    local lerp_StartAnimationTime = self.lerp_StartAnimationTime
    local currentValue = self.currentValue

    
    if width == nil and self.NotificationQueue != {} then -- This is when out of range and nil when we calling specfically.

        self.originalValue = self:GetY() 

        self:SetPos(self:GetX(), self:GetY() + 1)


        self.lerpValue = self:GetY()

        self.currentValue = self:GetY()

        self.currentValueString = self.NotificationQueue[1][1]
        self.colorVal = self.NotificationQueue[1][2]

        self.lerp_StartAnimationTime = SysTime()

        return
    end




    local animationTime = 4


    if self.lerpValue != nil and lerp_StartAnimationTime != nil then -- MAYBE ADD IN LERPING CAN ADD EXTRA POINTS??
        if (SysTime() - lerp_StartAnimationTime) >= animationTime then
            if (originalValue != lerpValue) then
                self.lerpValue = Lerp(((SysTime() - (lerp_StartAnimationTime+animationTime) )/animationTime), lerpValue, originalValue) -- SET to 0 as we want that

                if math.abs(originalValue - self.lerpValue) <= 1 then -- "Remember stops calculating after going fully"
                    self.lerp_StartAnimationTime = nil

                    local amount = 0

                    for i,v in pairs (self.NotificationQueue) do
                        if i == 1 then
                            self.NotificationQueue[1] = nil

                            continue 
                        end

                        self.NotificationQueue[i - 1] = v
                        self.NotificationQueue[i] = nil


                        amount = amount + 1
                    end


                    if amount >= 1 then
                        self:SetPos(self:GetX(), self.originalValue)

                        self:Paint(nil, nil)
                    end

                end

            end
        elseif self.lerpValue != 0 then
            self.lerpValue = Lerp(((SysTime() - lerp_StartAnimationTime)/animationTime), lerpValue, 0) -- SET to 0 as we want that

        end
    end
    self:SetY(math.floor(self.lerpValue))


    surface.SetDrawColor( colorVal ) 
    surface.DrawRect(1,1, width - 1, height - 1)

    draw.DrawText(currentValueString, "Fox.Main.Notification.Default", width * 0.5, height * 0.2 , color_white, TEXT_ALIGN_CENTER )





end

function PANEL:PaintOver(width, height)

end

vgui.Register("Fox.Notification", PANEL, "Panel" )
