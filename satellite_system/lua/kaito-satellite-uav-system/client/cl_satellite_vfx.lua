//  __   _  __     _ _          __ 
// | _| | |/ /__ _(_) |_ ___   |_ |
// | |  | ' // _` | | __/ _ \   | |
// | |  | . \ (_| | | || (_) |  | |
// | |  |_|\_\__,_|_|\__\___/   | |
// |__|                        |__|
                                                                      
/*
    Coucou.
*/

if SERVER then return end 

local ply = LocalPlayer()
ksus = ksus or {}

surface.CreateFont( "ksus.aurebesh", {
	font = "Aurebesh", 
	extended = false,
	size = 20,
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


local function pRefreshSize()
    function pRespW(pixels, base)
        base = base or 2560
        return ScrW()/(base/pixels)
      end
      
    function pRespH(pixels, base)
        base = base or 1440
        return ScrH()/(base/pixels)
    end
end
pRefreshSize()

hook.Add("OnScreenSizeChanged", "KSUS::UTILS::Refresh", function()
    pRefreshSize()
end)
    

-- hook.Add('PostGamemodeLoaded','ksus.debugUtils.removeEffectsOnJoin',function()
--     timer.Simple(2,function()
--         LocalPlayer():ConCommand('pp_fz_fisheye_enable 0')
--         LocalPlayer():ConCommand('pp_filmgrain 0')
--         LocalPlayer():ConCommand('pp_scaf 0')    
--     end)

-- end)

net.Receive('ksus.net.fromServer.toClient.activateSatelliteVFXs', function()
    LocalPlayer():ConCommand('pp_fz_fisheye_enable 1')
    LocalPlayer():ConCommand('pp_fz_fisheye_bgblur 1')
    LocalPlayer():ConCommand('pp_fz_fisheye_rsize 0.48')
    LocalPlayer():ConCommand('pp_fz_fisheye_wsize 0.98')
    LocalPlayer():ConCommand('pp_fz_fisheye_x_scale 1.63')
    LocalPlayer():ConCommand('pp_fz_fisheye_y_scale 1.74')
    LocalPlayer():ConCommand('pp_filmgrain 1')
    LocalPlayer():ConCommand('pp_scaf 1')

    local fadeDuration = 0.4 -- Durée du fade-in
    local fadeAlpha = 0
    local fadeTarget = 255

    local flashDuration = 10.0
    local flashAlpha = 0
    local flashTime = 0

    ksus.reloadProgress = 1
    local reloadTime = 0
    ksus.isReloading = false
    local reloadDuration = 10
    local bombFadeAlpha = 255

    local function GetFlashAlpha()
        return math.abs(math.sin(flashTime * (2 * math.pi / flashDuration))) * 255
    end

    local drawMaterial = Material("vgui/kaito/ksus/vhud.png")
    local detectedMaterial = Material("vgui/kaito/ksus/vhud_ennemy_detected.png")
    local flashMaterial = Material("vgui/kaito/ksus/vhud_animated_circle.png")
    local loadingBarMaterial = Material("vgui/kaito/ksus/vhud_nofs_loading_bar.png")
    local readyToFireText = Material('vgui/kaito/ksus/vhud_ready_to_fire_text.png')
    local reloadingFireText = Material('vgui/kaito/ksus/vhud_reloading_text.png')
    local bombIconMaterial = Material('vgui/kaito/ksus/vhud_bomb_icon.png')

    hook.Add("HUDPaint", "ksus.hook.HUDPaint.drawSatelliteOverlay", function()
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(drawMaterial)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    
        local ply = LocalPlayer()
        local ent = ply:GetViewEntity()
    
        if IsValid(ent) and ent:GetNWBool("ksus_entityInRadiusFound_satelliteCam", false) then
            fadeTarget = 255
        else
            fadeTarget = 0
        end
    
        fadeAlpha = Lerp(FrameTime() / fadeDuration, fadeAlpha, fadeTarget)
    
        if fadeAlpha > 0 then
            surface.SetDrawColor(255, 255, 255, fadeAlpha)
            surface.SetMaterial(detectedMaterial)
            surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
        end
    
        flashTime = (flashTime + FrameTime()) % flashDuration
        flashAlpha = GetFlashAlpha()
    
        surface.SetDrawColor(255, 255, 255, flashAlpha)
        surface.SetMaterial(flashMaterial)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    
        local barWidth = pRespW(352) * ksus.reloadProgress
    
        if ksus.reloadProgress != 1 then
            render.ClearStencil()
            render.SetStencilEnable(true)
            render.SetStencilWriteMask(255)
            render.SetStencilTestMask(255)
            render.SetStencilReferenceValue(1)
            render.SetStencilFailOperation(STENCILOPERATION_KEEP)
            render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
            render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
            render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
    
            surface.SetDrawColor(0, 0, 0, 45)
            surface.DrawRect(pRespW(603), pRespH(1067), barWidth, pRespH(20))
        
            render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
            render.SetStencilPassOperation(STENCILOPERATION_KEEP)
        
            surface.SetDrawColor(color_white)
            surface.SetMaterial(loadingBarMaterial)
            surface.DrawTexturedRect(pRespW(603), pRespH(1067), pRespW(352), pRespH(20))
        
            render.SetStencilEnable(false)
        else 
            surface.SetDrawColor(color_white)
            surface.SetMaterial(loadingBarMaterial)
            surface.DrawTexturedRect(pRespW(603), pRespH(1067), pRespW(352), pRespH(20))
        end
    
        if ksus.isReloading then
            reloadTime = reloadTime + FrameTime()
            ksus.reloadProgress = Lerp(reloadTime / reloadDuration, 0, 1)
            bombFadeAlpha = 0 -- Faire disparaître l'icône de bombe pendant le rechargement
            if ksus.reloadProgress >= 1 then
                ksus.reloadProgress = 1
                ksus.isReloading = false
                reloadTime = 0
                bombFadeAlpha = 255 -- Faire réapparaître l'icône de bombe après le rechargement
            end
        end

        -- Dessiner le texte "Prêt à tirer" ou "Rechargement en cours"
        if ksus.reloadProgress == 1 then
            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(readyToFireText)
            surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
        else
            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(reloadingFireText)
            surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
        end

        -- Dessiner l'icône de bombe avec un effet de fade-in après rechargement
        if bombFadeAlpha > 0 then
            bombFadeAlpha = Lerp(FrameTime() / fadeDuration, bombFadeAlpha, 255)
            surface.SetDrawColor(255, 255, 255, bombFadeAlpha)
            surface.SetMaterial(bombIconMaterial)
            surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
        end

        surface.SetFont("ksus.aurebesh")
        surface.SetTextColor(255, 255, 255, 255)

        -- Position de la caméra
        local camPos = LocalPlayer():GetViewEntity():GetPos()
        local camPosText = string.format("Caméra: X: %.2f, Y: %.2f, Z: %.2f", camPos.x, camPos.y, camPos.z)

        -- Position du point visé
        local hitPos = LocalPlayer():GetViewEntity():GetNWVector('ksus_hitposFromSatCam', Vector(0,0,0))
        local hitPosText = string.format("Point visé: X: %.2f, Y: %.2f, Z: %.2f", hitPos.x, hitPos.y, hitPos.z)

        -- Calculer les dimensions des textes
        local camTextWidth, camTextHeight = surface.GetTextSize(camPosText)
        local hitTextWidth, hitTextHeight = surface.GetTextSize(hitPosText)

        -- Positionner et dessiner le texte de la caméra en haut
        surface.SetTextPos((ScrW() - camTextWidth) / 2, ScrH() - camTextHeight - 100)
        surface.DrawText(camPosText)

        -- Positionner et dessiner le texte du point visé en bas
        surface.SetTextPos((ScrW() - hitTextWidth) / 2, ScrH() - hitTextHeight - 50)
        surface.DrawText(hitPosText)
    end)
end)






-- self:SetNWBool("ksus_entityInRadiusFound_satelliteCam", entityFound)

net.Receive('ksus.net.fromServer.toClient.removeSatelliteVFXs',function()
    LocalPlayer():ConCommand('pp_fz_fisheye_enable 0')
    LocalPlayer():ConCommand('pp_filmgrain 0')
    LocalPlayer():ConCommand('pp_scaf 0')
    hook.Remove("HUDPaint","ksus.hook.HUDPaint.drawSatelliteOverlay")

end)

-- local debugActive = false

-- hook.Add('Think','ksus.debug.checkForEntities',function()

--     if debugActive then
--         print(ply:GetViewEntity())
--         print(ply:GetViewEntity():GetNWBool("ksus_entityInRadiusFound_satelliteCam", false))
--     end


-- end)



-- pp_fz_fisheye_enable