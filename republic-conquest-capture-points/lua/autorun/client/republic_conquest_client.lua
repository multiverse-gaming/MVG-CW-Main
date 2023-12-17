surface.CreateFont( "RepublicConquestFont", {
    font = "geometos",
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
    outline = false
} )

net.Receive("RepublicConquest_Captured", function(len)
    RepublicConquest.Point = net.ReadTable()
    surface.PlaySound("republic_conquest/capture.wav")
end)

net.Receive("RepublicConquest_Sync", function(len)
    RepublicConquest.Point = net.ReadTable()
    RepublicConquest.Inside = net.ReadTable()
end)

hook.Add( "HUDPaint", "republic_conquest_timer_hudtext", function()
    for k, v in pairs(RepublicConquest.Point) do
        local index = k
                
        local indexcount = table.Count(RepublicConquest.Point)

        if isnumber(RepublicConquest.Point[index]) then continue end  
        if RepublicConquest.Point[index]["Active"] == false then indexcount = indexcount - 1 continue end

        // DEBUG
        -- local message1 = timer.Exists("republic_conquest_point_timer"..index)
        -- local message2 = RepublicConquest.Point[index]["Progress"]
        -- local message3 = LocalPlayer().playerinsideconquest[index]
        -- local message4 = timer.Exists("republic_conquest_point_timer_npc"..index)

        -- draw.DrawText("Timer Exists NPC: "..tostring(message4), "RepublicConquestFont", ScrW()/2, ScrH()/2 - 20, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
        -- draw.DrawText("Timer Exists Player: "..tostring(message1), "RepublicConquestFont", ScrW()/2, ScrH()/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
        -- draw.DrawText("Progress: "..tostring(message2), "RepublicConquestFont", ScrW()/2, ScrH()/2 + 20, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
        -- draw.DrawText("Inside: "..tostring(message3), "RepublicConquestFont", ScrW()/2, ScrH()/2 + 40, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)

        // Objective Previews
        local size = ScrH()/18

        // X shifts to remain centered
        local shift = 0
        local x = 0
        local x2 = 0
        local xpos = 0

        if indexcount == 1 then
            x = (ScrW()/2 - 33)
        elseif indexcount > 1 then
            x = (ScrW()/2 - 33) - (37 * (indexcount - 1))
        end

        x2 = x + (75 * (index - 1))

        if index == 1 then
            xpos = x
        elseif index > 1 then
            xpos = x2
        end

        local y = ScrH()/6

        local iconpick = RepublicConquest.Point[index]["Icon"]
        local iconlist = {
            ["blank"] = "republic_conquest/border.png",
            ["post"] = "republic_conquest/command_post.png",
            ["destroy"] = "republic_conquest/destroy.png",
            ["defend"] = "republic_conquest/hold.png",
            ["capture"] = "republic_conquest/capture.png"
        }

        local icon = iconlist[iconpick]
        
        local timers = 0

        if RepublicConquest.Point[index]["Captured"] == "Player" then
            surface.SetDrawColor(51, 93, 155, 255)
            surface.SetMaterial(Material("republic_conquest/background.png"))
            surface.DrawTexturedRect(xpos, y, size, size)
        elseif RepublicConquest.Point[index]["Captured"] == "NPC" then
            surface.SetDrawColor(155, 54, 51, 255)
            surface.SetMaterial(Material("republic_conquest/background.png"))
            surface.DrawTexturedRect(xpos, y, size, size)
        end
        if RepublicConquest.Point[index]["Captured"] == "None" then
            surface.SetDrawColor(31, 31, 31, 150)
            surface.SetMaterial(Material("republic_conquest/background.png"))
            surface.DrawTexturedRect(xpos, y, size, size)
        end

        if timer.Exists("republic_conquest_point_timer"..index) and (RepublicConquest.Point[index]["Progress"] == "Player" or RepublicConquest.Point[index]["Progress"] == "Contesting") then
            timers = timer.TimeLeft("republic_conquest_point_timer"..index)
            if timers < 0 then timers = timers * -1 end
            local progress = RepublicConquest.Point[index]["Time"] - timers
            local percent = (progress / RepublicConquest.Point[index]["Time"])
            local bar = size * percent
            surface.SetDrawColor(51, 93, 155, 255)
            surface.SetMaterial(Material("republic_conquest/background.png"))
            surface.DrawTexturedRect(xpos, y, size, bar)
        elseif timer.Exists("republic_conquest_point_timer"..index) and ((RepublicConquest.Point[index]["Progress"] == "None" and not timer.Exists("republic_conquest_point_timer_npc"..index)) or (RepublicConquest.Point[index]["Captured"] == "None" and RepublicConquest.Point[index]["Progress"] ~= "NPC")) then
            timers = timer.TimeLeft("republic_conquest_point_timer"..index)
            if timers < 0 then timers = timers * -1 end
            local progress = RepublicConquest.Point[index]["Time"] - timers
            local percent = (progress / RepublicConquest.Point[index]["Time"])
            local bar = size * percent
            surface.SetDrawColor(51, 93, 155, 255)
            surface.SetMaterial(Material("republic_conquest/background.png"))
            surface.DrawTexturedRect(xpos, y, size, bar)
        end

        if timer.Exists("republic_conquest_point_timer_npc"..index) and (RepublicConquest.Point[index]["Progress"] == "NPC" or RepublicConquest.Point[index]["Progress"] == "Contesting") then
            timers = timer.TimeLeft("republic_conquest_point_timer_npc"..index)
            if timers < 0 then timers = timers * -1 end
            local progress = RepublicConquest.Point[index]["Time"] - timers
            local percent = (progress / RepublicConquest.Point[index]["Time"])
            local bar = size * percent
            surface.SetDrawColor(155, 54, 51, 255)
            surface.SetMaterial(Material("republic_conquest/background.png"))
            surface.DrawTexturedRect(xpos, y, size, bar)
        elseif timer.Exists("republic_conquest_point_timer_npc"..index) and ((RepublicConquest.Point[index]["Progress"] == "None" and not timer.Exists("republic_conquest_point_timer"..index)) or (RepublicConquest.Point[index]["Captured"] == "None" and RepublicConquest.Point[index]["Progress"] ~= "Player")) then
            timers = timer.TimeLeft("republic_conquest_point_timer_npc"..index)
            if timers < 0 then timers = timers * -1 end
            local progress = RepublicConquest.Point[index]["Time"] - timers
            local percent = (progress / RepublicConquest.Point[index]["Time"])
            local bar = size * percent
            surface.SetDrawColor(155, 54, 51, 255)
            surface.SetMaterial(Material("republic_conquest/background.png"))
            surface.DrawTexturedRect(xpos, y, size, bar)
        end

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(Material(icon))
        surface.DrawTexturedRect(xpos, y, size, size)


        // Capturing!
        if LocalPlayer().playerinsideconquest == nil then LocalPlayer().playerinsideconquest = {} end
        if LocalPlayer().playerinsideconquest[index] == nil then LocalPlayer().playerinsideconquest[index] = false end
        if LocalPlayer().playerinsideconquest[index] == true then
            if RepublicConquest.Point[index]["Active"] == true then
                if isnumber(RepublicConquest.Point[index]) then return end
                -- if timer.Exists("republic_conquest_point_timer"..index) then
                --     local timers = timer.TimeLeft("republic_conquest_point_timer"..index)
                --     if timers < 0 then timers = timers * -1 end
                --     draw.SimpleText("Players Time Left for Point #"..index..": "..math.Round(timers), "RepublicConquestFont", ScrW()/2, ScrH()/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                -- end

                -- if timer.Exists("republic_conquest_point_timer_npc"..index) then
                --     local timers2 = timer.TimeLeft("republic_conquest_point_timer_npc"..index)
                --     if timers2 < 0 then timers2 = timers2 * -1 end
                --     draw.SimpleText("NPC Time Left for Point #"..index..": "..math.Round(timers2), "RepublicConquestFont", ScrW()/2, ScrH()/1.9, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                -- end

                if timer.Exists("republic_conquest_point_timer"..index) then
                    local timers = timer.TimeLeft("republic_conquest_point_timer"..index)
                    if timers < 0 then timers = timers * -1 end
                    local progress = RepublicConquest.Point[index]["Time"] - timers
                    local percent = (progress / RepublicConquest.Point[index]["Time"])
                    local size = ScrW()/5
                    local bar = size * percent

                    -- /// DEBUG!
                    
                    -- // Recount the players inside the point.
                    -- local playercount = table.Count(RepublicConquest.Inside[index]["Player"])

                    -- // Recount the NPCs inside the point.
                    -- local npcscount = table.Count(RepublicConquest.Inside[index]["NPC"])

                    -- local message2 = ("Players inside: "..playercount.." | NPCs inside: "..npcscount)
                    -- local message = "Point #"..index.." Progress is "..RepublicConquest.Point[index]["Progress"]
                    -- draw.SimpleText(message, "RepublicConquestFont", ScrW()/2, ScrH()/3, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    -- draw.SimpleText(message2, "RepublicConquestFont", ScrW()/2, ScrH()/3.2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            
                    surface.SetDrawColor( 0, 0, 0, 255)
                    surface.DrawRect( ScrW()/2.5, ScrH()/7, size, ScrH()/60 )
                    surface.SetDrawColor( 255, 255, 255, 255 )
                    surface.DrawRect( ScrW()/2.5, ScrH()/7, bar, ScrH()/60 )
                end
            end
        end
    end
end )

local function Draw3DZone(pos, rad, clr, detail, thick)
    local AlphaMask = Color(0, 0, 0, 0)
	render.SetStencilEnable(true)
	render.SetStencilWriteMask( 0xFF )
	render.SetStencilTestMask( 0xFF )
	render.SetStencilReferenceValue( 0 )
	render.SetStencilCompareFunction( STENCIL_ALWAYS )
	render.SetStencilPassOperation( STENCIL_KEEP )
	render.SetStencilFailOperation( STENCIL_KEEP )
	render.SetStencilZFailOperation( STENCIL_KEEP )
	render.SetColorMaterial()
	render.ClearStencil()
	--All
	render.SetStencilReferenceValue(7)
	render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
	render.DrawSphere(pos, -rad, detail, detail, AlphaMask)
	--Under
	render.SetStencilReferenceValue(7)
	render.SetStencilZFailOperation(STENCILOPERATION_DECR)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
	render.DrawSphere(pos, rad, detail, detail, AlphaMask)
	--Inner
	render.SetStencilReferenceValue(7)
	render.SetStencilZFailOperation(STENCILOPERATION_INCR)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
	render.DrawSphere(pos, -math.max(rad - thick, 0), detail, detail, AlphaMask)
	render.SetStencilZFailOperation(STENCILOPERATION_DECR)
	-- Overall
	render.SetStencilReferenceValue(7)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
	render.DrawSphere(pos, math.max(rad - thick, 0), detail, detail, AlphaMask)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)

	cam.IgnoreZ(true)
	render.SetStencilReferenceValue(7)
	render.DrawSphere(pos, rad + thick, detail, detail, clr)
	render.DrawSphere(pos, -rad, detail, detail, clr)
	cam.IgnoreZ(false)
	render.SetStencilEnable(false)
end

hook.Add( "PostDrawTranslucentRenderables", "DrawSpheresRepublicConquest", function()
    render.SetColorMaterial()

    for k,v in pairs(RepublicConquest.Point) do
        local index = k

        if not RepublicConquest:IsValid() then return end
        if RepublicConquest.Point[index] == nil then return end
        if isnumber(RepublicConquest.Point[index]) then return end

        if RepublicConquest.Point[index]["Active"] == true then
            if isnumber(RepublicConquest.Point[index]) then return end
            local pos = RepublicConquest.Point[index]["Position"]
            local radius = RepublicConquest.Point[index]["Radius"]
            local captured = RepublicConquest.Point[index]["Captured"]
            local color = Color(255,255,255,255)

            if captured == "Player" then
                color = Color( 32, 42, 170, 130)
            elseif captured == "NPC" then
                color = Color( 175, 0, 0)
            else
                color = Color( 255, 255, 255, 150)
            end

            if LocalPlayer().playerinsideconquest == nil then
                LocalPlayer().playerinsideconquest = {}
            end

            if LocalPlayer().playerinsideconquest[index] == nil then
                LocalPlayer().playerinsideconquest[index] = false
            end

            // Player's coordinates
            local ply_dist = LocalPlayer():GetPos()

            // If display is not on, don't draw, unless you're inside it.
            if RepublicConquest.Point[index]["Display"] == "0" and not LocalPlayer().playerinsideconquest[index] == true then continue end

            // If the player is further than 3000 units away, and is not inside the point, then don't draw the point.
            if ply_dist:Distance(pos) > 3000 and not LocalPlayer().playerinsideconquest[index] == true then continue end

            Draw3DZone(pos, radius, color, 50, 8)
        end
    end
end )