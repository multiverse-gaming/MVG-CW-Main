-------------------------
local HUD = {}
-------------------------


HUD.Name = "Main"
HUD.Icon = nil
HUD.Description = "This is the main one"

HUD.Priority = 1




function HUD.AllowUse(self, user)
	if Debug_Fox then
		print("[HUD.AllowUse] Allowing user to use this.")
	end
	return true
end

-- TODO: MAYBE ADD TO CHECK NUMBER OF ARGUMENTS IF TO MUCH AND OVERRIDES SELF ITS RIP?
function HUD.PreInit(self, screen_x, screen_y)
	-- Overridable.
end

--[[
	This function is the internal Part and SHOULD NEVER BE OVERRIDED.
]]


function HUD.Init(self, screen_x, screen_y)

	-- Used to store components




	do -- Create Elements

	
		self.C.Compass = vgui.Create("Fox.Compass")

		self.C.Compass_DirectionPart = vgui.Create("Fox.Compass.DirectionPart")



		self.C.Health = vgui.Create("Fox.PercentagePanel.Text")
		self.C.Armor = vgui.Create("Fox.PercentagePanel.Text")
		self.C.Shield = vgui.Create("Fox.PercentagePanel.Text")

		self.C.HitPointsSection = vgui.Create("Panel")

		self.C.WeaponInfo = vgui.Create("Fox.WeaponInfo")





		surface.CreateFont( "Fox.Main.Default", {
			font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
			extended = false,
			size = 22,
			weight = 500,
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








	end






	local text
	local width, height

	do
		surface.SetFont( "Fox.Main.Default" )

		text = "Hello World"
		width, height = surface.GetTextSize( text )
	end
	


	self.C.BackgroundPanels.Panels[1] = {0.02 * screen_x, screen_y - 71 - screen_y * 0.02, 0.2 * screen_x, screen_y * 0.04} -- Bottom Left



	do
		self.C.HitPointsSection:SetPos(self.C.BackgroundPanels.Panels[1][1], self.C.BackgroundPanels.Panels[1][2])
		self.C.HitPointsSection:SetSize(self.C.BackgroundPanels.Panels[1][3], self.C.BackgroundPanels.Panels[1][4])	
	end

	self.C.BackgroundPanels.Panels[2] = {0.78 * screen_x, screen_y - 71 - screen_y * 0.02, 0.2 * screen_x, screen_y * 0.04} -- Bottom Right

	do
		self.C.WeaponInfo:SetPos(self.C.BackgroundPanels.Panels[2][1], self.C.BackgroundPanels.Panels[2][2])
		self.C.WeaponInfo:SetSize(self.C.BackgroundPanels.Panels[2][3], self.C.BackgroundPanels.Panels[2][4])
	end



	do

		
		do
			local w, h = self.C.BackgroundPanels.Panels[1][3], self.C.BackgroundPanels.Panels[1][4]


			self.C.Health:SetSize(w * 0.5, h)
			self.C.Health:SetPos(0, 0)
			self.C.Health:SetParent(self.C.HitPointsSection)

	
			self.C.Armor:SetSize(w * 0.5,h)
			self.C.Armor:SetPos( w*0.5, 0)
			self.C.Armor:SetParent(self.C.HitPointsSection)

			self.C.Shield:SetSize(w * 0.5,h)
			self.C.Shield:SetPos( w, 0)
			self.C.Shield:SetParent(self.C.HitPointsSection)

			


		end


		self.C.Compass_DirectionPart:SetParent(self.C.Compass)

		do
			self.C.Compass.PaintOver = function(self, width, height)

				local child = self:GetChild(0)

				draw.DrawText(child.currentDirection, "Fox.Main.Default", width * 0.5, height * 0.1 , color_white, TEXT_ALIGN_CENTER )
			end
		end
	

		do
			local w, h = 0.3 * screen_x,71
			local pos_x, pos_y = screen_x * 0.35, screen_y * 0.02

			-- I switched these around.. doesn't matter much, but they aint what there name says

		
			self.C.Compass:SetSize(w * 0.7,h)
			self.C.Compass:SetPos(pos_x + w * 0.15,pos_y)

		end

		do
			local w, h = self.C.Compass:GetSize()

			self.C.Compass_DirectionPart:SetPos(w * 0.03,h/2)
			self.C.Compass_DirectionPart:SetSize(w * 0.94,h/2)

		end




			



	end

	do
		local currentDirection = math.Round(360 - (LocalPlayer():GetAngles().y % 360))
		self.C.Compass_DirectionPart.currentDirection = currentDirection
		local fovSide = (LocalPlayer():GetFOV()/2)
		self.C.Compass_DirectionPart.LeftMaxDirection = self.ReCalculateDegrees(currentDirection - fovSide)
		self.C.Compass_DirectionPart.RightMaxDirection = self.ReCalculateDegrees(currentDirection + fovSide)
		
	end

	do -- Values for Health
		self.C.Health.Val = LocalPlayer():Health()
		self.C.Health.MaxVal = LocalPlayer():GetMaxHealth()
		self.C.Health.Color = Color(255,255,255)
		self.C.Health.Color2 = Color(255,172,172)
		self.C.Health.Icon = Material( "materials/fox/CustomHUD/icons/health.png")
	end


	do -- Values for Armour
		self.C.Armor.Val = LocalPlayer():Armor()
		self.C.Armor.MaxVal = LocalPlayer():GetMaxArmor()
		self.C.Armor.Color = Color(255,255,255)
		self.C.Armor.Color2 = Color(131,185,255)
		self.C.Armor.Icon = Material( "materials/fox/CustomHUD/icons/armor.png")
	end

	
	do -- Values for Shield
		self.C.Shield.Val = 0
		self.C.Shield.MaxVal = 1
		self.C.Shield.Color = Color(255,255,255)
		self.C.Shield.Color2 = Color(131,185,255)
		self.C.Shield.Icon = Material( "materials/fox/CustomHUD/icons/shield.png")
	end






end


--[[
	Use this to change any values before calculations happen to re-arrange stuff.
]]
function HUD.PostInitI(self, screen_x, screen_y)

	FoxLibs.GUI:Calculate_percentagePanel(self.C.Health) 
	FoxLibs.GUI:Calculate_percentagePanel(self.C.Armor) 
	FoxLibs.GUI:Calculate_percentagePanel(self.C.Shield) 

	FoxLibs.GUI.Lerping:Init(self.C.Health, 2, 5, 5, {4}, {4})
	FoxLibs.GUI.Lerping:Init(self.C.Armor, 2, 5, 5, {4}, {4})
	FoxLibs.GUI.Lerping:Init(self.C.Shield, 2, 5, 5, {4}, {4}) -- TODO: NEED TO MAKE IT BE RE-RUN IN POSTINIT IF WANT TO CHANGE THEMSELF.

	self.C.Health.Points[4].y = LocalPlayer():Health()
	self.C.Armor.Points[4].y = LocalPlayer():Armor()
	self.C.Shield.Points[4].y = LocalPlayer():GetNWInt( "Shield_HP" )






	self.Spawn(self, LocalPlayer()) -- Calls once hud is loaded.



end

function HUD.PostInit(self, screen_x, screen_y)
	-- Overridable
end




-- Can reduce calculations
function HUD.Calculate(self)
	
    FoxLibs.GUI.Lerping:UpdatePointPosition(self.C.Health, 4, "y", LocalPlayer():Health())
	FoxLibs.GUI.Lerping:UpdatePointPosition(self.C.Armor, 4, "y", LocalPlayer():Armor())
    FoxLibs.GUI.Lerping:UpdatePointPosition(self.C.Shield, 4, "y", LocalPlayer():GetNWInt( "Shield_HP" ) )

	 

	FoxLibs.GUI.Lerping:LerpProcessFunction(self.C.Armor)
	FoxLibs.GUI.Lerping:LerpProcessFunction(self.C.Shield)
	FoxLibs.GUI.Lerping:LerpProcessFunction(self.C.Health)



	do -- Make Ammo go at top still or something remember stein's hud.
		if (self.C.Compass_DirectionPart):IsValid() then
			local currentDirection = math.Round(360 - (LocalPlayer():GetAngles().y % 360))
			if currentDirection == 360 then
				currentDirection = 0
			end
			self.C.Compass_DirectionPart.currentDirection = currentDirection
	
			local fovSide = math.Round((LocalPlayer():GetFOV()/2),0)
			self.C.Compass_DirectionPart.fov = fovSide * 2
			self.C.Compass_DirectionPart.LeftMaxDirection = self.ReCalculateDegrees(currentDirection - fovSide)
			self.C.Compass_DirectionPart.RightMaxDirection = self.ReCalculateDegrees(currentDirection + fovSide)
		end
	end



end

function HUD.Spawn(self, ply)

	self.Calculate_HPBars(self, ply)

end


function HUD.Calculate_HPBars(self, ply)
	
	local playerMaxShield


	if IsValid(HPType_Shield) and HpType_Shield.Whitelist ~= nil then 
		local succ, err = pcall(function() playerMaxShield = HpType_Shield.Whitelist[ply:Team()][2] end)

		if succ == false then
			playerMaxShield = nil
		end
		
	else
		playerMaxShield = nil
	end


	
	local playerMaxHealth = ply:GetMaxHealth()
	local playerMaxArmor = ply:GetMaxArmor()

	local values = {}
	values["Health"] = playerMaxHealth or 0
	values["Armor"] = playerMaxArmor or 0
	values["Shield"] = playerMaxShield or 0

	local countVTypes = 0


	for i,v in pairs (values) do
		if v ~= nil and v ~= 0 then
			countVTypes = countVTypes + 1

			self.C[i].Val = v
			self.C[i].MaxVal = v
			self.C[i].lerpValue = v
			self.C[i]:Show()
		else
			self.C[i]:Hide()
		end
	end


	local screen_x, screen_y = ScrW(), ScrH()

	self.C.BackgroundPanels.Panels[1] = {0.02 * screen_x, screen_y - 71 - screen_y * 0.02, (0.1 * screen_x) * countVTypes, screen_y * 0.04} -- Bottom Left

	local w, h = self.C.HitPointsSection:GetSize()


	local interval = 0
	for i,v in pairs (values) do
		if v ~= nil and v ~= 0 then
			self.C[i]:SetSize(w * (1/countVTypes), h)
			self.C[i]:SetPos((w * (interval/countVTypes)))

			interval = 1 + interval

		end
	end
	
end

function HUD.ReCalculateDegrees(degree)
	if degree > 360 then
		return degree - 360
	elseif degree <= 0 then
		return degree + 360
	else
		return degree
	end
end






-----------------------------
return HUD
-----------------------------
