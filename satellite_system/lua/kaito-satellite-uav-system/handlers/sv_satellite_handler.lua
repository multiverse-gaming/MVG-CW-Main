//  __   _  __     _ _          __ 
// | _| | |/ /__ _(_) |_ ___   |_ |
// | |  | ' // _` | | __/ _ \   | |
// | |  | . \ (_| | | || (_) |  | |
// | |  |_|\_\__,_|_|\__\___/   | |
// |__|                        |__|
                                                                      
/*
    Coucou.
*/

if CLIENT then return end 

local speedsTable = speedsTable or {} 

local function playerSpeedManager(ply) -- 6 to disable move
    if not speedsTable[ply:EntIndex()] then
        speedsTable[ply:EntIndex()] = { ply:GetWalkSpeed(), ply:GetRunSpeed(), ply:GetDuckSpeed() }
        timer.Simple(0.2,function()
            ply:SetWalkSpeed(6)
            ply:SetRunSpeed(6)
            ply:SetDuckSpeed(6)       
        end)

    else
        
        ply:SetWalkSpeed(speedsTable[ply:EntIndex()][1] or 160)
        ply:SetRunSpeed(speedsTable[ply:EntIndex()][2] or 120)
        ply:SetDuckSpeed(speedsTable[ply:EntIndex()][3] or 40)
        timer.Simple(0.2,function()
            table.remove(speedsTable,ply:EntIndex())
        end)
        
    end

end

hook.Add('DoPlayerDeath','kees.hooks.doPlayerDeath.handlePlayerDeath.bugPrevention',function(ply,attacker,dmgInfo)
    if not IsValid(ply) then return end 
    local cameraEnt = ply:GetNWEntity('ksus_plySatelCamera',NULL)
    if IsValid(cameraEnt) then
        ply:SetViewEntity(ply)
        playerSpeedManager(ply)
        hook.Remove('Think',"ksus_controlThread_satellite_"..cameraEnt:EntIndex()..ply:EntIndex())
        cameraEnt:SetVelocity( Vector(0,0,-100) )
        cameraEnt:StopLoopingSound(cameraEnt:GetNWInt('ksus_satelliteLoopingSound',-1))    
        cameraEnt:Remove()
        ply:SetNWEntity("ksus_plySatelCamera",NULL)
        ply:SetNWBool("ksus_plySatelCameraIsActive",false)
        net.Start('ksus.net.fromServer.toCLient.forceRemoveThermals',false)
        net.Send(ply)
        net.Start('ksus.net.fromServer.toClient.removeSatelliteVFXs',false)
        net.Send(ply)
        ply:SendLua('surface.PlaySound("kaito/ksus/others/satellite_shutting_down.mp3")')
        ply:SendLua('surface.PlaySound("kaito/ksus/others/satellite_stop.mp3")')
        ply:SetFOV(90)

        timer.Simple(2,function()
            net.Start('ksus.net.fromServer.toCLient.forceRemoveThermals',false)
            net.Send(ply)
            net.Start('ksus.net.fromServer.toClient.removeSatelliteVFXs',false)
            net.Send(ply)
        end)
        
    end    
end)





