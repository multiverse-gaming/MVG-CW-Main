local OBJ = NCS_DATAPAD.GetPlugin()

local COL_1 = Color(255,255,255)
local function SendNotification(ply, msg)
    local COL = RDV.COMMUNICATIONS.CFG.Prefix.Color
    local PRE = RDV.COMMUNICATIONS.CFG.Prefix.Appension
	
    RDV.LIBRARY.AddText(ply, COL, "["..PRE.."] ", Color(255,255,255), msg)
end
function OBJ:DoClick(player, frame, PAGE)
    PAGE.PaintOver = function() end

    local w, h = PAGE:GetSize()

    local SCROLL = vgui.Create("DScrollPanel", PAGE)
    SCROLL:GetVBar():SetWide(0)
    SCROLL:Dock(FILL)
    SCROLL:DockMargin(w * 0.01, h * 0.01, w * 0.01, h * 0.01)
    SCROLL.Think = function(self)
        local BUT = vgui.Create("PIXEL.TextButton", self)
            BUT:Dock(TOP)
            if MUTED then
                BUT:SetText("Unmute")
                BUT.DoClick = function()
                    net.Start("RDV.COMMUNICATIONS.Mute")
                    net.SendToServer()
                    MUTED = !MUTED
                    local MUTED = MUTED
                    local TEXT = MUTED and RDV.LIBRARY.GetLang(nil, "COMMS_unmuteLabel") or RDV.LIBRARY.GetLang(nil, "COMMS_muteLabel")

                    if MUTED then
                        SendNotification(LocalPlayer(), RDV.LIBRARY.GetLang(nil, "COMMS_mutedText"))
                    else
                        SendNotification(LocalPlayer(), RDV.LIBRARY.GetLang(nil, "COMMS_unmutedText"))
                    end

                    surface.PlaySound("reality_development/ui/ui_accept.ogg")
                    timer.Simple(0.1, function() OBJ:DoClick(player, frame, PAGE) end)
                end
            else
                BUT:SetText("Mute")
                BUT.DoClick = function()
                    net.Start("RDV.COMMUNICATIONS.Mute")
                    net.SendToServer()
                    MUTED = !MUTED
                    local MUTED = MUTED
                    local TEXT = MUTED and RDV.LIBRARY.GetLang(nil, "COMMS_unmuteLabel") or RDV.LIBRARY.GetLang(nil, "COMMS_muteLabel")

                    if MUTED then
                        SendNotification(LocalPlayer(), RDV.LIBRARY.GetLang(nil, "COMMS_mutedText"))
                    else
                        SendNotification(LocalPlayer(), RDV.LIBRARY.GetLang(nil, "COMMS_unmutedText"))
                    end

                    surface.PlaySound("reality_development/ui/ui_accept.ogg")
                    timer.Simple(0.1, function() OBJ:DoClick(player, frame, PAGE) end)
                end
            end
        for k, v in ipairs(RDV.COMMUNICATIONS.LIST_SEQUENTIAL) do
            local NAME = v.NAME
    
            if !RDV.COMMUNICATIONS.CanAccessChannel(LocalPlayer(), NAME) then
                continue
            end
            local OCCUPANTS = RDV.COMMUNICATIONS.GetMemberCount(NAME)
            
            local LABEL = self:Add("DButton")
            LABEL:Dock(TOP)
            LABEL:SetText("")
            LABEL:SetHeight(h * 0.1)
            LABEL:SetFont("RD_FONTS_CORE_LABEL_LOWER")
            LABEL:DockMargin(w * 0.01, h * 0.01, w * 0.01, h * 0.01)
            LABEL.Paint = function(self, w, h)
                surface.SetDrawColor(PIXEL.CopyColor(PIXEL.Colors.Header))
                surface.DrawRect(0, 0, w, h)
    
                draw.SimpleText(NAME, "RD_FONTS_CORE_LABEL_LOWER", w * 0.05, h * 0.5, COL_1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                draw.SimpleText(OCCUPANTS, "RD_FONTS_CORE_LABEL_LOWER", w * 0.7, h * 0.5, COL_1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            end
            if ( RDV.COMMUNICATIONS.GetActiveChannel(LocalPlayer()) ~= NAME ) then
                local BUT = vgui.Create("PIXEL.TextButton", LABEL)
                BUT:Dock(RIGHT)
                BUT:SetText("Connect")
                BUT.DoClick = function()
                    surface.PlaySound("buttons/blip1.wav")
                    net.Start("RDV.COMMUNICATIONS.ChangeChannel")
                        net.WriteUInt(k, 8)
                    net.SendToServer()
                    timer.Simple(0.1, function() OBJ:DoClick(player, frame, PAGE) end)
                end
            else
                local BUT = vgui.Create("PIXEL.TextButton", LABEL)
                BUT:Dock(RIGHT)
                BUT:SetText("Disconnect")
                BUT.DoClick = function()
                    net.Start("RDV.COMMUNICATIONS.Disconnect")
                    net.SendToServer()
                    surface.PlaySound("reality_development/ui/ui_denied.ogg")
                    timer.Simple(0.1, function() OBJ:DoClick(player, frame, PAGE) end)
                end
            end
            
        end
        

        self.Think = nil
    end
end