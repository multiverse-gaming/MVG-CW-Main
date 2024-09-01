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

local menuHasBeenOpened = false
local artilleryTimeout = CurTime() + 10


-- local loadingBarMaterial = Material("vgui/kaito/ksus/vhud_loading_bar.png")  -- Remplacez par le chemin de votre image de barre de chargement


-- Fonction appelée lorsqu'un message est reçu
net.Receive('ksus.net.fromServer.toClient.updateFireMissionStatus', function()
    -- Réinitialiser les variables pour la barre de chargement

    artilleryTimeout = CurTime() + 12

end)









local function DrawBlurRect(x, y, w, h, layers, density, alpha)
    -- Utiliser un matériau de flou
    local blur = Material("pp/blurscreen")
    surface.SetDrawColor(255, 255, 255, alpha)
    surface.SetMaterial(blur)
    
    for i = 1, layers do
        -- Ajuster la quantité de flou
        blur:SetFloat("$blur", (i / layers) * density)
        blur:Recompute()
        -- Dessiner le rectangle flou
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
    end
end

local function initSatelliteHandler()
    hook.Remove('HUDPaint','ksus.hooks.hudPaint.utils.inBetweenBlur')    
    local ply = LocalPlayer()
    local weap = ply:GetActiveWeapon()
    -- weap:Reload()

    net.Start('ksus.net.fromCLient.toServer.sendVmAnimationToPlayer',false)
    net.SendToServer()

    timer.Simple(3,function()
        net.Start('ksus.net.fromClient.toServer.launchSatelliteView',false)
        net.SendToServer()
        LocalPlayer():ScreenFade(SCREENFADE.IN,Color(0,0,0,255),6,1.2)
        
    end)

end

local function refuseConnect()
    chat.AddText(Color(255,0,0,255),"[KSUS] Connection aborted.")
    hook.Remove('HUDPaint','ksus.hooks.hudPaint.utils.inBetweenBlur')
end

local function endCommunicationWithSatellite()
    net.Start('ksus.net.fromClient.toServer.stopSatelliteView')
    net.SendToServer()
    LocalPlayer():ScreenFade(SCREENFADE.IN,Color(0,0,0,255),4,0.4)
    hook.Remove('HUDPaint','ksus.hooks.hudPaint.utils.inBetweenBlur')
end


net.Receive('ksus.net.fromServer.toClient.openMainSatelliteVGUI',function()
    menuHasBeenOpened = true
    -- Build the menu
    local mainMenuOption = mvp.meta.radialMenu:New() -- creates a menu object
    mainMenuOption:AddOption("Connect to Satellite", "Connect to Satellite²", Material("vgui/kaito/ksus/icons/connect.png"), Color(81, 255, 0), initSatelliteHandler)

    local refuseButton = mainMenuOption:AddOption("Cancel", "Get out of the menu (or right click)", Material("vgui/kaito/ksus/icons/disconnect.png"), Color(255, 0, 0), refuseConnect)

    --subMenuHolder:AddSubOption("Option Title", "Option description, can be nil", Material("path/to/icon/can_be_nil.png"), Color(255, 150, 150), function() print("clicked") end)
    --subMenuHolder:AddSubOption("Option Title 2", "Option description, can be nil 2", Material("path/to/icon/can_be_nil2.png"), Color(255, 150, 150), function() print("clicked2") end)

    -- When needed open it
    mainMenuOption:Open()

    hook.Add('HUDPaint','ksus.hooks.hudPaint.utils.inBetweenBlur',function()
        DrawBlurRect(0, 0, ScrW(), ScrH(), 7, 3, 255)
    end)

end)

local function placeholder()
    return 2
end

local function thermalsInteraction()
    net.Start('ksus.net.fromClient.toServer.thermalsBridge',false)
    net.SendToServer()
    hook.Remove('HUDPaint','ksus.hooks.hudPaint.utils.inBetweenBlur')
end

