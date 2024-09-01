game.AddParticles("particles/vman_explosion.pcf")
game.AddParticles("particles/explodey.pcf")

if (SERVER) then
    resource.AddFile("resource/fonts/UbuntuMono-Regular.ttf")
    PrecacheParticleSystem("full_explode")
    PrecacheParticleSystem("dusty_explosion_rockets")
    util.AddNetworkString("kaito_net_sound_new_he")
    util.AddNetworkString("kaito_net_sound_new_se")
    util.AddNetworkString("kaito_net_sound_new_in")

    if not ConVarExists("kmortar_he_damagevalue") then
        CreateConVar("kmortar_he_damagevalue", 250, 0, "Damage of the HE shell impact")
    end
    
    if not ConVarExists("kmortar_he_splash_radius") then
        CreateConVar("kmortar_he_splash_radius", 750, 0, "Damage of the HE shell impact")
    end

    if not ConVarExists("kmortar_in_impact_damagevalue") then
        CreateConVar("kmortar_in_impact_damagevalue", 100, 0, "Damage of the IN shell impact")
    end

    timer.Simple(10, function ()
        if (istable(repairDatabase)) then
            repairDatabase["mortar"] = function (fc, mortar)
                if (mortar:Health() < mortar:GetMaxHealth()) then
                    local newHealth = mortar:Health() + 50
                    if (newHealth <= mortar:GetMaxHealth()) then
                        mortar:SetHealth(newHealth)
                    else
                        mortar:SetHealth(mortar:GetMaxHealth())
                    end
                    return true
                end
                return false
            end
        end
    end)
end

hook.Add( "AddToolMenuCategories", "kCustomMortarCategory", function()
	spawnmenu.AddToolCategory( "Options", "BetterMortarOptions", "#Better Mortar" )
end )

hook.Add( "PopulateToolMenu", "kCustomMortarClientOptionsMenu", function()
	spawnmenu.AddToolMenuOption( "Options", "BetterMortarOptions", "KCMortar_Menu", "#Client Settings", "", "", function( panel )

		panel:CheckBox("Activate Sci-Fi Overlay in Rangefinder", "draw_mortar_shud")
        panel:CheckBox("Enable distance table in Rangefinder", "draw_mortar_rangefinder_table")
        panel:CheckBox("Enable distance table in Mortar too (optional)", "draw_mortar_mortar_table")
        panel:CheckBox("Use the Binoculars overlay", "draw_mortar_rangefinder_overlay")
        panel:CheckBox("Play rangefinder sounds", "mortar_play_rangefinder_sounds")
        panel:CheckBox("Enable Shellshock (recommended)", "k_mortcl_enable_shelllshock")
	end )

    spawnmenu.AddToolMenuOption( "Options", "BetterMortarOptions", "KSMortar_Menu", "#Server Settings", "", "", function( panel )
		panel:ClearControls()
        panel:NumSlider("HE Damage Value", "kmortar_he_damagevalue", 100, 800, 0)
        panel:NumSlider("HE Splash Radius", "kmortar_he_splash_radius", 500, 1100, 0)
        panel:NumSlider("IN Impact DMG Value", "kmortar_in_impact_damagevalue", 50, 500, 0)

    end )
end )


	


hook.Add("CalcMainActivity", "SWMortarSeatAnimOverride", function (ply, vel)
    local seat = ply:GetVehicle()

    if (not IsValid(seat) or not IsValid(seat:GetParent()) or seat:GetParent():GetClass() ~= "mortar") then return end

    ply.CalcIdeal = ACT_CROUCH
    ply.CalcSeqOverride = ply:LookupSequence("pose_ducking_01")

    return ply.CalcIdeal, ply.CalcSeqOverride
end)

hook.Add("CalcView", "SWMortarCalcViewMortarSeat", function (ply, pos, angles, fov)
    local seat = LocalPlayer():GetVehicle()
    if (IsValid(seat) and IsValid(seat:GetParent()) and seat:GetParent():GetClass() == "mortar") then
        local view = {
            origin = pos + angles:Up() * 50 - angles:Forward() * 100,
            angles = angles,
            fov = fov,
            drawviewer = true
        }

        return view
    end
end)

