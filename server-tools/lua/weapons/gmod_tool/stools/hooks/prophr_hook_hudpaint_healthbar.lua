hook.Add("HUDPaint", "PropHr:EntHealthbar", function()
	local ply = LocalPlayer()
	local ent = ply:GetEyeTrace().Entity
	if (!ply:IsValid() or !ent:IsValid()) then return nil end
	if (ent:GetNWString("prophr_active", false) == false) then return nil end

	-- Retrive values
	local health      = ent:GetNWInt("prophr_health", nil)
	local health_left = ent:GetNWInt("prophr_health_left", nil)
	--
	local prophr_material = ent:GetNWString("prophr_prophr_material", "")
	--
	if (
		prophr_material != "" or
		ent:GetNWBool("prophr_isNPC", false)
	) then
		local position  = (ent:LocalToWorld(ent:OBBCenter())):ToScreen()
		--
		local width             = (220 --[[ Change this for healthbar-width when health is 100 % ]] * (health_left / health))
		local width_constant    = (220 --[[ Change this for healthbar-width when health is 100 % ]] * (health / health))
		local smooth_width      = width
		local height            = 20
		--
		local ent_y = ent:OBBMaxs().y
		--
		-- Draw Rounded Box
		if (ent:GetNWBool("prophr_health_bar_active", 0) == 1) then
			-- Skin health-bar
			draw.RoundedBox(
				3,
				(position.x - (width_constant / 2)),
				(position.y - (height / 2) * 8.2),
				width_constant,
				40,
				Color(000, 000, 000, 220)
			)
			-- Real health-bar
			smooth_width = Lerp(
				(RealFrameTime() * 0.05),
				smooth_width,
				width
			)
			--local healthbar_farge = {r = 250, g = 0, b = 0} --util.JSONToTable(GetConVar("prophr_healthbarcolor"):GetString())
			draw.RoundedBox(
				3,
				(position.x - (width / 2) - ((width_constant - width) / 2)),
				(position.y - (height / 2) * 8.2),
				smooth_width,
				40,
				Color(prophr_healthbarcolor.r, prophr_healthbarcolor.g, prophr_healthbarcolor.b, 200)
			)
		end
		-- Draw health-left-text
		local smooth_health_left = health_left
		local textColor = {r = 255, g = 255, b = 255}
		local function h(hp)
			return "I got fokin "..math.Round(hp, 0).." HP left"
		end
			-- Template text for retriving size
		-- Denne teikner tekst..
		surface.SetFont("healthText")
		surface.SetTextColor(textColor.r, textColor.g, textColor.b, 0)
		surface.SetTextPos(0, 0)
		surface.DrawText(h(health_left))
		--
		surface.SetTextColor(textColor.r, textColor.g, textColor.b, 255)
		surface.SetTextPos(
			(position.x - (width_constant / 2) + 11),
			(position.y - 72)
		)
		--
		local width_text, height_text = surface.GetTextSize(h(health_left))
		--
		if (
			ent:GetNWBool("prophr_health_left_text_active", 0) == 1 and
			ent:GetNWBool("prophr_health_bar_active", 0) == 1
		) then
			-- Algin top-left (health-bar On)
			smooth_health_left = Lerp(
				(RealFrameTime() * 0.05),
				smooth_health_left,
				health_left
			)
			surface.DrawText(h(smooth_health_left))
		end
		--
		if (
			ent:GetNWBool("prophr_health_left_text_active", 0) == 1 and
			ent:GetNWBool("prophr_health_bar_active", 0) == 0
		) then
			-- Algin middle (health-bar Off, Only text)
				-- Template text for retriving size
			surface.SetFont("healthText")
			surface.SetTextColor(textColor.r, textColor.g, textColor.b, 0)
			surface.SetTextPos(0, 0)
			surface.DrawText(h(health_left))
			--
			local width_text, height_text = surface.GetTextSize(h(health_left))
				-- Skin health-bar
			draw.RoundedBox(
				3,
				(position.x - (width_text / 2) - 10),
				(position.y - (height_text / 2) * 10.2 - 5),
				(width_text + 20),
				(height_text / 2) + 20,
				Color(000, 000, 000, 220)
			)
			--
			surface.SetTextPos(
				(position.x - (width_text / 2)),
				(position.y - (height_text / 2) * 10.2)
			)
			surface.SetTextColor(textColor.r, textColor.g, textColor.b, 250)
			--
			smooth_health_left = Lerp(
				(RealFrameTime() * 0.05),
				smooth_health_left,
				health_left
			)
			surface.DrawText(h(smooth_health_left))
		end
	end
end)