net.Receive('ksus.net.fromClient.toServer.launchSatelliteView',function(len,ply)

    local playerUsesBaseTablet = ksusUtils.securityNetInjectionWeapCheck(ply,"kaito_satellite_tablet")
    -- print(playerUsesBaseTablet)
    local playerUsesNoArtTablet = ksusUtils.securityNetInjectionWeapCheck(ply,"kaito_satellite_tablet_noartillery")
    -- print(playerUsesNoArtTablet)

    if (playerUsesBaseTablet == false) and (playerUsesNoArtTablet == false) then -- check the functions file in autorun to see how it works, simple bool check
        ply:SendLua("chat.AddText(Color(255,0,0,255),'[KSUS] Error has occured, please ask admins to look into the console.')")
        timer.Create("ksus_warning_"..tostring(CurTime()),0.4,4,function()
            MsgC(Color(255,0,0,255),'[KSUS] INJECTION ATTEMPT OR BUG WITH PLAYER/WEAPON TYPE ON '.. ply:Nick()..'\n')
        end)

        return 
    end

    net.Start('ksus.net.fromServer.toClient.activateSatelliteVFXs',false)
    net.Send(ply)



    if IsValid(ply:GetNWEntity("ksus_plySatelCamera",NULL)) then
        ply:SendLua("chat.AddText(Color(255,0,0,255),'[KSUS] Error has occured, you already have a camera.')")
    end
    local cameraEnt = ents.Create('ksus_main_camera')
    cameraEnt:SetPos(ply:GetPos() + Vector(0,0,4500))
    cameraEnt:SetAngles(Angle(90,0,0))
    cameraEnt:Spawn()
    cameraEnt:Activate()

    timer.Create('ksus_startThread_satellite_'..cameraEnt:EntIndex(),0.2,20,function()
        if not IsValid(ply) or not IsValid(cameraEnt) then return end 
        cameraEnt:SetVelocity( Vector(0,0,100) )
    end)
    
    
    ply:SetNWEntity("ksus_plySatelCamera",cameraEnt)
    ply:SetNWBool("ksus_plySatelCameraIsActive",true)
    ply:SetViewEntity(cameraEnt)
    playerSpeedManager(ply)

    cameraEnt:SetNWEntity("ksus_satelliteCamera_linkedPlayer",ply)

    hook.Add('Think',"ksus_controlThread_satellite_"..cameraEnt:EntIndex()..ply:EntIndex(),function()
        if not IsValid(cameraEnt) or not IsValid(ply) then
            ply:SetNWEntity("ksus_plySatelCamera",NULL)
            ply:SetNWBool("ksus_plySatelCameraIsActive",false)
            return
        end
        cameraEnt:CameraControl(ply)
    end)
    -- cameraEnt:EmitSound('kaito/ksus/others/satellite_start.mp3',70,100)
    ply:SendLua('surface.PlaySound("kaito/ksus/others/satellite_start.mp3")')
    local sndId = cameraEnt:StartLoopingSound('kaito/ksus/background_sounds/satellite_01.mp3')

    timer.Simple(1.75,function()
        ply:SendLua('surface.PlaySound("kaito/ksus/background_sounds/satellite_01.mp3")')
        ply:SendLua('surface.PlaySound("kaito/ksus/background_sounds/satellite_02.mp3")')   
    end)


    cameraEnt:SetNWInt("ksus_satelliteLoopingSound",sndId)


end)

net.Receive('ksus.net.fromClient.toServer.thermalsBridge',function(len,ply)
    net.Start('ksus.net.fromServer.toClient.swithThermals',false)
    net.Send(ply)
    local cameraEnt = ply:GetNWEntity("ksus_plySatelCamera",NULL)
    if IsValid(cameraEnt) then
        cameraEnt:EmitSound("kaito/ksus/others/satellite_toggle_thermals.mp3")
    end
    
end)

net.Receive('ksus.net.fromClient.toServer.stopSatelliteView',function(len,ply)
    
    -- cameraEnt:EmitSound('kaito/ksus/others/satellite_shutting_down.mp3')
    if not IsValid(ply) then return end 
    local cameraEnt = ply:GetNWEntity('ksus_plySatelCamera',NULL)
    if IsValid(cameraEnt) then
        ply:SetViewEntity(ply)
        playerSpeedManager(ply)
        hook.Remove('Think',"ksus_controlThread_satellite_"..cameraEnt:EntIndex()..ply:EntIndex())
        cameraEnt:SetVelocity( Vector(0,0,-100) )
        cameraEnt:StopLoopingSound(cameraEnt:GetNWInt('ksus_satelliteLoopingSound',-1))    
        cameraEnt:Remove()
        ply:SetNWEntity("ksus_plySatelCamera",NULL)
        ply:SetNWBool("ksus_plySatelCameraIsActive",false)
        net.Start('ksus.net.fromServer.toCLient.forceRemoveThermals',false)
        net.Send(ply)
        net.Start('ksus.net.fromServer.toClient.removeSatelliteVFXs',false)
        net.Send(ply)
        ply:SendLua('surface.PlaySound("kaito/ksus/others/satellite_shutting_down.mp3")')
        ply:SendLua('surface.PlaySound("kaito/ksus/others/satellite_stop.mp3")')
        ply:SetFOV(90)
        
    end
end)

