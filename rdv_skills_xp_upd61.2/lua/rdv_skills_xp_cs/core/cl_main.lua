--[[------------------------------------]]--
--  HUD
--[[------------------------------------]]--

local WAITING = {}

net.Receive("RDV.LEVELS.GetPlayer", function()
    local E = net.ReadPlayer()
    local LVL = net.ReadUInt(16)
    local POI = net.ReadUInt(16)
    local EXP = net.ReadString()

    if WAITING[E] then
        WAITING[E].Func({L = LVL, P = POI, E = EXP})
    end
end )

local function EditPlayer(FRAME, PLAYER)
    WAITING[PLAYER] = {
        Func = function(D)
            local EDIT = RDV.LIBRARY.GetLang(nil, "SAL_editLabel")
            local EXPERIENCE = RDV.LIBRARY.GetLang(nil, "SAL_experienceLabel")
            local LEVEL = RDV.LIBRARY.GetLang(nil, "SAL_levelLabel")
            local POINTS = RDV.LIBRARY.GetLang(nil, "SAL_skillPoints")
            local CONFIRM = RDV.LIBRARY.GetLang(nil, "SAL_confirmLabel")

            local FRAME = vgui.Create("PIXEL.Frame")
            FRAME:SetSize(ScrW() * 0.2, ScrH() * 0.2)
            FRAME:Center()
            FRAME:SetTitle(EDIT)
            FRAME:MakePopup(true)
        
            local w, h = FRAME:GetSize()

            --[[---------------------------------------[[--
                Divider
            --]]---------------------------------------]]--

            local TLABEL = vgui.Create("DLabel", FRAME)
            TLABEL:Dock(TOP)
            TLABEL:SetText(EXPERIENCE)
            TLABEL:SetFont("RD_FONTS_CORE_LABEL_LOWER")
            TLABEL:SetTextColor(COL_1)
            TLABEL:SetMouseInputEnabled(true)
            TLABEL:SetContentAlignment(5)
            TLABEL:DockMargin(w * 0.025, 0, w * 0.025, h * 0.025)

            --[[---------------------------------------[[--
                Experience
            --]]---------------------------------------]]--

            local XP = vgui.Create("PIXEL.TextEntry", FRAME)
            XP:Dock(TOP)
            XP:SetKeyBoardInputEnabled(true)
            XP:SetHeight(h * 0.2)
            XP:DockMargin(w * 0.025, 0, w * 0.025, h * 0.025)

            if D.E then
                XP:SetValue(D.E)
            end

            XP.OnChange = function(self)
            end
            
            --[[---------------------------------------[[--
                Divider
            --]]---------------------------------------]]--

            local PARENT = vgui.Create("DLabel", FRAME)
            PARENT:Dock(TOP)
            PARENT:SetText("")
            PARENT:DockMargin(w * 0.025, 0, w * 0.025, h * 0.025)

            local P_LEFT = vgui.Create("DLabel", PARENT)
            P_LEFT:Dock(LEFT)
            P_LEFT:SetText(POINTS)
            P_LEFT:SetFont("RD_FONTS_CORE_LABEL_LOWER")
            P_LEFT:SetTextColor(COL_1)
            P_LEFT:SetMouseInputEnabled(true)
            P_LEFT:SetContentAlignment(5)
            P_LEFT:SetSize(w * 0.4, h * 0.1)

            local P_RIGHT = vgui.Create("DLabel", PARENT)
            P_RIGHT:Dock(RIGHT)
            P_RIGHT:SetText(LEVEL)
            P_RIGHT:SetFont("RD_FONTS_CORE_LABEL_LOWER")
            P_RIGHT:SetTextColor(COL_1)
            P_RIGHT:SetMouseInputEnabled(true)
            P_RIGHT:SetContentAlignment(5)
            P_RIGHT:SetSize(w * 0.4, h * 0.1)

            --[[---------------------------------------[[--
                Points and Level
            --]]---------------------------------------]]--

            local LABEL = vgui.Create("DLabel", FRAME)
            LABEL:SetText("")
            LABEL:SetHeight(h * 0.175)
            LABEL:Dock(TOP)
            LABEL:DockMargin(w * 0.025, 0, w * 0.025, h * 0.025)
            LABEL:SetMouseInputEnabled(true)

            local P = vgui.Create("PIXEL.TextEntry", LABEL)
            P:Dock(LEFT)
            P:SetKeyBoardInputEnabled(true)
            P:SetSize(w * 0.4, h * 0.075)
            
            if D.P then
                P:SetValue(D.P)
            end

            local L = vgui.Create("PIXEL.TextEntry", LABEL)
            L:Dock(RIGHT)
            L:SetKeyBoardInputEnabled(true)
            L:SetSize(w * 0.4, h * 0.075)

            if D.L then
                L:SetValue(D.L)
            end

            local SAVE = vgui.Create("PIXEL.TextButton", FRAME)
            SAVE:SetText(CONFIRM)
            SAVE:Dock(BOTTOM)
        
            SAVE.DoClick = function()
                if !IsValid(PLAYER) then return end

                net.Start("RDV.LEVELS.SetPlayer")
                    net.WritePlayer(PLAYER)
                    net.WriteUInt(tonumber(L:GetValue()), 16)
                    net.WriteUInt(tonumber(P:GetValue()), 16)
                    net.WriteString(tonumber(XP:GetValue()))
                net.SendToServer()

                if IsValid(FRAME) then
                    FRAME:Remove()
                end
            end

            WAITING[PLAYER] = nil
        end,
    }

    net.Start("RDV.LEVELS.GetPlayer")
        net.WritePlayer(PLAYER)
    net.SendToServer()
