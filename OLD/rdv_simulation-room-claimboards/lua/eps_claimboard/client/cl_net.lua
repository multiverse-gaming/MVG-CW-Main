--[[

    Claim Panel Opened.

--]]

local pre = EPS_ClaimBoard_Config.Prefix
local precolor = EPS_ClaimBoard_Config.PrefixColor

local function OpenStatus(ent)
    if ent:GetClaimBoardOpen() then
        return "Open"
    else
        return "Closed"
    end
end

net.Receive("OpenClaimPanel", function()
    local entity = net.ReadEntity()
    local open = true

    local EPS_ClaimBoard_Frame = vgui.Create("XeninUI.Frame")
    EPS_ClaimBoard_Frame:SetTitle("Claim Board")
    EPS_ClaimBoard_Frame:SetSize(ScrW() * 0.4, ScrH() * 0.4)
    EPS_ClaimBoard_Frame:Center()
    EPS_ClaimBoard_Frame:MakePopup()

    EPS_ClaimBoard_Frame.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, XeninUI.Theme.Primary)
    end

    local EPS_ClaimBoard_Title = vgui.Create("XeninUI.TextEntry", EPS_ClaimBoard_Frame)
    EPS_ClaimBoard_Title:SetSize(ScrW() * 0.3, ScrH() * 0.05)
    EPS_ClaimBoard_Title:SetPos(ScrW() * 0, ScrH() * 0.1)
    EPS_ClaimBoard_Title:CenterHorizontal()
    EPS_ClaimBoard_Title:SetPlaceholder("Title Text")

    local EPS_ClaimBoard_Battalion = vgui.Create("XeninUI.Button")
    EPS_ClaimBoard_Battalion:SetParent(EPS_ClaimBoard_Frame)
    EPS_ClaimBoard_Battalion:SetText("Battalion")
    EPS_ClaimBoard_Battalion:SetTextColor(Color(255,255,255, 255))
    EPS_ClaimBoard_Battalion:SetSize(ScrW() * 0.1, ScrH() * 0.05)
    EPS_ClaimBoard_Battalion:SetPos(ScrW() * 0.08, ScrH() * 0.225)
    EPS_ClaimBoard_Battalion:SetFont("XeninUI.EPSClaimboard.Button")

    EPS_ClaimBoard_Battalion.DoClick = function(btn)
        local EPS_Options = DermaMenu()


        for k, v in pairs(EPS_ClaimBoard_Config.Battalions) do
            if EPS_ClaimBoard_Config.Battalions[k].Jobs[team.GetName(LocalPlayer():Team())] then
                EPS_Options:AddOption(k, function()
                    EPS_ClaimBoard_Battalion:SetText(k)

                    surface.PlaySound("common/talk.wav")
                end)
            end
        end

        surface.PlaySound("common/talk.wav")

        EPS_Options:Open()
    end


    EPS_ClaimBoard_Battalion.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, XeninUI.Theme.Navbar)
    end
	
    local EPS_ClaimBoard_Status = vgui.Create("XeninUI.Button")
    EPS_ClaimBoard_Status:SetParent(EPS_ClaimBoard_Frame)
    EPS_ClaimBoard_Status:SetText("Status")
    EPS_ClaimBoard_Status:SetTextColor(Color(255,255,255, 255))
    EPS_ClaimBoard_Status:SetSize(ScrW() * 0.1, ScrH() * 0.05)
    EPS_ClaimBoard_Status:SetPos(ScrW() * 0.215, ScrH() * 0.225)
    EPS_ClaimBoard_Status:SetFont("XeninUI.EPSClaimboard.Button")

    EPS_ClaimBoard_Status.DoClick = function(btn)
    local OpenCloseStatusOptions = DermaMenu()
        OpenCloseStatusOptions:AddOption("Open", function() surface.PlaySound("common/talk.wav") EPS_ClaimBoard_Status:SetText("Open") open = true end)
        OpenCloseStatusOptions:AddOption("Closed", function() surface.PlaySound("common/talk.wav") EPS_ClaimBoard_Status:SetText("Closed") open = false end)
		OpenCloseStatusOptions:Open()

        surface.PlaySound("common/talk.wav")
    end
    EPS_ClaimBoard_Status.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, XeninUI.Theme.Navbar)
    end
	
    local EPS_ClaimBoard_Save = vgui.Create("XeninUI.Button", EPS_ClaimBoard_Frame)
    EPS_ClaimBoard_Save:SetText("Save")
    EPS_ClaimBoard_Save:SetTextColor(Color(255,255,255, 255))
    EPS_ClaimBoard_Save:SetSize(ScrW() * 0.1, ScrH() * 0.05)
    EPS_ClaimBoard_Save:SetPos(ScrW() * 0.08, ScrH() * 0.325)
    EPS_ClaimBoard_Save:SetFont("XeninUI.EPSClaimboard.Button")

    EPS_ClaimBoard_Save.DoClick = function()
        if EPS_ClaimBoard_Battalion:GetText() ~= "Battalion" and EPS_ClaimBoard_Title:GetText() ~= "" then
        	net.Start("UpdateClaimPanel")
        	    net.WriteEntity(entity)
        	    net.WriteString(EPS_ClaimBoard_Battalion:GetText())
        	    net.WriteString(EPS_ClaimBoard_Title:GetText())
        	    net.WriteBool(open)
        	net.SendToServer()
        else
            chat.AddText(precolor, "["..pre.."] ", Color(255,255,255), "Please fill out all the information.")
            surface.PlaySound("common/talk.wav")
        end

        EPS_ClaimBoard_Frame:Remove()
    end

    EPS_ClaimBoard_Save.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, XeninUI.Theme.Navbar)
    end

    local EPS_ClaimBoard_Unclaim = vgui.Create("XeninUI.Button", EPS_ClaimBoard_Frame)
    EPS_ClaimBoard_Unclaim:SetText("Unclaim")
    EPS_ClaimBoard_Unclaim:SetTextColor(Color(255,255,255, 255))
    EPS_ClaimBoard_Unclaim:SetSize(ScrW() * 0.1, ScrH() * 0.05)
    EPS_ClaimBoard_Unclaim:SetPos(ScrW() * 0.215, ScrH() * 0.325)
    EPS_ClaimBoard_Unclaim:SetFont("XeninUI.EPSClaimboard.Button")

    EPS_ClaimBoard_Unclaim.DoClick = function()
        net.Start("UnclaimClaimPanel")
            net.WriteEntity(entity)
        net.SendToServer()

        EPS_ClaimBoard_Frame:Remove()
    end

    EPS_ClaimBoard_Unclaim.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, XeninUI.Theme.Navbar)
    end

    if entity:GetClaimBoardClaimed() then
        EPS_ClaimBoard_Title:SetText(entity:GetClaimBoardTitle())
        EPS_ClaimBoard_Battalion:SetText(entity:GetClaimBoardBat())
		
		EPS_ClaimBoard_Status:SetText(OpenStatus(entity))
    end
