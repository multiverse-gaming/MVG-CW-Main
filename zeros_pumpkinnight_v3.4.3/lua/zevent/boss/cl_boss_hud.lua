/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

if SERVER then return end
zpn = zpn or {}
zpn.Boss = zpn.Boss or {}

local health = 0

// This handels the hud
//zclib.Hook.Add("HUDPaint", "zpn_BossHud", function() zpn.Boss.HUD() end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

BMASKS.CreateMask("BossHealthBar", zpn.Theme.Boss.HUD.materials["bar_mask"], "noclamp smooth")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4

function zpn.Boss.HUD(Boss)
	if zclib.util.InDistance(LocalPlayer():GetPos(), Boss:GetPos(), zpn.config.Boss.AttackDistance) == false then return end
	if Boss:GetActionState() == -1 then return end

	health = Boss:GetMonsterHealth()

	if health > 0 then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

		surface.SetDrawColor(color_white)
		surface.SetMaterial(zpn.Theme.Boss.HUD.materials["bar_bg"])
		surface.DrawTexturedRect(610 * zclib.wM, 70 * zclib.hM, zclib.wM * 700, zclib.hM * 50)

		if Boss:GetActionState() == 3 then

			local shield_progress = (1 / zpn.config.Boss.HealShield) * Boss:GetShield()
			BMASKS.BeginMask("BossHealthBar")
				draw.RoundedBox(0, 610 * zclib.wM, 70 * zclib.hM, zclib.wM * Lerp(shield_progress, 0, 700), zclib.hM * 50, zpn.Theme.Design.color_shield)
			BMASKS.EndMask("BossHealthBar",610 * zclib.wM, 70 * zclib.hM, 700 * zclib.wM, 50 * zclib.hM)


			surface.SetDrawColor(color_white)
			surface.SetMaterial(zpn.Theme.Boss.HUD.materials["bar_alpha"])
			surface.DrawTexturedRect(610 * zclib.wM, 70 * zclib.hM, zclib.wM * 700, zclib.hM * 50)

			zpn.Theme.Boss.HUD.PostDraw()

			surface.SetDrawColor(color_white)
			surface.SetMaterial(zpn.Theme.Design.icon_armor)
			surface.DrawTexturedRect(550 * zclib.wM, 45 * zclib.hM, zclib.wM * 100, zclib.hM * 100)
		else
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

			local health_progress = (1 / zpn.config.Boss.Health) * health
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

			BMASKS.BeginMask("BossHealthBar")
				draw.RoundedBox(0, 610 * zclib.wM, 70 * zclib.hM, zclib.wM * Lerp(health_progress, 0, 700), zclib.hM * 50, zpn.Theme.Design.color_health)
			BMASKS.EndMask("BossHealthBar",610 * zclib.wM, 70 * zclib.hM, 700 * zclib.wM, 50 * zclib.hM)

			surface.SetDrawColor(zpn.default_colors["white02"])
			surface.SetMaterial(zpn.Theme.Boss.HUD.materials["bar_alpha"])
			surface.DrawTexturedRect(610 * zclib.wM, 70 * zclib.hM, zclib.wM * 700, zclib.hM * 50)

			zpn.Theme.Boss.HUD.PostDraw()

			surface.SetDrawColor(color_white)
			surface.SetMaterial(zpn.Theme.Boss.HUD.materials["zpn_boss_head"])
			surface.DrawTexturedRect(zpn.Theme.Boss.HUD.HeadOffset.x * zclib.wM, zpn.Theme.Boss.HUD.HeadOffset.y * zclib.hM, zclib.wM * zpn.Theme.Boss.HUD.HeadOffset.w, zclib.hM * zpn.Theme.Boss.HUD.HeadOffset.h)
		end
	end
end