net.Receive('ksus.net.fromClient.toServer.waypointInteraction',function(len,ply)
    
    local wpName = net.ReadString()
    local cameraEnt = ply:GetNWEntity("ksus_plySatelCamera",NULL)
    -- print('Net Waypoit called')
    if IsValid(cameraEnt) then
        -- print('Passed')
        if wpName == "ksus_DWAC_K" then
            cameraEnt:RemoveWaypoint(ply)
        else
            cameraEnt:SpawnWaypoint(ply,wpName)
        end
            
    end
end)

local function SpawnShellsAtRadius(origin, radius, n, d, sType)
    --print('SpawnShellAtRadius() called with : ')
    --print(origin,radius,n,d,sType)
    local isDistPlayed = GetConVar("kplayartdistantsound"):GetInt()
    local getTBI = GetConVar("kshellwaitingtime"):GetInt()
    if n <= 0 then
        return -- Ne rien faire si le nombre de shells est inférieur ou égal à zéro
    end
    local delay = d -- Délai en secondes entre chaque spawn
    local shellName = sType
    isDistPlayed = GetConVar("kplayartdistantsound"):GetInt()
    if string.find(shellName, 'mortar') and isDistPlayed >= 1 then
        for i = 1, n do
            timer.Simple(delay * i, function()
                net.Start("kaito_net_sound_new_mortar_basefire")
                net.WriteString("placeholder")
                net.Broadcast()
            end)
        end
        timer.Simple(getTBI - 5, function()
            for i = 1, n do
                local angle = math.random(0, 360) -- Angle aléatoire
                local radianAngle = math.rad(angle) -- Convertir l'angle en radians
                local offset = math.random(100, 800)
                -- Calculer la position en fonction de l'angle et du rayon
                local x = origin.x + (math.cos(radianAngle) * (radius - offset))
                local y = origin.y + (math.sin(radianAngle) * (radius - offset))

                -- Créer un vecteur pour la position potentielle de l'entité
                local spawnPos = Vector(x, y, origin.z) + Vector(0,0,20)

                -- Utiliser util.TraceHull pour vérifier la géométrie du sol
                local trace = util.TraceHull({
                    start = spawnPos,
                    endpos = spawnPos - Vector(0, 0, 1000), -- Descendre de 1000 unités pour vérifier la géométrie du sol
                    mins = Vector(-16, -16, 0), -- Ajustez ces valeurs selon les dimensions de votre entité
                    maxs = Vector(16, 16, 72), -- Ajustez ces valeurs selon les dimensions de votre entité
                    filter = function(ent)
                        if ent:GetClass() == "worldspawn" then
                            return true
                        end
                    end
                })

                if trace.Hit then
                    -- L'entité a touché le sol, nous pouvons créer l'entité à cette position
                    timer.Simple(delay * i, function()
                        local shell = ents.Create(shellName)
                        shell:SetPos(trace.HitPos)
                        shell:Spawn()
                    end)
                end
            end
        end)
        return
    end

    for i = 1, n do
        local angle = math.random(0, 360) -- Angle aléatoire
        local radianAngle = math.rad(angle) -- Convertir l'angle en radians
        local offset = math.random(100, 800)
        -- Calculer la position en fonction de l'angle et du rayon
        local x = origin.x + (math.cos(radianAngle) * (radius - offset))
        local y = origin.y + (math.sin(radianAngle) * (radius - offset))

        -- Créer un vecteur pour la position potentielle de l'entité
        local spawnPos = Vector(x, y, origin.z)

        -- Utiliser util.TraceHull pour vérifier la géométrie du sol
        local trace = util.TraceHull({
            start = spawnPos,
            endpos = spawnPos - Vector(0, 0, 1000), -- Descendre de 1000 unités pour vérifier la géométrie du sol
            mins = Vector(-16, -16, 0), -- Ajustez ces valeurs selon les dimensions de votre entité
            maxs = Vector(16, 16, 72), -- Ajustez ces valeurs selon les dimensions de votre entité
            filter = function(ent)
                if ent:GetClass() == "worldspawn" then
                    return true
                end
            end
        })

        if trace.Hit then
            -- L'entité a touché le sol, nous pouvons créer l'entité à cette position
            timer.Simple(delay * i, function()
                local shell = ents.Create(shellName)
                shell:SetPos(trace.HitPos)
                shell:Spawn()
            end)
        end
    end
