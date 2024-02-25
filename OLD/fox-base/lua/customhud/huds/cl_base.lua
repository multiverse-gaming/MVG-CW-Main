-------------------------
local HUD = {}
-------------------------

HUD.Version = 2.0

HUD.ElementsOtherHudsCanKnow = {"C", "C.BackgroundPanels", "C.BackgroundPanels.Panels"}


function HUD.PreInitI(self, screen_x, screen_y)
    self.C = self.C or {} -- MAKE SURE DO THIS IN MULTIPLE IF USING THIS.

    self.C.BackgroundPanels = vgui.Create("Fox.Panel.Background")

    self.C.BackgroundPanels:SetMouseInputEnabled(false) -- Needed to fix pac3 as hovers over it issue.


    self.C.BackgroundPanels, self.C.BackgroundPanels.Panels = self.C.BackgroundPanels or {}, self.C.BackgroundPanels.Panels or {}


    if Debug_Fox then
        print("[CustomHUD][MAIN] Finished PreInit (Internal).")
    end

end


function HUD.Init(self, screen_x, screen_y)
    if Debug_Fox then
		print("[CustomHUD][MAIN] Finished Init.")
	end
end

function HUD.PostInitI(self, screen_x, screen_y)
    if Debug_Fox then
		print("[CustomHUD][MAIN] Finished PostInit (Internal).")
	end

end

function HUD.Calculate(self, screen_x, screen_y)

    do -- Hud painting appropiate.
        if  
            (LocalPlayer() ~= NULL and LocalPlayer():GetActiveWeapon() ~= NULL and LocalPlayer():GetActiveWeapon():GetPrintName() == "#GMOD_Camera") -- GMOD Camera
        or 
            (pace ~= nil and pace.Active == true ) -- PAC3
        or 
            self.HideHUDConditions ~= nil and isfunction(self.HideHUDConditions) and self.HideHUDConditions() == true -- CONFIG
        then
            self.HideElements(self)
        else
            self.ShowElements(self)
        end


    
    end



end

function HUD.HideElements(self)
    if self.C ~= nil and istable(self.C) then
        for i,v in pairs(self.C) do
            if not (i == "Health" or i == "Shield" or i == "Armor") then -- TODO: ALL HP TYPES.
                v:Hide()
            end
        end
    end
    
end

function HUD.ShowElements(self)
    if self.C ~= nil and istable(self.C) then
        for i,v in pairs(self.C) do
            if not (i == "Health" or i == "Shield" or i == "Armor") then -- TODO: ALL HP TYPES.
                v:Show()
            end
        end
    end
end


function HUD.CreateFonts(self)

end


-------------------------
return HUD
-------------------------