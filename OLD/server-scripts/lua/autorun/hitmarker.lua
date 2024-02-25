AddCSLuaFile()

CreateClientConVar("weapon_hitmarker_enable", 1, true, false, "Enable or disable the hitmarker.")
CreateClientConVar("weapon_hitmarker_sound_enable", 1, true, false, "Enable or disable the hitmarker sound.")
CreateClientConVar("weapon_hitmarker_triangle_enable", 0, true, false, "Switch the default hitmarker to a triangle hitmarker.")
-- CreateClientConVar("weapon_hitmarker_scale", 1, true, false, "Choose scale for hitmarker.")

if SERVER then

    hook.Add("EntityTakeDamage", "markPlayerForHitmarker", function(target, dmg)

        local ply = dmg:GetAttacker()

        if (target:IsNPC() or target:IsPlayer()) and ply:IsValid() and ply:IsPlayer() and not ply:GetNWBool("DoHitmarkerForPlayer", false) then

            ply:SetNWBool("DoHitmarkerForPlayer", true)

            timer.Simple(0.2, function()

                ply:SetNWBool("DoHitmarkerForPlayer", false)

            end)

        end

    end)

end

if CLIENT then

    local mat_regular = Material("vgui/tfa_hitmarker.png", "smooth mips")
    local mat_triang = Material("vgui/tfa_hitmarker_triang.png", "smooth mips")

    local timeLastHitmarkerSound = nil

    hook.Add("HUDPaint", "drawDamageHitMarkerForWeapons", function()

        if GetConVar("weapon_hitmarker_enable"):GetInt() == 1 and LocalPlayer():GetNWBool("DoHitmarkerForPlayer", false) then

            local width, height = ScrW(), ScrH()
            local sprh = math.floor((height / 1080) * 64 * 1)
            local sprh2 = sprh / 2
            local mX, mY = width / 2, height / 2

            if GetConVar("weapon_hitmarker_triangle_enable"):GetInt() == 1 then
                surface.SetDrawColor(255, 255, 255, 200)
                surface.SetMaterial(mat_triang)
                surface.DrawTexturedRect(mX - sprh2, mY - sprh2, sprh, sprh)
            else
                surface.SetDrawColor(255, 255, 255, 200)
                surface.SetMaterial(mat_regular)
                surface.DrawTexturedRect(mX - sprh2, mY - sprh2, sprh, sprh)
            end

            if timeLastHitmarkerSound == nil then
                timeLastHitmarkerSound = CurTime()
            end

            if GetConVar("weapon_hitmarker_sound_enable"):GetInt() == 1 and timeLastHitmarkerSound <= CurTime() then
                surface.PlaySound("stein/hitmarker.wav")
                timeLastHitmarkerSound = CurTime() + 0.5
            end

        end

    end)

    hook.Add("PopulateToolMenu", "Weapons Options", function()

        spawnmenu.AddToolMenuOption("Options", "Weapons", "Weapons Options", "Options", "", "", function(dform)

            dform:CheckBox("Hitmarker", "weapon_hitmarker_enable")
            dform:ControlHelp("Enable or disable the hitmarker.")

            dform:CheckBox("Hitmarker sound", "weapon_hitmarker_sound_enable")
            dform:ControlHelp("Enable or disable the hitmarker sound.")

            dform:CheckBox("Triangle hitmarker", "weapon_hitmarker_triangle_enable")
            dform:ControlHelp("Switch the default hitmarker to a triangle hitmarker.")

            --[[dform:NumSlider("Hitmarker scale", "weapon_hitmarker_scale", 0.1, 2, 1)
            dform:ControlHelp("Choose scale for hitmarker.")]]

        end)

    end)
end