end

local COL_1 = Color(255,255,255)
local COL_2 = Color(32, 32, 32)
local COL_3 = Color(44, 44, 44)
local COL_4 = Color(41, 128, 185)
local COL_6 = Color(27, 27, 27, 255)
local COL_7 = Color(150,145,145)
local COL_8 = Color(125,255,0)

local function GreenToRed(percent)
    local r = 255 * percent/100
    local g = 255 - (255 * percent/100)

    return Color(g,r,0)
end

surface.CreateFont( "RDV.LEVELS.INFO.BAR", {
    font = "Roboto", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    size = ScrW() * 0.009,
})

local PERCENT = 0
local MSG = ""

local function CacheXPBar()
    local LEVEL = RDV.SAL.GetLevel(LocalPlayer())
    local EXPERIENCE = RDV.SAL.GetExperience(LocalPlayer())

    if not LEVEL or not EXPERIENCE then
        return
    end

    local requiredxp = RDV.SAL.GetRequiredXP(LEVEL + 1)
    if !requiredxp then return end

    local percent = EXPERIENCE / requiredxp * 100

    local LANG = RDV.LIBRARY.GetLang(nil, "SAL_levelHudMain", {
        string.Comma(LEVEL),
        string.Comma(EXPERIENCE),
        string.Comma(requiredxp),
    })

            
    return LANG, percent
end

hook.Add("InitPostEntity", "RDV.SAL.LOAD", function()
    local SID64 = LocalPlayer():SteamID64()
    RDV.SAL.PLAYERS[SID64] = RDV.SAL.PLAYERS[SID64] or {}
end )

