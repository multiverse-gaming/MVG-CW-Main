local OBJ = NCS_DATAPAD.CreatePlugin("Arrest Reports")

OBJ.Icon = "H5wE79w.png"

OBJ:AddConfigurationDerma(function(S, F, CFG)
    local w, h = F:GetSize()

    local M_LABEL = S:Add("DLabel")
    M_LABEL:SetText("Arrest Access")
    M_LABEL:Dock(TOP)
    M_LABEL:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)

    local S_TEAM = S:Add("DListView")
    S_TEAM:Dock(TOP)
    S_TEAM:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
    S_TEAM:SetTall(h * 0.3)
    S_TEAM:AddColumn( NCS_DATAPAD.GetLang(nil, "DAP_nameLabel"), 1 )
    S_TEAM.OnRowRightClick = function(sm, ID, LINE)
        if !LINE.TEAM then return end

        LINE:SetSelected(false)
        CFG.SHOCK[LINE.TEAM] = nil
    end
    S_TEAM.OnRowSelected = function(s, ind, row)
        if !row.TEAM then return end

        CFG.SHOCK[row.TEAM] = true
    end

    for k, v in ipairs(team.GetAllTeams()) do
        local L = S_TEAM:AddLine(v.Name)
        L.TEAM = v.Name
        
        if CFG.SHOCK[v.Name] then
            L:SetSelected(true)
        end
    end
end)
--NCS_DATAPAD.CONFIG.DescLimit = 2000
--NCS_DATAPAD.CONFIG.TitleLimit = 100