local HUD = {}



function HUD.PreliminaryCheck(self)
	local gamemodeAG = engine.ActiveGamemode()

	if not CustomHUD_Fox.Loader:ComponentExists("notifications") then
		CustomHUD_Fox.Loader:AddMessage("[CLIENT] Notification component doesn't exist, therefore wont be able to do notifications", 3)
	end
	
	if gamemodeAG == "darkrp" or (DarkRP or gamemodeAG == "starwarsrp") then
		return true
	else
		CustomHUD_Fox.Loader:AddMessage("[CLIENT] Failed to load Defcon, as it isn't compatible with this gamemode.", 1) 
		return false
	end
end

function HUD.Init(self, screen_x, screen_y)

		self.C.Defcon = vgui.Create("Fox.Defcon")


		surface.CreateFont( "Fox.Main.Defcon.Default", {
			font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
			extended = false,
			size = 30,
			weight = 1000,
			blursize = 0,
			scanlines = 0,
			antialias = true,
			underline = false,
			italic = false,
			strikeout = false,
			symbol = false,
			rotary = false,
			shadow = false,
			additive = false,
			outline = false,
		} )


		self.C.BackgroundPanels.Panels[3] = {0.88 * screen_x, 0.15 * screen_y, 0.1 * screen_x, screen_y * 0.04} -- Defcon

		self.C.Defcon:SetSize(self.C.BackgroundPanels.Panels[3][3], self.C.BackgroundPanels.Panels[3][4])
		self.C.Defcon:SetPos(self.C.BackgroundPanels.Panels[3][1], self.C.BackgroundPanels.Panels[3][2])


		do -- Values for Defcon
			self.C.Defcon.Val = 5
			self.C.Defcon.MaxVal = 5
			self.C.Defcon.Colors = {}
			local ambient = 100

			self.C.Defcon.Colors[5] = Color(255,255,255, 0)
			self.C.Defcon.Colors[4] = Color(74,162,74, ambient)
			self.C.Defcon.Colors[3] = Color(232,210,47, ambient)
			self.C.Defcon.Colors[2] = Color(209,136,25, ambient)
			self.C.Defcon.Colors[1] = Color(133,23,23, ambient)

		end
end

function HUD.PostInit(self, screen_x, screen_y, isTest)

	if isbool(isTest) and isTest == false then
		hook.Run("Fox.Defcon.Load") -- Runs Defcon files for client and shared.
	end

end

function HUD.Calculate(self)
	if self.C.Defcon.Val ~= defcon_level then

		self.C.Defcon.Val = defcon_level

		if self.AddNotification ~= nil and isfunction(self.AddNotification) then -- Notification Module
			self.AddNotification(self, "Defcon " .. defcon_level, self.C.Defcon.Colors[defcon_level]) -- TODO SHOULD WE WAIT TILL VALID OBJECT OR IS THIS K?

		end
	end
end


return HUD