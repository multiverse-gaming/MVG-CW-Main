-- Open the Polls UI
local function OpenPollsUI()
    if IsValid(LDT_Polls.mainPanel) then
        LDT_Polls.mainPanel:Remove()
    end

    LDT_Polls.mainPanel = vgui.Create( "PollsFrame" )
    LDT_Polls.mainPanel:SetSize( LDT_Polls.Config.Scrw*0.3, LDT_Polls.Config.Scrh*0.6 )
    LDT_Polls.mainPanel:Center()
    LDT_Polls.mainPanel:MakePopup()
    LDT_Polls.mainPanel:ShowCloseButton(false)
    LDT_Polls.mainPanel:Show()
end

net.Receive("LDT_Polls_OpenPollsUI", function()
    if not IsValid(LDT_Polls.ply) then
        LDT_Polls.ply = LocalPlayer()
    end
	OpenPollsUI()
end)