local function waypointInteraction()

    local function closeFunc()
        hook.Remove('HUDPaint','ksus.hooks.hudPaint.utils.inBetweenBlur')
    end

    -- Création de la fenêtre
    local frame = vgui.Create("DFrame")
    frame:SetTitle("Name of the Waypoint")
    frame:SetSize(300, 230) -- Augmenté pour faire de la place au texte explicatif
    frame:Center()
    frame:MakePopup()
    frame:ShowCloseButton(true) -- Cache le bouton de fermeture par défaut
    frame:SetDraggable(true) -- Permet de déplacer la fenêtre
    frame:SetBackgroundBlur(true) -- Ajoute un flou d'arrière-plan

    -- Appliquer un style minimaliste à la fenêtre
    frame.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(0, 0, 0, 200)) -- Fond noir transparent et bords arrondis
    end

    frame.OnClose = closeFunc

    -- Création de la zone d'entrée texte
    local textEntry = vgui.Create("DTextEntry", frame)
    textEntry:SetPos(25, 50)
    textEntry:SetSize(250, 25)
    textEntry:SetDrawBackground(false) -- Retire l'arrière-plan de la zone de texte
    textEntry:SetTextColor(Color(255, 255, 255)) -- Texte en blanc
    textEntry:SetFont("DermaLarge") -- Police plus grande

    -- Ajouter un contour autour de la zone de texte pour la rendre plus visible
    textEntry.Paint = function(self, w, h)
        -- Fond de la zone de texte (léger gris pour contraste)
        draw.RoundedBox(4, 0, 0, w, h, Color(60, 60, 60, 255))
        -- Texte à l'intérieur
        self:DrawTextEntryText(Color(255, 255, 255), Color(30, 130, 255), Color(255, 255, 255))
    end

    -- Création du texte explicatif
    local explanationLabel = vgui.Create("DLabel", frame)
    explanationLabel:SetPos(25, 80)
    explanationLabel:SetSize(250, 40)
    explanationLabel:SetText("\n Place the camera over the point and then click Remove if you need to delete a point.")
    explanationLabel:SetTextColor(Color(200, 200, 200)) -- Texte en gris clair
    explanationLabel:SetWrap(true) -- Permet au texte d'être sur plusieurs lignes


    -- Création du bouton "Send"
    local submitButton = vgui.Create("DButton", frame)
    submitButton:SetText("Send")
    submitButton:SetPos(100, 130)
    submitButton:SetSize(100, 30)
    submitButton:SetTextColor(Color(255, 255, 255)) -- Texte du bouton en blanc
    submitButton:SetFont("DermaLarge") -- Police plus grande
    submitButton.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(50, 50, 50, 200)) -- Fond du bouton en gris foncé
    end

    -- Quand le bouton "Send" est cliqué
    submitButton.DoClick = function()
        local textValue = textEntry:GetValue() -- Récupérer la valeur du champ texte
        -- print(textValue)

        -- Envoi de la valeur via un message net
        net.Start("ksus.net.fromClient.toServer.waypointInteraction")
        net.WriteString(textValue)
        net.SendToServer()

        frame:Close() -- Ferme la fenêtre
    end

    -- Création du bouton "Remove Point"
    local removeButton = vgui.Create("DButton", frame)
    removeButton:SetText("Remove")
    removeButton:SetPos(100, 170) -- Placé sous le bouton "Send"
    removeButton:SetSize(100, 30)
    removeButton:SetTextColor(Color(255, 255, 255)) -- Texte du bouton en blanc
    removeButton:SetFont("DermaLarge") -- Police plus grande
    removeButton.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(50, 50, 50, 200)) -- Fond du bouton en gris foncé
    end

    -- Quand le bouton "Remove Point" est cliqué
    removeButton.DoClick = function()

        -- Envoi d'une notification ou d'un message net pour la suppression
        net.Start("ksus.net.fromClient.toServer.waypointInteraction")
        net.WriteString("ksus_DWAC_K")
        net.SendToServer()

        frame:Close() -- Ferme la fenêtre
        hook.Remove('HUDPaint','ksus.hooks.hudPaint.utils.inBetweenBlur')
    end
    
end


local function handleArtilleryMenuInteractions(actionType, ammunitionType, strikeType)
    print(artilleryTimeout)

    if artilleryTimeout > CurTime() then
        chat.AddText(Color(255,0,0,255),"[KSUS] Please wait before firing again.")
        hook.Remove('HUDPaint','ksus.hooks.hudPaint.utils.inBetweenBlur')
        return 
    end

    -- Construction du tableau des données à envoyer
    local data = {
        actionType = actionType,
        ammunitionType = ammunitionType,
        strikeType = strikeType
    }

    -- Affichage pour vérifier les données (facultatif)
    -- PrintTable(data)

    -- Envoi des données via un message net
    net.Start("ksus.net.fromClient.toServer.sendFireMission")
    net.WriteString(util.TableToJSON(data)) -- Conversion du tableau en JSON pour l'envoi
    net.SendToServer()
    ksus.reloadProgress = 0
    ksus.isReloading = true
    
    hook.Remove('HUDPaint','ksus.hooks.hudPaint.utils.inBetweenBlur')
end





hook.Add('Think','ksus.hooks.think.utils.menuCheckIfPlayerRightClick_ToCloseMenu',function()

    local isRightClickDown = input.IsMouseDown(MOUSE_RIGHT)
    

    if (isRightClickDown and not wasRightClickDown) and menuHasBeenOpened then

        menuHasBeenOpened = false 
        hook.Remove('HUDPaint','ksus.hooks.hudPaint.utils.inBetweenBlur')

    end

    -- Met à jour l'état précédent du clic droit
    wasRightClickDown = isRightClickDown
end)