end)

net.Receive("EPS_ClaimBoard_Inspect", function()
    local ent = net.ReadEntity()

    local EPS_ClaimBoard_Frame = vgui.Create("XeninUI.Frame")
    EPS_ClaimBoard_Frame:SetTitle("Claim-Board")
    EPS_ClaimBoard_Frame:SetSize(ScrW() * 0.4, ScrH() * 0.4)
    EPS_ClaimBoard_Frame:Center()
    EPS_ClaimBoard_Frame:MakePopup()

    EPS_ClaimBoard_Frame.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, XeninUI.Theme.Primary)
    end

    local EPS_ClaimBoard_Title = vgui.Create("XeninUI.TextEntry", EPS_ClaimBoard_Frame)
    EPS_ClaimBoard_Title:SetSize(ScrW() * 0.3, ScrH() * 0.05)
    EPS_ClaimBoard_Title:SetPos(ScrW() * 0, ScrH() * 0.1)
    EPS_ClaimBoard_Title:Dock(FILL)
    EPS_ClaimBoard_Title.textentry:SetMultiline(true)
    EPS_ClaimBoard_Title.textentry:SetEditable(false)
    EPS_ClaimBoard_Title.textentry:SetKeyBoardInputEnabled(false)
    EPS_ClaimBoard_Title.textentry:SetMouseInputEnabled(false)

    EPS_ClaimBoard_Title:SetText("Title: "..ent:GetClaimBoardTitle().."\n\nStatus: "..OpenStatus(ent).."\nClaimer: "..ent:GetClaimBoardClaimer():Name().." \nBattalion: "..ent:GetClaimBoardBat())

    local EPS_ClaimBoard_Unclaim = vgui.Create("XeninUI.Button", EPS_ClaimBoard_Frame)
    EPS_ClaimBoard_Unclaim:SetText("Unclaim")
    EPS_ClaimBoard_Unclaim:SetTextColor(Color(255,255,255, 255))
    EPS_ClaimBoard_Unclaim:Dock(BOTTOM)
    EPS_ClaimBoard_Unclaim:SetFont("XeninUI.EPSClaimboard.Button")

    EPS_ClaimBoard_Unclaim.DoClick = function()
        net.Start("EPS_Admin_Unclaim")
            net.WriteEntity(ent)
        net.SendToServer()

        EPS_ClaimBoard_Frame:Remove()
    end

    EPS_ClaimBoard_Unclaim.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, XeninUI.Theme.Navbar)
    end
end)