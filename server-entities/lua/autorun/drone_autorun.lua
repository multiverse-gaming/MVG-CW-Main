AddCSLuaFile()

hook.Add("Move", "drone_move", function(ply, move)
	local drone = ply:GetNWEntity("drone_")
	if not drone then return end
	if not drone:IsValid() then return end
	
	if ply.drones_stopMoving then ply.drones_stopMoving = false return end
	move:SetOrigin(drone:GetPos() - Vector(0, 0, 65))
	
	return true
end)

hook.Add("KeyPress", "drone_exit", function(ply, key)
	if CLIENT then return end

	local drone = ply:GetNWEntity("drone_")

	if drone:IsValid() then
		if key == IN_USE then
			drone:SetDriver(NULL) 
		end

		if key == IN_SCORE and CurTime() > drone.wait then
			drone:SetNWBool("thirdperson", not drone:GetNWBool("thirdperson"))
			drone.wait = CurTime() + 0.1
		end

		if key == IN_ZOOM and CurTime() > drone.wait then
			--Now it is not nightvision
			--Just i am lazy to change name of this variable
			drone:SetNWBool("nightvision", not drone:GetNWBool("nightvision"))
			drone.wait = CurTime() + 0.1
		end
	end
end)

if CLIENT then
	usermessage.Hook("upd_health_drone", function(data)
		local self = data:ReadEntity()
		local hp = data:ReadString()

		if not self:IsValid() then return end

		self.armor = hp
	end)

	hook.Add("HUDPaint", "drone_drawhud", function()
		local ply = LocalPlayer()
		local drone = ply:GetNWEntity("drone_")

		if drone:IsValid() then
			if drone:GetNWBool("thirdperson") then return end

			local x, y = ScrW(), ScrH()

			surface.SetDrawColor(Color(255, 0, 0))

			local cam_up = drone.cam_up or 13
			local pos = (drone:GetPos() + drone:GetForward() * 10 - drone:GetUp() * cam_up):ToScreen()

			surface.DrawLine(pos.x - 30, pos.y - 30, pos.x - 40, pos.y - 40)
			surface.DrawLine(pos.x - 30, pos.y + 30, pos.x - 40, pos.y + 40)
			surface.DrawLine(pos.x + 30, pos.y - 30, pos.x + 40, pos.y - 40)
			surface.DrawLine(pos.x + 30, pos.y + 30, pos.x + 40, pos.y + 40)

			for i = 1, x, 50 do surface.DrawLine(i, pos.y, i + 15, pos.y) end
			surface.DrawCircle(pos.x, pos.y, 50, Color(255, 0, 0))

			surface.DrawCircle(pos.x, pos.y, 200, Color(0, 255, 0))
			surface.DrawCircle(pos.x, pos.y, 210, Color(0, 255, 0))

			draw.SimpleText(tostring(drone:GetPos()), "Trebuchet24", 50, y / 1.1, Color(255, 0, 0), TEXT_ALIGNT_LEFT)
			draw.SimpleText("ARMOR " .. drone.armor, "Trebuchet24", pos.x / 2, pos.y, Color(255, 0, 0))
			draw.SimpleText("SPEED " .. math.Round(drone:GetVelocity():Length()), "Trebuchet24", pos.x / 2, pos.y + 20, Color(255, 0, 0))
			draw.SimpleText(drone:GetUnit(), "Trebuchet24", pos.x / 2, pos.y + 40, Color(255, 0, 0))
			--Crosshair

			x, y = x / 2, y / 2

			surface.DrawLine(x - 10, y - 10, x - 20, y - 20)
			surface.DrawLine(x - 10, y + 10, x - 20, y + 20)
			surface.DrawLine(x + 10, y - 10, x + 20, y - 20)
			surface.DrawLine(x + 10, y + 10, x + 20, y + 20)
		end
	end)

	local hud = {
		CHudHealth = true,
		CHudBattery = true,
		CHudCrosshair = true
	}
	hook.Add("HUDShouldDraw", "drone_hud", function(name)
		if LocalPlayer():IsValid() and LocalPlayer():GetNWEntity("drone_"):IsValid() then
			if LocalPlayer():GetNWEntity("drone_"):GetNWBool("thirdperson") and name == "CHudCrosshair" then return true end
			if hud[name] then return false end
		end
	end)


	hook.Add("RenderScreenspaceEffects", "drone_eff", function()
		local ply = LocalPlayer()

		if ply:GetNWEntity("drone_"):IsValid() and not ply:GetNWEntity("drone_"):GetNWBool("thirdperson") then
			local tab = {
				["$pp_colour_addr"] = 0,
				["$pp_colour_addg"] = 0,
				["$pp_colour_addb"] = 0,
				["$pp_colour_brightness"] = 0,
				["$pp_colour_contrast"] = 1,
				["$pp_colour_colour"] = 1,
				["$pp_colour_mulr"] = 0,
				["$pp_colour_mulg"] = 0,
				["$pp_colour_mulb"] = 0
			}

			DrawColorModify(tab)
			DrawMaterialOverlay("effects/combine_binocoverlay.vmt", 0)
		end
	end)

	local corfov = 0
	hook.Add("CalcView", "drone_view", function(ply, pos, ang, fov)
		local drone = ply:GetNWEntity("drone_")

		ply.ShouldDisableLegs = false
		if drone:IsValid() then
			ply.ShouldDisableLegs = true --Fixes conflicts with Gmod Legs
			local view = {}

			--Set some constants
			local forward = drone.forward or 200
			local up = drone.up or 90
			local cam_up = drone.cam_up or 13

			view.origin = not drone:GetNWBool("thirdperson") and drone:GetPos() - drone:GetUp() * cam_up or util.QuickTrace(drone:GetPos() + drone:GetUp() * 20, -drone:GetAngles():Forward() * forward + drone:GetUp() * up, drone).HitPos
			view.angles = drone:GetAngles() + ang

			corfov = ply:KeyDown(IN_RELOAD) and math.Approach(corfov, 40, 1) or math.Approach(corfov, fov, 1)
			fov = corfov
			view.fov = fov

			return view
		end
	end)

	hook.Add("PlayerBindPress", "drone_keys", function(ply, bind, p)
		local drone = ply:GetNWEntity("drone_")

		if drone:IsValid() then		
			local tools = {
				"phys_swap",
				"slot",
				"invnext",
				"invprev",
				"lastinv",
				"gmod_tool",
				"gmod_toolmode"
			}
			
			for k, v in pairs(tools) do if bind:find(v) then return true end end
		end
	end)
end