net.Receive('ksus.net.fromServer.toClient.openInCommandVGUI',function()
    menuHasBeenOpened = true 

    local optionMenuGui = mvp.meta.radialMenu:New()
    optionMenuGui:AddOption("Waypoint","All in the Name.", Material("vgui/kaito/ksus/icons/waypoint.png"),Color(43,99,255), waypointInteraction)
    optionMenuGui:AddOption("Thermals","Heat vision", Material("vgui/kaito/ksus/icons/eye.png"),Color(6,12,27), thermalsInteraction)

    hook.Add('HUDPaint','ksus.hooks.hudPaint.utils.inBetweenBlur',function()
        DrawBlurRect(0, 0, ScrW(), ScrH(), 7, 3, 255)
    end)

    if not (LocalPlayer():GetActiveWeapon():GetClass() == "kaito_satellite_tablet_noartillery") then
        local artilleryOption = optionMenuGui:AddOption("Mortar or Artillery","Yeet", Material("vgui/kaito/ksus/icons/artillery.png"),Color(255,8,8), placeholder)

        local artilleryMenu = artilleryOption:AddSubOption("Artillery", "Call an artillery strike", Material("orion/artillery_system/artillery_icons/base.png"), Color(255, 0, 0), function() print("clicked") end)
        local mortarMenu = artilleryOption:AddSubOption("Mortar", "Call an mortar strike", Material("orion/artillery_system/mortar_icons/base.png"), Color(255, 153, 19), function() print("clicked") end)

            -- Options du sous-menu de l'artillerie
            local function addSubOptions(parentMenu, actionType, ammunitionType)
                parentMenu:AddSubOption("Unique", "Better precision.", Material("orion/artillery_system/general_use/art_solo.png"), Color(61, 55, 48), function()
                    handleArtilleryMenuInteractions(actionType, ammunitionType, "Unique")
                end)
                parentMenu:AddSubOption("Salvo", "Salvo for democracy spreading purposes.", Material("orion/artillery_system/general_use/art_multiple.png"),  Color(61, 55, 48), function()
                    handleArtilleryMenuInteractions(actionType, ammunitionType, "Salvo")
                end)
                parentMenu:AddSubOption("Basic", "Long strikes.", Material("orion/artillery_system/general_use/art_multiple.png"),  Color(61, 55, 48), function()
                    handleArtilleryMenuInteractions(actionType, ammunitionType, "Base")
                end)
            end
        
            -- Ajout des sous-options pour l'artillerie 155mm HE
            local artillery155HEMenu = artilleryMenu:AddSubOption("Artillery 155mm HE", "'Yes, Rico, Kaboom.'", Material("orion/artillery_system/artillery_icons/he.png"), Color(252, 36, 36))
            addSubOptions(artillery155HEMenu, "Artillery", "HE")
        
            -- Ajout des sous-options pour l'artillerie 155mm Smoke
            local artillery155SmokeMenu = artilleryMenu:AddSubOption("Artillery 155mm Smoke", "Covering smoke.", Material("orion/artillery_system/artillery_icons/smoke.png"), Color(15, 187, 255))
            addSubOptions(artillery155SmokeMenu, "Artillery", "Smoke")
        
            -- Ajout des sous-options pour le mortier 88mm HE
            local mortar88HEMenu = mortarMenu:AddSubOption("Mortar 88mm HE", "'Yes, Rico, Kaboom.'", Material("orion/artillery_system/mortar_icons/he.png"), Color(243, 17, 17))
            addSubOptions(mortar88HEMenu, "Mortar", "HE")
        
            -- Ajout des sous-options pour le mortier 88mm Smoke
            local mortar88SmokeMenu = mortarMenu:AddSubOption("Mortar 88mm Smoke", "Covering smoke.", Material("orion/artillery_system/mortar_icons/smoke.png"), Color(15, 187, 255))
            addSubOptions(mortar88SmokeMenu, "Mortar", "Smoke")
        
            -- Ajout des sous-options pour le mortier 88mm Incendiaire
            local mortar88IncendiaryMenu = mortarMenu:AddSubOption("Mortar 88mm Incendiary", "Oh sweet Napalm.", Material("orion/artillery_system/mortar_icons/incendiary.png"), Color(150, 4, 4))
            addSubOptions(mortar88IncendiaryMenu, "Mortar", "Incendiary")          
    end


            

    optionMenuGui:AddOption("Disconnect","End the connection.", Material("vgui/kaito/ksus/icons/disconnect.png"),Color(255,8,8), endCommunicationWithSatellite)
    -- a ajouter, zoom, dezoom
    

    optionMenuGui:Open()
end)