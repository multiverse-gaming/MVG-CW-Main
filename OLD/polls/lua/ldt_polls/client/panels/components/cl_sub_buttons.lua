local PANEL = {}

local icons = {
    {
        Icon = Material("ldt_polls/running_btn.png", "noclamp smooth"),
        IconPressed = Material("ldt_polls/running_btn_pressed.png", "noclamp smooth"),
        Sizex = 144
    },
    {
        Icon = Material("ldt_polls/ended_btn.png", "noclamp smooth"),
        IconPressed = Material("ldt_polls/ended_btn_pressed.png", "noclamp smooth"),
        Sizex = 144
    },
    {
        Icon = Material("ldt_polls/your_btn.png", "noclamp smooth"),
        IconPressed = Material("ldt_polls/your_btn_pressed.png", "noclamp smooth"),
        Sizex = 128
    },
    {
        Icon = Material("ldt_polls/stats_btn.png", "noclamp smooth"),
        IconPressed = Material("ldt_polls/stats_btn_pressed.png", "noclamp smooth"),
        Sizex = 128
    }
}
local leftArrow = Material("ldt_polls/arrow-left.png", "noclamp smooth")
local rightArrow = Material("ldt_polls/arrow-right.png", "noclamp smooth")

-- The individual types of polls
local types = {"Running", "Finished", "Your"}

-- Setup default properties of this panel
function PANEL:Init()
    if LDT_Polls.Config.EnableStatistics then
        types[4] = "Stats"
    end

    self:Dock(TOP)
    self:SetTall(LDT_Polls.GetHeight(24))
    self:DockMargin(LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10), LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10))
    self:SetOverlap( -LDT_Polls.GetWidth(15) )
    self:FillButtons()

    self.btnLeft.Paint = function(me, w, h)
        surface.SetMaterial( leftArrow )
        surface.SetDrawColor( LDT_Polls.Config.White )
        surface.DrawTexturedRect( 0,0, LDT_Polls.GetWidth(w), LDT_Polls.GetHeight(w) )
    end

    self.btnRight.Paint = function(me, w, h)
        surface.SetMaterial( rightArrow )
        surface.SetDrawColor( LDT_Polls.Config.White )
        surface.DrawTexturedRect( 0,0, LDT_Polls.GetWidth(w), LDT_Polls.GetHeight(w) )
    end
end

-- This function creates the individual btns
function PANEL:FillButtons()
    self.DImage = {}

    for k,v in ipairs(types) do
        self.DImage[k] = self:Add("DImageButton")
        self.DImage[k]:SetWide(LDT_Polls.GetWidth(icons[k].Sizex))
        self.DImage[k].DoClick = function()
            if LDT_Polls.CurrentType == v then return end
            LDT_Polls.CurrentType = v
            
            if IsValid(LDT_Polls.mainPanelThis.centerPanel) then
                LDT_Polls.mainPanelThis.centerPanel:Remove()
            end

            if v == "Stats" then
                LDT_Polls.mainPanelThis.centerPanel = LDT_Polls.mainPanelThis:Add( "PollsStatsPanel" )
            else
                LDT_Polls.mainPanelThis.centerPanel = LDT_Polls.mainPanelThis:Add( "PollsPanel" )
                LDT_Polls.mainPanelThis.centerPanel:SetType(k)
            end

            LDT_Polls.mainPanelThis.selected = k
            LDT_Polls.TopSecTextMsg = ""
            if v == "Running" then
                LDT_Polls.TopTextMsg = LDT_Polls.GetLanguange("CurrentPollsTitle")
            elseif v == "Finished" then
                LDT_Polls.TopTextMsg = LDT_Polls.GetLanguange("EndedPollsTitle")
            elseif v == "Your" then
                LDT_Polls.TopTextMsg = LDT_Polls.GetLanguange("YourPollsTitle")
            elseif v == "Stats" then
                LDT_Polls.TopTextMsg = LDT_Polls.GetLanguange("StatsTitle")
                LDT_Polls.TopSecTextMsg = LDT_Polls.GetInterval()
            end
        end

        self.DImage[k].Paint = function(me, w, h)
            if LDT_Polls.mainPanelThis.selected == k then
                surface.SetMaterial( icons[k].IconPressed )
            else
                surface.SetMaterial( icons[k].Icon )
            end

            surface.SetDrawColor( LDT_Polls.Config.White )
            surface.DrawTexturedRect( 0, 0, LDT_Polls.GetWidth(icons[k].Sizex), LDT_Polls.GetHeight(24) )
        end

        self:AddPanel( self.DImage[k] )
    end

    LDT_Polls.mainPanelThis.centerPanel = LDT_Polls.mainPanelThis:Add( "PollsPanel" )
    LDT_Polls.mainPanelThis.centerPanel:SetType(LDT_Polls.mainPanelThis.selected)
    LDT_Polls.TopTextMsg = LDT_Polls.GetLanguange("CurrentPollsTitle")
end

function PANEL:OnSizeChanged(w, h)
end

-- Change the defualt paint.
function PANEL:Paint(w, h)
end

vgui.Register("PollsSubBtns", PANEL, "DHorizontalScroller")