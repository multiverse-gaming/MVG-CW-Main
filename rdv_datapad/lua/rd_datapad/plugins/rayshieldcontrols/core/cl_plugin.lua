local OBJ = NCS_DATAPAD.GetPlugin()

if not OBJ then return end

function OBJ:DoClick(ply, MENU, PAGE)
    PAGE.PaintOver = function() end

    local w, h = PAGE:GetSize()

    -- Create the scroll panel for displaying hackable consoles
    local SCROLL = vgui.Create("DPanel", PAGE)
    SCROLL:Dock(FILL)
    SCROLL.Paint = function(self, w, h)
        draw.SimpleText(NCS_DATAPAD.GetLang(nil, "Hackable Console Status"), "NCS_DEF_FRAME_TITLE", w * 0.5, h * 0.05, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    SCROLL:DockMargin(0, h * 0.05, w * 0.02, h * 0.02)

    -- Create a scrollable panel for the list of consoles
    local consoleList = vgui.Create("DScrollPanel", SCROLL)
    consoleList:Dock(FILL)
    consoleList:SetSize(w, h * 0.85)

    local function UpdateConsoleList()
        consoleList:Clear()  -- Clear previous console list

        local consoles = ents.FindByClass("dev_hackable_console_door")  -- Find all hackable console entities
        if #consoles == 0 then
            local noConsolesLabel = vgui.Create("DLabel", consoleList)
            noConsolesLabel:SetText("No hackable consoles found.")
            noConsolesLabel:SetFont("NCS_DEFCON_TextLabel")
            noConsolesLabel:SetTextColor(color_white)
            noConsolesLabel:Dock(TOP)
            noConsolesLabel:DockMargin(10, 10, 10, 10)
        end

        for _, console in ipairs(consoles) do
            local status
            if console:GetIsHacking() then
                if console:GetHackTimeRemaining() > 0 then
                    status = "Hacking in progress (" .. console:GetHackTimeRemaining() .. " seconds remaining)"
                else
                    status = "Hacked"
                end
            else
                status = "Not hacked"
            end

            -- Create a panel for each console
            local panel = vgui.Create("DPanel", consoleList)
            panel:SetTall(40)
            panel:Dock(TOP)
            panel:DockMargin(5, 5, 5, 5)
            panel.Paint = function(self, w, h)
                draw.RoundedBox(8, 0, 0, w, h, Color(60, 60, 60, 255))
                draw.SimpleText("Console " .. console:EntIndex() .. ": " .. status, "NCS_DEFCON_TextLabel", 10, h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end

            -- Add the Drop Rayshield button if the console is hacked
            if status == "Hacked" then
                local dropButton = vgui.Create("DButton", panel)
                dropButton:SetText("Drop Rayshield")
                dropButton:SetSize(150, 30)
                dropButton:Dock(RIGHT)
                dropButton:DockMargin(10, 5, 10, 5)
                dropButton.DoClick = function()
                    -- Send a request to the server to drop the rayshield for this console
                    net.Start("DropRayshield")
                    net.WriteEntity(console)  -- Send the console entity to the server
                    net.SendToServer()
                end
            end
        end
    end

    -- Update the console list immediately and periodically
    UpdateConsoleList()
    timer.Create("ConsoleListUpdate", 5, 0, UpdateConsoleList)

    -- Clean up the timer when the panel is removed
    function SCROLL:OnRemove()
        timer.Remove("ConsoleListUpdate")
    end
end
