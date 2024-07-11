local OBJ = NCS_DATAPAD.GetPlugin()

if not OBJ then return end

function OBJ:DoClick(ply, MENU, PAGE)
    PAGE.PaintOver = function() end

    local w, h = PAGE:GetSize()

    local SCROLL = vgui.Create("DPanel", PAGE)
    SCROLL:Dock(FILL)
    SCROLL.Paint = function()
        draw.SimpleText(NCS_DATAPAD.GetLang(nil, "DAP_terminalStatus"), "NCS_DEF_FRAME_TITLE", w * 0.5, h * 0.1, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    SCROLL:DockMargin(0, h * 0.02, w * 0.02, h * 0.02)
    
    local terminalList = vgui.Create("DPanelList", SCROLL)
    terminalList:Dock(FILL)
    terminalList:SetSpacing(5)
    terminalList:EnableVerticalScrollbar(true)

    local function UpdateTerminalList(terminals)
        terminalList:Clear()
        for _, terminalData in ipairs(terminals) do
            local terminal = terminalData.entity
            local status = terminalData.broken and "Broken" or "Functioning"

            local panel = vgui.Create("DPanel")
            panel:SetTall(40)
            panel:Dock(TOP)
            panel:DockMargin(5, 5, 5, 5)
            panel.Paint = function(self, w, h)
                draw.RoundedBox(8, 0, 0, w, h, Color(60, 60, 60, 255))
                draw.SimpleText("Terminal " .. terminal:EntIndex() .. ": " .. status, "NCS_DEFCON_TextLabel", 10, h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end

            terminalList:AddItem(panel)
        end
    end

    net.Start("RequestTerminalStatus")
    net.SendToServer()

    net.Receive("SendTerminalStatus", function()
        local terminals = net.ReadTable()
        UpdateTerminalList(terminals)
    end)

    function SCROLL:OnRemove()
        net.Receive("SendTerminalStatus", function() end)
    end
end