local visorMaterial = Material("models/dolunity/starwars/visor-final.png")
hook.Add("HUDPaint", "SWMortarHUD", function ()
    local seat = LocalPlayer():GetVehicle()
    if (IsValid(seat) and IsValid(seat:GetParent()) and seat:GetParent():GetClass() == "mortar") then
        local mortar = seat:GetParent()
        local barrelId = mortar:LookupBone("Barrel")
        local barrelAngle = mortar:GetManipulateBoneAngles(barrelId) + Angle(rot,0,ang)
        barrelAngle.z = math.Clamp(barrelAngle.z, mortar.AnglingMin, mortar.AnglingMax)

        surface.SetDrawColor(255,255,255)
        surface.SetMaterial(visorMaterial)
        local height = ScrH() * 0.25
        local width = height * 1.27
        surface.DrawTexturedRect((ScrW() - width) / 2, ScrH() - height * 0.9, width, height)

        surface.SetFont("swmFont")
        surface.SetTextColor(255, 255, 255)
        local rText
        local bax = math.abs((barrelAngle.x + mortar:GetLocalAngles().y) % 360 - 360)
        if (math.Round(bax, 2) >= 0) then
            rText = "R   >  " .. math.Round(bax, 2) .. "°"
        else
            rText = "R   >  " .. math.Round(bax, 2) .. "°"
        end
        local rWidth, rHeight = surface.GetTextSize(rText)
        surface.SetTextPos((ScrW() - width) / 2 + width * 0.1, ScrH() - height + rHeight + height * 0.11)
        surface.DrawText(rText)
        local aText = "Mil >  " .. (math.abs(math.Round(barrelAngle.z, 2) - mortar.AnglingMax) * 25 + 800)
        local aWidth, aHeight = surface.GetTextSize(aText)
        surface.SetTextPos((ScrW() - width) / 2 + width * 0.1, ScrH() - height + rHeight + aHeight + height * 0.16)
        surface.DrawText(aText)
        local sText = "Mun >  " .. table.GetKeys(mortar.ShellClasses)[mortar:GetNWInt("ShellClassId")]
        local sWidth, sHeight = surface.GetTextSize(aText)
        surface.SetTextPos((ScrW() - width) / 2 + width * 0.1, ScrH() - height + rHeight + aHeight + sHeight + height * 0.21)
        surface.DrawText(sText)

        local fPosX = (ScrW() - width) / 2 + width * 0.72
        local fPosY = ScrH() - height + height * 0.23
        if (mortar:GetNWInt("NextFire") > CurTime()) then
            surface.SetDrawColor(100,0,0,255)
        else
            surface.SetDrawColor(255,0,0,255)
        end
        draw.NoTexture()
        surface.DrawPoly({
            {x = fPosX + 0,y = fPosY + 100},
            {x = fPosX + 30,y = fPosY + 0},
            {x = fPosX + 60,y = fPosY + 100}
        })

        draw.RoundedBox(0,(ScrW() - width) / 2 + width * 0.1, ScrH() - height * 0.375, width * 0.8, height * 0.02, Color(50,100,255, 50))
        draw.RoundedBox(0,(ScrW() - width) / 2 + width * 0.1, ScrH() - height * 0.375, width * 0.8 * (math.max(mortar:Health(), 0) / mortar:GetMaxHealth()), height * 0.02, Color(0,75,255))
        local shouldRTableBeDrawn = GetConVar("draw_mortar_mortar_table"):GetInt()
        local rangeTable = Material("models/dolunity/starwars/mortar_scale.png")
        if (shouldRTableBeDrawn != 0) then 
            surface.SetDrawColor(255,255,255)
            surface.SetMaterial(rangeTable)
            local height = ScrH() * 0.462
            local width = height * 0.6
            surface.DrawTexturedRect(ScrW() * 0.02, (ScrH() - height) / 2, width, height)
        end
    end
end)

if (CLIENT) then

    if not ConVarExists("draw_mortar_shud") then
        CreateClientConVar("draw_mortar_shud","1",true,false, "Activate SWRP Hud in the Rangefinder.")
    end

    if not ConVarExists("draw_mortar_rangefinder_table") then
        CreateClientConVar("draw_mortar_rangefinder_table","1",true,false, "Render table distance in rangefinder")
    end

    if not ConVarExists("draw_mortar_mortar_table") then
        CreateClientConVar("draw_mortar_mortar_table","0",true,false, "Render table distance in mortar too")
    end

    if not ConVarExists("draw_mortar_rangefinder_overlay") then
        CreateClientConVar("draw_mortar_rangefinder_overlay","1",true,false, "Use the Binoculars overlay")
    end

    if not ConVarExists("mortar_play_rangefinder_sounds") then
        CreateClientConVar("mortar_play_rangefinder_sounds","1",true,false, "Play rangefinder sounds")
    end

    if not ConVarExists("k_mortcl_enable_shelllshock") then
        CreateClientConVar("k_mortcl_enable_shelllshock", 1, true, false, "Enable or not Shellshock")
    end


    surface.CreateFont("swmFont", {
        font = "Ubuntu Mono", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 28,
        weight = 500,
        blursize = 0,
        scanlines = 0,
        antialias = true,
    })
    killicon.Add("mortar_bomb_shell", "vgui/hud/kaito/killicon/mortar", Color(28, 28, 28, 1))
    killicon.Add("mortar_fire_shell", "vgui/hud/kaito/killicon/mortar", Color(227, 5, 5, 1))
end
