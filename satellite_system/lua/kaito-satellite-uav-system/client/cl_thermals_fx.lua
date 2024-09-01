//  __   _  __     _ _          __ 
// | _| | |/ /__ _(_) |_ ___   |_ |
// | |  | ' // _` | | __/ _ \   | |
// | |  | . \ (_| | | || (_) |  | |
// | |  |_|\_\__,_|_|\__\___/   | |
// |__|                        |__|
                                                                      
/*
    Coucou.
*/

local isSatThermalActive = false 

net.Receive("ksus.net.fromServer.toClient.swithThermals", function()

    
    surface.PlaySound("kaito/ksus/others/satellite_toggle_thermals.mp3")
    local thermalMat = Material("pp/texturize/plain.png")


    local thermalBloomSettings = {
        darken = 0,
        multiply = 1,
        sizex = 4,
        sizey = 4,
        passes = 1,
        colormultiply = 1,
        red = 1,
        green = 1,
        blue = 1,
    }




    if not isSatThermalActive then
        LocalPlayer():ScreenFade(SCREENFADE.IN,Color(0,0,0,255),4,0.4)
        hook.Add("PreDrawEffects", "kaitoSatThermals", function()
            local cur_pos_player = LocalPlayer():GetNWVector("KaitoSatCameraPos", LocalPlayer():GetPos())
            TMWalls = 0
            TMRange = 550000000
            local extraGlowEnts = {}
            
            render.ClearStencil()
            
            render.SetStencilEnable(true)
            render.SetStencilWriteMask(255)
            render.SetStencilTestMask(255)
            render.SetStencilReferenceValue(1)
                
            for _, ent in ipairs(ents.GetAll()) do
                if (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) then
                    if (ent == LocalPlayer()) then
                        if (!ent:Alive()) then
                            isSatThermalActive = false
                                
                            hook.Remove("PreDrawEffects", "kaitoSatThermals")
                            hook.Remove("RenderScreenspaceEffects", "VisionThermiqueBase")
                                
                            return
                        end
                    else
                        if TMRange != 0 then
                            if (ent:GetPos():DistToSqr(cur_pos_player) > TMRange) then continue end
                        end
                            
                        render.SetStencilCompareFunction(STENCIL_ALWAYS)
                            
                        if (TMWalls == 1) then
                            render.SetStencilZFailOperation(STENCIL_REPLACE)
                        else
                            render.SetStencilZFailOperation(STENCIL_KEEP)
                        end
                            
                        render.SetStencilPassOperation(STENCIL_REPLACE)
                        render.SetStencilFailOperation(STENCIL_KEEP)
                        ent:DrawModel()
                            
                        render.SetStencilCompareFunction(STENCIL_EQUAL)
                        render.SetStencilZFailOperation(STENCIL_KEEP)
                        render.SetStencilPassOperation(STENCIL_KEEP)
                        render.SetStencilFailOperation(STENCIL_KEEP)
                            
                        cam.Start2D()
                            surface.SetDrawColor(234, 234, 234)
                            surface.DrawRect(0, 0, ScrW(), ScrH())
                        cam.End2D()
                            
                        table.insert(extraGlowEnts, ent)
                    end
                end
            end
                
            if (TMWalls == 1) then
                halo.Add(extraGlowEnts, Color(255, 255, 255), 1, 1, 1, true, true)
            else
                halo.Add(extraGlowEnts, Color(255, 255, 255), 1, 1, 1, true, false)
            end
                
            render.SetStencilCompareFunction(STENCIL_NOTEQUAL)
            render.SetStencilZFailOperation(STENCIL_KEEP)
            render.SetStencilPassOperation(STENCIL_KEEP)
            render.SetStencilFailOperation(STENCIL_KEEP)
            render.SetStencilEnable(false)

        end)

        hook.Add("RenderScreenspaceEffects", "VisionThermiqueBase", function()
            local thermalColorSettings = {
                ["$pp_colour_addr"] = 0,
                ["$pp_colour_addg"] = 0,
                ["$pp_colour_addb"] = 0,
                ["$pp_colour_brightness"] = 0.05,
                ["$pp_colour_contrast"] = 0.5,
                ["$pp_colour_colour"] = 0,
                ["$pp_colour_mulr"] = 0,
                ["$pp_colour_mulg"] = 0,
                ["$pp_colour_mulb"] = 0,
            }

            DrawColorModify(thermalColorSettings)

            local dlight = DynamicLight(LocalPlayer():EntIndex())

            if dlight then
                dlight.brightness = 1
                dlight.Size = 900
                dlight.r = 255
                dlight.g = 255
                dlight.b = 255
                dlight.Decay = 1000
                dlight.Pos = EyePos()
                dlight.DieTime = CurTime() + 0.1
            end

            DrawBloom(thermalBloomSettings.darken,thermalBloomSettings.multiply,thermalBloomSettings.sizex,thermalBloomSettings.sizey,thermalBloomSettings.passes,thermalBloomSettings.colormultiply,thermalBloomSettings.red,thermalBloomSettings.green,thermalBloomSettings.blue)
            DrawTexturize(1, thermalMat)

        end)

        isSatThermalActive = true 
    else
        hook.Remove("PreDrawEffects", "kaitoSatThermals")
        hook.Remove("RenderScreenspaceEffects", "VisionThermiqueBase")
        isSatThermalActive = false 
        LocalPlayer():ScreenFade(SCREENFADE.IN,Color(0,0,0,255),4,0.4)
    end

end)

net.Receive('ksus.net.fromServer.toCLient.forceRemoveThermals',function()
    if not isSatThermalActive then return end 
    hook.Remove("PreDrawEffects", "kaitoSatThermals")
    hook.Remove("RenderScreenspaceEffects", "VisionThermiqueBase")
    LocalPlayer():ScreenFade(SCREENFADE.IN,Color(0,0,0,255),4,0.4)
    isSatThermalActive = false 
end)