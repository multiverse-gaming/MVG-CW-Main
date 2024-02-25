local CAT = "Announcements"

RDV.LIBRARY.AddConfigOption("ANNOUNCEMENTS_chatCommand", {
    TYPE = RDV.LIBRARY.TYPE.ST, 
    CATEGORY = CAT, 
    DESCRIPTION = "Server Announcement Command", 
    DEFAULT = "/announce", 
    SECTION = "Core",
})

RDV.LIBRARY.AddConfigOption("ANNOUNCEMENTS_length", {
    TYPE = RDV.LIBRARY.TYPE.NM, 
    CATEGORY = CAT, 
    DESCRIPTION = "Server Announcement Length", 
    DEFAULT = 15, 
    SECTION = "Core",
    MAX = 100,
    MIN = 1,
})

RDV.LIBRARY.AddConfigOption("ANNOUNCEMENTS_soundEnabled", {
    TYPE = RDV.LIBRARY.TYPE.BL, 
    CATEGORY = CAT, 
    DESCRIPTION = "Sounds Enabled", 
    DEFAULT = true, 
    SECTION = "Sounds",
})

RDV.LIBRARY.AddConfigOption("ANNOUNCEMENTS_sound", {
    TYPE = RDV.LIBRARY.TYPE.ST, 
    CATEGORY = CAT, 
    DESCRIPTION = "Notification Sound", 
    DEFAULT = "rdv/announcements/notify.ogg", 
    SECTION = "Sounds",
})

local COL_1 = Color(255,255,255)

local function SendNotification(ply, msg)
    RDV.LIBRARY.AddText(ply, Color(255,0,0), "["..RDV.LIBRARY.GetLang(nil, "ANNOUNCE_notificationLabel").."] ", Color(255,255,255), msg)
end

if SERVER then
    util.AddNetworkString("RDV_ANNOUNCEMENTS_SEND")

    hook.Add("PlayerSay", "RDV_ANNOUNCEMENTS_PlayerSay", function(P, T)
        local DATA = string.Explode(" ", T)
        local CMD = string.lower(DATA[1])
        
        if ( CMD == RDV.LIBRARY.GetConfigOption("ANNOUNCEMENTS_chatCommand") ) then
            local ACCESS = false

            if CAMI and CAMI.PlayerHasAccess(P, "[RDV] Server Announcements", nil) then
                ACCESS = true
            elseif P:IsAdmin() then
                ACCESS = true
            end

            if !ACCESS then
                SendNotification(P, RDV.LIBRARY.GetLang(nil, "ANNOUNCE_noPerms"))
                return ""
            end

            local MSG = string.Implode(" ", DATA)
            MSG = string.sub(MSG, string.len(DATA[1]) + 1)
            MSG = string.Trim(MSG)

            if not MSG or MSG == "" then
                return ""
            end

            net.Start("RDV_ANNOUNCEMENTS_SEND")
                net.WriteString(MSG)
            net.Broadcast()

            return ""
        end
    end )

    concommand.Add("rdv_announce", function(P, CMD, ARGS)
        if IsValid(P) and !P:IsAdmin() then return end
        
        local MSG = string.Implode(" ", ARGS)
        MSG = string.Trim(MSG)

        if not MSG or MSG == "" then
            return ""
        end

        net.Start("RDV_ANNOUNCEMENTS_SEND")
            net.WriteString(MSG)
        net.Broadcast()
    end )
else
    surface.CreateFont( "RDV_ANNOUNCEMENTS_Large", {
        font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        size = ScrW() * 0.025,
    } )

    surface.CreateFont( "RDV_ANNOUNCEMENTS_Small", {
        font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        size = ScrW() * 0.015,
    } )

    local START
    local MSG
    local RESET = false

    net.Receive("RDV_ANNOUNCEMENTS_SEND", function()
        START = SysTime() 
        MSG = net.ReadString()
        RESET = false

        if RDV.LIBRARY.GetConfigOption("ANNOUNCEMENTS_soundEnabled") then
            local SOUND = RDV.LIBRARY.GetConfigOption("ANNOUNCEMENTS_sound")

            surface.PlaySound(SOUND)
        end

        SendNotification(LocalPlayer(), MSG)

        timer.Create("RDV_ANNOUNCEMENTS_RESET", RDV.LIBRARY.GetConfigOption("ANNOUNCEMENTS_length"), 1, function()
            START = SysTime()
            
            RESET = true
        end )
    end )

    hook.Add("HUDPaint", "RDV_ANNOUNCEMENTS_HUDPaint", function()
        local SYS = SysTime()

        if ( MSG and MSG ~= "" ) then
            local TITLE = RDV.LIBRARY.GetLang(nil, "ANNOUNCE_titleLabel")

            if !RESET then
                draw.SimpleText( TITLE, "RDV_ANNOUNCEMENTS_Large", ScrW() * 0.5, Lerp(SYS - START, 0, ScrH() * 0.2 ), Color(255,0,0), TEXT_ALIGN_CENTER )
                draw.SimpleText( MSG, "RDV_ANNOUNCEMENTS_Small", ScrW() * 0.5, ( ScrW() * 0.025 ) + Lerp(SYS - START, 0, ScrH() * 0.2 ), color_white, TEXT_ALIGN_CENTER )
            else
                local VAL = Lerp(SYS - START, ScrH() * 0.2, 0 )

                if VAL == (-ScrW() * 0.2) then
                    MSG = nil
                end

                draw.SimpleText( TITLE, "RDV_ANNOUNCEMENTS_Large", ScrW() * 0.5, Lerp(SYS - START, ScrH() * 0.2, (-ScrW() * 0.1) ), Color(255,0,0), TEXT_ALIGN_CENTER )
                draw.SimpleText( MSG, "RDV_ANNOUNCEMENTS_Small", ScrW() * 0.5, ( ScrW() * 0.025 ) + Lerp(SYS - START, ScrH() * 0.2, (-ScrW() * 0.1) ), color_white, TEXT_ALIGN_CENTER )
            end
        end
    end )
end