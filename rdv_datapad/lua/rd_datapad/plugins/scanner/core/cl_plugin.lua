local OBJ = NCS_DATAPAD.GetPlugin()

if !OBJ then return end

local COL_1 = Color(255,255,255)
local TIME = 3
local INTERATIONS = 20

function OBJ:DoClick(ply, MENU, PAGE)
    PAGE.PaintOver = function() end

    local w, h = PAGE:GetSize()

    local SCROLL = vgui.Create("DPanel", PAGE)
    SCROLL:Dock(FILL)
    SCROLL.Paint = function() 
        draw.SimpleText(NCS_DATAPAD.GetLang(nil, "DAP_scannerAccess"), "NCS_DEF_FRAME_TITLE", w * 0.5, h * 0.4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    SCROLL:DockMargin(0, h * 0.02, w * 0.02, h * 0.02)
    
    SCROLL.Think = function(self)

        NCS_DATAPAD.IsAdmin(ply, function(ACCESS)
            if ACCESS or NCS_DATAPAD.CONFIG.ENGINEERS[team.GetName(ply:Team())] then
            
                SCROLL.Paint = function() end
                local w, h = self:GetSize()

                local BUTTON = vgui.Create("RDV_DAP_TextButton", SCROLL)
                BUTTON:SetText("Start Scan")
                BUTTON:Dock(FILL)
                BUTTON.DoClick = function()

                    local npc_count = 0
                    local player_count = 0

                    BUTTON:Remove()

                    for i, npc in ipairs( ents.FindByClass( "npc_*" ) ) do
                        if IsValid( npc ) and npc:IsNPC()then
                            npc_count = npc_count + 1
                        end
                    end

                    local enemy_teams = {
                        TEAM_BATTLEDROID,
                        TEAM_CQBATTLEDROID,
                        TEAM_ROCKETDROID,
                        TEAM_HEAVYBATTLEDROID,
                        TEAM_RECONBATTLEDROID,
                        TEAM_ENGINEERDROID,
                        TEAM_MEDICALDROID,
                        TEAM_COMMANDERDROID,
                        TEAM_SITH,
                        TEAM_SUPERBATTLEDROID,
                        TEAM_SUPERJUMPDROID,
                        TEAM_DROIDEKA,
                        TEAM_MAGNAGUARD,
                        TEAM_TACTICALDROID,
                        TEAM_TANKERDROID,
                        TEAM_SNIPERDROID,
                        TEAM_TECHNICALDROID,
                        TEAM_BOUNTYHUNTERREINFORCE,
                        TEAM_BXCOMMANDODROID,
                        TEAM_BXASSASSINDROID,
                        TEAM_BXSLUGDROID,
                        TEAM_BXSPLICERDROID,
                        TEAM_BXRECONDROID,
                        TEAM_BXHEAVYDROID,
                        TEAM_BXCOMMANDERDROID,
                        TEAM_UMBARANTROOPER,
                        TEAM_UMBARANHEAVYTROOPER,
                        TEAM_UMBARANSNIPER,
                        TEAM_UMBARANENGINEER,
                        TEAM_UMBARANOFFICER,
                        TEAM_PRISONER,
                        TEAM_UNDEAD,
                        TEAM_CUSTOMENEMY,
                        TEAM_COUNTDOOKU,
                        TEAM_ASAJJVENTRESS,
                        TEAM_DARTHMAUL,
                        TEAM_GENERALGRIEVOUS,
                        TEAM_SAVAGEOPRESS,
                        TEAM_PREVISZLA,
                        TEAM_CADBANE,
                        TEAM_HONDO,
                        TEAM_BOSK,
                        TEAM_DURGE
                    }

                    function table.contains(table, element)
                        for _, value in ipairs(table) do
                            if value == element then
                                return true
                            end
                        end
                        return false
                    end

                    for _, ply in ipairs(player.GetAll()) do
                        if IsValid(ply) and ply:IsPlayer() then
                            local team_id = ply:Team()
                            if table.contains(enemy_teams, team_id) then
                                player_count = player_count + 1
                            end
                        end
                    end

                    local percentage = 0

                    local Delay = vgui.Create("DLabel", SCROLL)
                    Delay:Dock(FILL)
                    Delay:DockMargin(w * 0.4, 0, 0, 0)
                    --Delay:SetPos( w * 0.5, h * 0.3 )
                    --Delay:SetSize(725, 70)
                    Delay:SetColor(color_white)
                    Delay:SetFont("RDV_DAP_FRAME_TITLE")
                    Delay:SetText("Scanning: " ..percentage.."%")
                    --Delay:SetContentAlignment("1")`

                    local total_hostiles = npc_count + player_count

                    local Results = vgui.Create("DLabel", SCROLL)
                    Results:Dock(TOP)
                    Results:DockMargin(w * 0.3,  h * 0.5, 0, 0)
                    --ResultTitle:SetPos( w * 0.5, h * 0.3 )
                    --ResultTitle:SetSize(725, 70)
                    Results:SetColor(color_white)
                    Results:SetFont("NCS_DEFCON_TextLabel")
                    Results:SetText("Scan Results: " .. total_hostiles .. " hostiles")
                    --ResultTitle:SetContentAlignment("1")
                    Results:Hide()

                    timer.Create("rdv_scanning", TIME, INTERATIONS, function()
                        percentage = percentage + 5
                        Delay:SetText("Scanning: " ..percentage.."%")
                        if (timer.RepsLeft("rdv_scanning") == 0) then
                            Delay:Hide()
                            Results:Show()  
                        end 
                    end)
                end

                self.Think = nil
            end
        end )
    end

    function SCROLL:OnRemove()  
        timer.Remove("rdv_scanning")
    end

    function PAGE:OnRemove()
        timer.Remove("rdv_scanning")
    end 
end