local test = false
hook.Add("HUDPaint", "RDV.SAL.HUDPaint", function()
    MSG, PERCENT = CacheXPBar()

    if not PERCENT or not MSG then
        return
    end

    if !RDV.LIBRARY.GetConfigOption("SAL_hudEnabled") then return end

    local teams = RDV.LIBRARY.GetConfigOption("SAL_expTEAMS")
    local clientTeam = team.GetName(LocalPlayer():Team())

    if not istable(teams) or teams[clientTeam] == nil then return end

    local AD = {
        W = RDV.LIBRARY.GetConfigOption("SAL_Adjustw"),
        H = RDV.LIBRARY.GetConfigOption("SAL_Adjusth"),
    }
            
    local W, H = ScrW(), ScrH()

    draw.RoundedBox(5, W * 0.375 + (W * AD.W), H * 0.015 + (H * AD.H), W * 0.25, H * 0.03, COL_2)
    draw.RoundedBox(0, W * 0.37775 + (W * AD.W), H * 0.02 + (H * AD.H), W * 0.002445 * PERCENT, H * 0.02, COL_3)

    draw.SimpleText(MSG, "RDV.LEVELS.INFO.BAR", W * 0.5 + (W * AD.W), H * 0.03 + (H * AD.H), COL_1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    -- Experience Bonus Check
    local BONUS = RDV.SAL.GetActiveBonus()
    if !BONUS then return end

    local LANG = RDV.LIBRARY.GetLang(nil, "SAL_bonusActive", {
        BONUS,
    })
    
    draw.SimpleText(LANG, "RDV.LEVELS.INFO.BAR", W * 0.5 + (W * AD.W), H * 0.06 + (H * AD.H), COL_1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)


--[[------------------------------------]]--
--  MENU ACCESS
--[[------------------------------------]]--

local function SendNotification(msg)
    RDV.LIBRARY.AddText(LocalPlayer(), RDV.LIBRARY.GetConfigOption("SAL_prefixColor"), "["..RDV.LIBRARY.GetConfigOption("SAL_prefix").."] ", COL_1, msg)
end

local function ResetSkillsConfirmMenu(PRICE, OLDF, SKILLS)
    local CAN = RDV.LIBRARY.GetConfigOption("SAL_resetEnabled")

    if !CAN then return end
    
    if not SKILLS or table.Count(SKILLS) < 1 then
        SendNotification(RDV.LIBRARY.GetLang(nil, "SAL_noPointsInvested"))
        return
    end

    local FORMAT = RDV.LIBRARY.FormatMoney(nil, PRICE)

    if IsValid(OLDF) then
        OLDF:SetVisible(false)
    end

    local PANEL = vgui.Create("PIXEL.Frame")
    PANEL:SetSize(ScrW() * 0.2, ScrH() * 0.125)
    PANEL:Center()
    PANEL:MakePopup(true)
    PANEL:SetTitle(RDV.LIBRARY.GetLang(nil, "SAL_titleLabel"))

    PANEL.OnRemove = function()
        if IsValid(OLDF) then
            OLDF:SetVisible(true)
        end
    end

    local w, h = PANEL:GetSize()

    local LANG = RDV.LIBRARY.GetLang(nil, "SAL_resetSkillsPrice", {
        FORMAT,
    })

    local LABEL = vgui.Create("DLabel", PANEL)
    LABEL:SetText("")
    LABEL:Dock(TOP)
    LABEL:SetSize(w, h * 0.5)
    LABEL:SetWrap(true)
    LABEL:SetContentAlignment(5)
    LABEL.PaintOver = function(self, w, h)
        draw.DrawText(LANG, "RD_FONTS_CORE_LABEL_LOWER", w * 0.5, h * 0.1, COL_1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local BUTTON = vgui.Create("PIXEL.TextButton", PANEL)
    BUTTON:SetText(RDV.LIBRARY.GetLang(nil, "SAL_confirmLabel"))
    BUTTON:Dock(FILL)

    BUTTON.DoClick = function()
        local AFFORD = RDV.LIBRARY.CanAfford(LocalPlayer(), nil, RDV.LIBRARY.GetConfigOption("SAL_resetPrice"))

        if AFFORD then
            net.Start("RDV.LEVELS.ResetSkills")
            net.SendToServer()

            PANEL:Remove()
            OLDF:Remove()
        end
    end
end

local function GetTotalXP(LVL, EXP)
    if not LVL then
        LVL = RDV.SAL.GetLevel(LocalPlayer())
    end

    if not EXP then
        EXP = RDV.SAL.GetExperience(LocalPlayer())
    end

    local TOTAL = 0

    for i = 1, LVL do
        if !RDV.SAL.GetRequiredXP(i) then continue end

        TOTAL = TOTAL + RDV.SAL.GetRequiredXP(i)
    end

    TOTAL = TOTAL + EXP

    return (TOTAL or 0)
end

--[[------------------------------------]]--
    --  Admin Menu
--[[------------------------------------]]--

local WAITING = {}

net.Receive("RDV.LEVELS.GetSkills", function()
    local P = net.ReadPlayer()
    local T = net.ReadTable()

    if WAITING[P] then
        WAITING[P].Func(T)

        WAITING[P] = nil
    end
end )

function RDV.SAL.OpenMenu()
    net.Start("RDV.LEVELS.GetSkills")
    net.SendToServer()

    local function Display(INFO)
        local FRAME = vgui.Create("PIXEL.Frame")
        FRAME:SetSize(ScrW() * 0.4, ScrH() * 0.5)
        FRAME:Center()
        FRAME:SetTitle(RDV.LIBRARY.GetLang(nil, "SAL_titleLabel"))
        FRAME:MakePopup(true)

        local w, h = FRAME:GetSize()

        local SIDE = vgui.Create("PIXEL.Sidebar", FRAME)
        SIDE:Dock(LEFT)
        SIDE:SetWide(w * 0.3)
    
        local PANEL = vgui.Create("DPanel", FRAME)
        PANEL:Dock(FILL)
        PANEL.Paint = function() end
        PANEL.Think = function(self) SIDE:SelectItem("home") self.Think = function() end end
    
        local EXP = RDV.SAL.GetExperience(LocalPlayer())
        local LVL = RDV.SAL.GetLevel(LocalPlayer())
        local POINTS = RDV.SAL.GetPoints(LocalPlayer())

        SIDE:AddItem("home", RDV.LIBRARY.GetLang(nil, "SAL_homeLabel"), RDV.LIBRARY.GetConfigOption("SAL_homeIcon"), function()
            if IsValid(PANEL) then
                PANEL:Clear()
            end
        --[[------------------------------------]]--
        --  Home
        --[[------------------------------------]]--

            if !RDV.SAL.GetRequiredXP(LVL + 1) then
                return
            end

            local REQ = RDV.SAL.GetRequiredXP(LVL + 1)
            local percent = EXP / REQ * 100

            local TOTAL = GetTotalXP()

            local LERPED = GreenToRed(percent)

            local w, h = PANEL:GetSize()

            local HEADER = vgui.Create("DLabel", PANEL)
            HEADER:Dock(TOP)
            HEADER:SetSize(ScrW() * 0, ScrH() * 0.025)
            HEADER:DockMargin(w * 0.025, h * 0.01, w * 0.025, 0)
            HEADER:SetText("")
            
            local MSG = RDV.LIBRARY.GetLang(nil, "SAL_personalStatistics")

            HEADER.Paint = function(self, w, h)
                draw.SimpleText(MSG, "RD_FONTS_CORE_LABEL_LOWER", w * 0.5, h * 0.5, COL_1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

            local LEVEL = vgui.Create("DLabel", PANEL)
            LEVEL:SetSize(0, h * 0.15)
            LEVEL:DockMargin(w * 0.01, h * 0.01, w * 0.01, 0)
            LEVEL:Dock(TOP)
            LEVEL:SetText("")

            local LLevel = RDV.LIBRARY.GetLang(nil, "SAL_levelLabel")

            local SKILLPOINTS = RDV.LIBRARY.GetLang(nil, "SAL_skillPoints")

            LEVEL.Paint = function(self, w, h)
                local COL = PIXEL.OffsetColor(PIXEL.CopyColor(PIXEL.Colors.Header), 5)

                draw.RoundedBox(5, 0, 0, w, h, COL)

                draw.SimpleText(LLevel, "RD_FONTS_CORE_LABEL_LOWER", w * 0.25, h * 0.1, COL_4, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
                draw.SimpleText(string.Comma(LVL), "RD_FONTS_CORE_LABEL_LOWER", w * 0.25, h * 0.6, COL_1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

                draw.SimpleText(SKILLPOINTS, "RD_FONTS_CORE_LABEL_LOWER", w * 0.75, h * 0.1, COL_4, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
                draw.SimpleText(string.Comma( POINTS ), "RD_FONTS_CORE_LABEL_LOWER", w * 0.75, h * 0.6, COL_1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

            local EXPERIENCE = vgui.Create("DLabel", PANEL)
            EXPERIENCE:SetSize(0, h * 0.15)
            EXPERIENCE:DockMargin(w * 0.01, h * 0.01, w * 0.01, 0)
            EXPERIENCE:Dock(TOP)
            EXPERIENCE:SetText("")

            local LExperience = RDV.LIBRARY.GetLang(nil, "SAL_experienceLabel")

            local LTotalExperience = RDV.LIBRARY.GetLang(nil, "SAL_totalExperienceLabel")

            EXPERIENCE.Paint = function(self, w, h)
                local COL = PIXEL.OffsetColor(PIXEL.CopyColor(PIXEL.Colors.Header), 5)

                draw.RoundedBox(5, 0, 0, w, h, COL)

                draw.SimpleText(LExperience, "RD_FONTS_CORE_LABEL_LOWER", w * 0.25, h * 0.1, COL_4, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
                draw.SimpleText(string.Comma(EXP).." / "..string.Comma(REQ).."XP", "RD_FONTS_CORE_LABEL_LOWER", w * 0.25, h * 0.6, LERPED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

                draw.SimpleText(LTotalExperience, "RD_FONTS_CORE_LABEL_LOWER", w * 0.75, h * 0.1, COL_4, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
                draw.SimpleText(string.Comma(TOTAL).."XP", "RD_FONTS_CORE_LABEL_LOWER", w * 0.75, h * 0.6, COL_8, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

            RDV.LIBRARY.Timer("RDV.LEVELS.INFO.FETCH_STATS", 5, 0, function()
                if !RDV.SAL.GetRequiredXP(LVL + 1) then
                    return
                end

                EXP = RDV.SAL.GetExperience(LocalPlayer())
                LVL = RDV.SAL.GetLevel(LocalPlayer())
                POINTS = RDV.SAL.GetPoints(LocalPlayer())

                REQ = RDV.SAL.GetRequiredXP(LVL + 1)
                
                percent = EXP / REQ * 100

                LERPED = GreenToRed(percent)

                TOTAL = GetTotalXP()
            end)

            --[[------------------------------------]]--
            --  Leaderboard
            --[[------------------------------------]]--
            
            if RDV.LIBRARY.GetConfigOption("SAL_leaderboardEnabled") == true then
                net.Start("RDV.LEVELS.RetrieveScoreboard")
                net.SendToServer()

                net.Receive("RDV.LEVELS.RetrieveScoreboard", function()
                    local DATA = net.ReadTable()

                    if istable(DATA) then
                        local HEADER = vgui.Create("DLabel", PANEL)
                        HEADER:Dock(TOP)
                        HEADER:SetSize(ScrW() * 0, ScrH() * 0.025)
                        HEADER:DockMargin(w * 0.025, h * 0.01, w * 0.025, 0)
                        HEADER:SetText("")
                
                        local LLeaderboard = RDV.LIBRARY.GetLang(nil, "SAL_leaderboardLabel")

                        local LTop = RDV.LIBRARY.GetLang(nil, "SAL_topLabel")

                        HEADER.Paint = function(self, w, h)
                            draw.SimpleText(LLeaderboard, "RD_FONTS_CORE_LABEL_LOWER", w * 0.5, h * 0.5, COL_1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        end
    
                        local SCROLL = vgui.Create("PIXEL.ScrollPanel", PANEL)
                        SCROLL:Dock(FILL)

                        local LLoading = RDV.LIBRARY.GetLang(nil, "SAL_loadingLabel")
                        local LIMIT = RDV.LIBRARY.GetConfigOption("SAL_ldbLimit")

                        for k, v in ipairs(DATA) do
                            local NAME = LLoading
                            local FOUND = false

                            steamworks.RequestPlayerInfo( v.CLIENT, function( steamName )
                                NAME = steamName
                                FOUND = true
                            end )

                            local PERCENT_SCB = ((LIMIT - k) + 1 or 0) * 100 / (LIMIT or 0)

                            local LERPED = GreenToRed(PERCENT_SCB)

                            local label = SCROLL:Add("DLabel")
                            label:SetSize(0, h * 0.1)
                            label:DockMargin(w * 0.01, h * 0.01, w * 0.01, 0)
                            label:Dock(TOP)
                            label:SetText("")
                            label.Paint = function(self, w, h)
                                local COL = PIXEL.OffsetColor(PIXEL.CopyColor(PIXEL.Colors.Header), 5)

                                draw.RoundedBox(5, 0, 0, w, h, COL)
                        
                                draw.SimpleText(LTop..string.Comma(k), "RD_FONTS_CORE_LABEL_LOWER", w * 0.05, h * 0.5, LERPED, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                                draw.SimpleText(NAME.." ("..(v.PCHARACTER or 1)..")", "RD_FONTS_CORE_LABEL_LOWER", w * 0.5, h * 0.5, COL_1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

                                draw.SimpleText(string.Comma(v.LEVEL), "RD_FONTS_CORE_LABEL_LOWER", w * 0.95, h * 0.5, COL_1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                            end
                        end
                    end
                end)
            end

            if RDV.LIBRARY.GetConfigOption("SAL_resetEnabled") then
                local PRICE = RDV.LIBRARY.GetConfigOption("SAL_resetPrice")
                local FORMAT = RDV.LIBRARY.FormatMoney(nil, PRICE)

                local LReset = RDV.LIBRARY.GetLang(nil, "SAL_resetSkillsLabel", {
                    FORMAT,
                })

                local BUTTON = vgui.Create("PIXEL.TextButton", PANEL)
                BUTTON:SetText(LReset)
                BUTTON:SetSize(w, h * 0.1)
                BUTTON:Dock(BOTTOM)
                BUTTON.DoClick = function(self)
                    ResetSkillsConfirmMenu(PRICE, FRAME, INFO)
                end
            end

            FRAME.OnRemove = function()
                RDV.LIBRARY.TimerRemove("RDV.LEVELS.INFO.FETCH_STATS")
            end
        end)

        --[[------------------------------------]]--
        --  SKILLS
        --[[------------------------------------]]--

        local LSkills = RDV.LIBRARY.GetLang(nil, "SAL_skillsLabel")

        SIDE:AddItem("skills", LSkills, RDV.LIBRARY.GetConfigOption("SAL_skillsIcon"), function()
            if IsValid(PANEL) then
                PANEL:Clear()
            end

            local w, h = PANEL:GetSize()
            
            local SCROLL = vgui.Create("PIXEL.ScrollPanel", PANEL)
            SCROLL:Dock(FILL)
            SCROLL:DockMargin(0, 0, 0, h * 0.05)

            local CATEGORIES = {}

            for k, v in pairs(RDV.SAL.SKILLS.LIST) do
                local LEVEL = ( INFO[k] or 0 )

                local CAN = hook.Run("RDV_SAL_CanGiveSkill", LocalPlayer(), k, (LEVEL + 1))

                if ( CAN == false ) then
                    continue
                end

                -- Normally this would be done in a table-indexy way, but that doesn't instantiate the table? I think?
                -- No, I don't know why. These are always small numbers anyway, and it's only run once on the client side, so its fine.
                local skip = true
                local doesTheTableActuallyExist = false
                for noEffectTeams, exists in pairs(v:GetNoEffectTeams()) do
                    doesTheTableActuallyExist = true
                    if (noEffectTeams == LocalPlayer():Team()) then
                        skip = false
                        continue
                    end
                end
                if doesTheTableActuallyExist && skip then continue end

                v.CATEGORY = v.CATEGORY or RDV.LIBRARY.GetLang(nil, "SAL_uncategorizedLabel")
                v.COLOR = v.COLOR or COL_1
                v.DESCRIPTION = v.DESCRIPTION or "N/A"

                local REQ = v.LevelReq[LEVEL + 1]

                if not CATEGORIES[v.CATEGORY] then
                    local CATEGORY_F = SCROLL:Add("PIXEL.Category")
                    CATEGORY_F:Dock(TOP)
                    CATEGORY_F:SetTitle( v.CATEGORY )
                    CATEGORY_F:DockMargin(w * 0.015, h * 0.015, w * 0.015, h * 0.015)
        
                    CATEGORIES[v.CATEGORY] = CATEGORY_F
                end
    
                local CATEGORY = CATEGORIES[v.CATEGORY]

                local label = CATEGORY:Add("DLabel")
                label:SetSize(0, h * 0.13)
                label:DockMargin(w * 0.01, h * 0.01, w * 0.01, 0)
                label:Dock(TOP)
                label:SetText("")

                if !REQ or REQ < tonumber(LVL) then
                    label:SetTooltip(v.DESCRIPTION)
                end

                label:SetMouseInputEnabled(true)

                label.Paint = function(self, w, h)
                    local COL = PIXEL.OffsetColor(PIXEL.CopyColor(PIXEL.Colors.Header), 5)

                    draw.RoundedBox(5, 0, 0, w, h, COL)

                    if REQ and REQ > tonumber(LVL) then
                        draw.RoundedBox(0, 0, h * 0.2, w, h * 0.6, Color(0, 0, 0, 75))
                        draw.SimpleText(RDV.LIBRARY.GetLang(nil, "SAL_levelRequired", {REQ}), "RD_FONTS_CORE_LABEL_LOWER", w * 0.5, h * 0.5, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    else
                        draw.SimpleText(k.." - "..math.Clamp(LEVEL, 0, v.MAX).." / "..v.MAX, "RD_FONTS_CORE_LABEL_LOWER", w * 0.05, h * 0.2, v.COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

                        local VAL = "N/A"

                        if v.DESCRIPTION then
                            VAL = string.sub( (v.DESCRIPTION or "N/A"), 0, 50 )

                            if VAL ~= v.DESCRIPTION then
                                VAL = VAL.."..."
                            end
                        end

                        draw.SimpleText( VAL, "RD_FONTS_CORE_PROPERTY_TABS", w * 0.05, h * 0.5, LERPED, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                    end
                end

                local LMax = RDV.LIBRARY.GetLang(nil, "SAL_maxLabel")
                local LPurchase = RDV.LIBRARY.GetLang(nil, "SAL_purchaseLabel")
                local LMaxed = RDV.LIBRARY.GetLang(nil, "SAL_skillMaxedOut")
                local LNoPoints = RDV.LIBRARY.GetLang(nil, "SAL_noPointsAvailable")
                
                if !REQ or REQ <= tonumber(LVL) then

                    local BUTTON = vgui.Create("PIXEL.TextButton", label)
                    
                    if LEVEL >= v.MAX then
                        BUTTON:SetText(LMax)
                    else
                        BUTTON:SetText(LPurchase)
                    end

                    BUTTON:SetSize(w * 0.2, h)
                    BUTTON:Dock(RIGHT)
                    BUTTON:SetMouseInputEnabled(true)

                    BUTTON.DoClick = function()
                        if LEVEL >= v.MAX then
                            RDV.LIBRARY.AddText(LocalPlayer(), RDV.LIBRARY.GetConfigOption("SAL_prefixColor"), "["..RDV.LIBRARY.GetConfigOption("SAL_prefix").."] ", COL_1, LMaxed)

                            return
                        end

                        POINTS = RDV.SAL.GetPoints(LocalPlayer())

                        if not RDV.SAL.SKILLS.LIST[k] or tonumber(POINTS) <= 0 then
                            RDV.LIBRARY.AddText(LocalPlayer(), RDV.LIBRARY.GetConfigOption("SAL_prefixColor"), "["..RDV.LIBRARY.GetConfigOption("SAL_prefix").."] ", COL_1, LNoPoints)

                            return
                        else
                            net.Start("RDV.LEVELS.UpgradeSkill")
                                net.WriteString(k)
                            net.SendToServer()

                            LEVEL = LEVEL + 1
                            POINTS = POINTS - 1

                            if not INFO[k] then
                                INFO[k] = 1
                            else
                                INFO[k] = INFO[k] + 1
                            end

                            surface.PlaySound("addoncontent/shared/purchase.ogg")
                        end
                    end
                end
            end

            --[[
                Purchase
            --]]

            local PRICE = RDV.LIBRARY.GetConfigOption("SAL_skillPrice")
            local canBuy = RDV.LIBRARY.GetConfigOption("SAL_purchaseEnabled")

            if canBuy and isnumber(PRICE) and PRICE > 0 then
                local FORMAT = RDV.LIBRARY.FormatMoney(nil, PRICE)

                local LPurchase = RDV.LIBRARY.GetLang(nil, "SAL_purchaseSkillpointLabel", {
                    FORMAT,
                })

                local LCannotAfford = RDV.LIBRARY.GetLang(nil, "SAL_cannotAffordSkillpoint")

                local BUTTON = vgui.Create("PIXEL.TextButton", PANEL)
                BUTTON:SetText(LPurchase)
                BUTTON:SetSize(w, h * 0.1)
                BUTTON:Dock(BOTTOM)

                BUTTON.DoClick = function()
                    local AFFORD = RDV.LIBRARY.CanAfford(LocalPlayer(), nil, PRICE)

                    if AFFORD then
                        surface.PlaySound("addoncontent/shared/purchase.ogg")

                        net.Start("RDV.LEVELS.PurchaseSkillpoint")
                        net.SendToServer()

                        POINTS = POINTS + 1
                    else
                        RDV.LIBRARY.AddText(LocalPlayer(), RDV.LIBRARY.GetConfigOption("SAL_prefixColor"), "["..RDV.LIBRARY.GetConfigOption("SAL_prefix").."] ", COL_1, LCannotAfford)
                    end
                end
            end
        end)

        if RDV.SAL.HasPermission(LocalPlayer()) then
            SIDE:AddItem("admin", RDV.LIBRARY.GetLang(nil, "SAL_admLabel"), RDV.LIBRARY.GetConfigOption("SAL_adminIcon"), function()
                
                if IsValid(PANEL) then
                    PANEL:Clear()
                end

                local w, h = PANEL:GetSize()

                local SCROLL = vgui.Create("PIXEL.ScrollPanel", PANEL)
                SCROLL:Dock(FILL)
                SCROLL:DockMargin(0, 0, 0, h * 0.05)

                for k, v in ipairs(player.GetHumans()) do
                    local label = SCROLL:Add("DLabel")
                    label:SetSize(0, h * 0.13)
                    label:DockMargin(w * 0.01, h * 0.01, w * 0.01, 0)
                    label:Dock(TOP)
                    label:SetText("")

                    label:SetMouseInputEnabled(true)

                    label.Paint = function(self, w, h)
                        local COL = PIXEL.OffsetColor(PIXEL.CopyColor(PIXEL.Colors.Header), 5)

                        draw.RoundedBox(5, 0, 0, w, h, COL)

                        draw.SimpleText(v:Name(), "RD_FONTS_CORE_LABEL_LOWER", w * 0.05, h * 0.15, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                        draw.SimpleText(team.GetName(v:Team()), "RD_FONTS_CORE_LABEL_LOWER", w * 0.05, h * 0.85, team.GetColor(v:Team()), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
                    end

                    local BUTTON = vgui.Create("PIXEL.TextButton", label)
                    BUTTON:SetText(RDV.LIBRARY.GetLang(nil, "SAL_editLabel"))
                    BUTTON:Dock(RIGHT)

                    BUTTON.DoClick = function()
                        EditPlayer(FRAME, v)
                    end
                end
            end)
        end
    end

    WAITING[LocalPlayer()] = {
        Func = function(data)
            Display(data)

            WAITING[LocalPlayer()] = nil
        end,
    }
end

hook.Add("PlayerButtonDown", "RDV.SKILLS.COMMAND", function(ply, button)
    if ( ply == LocalPlayer() ) then
        local BIND = RDV.LIBRARY.GetConfigOption("SAL_menuBind")

        local teams = RDV.LIBRARY.GetConfigOption("SAL_expTEAMS")
        local clientTeam = team.GetName(LocalPlayer():Team())
        if teams == nil or teams == false or teams[clientTeam] == nil or teams[clientTeam] == false then return end
        
        if BIND and IsFirstTimePredicted() then
            if button == BIND then
                RDV.SAL.OpenMenu()
            end
        end
    end
end)

hook.Add("OnPlayerChat", "RDV.SKILLS.COMMAND", function(ply, text)
    if ( ply == LocalPlayer() ) then
        local BIND = RDV.LIBRARY.GetConfigOption("SAL_menuCommand")

        if BIND and text == BIND then
            RDV.SAL.OpenMenu()

            return true
        end
    end
end)