end

net.Receive("ksus.net.fromClient.toServer.sendFireMission", function(len, ply)

    local jsonTable = net.ReadString()
    local toTable = util.JSONToTable(jsonTable)

    local actionType = toTable["actionType"]
    local ammoType = toTable["ammunitionType"]
    local strikeType = toTable["strikeType"]

    local playerHasValidWeap = ksusUtils.securityNetInjectionWeapCheck(ply,"kaito_satellite_tablet")

    if not playerHasValidWeap then
        ply:SendLua("chat.AddText(Color(255,0,0,255),'[KSUS] Error has occured, please ask admins to look into the console.')")
        timer.Create("ksus_warning_" .. tostring(CurTime()), 0.4, 4, function()
            MsgC(Color(255, 0, 0, 255), '[KSUS] INJECTION ATTEMPT OR BUG WITH PLAYER/WEAPON TYPE ON ' .. ply:Nick() .. '\n')
            print('269')
        end)
        return 
    end

    net.Start('ksus.net.fromServer.toClient.updateFireMissionStatus',false)
    net.Send(ply)

    local fireTable = {
        ["Artillery"] = {
            ["HE"] = "artillery_he",
            ["Smoke"] = "artillery_se",
        },
        ["Mortar"] = {
            ["HE"] = "mortar_bomb_shell",
            ["Smoke"] = "mortar_smoke_shell",
            ["Incendiary"] = "mortar_fire_shell",
        }
    }

    local baseFireType = actionType
    local baseMunitionType = ammoType
    local fireType = strikeType
    local entToUse = fireTable[baseFireType][baseMunitionType]
    local timeOffset = 0

    -- Récupérer l'entité caméra attachée au joueur
    local cameraEnt = ply:GetNWEntity("ksus_plySatelCamera", NULL)
    local aimPos = Vector(0,0,0)

    if IsValid(cameraEnt) then
        -- Effectuer un trace à partir de la caméra pour obtenir la position visée
        local trace = util.TraceLine({
            start = cameraEnt:GetPos(),
            endpos = cameraEnt:GetPos() + cameraEnt:GetAngles():Forward() * 10000, -- Trace en avant de la caméra
            filter = cameraEnt
        })
        aimPos = trace.HitPos
    else
        -- Si la caméra n'est pas valide, utiliser la vue du joueur (fallback)
        aimPos = ply:GetEyeTrace().HitPos
    end
    local cameraEnt = ply:GetNWEntity("ksus_plySatelCamera",NULL)
    -- print(aimPos)

    if IsValid(cameraEnt) then
        aimPos = cameraEnt:GetNWVector('ksus_hitposFromSatCam',Vector(0,0,0))
        -- print('isValid : ')
        -- print(aimPos)
    end

    
    

    aimPos.z = aimPos.z + 10 -- Ajuster la position en hauteur

    if fireType == "Unique" then
        local ent = ents.Create(entToUse)
        if (string.find(entToUse, "mortar")) then
            net.Start("kaito_net_sound_new_mortar_basefire")
                net.WriteString("placeholder")
            net.Broadcast()
            timer.Simple((GetConVar("kshellwaitingtime"):GetInt() or 5) - 5, function()
                if IsValid(ent) then
                    ent:SetPos(aimPos)
                    ent:Spawn()
                end        
            end)
        else
            if IsValid(ent) then
                ent:SetPos(aimPos)
                ent:Spawn()         
            end
        end


    elseif fireType == "Base" then
        SpawnShellsAtRadius(aimPos, 2000, GetConVar("k_art_radialstrike_value"):GetInt(), 0.85, entToUse)

    elseif fireType == "Salvo" then
        SpawnShellsAtRadius(aimPos, 1500, GetConVar("k_art_volleystrike_value"):GetInt(), 0.15, entToUse)
    end




end)



