include('shared.lua')

function ENT:Draw()
    self:DrawModel()
end

function DrawTheMenu()
local random1 = math.random(1, 4)
local random2 = math.random(1, 4)
local random3 = math.random(1, 4)
local random4 = math.random(1, 4)
local randomserial = math.random(1000, 9999)
local randomserial2 = math.random(1, 9)
imhere = true
frame = vgui.Create("DFrame")
frame:SetSize(1000, 720)
frame:Center()
frame:SetVisible(true)
frame:SetDraggable( false )
frame:ShowCloseButton( true )
frame:MakePopup()
frame:SetTitle("Interface")
frame.Paint = function(self, w, h)
	draw.RoundedBox(0,0,0,w, h, Color(0,0,0,255))
	draw.RoundedBox( 0, 2, 2, w-4, h-4, Color(  102,102,102, 255 ))	
end

local wire1 = vgui.Create("DButton" , frame)
wire1:SetSize(30, 650)
wire1:SetPos(350, 50)
wire1:SetText("1")
local wire2 = vgui.Create("DButton" , frame)
wire2:SetSize(30, 650)
wire2:SetPos(450, 50)
wire2:SetText("2")
local wire3 = vgui.Create("DButton" , frame)
wire3:SetSize(30, 650)
wire3:SetPos(550, 50)
wire3:SetText("3")
local wire4 = vgui.Create("DButton" , frame)
wire4:SetSize(30, 650)
wire4:SetPos(650, 50)
wire4:SetText("4")


if (random1 == 1) then
	wire1.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 0, 0, 250 ) )
end
end
if (random1 == 2) then
	wire1.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 0, 250 ) )
end
end
if (random1 == 3) then
	wire1.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 255, 250 ) )
end
end
if (random1 == 4) then
	wire1.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 250 ) )
end
end
if (random2 == 1) then
	wire2.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 0, 0, 250 ) )
end
end
if (random2 == 2) then
	wire2.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 0, 250 ) )
end
end
if (random2 == 3) then
	wire2.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 255, 250 ) )
end
end
if (random2 == 4) then
	wire2.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 250 ) )
end
end
if (random3 == 1) then
	wire3.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 0, 0, 250 ) )
end
end
if (random3 == 2) then
	wire3.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 0, 250 ) )
end
end
if (random3 == 3) then
	wire3.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 255, 250 ) )
end
end
if (random3 == 4) then
	wire3.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 250 ) )
end
end
if (random4 == 1) then
	wire4.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 0, 0, 250 ) )
end
end
if (random4 == 2) then
	wire4.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 0, 250 ) )
end
end
if (random4 == 3) then
	wire4.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 255, 250 ) )
end
end
if (random4 == 4) then
	wire4.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 250 ) )
end
end
if (random1 == 3 and random2 == 3 or random1 == 3 and random3 == 3 or random1 == 3 and random4 == 3 or random2 == 3 and random3 == 3 or random2 == 3 and random4 == 3 or random3 == 3 and random4 == 3) then
	wire2.DoClick = function()
       net.Start("Print")
       net.SendToServer()
       frame:Close()
    end
    wire3.DoClick = function()
       net.Start("Damage")
       net.SendToServer()
       frame:Close()
    end
    wire1.DoClick = function()
       net.Start("Damage")
       net.SendToServer()
       frame:Close()
    end
    wire4.DoClick = function()
       net.Start("Damage")
       net.SendToServer()
       frame:Close()
    end
elseif (random4 == 4) then
	wire1.DoClick = function()
       net.Start("Damage")
       net.SendToServer()
       frame:Close()
    end
    wire2.DoClick = function()
       net.Start("Damage")
       net.SendToServer()
       frame:Close()
    end
    wire3.DoClick = function()
       net.Start("Print")
       net.SendToServer()
       frame:Close()
    end
    wire4.DoClick = function()
       net.Start("Damage")
       net.SendToServer()
       frame:Close()
    end
elseif (random1 == 4) then
    wire3.DoClick = function()
       net.Start("Damage")
       net.SendToServer()
       frame:Close()
    end
    wire2.DoClick = function()
       net.Start("Damage")
       net.SendToServer()
       frame:Close()
    end
    wire4.DoClick = function()
       net.Start("Print")
       net.SendToServer()
       frame:Close()
    end
    wire1.DoClick = function()
       net.Start("Damage")
       net.SendToServer()
       frame:Close()
    end
elseif(random1 == 1 && random4 == 1) then
	wire3.DoClick = function()
       net.Start("Damage")
       net.SendToServer()
       frame:Close()
    end
    wire2.DoClick = function()
       net.Start("Print")
       net.SendToServer()
       frame:Close()
    end
    wire1.DoClick = function()
       net.Start("Damage")
       net.SendToServer()
       frame:Close()
    end
    wire4.DoClick = function()
       net.Start("Damage")
       net.SendToServer()
       frame:Close()
    end
else
    wire3.DoClick = function()
       net.Start("Damage")
       net.SendToServer()
       frame:Close()
    end
    wire4.DoClick = function()
       net.Start("Print")
       net.SendToServer()
       frame:Close()
    end
    wire1.DoClick = function()
       net.Start("Damage")
       net.SendToServer()
       frame:Close()
    end
    wire2.DoClick = function()
       net.Start("Damage")
       net.SendToServer()
       frame:Close()
    end
  end
end
usermessage.Hook( "DrawTheMenu", DrawTheMenu )

function DrawTheDatapadMenu()
		local frame = vgui.Create( "DFrame" )
		frame:SetSize( ScrW() * 0.26, ScrH() *0.5)
		frame:SetPos( 50, 50 )	
		frame:MakePopup()
		frame:SetTitle("Bomben Entschäfung")														-- Titel
		frame.Paint = function(self, w, h)
			draw.RoundedBox(0,0,0,w, h, Color(0,0,0,255))
			draw.RoundedBox( 0, 2, 2, w-4, h-4, Color(  25,  25, 112, 255 ))
		end
		local TextEntry = vgui.Create( "DTextEntry", frame )									-- Textfeld erstellen
		TextEntry:SetPos( 25, 50 )
		TextEntry:SetSize( 450 , 125 )
		TextEntry:SetText("Dieser Bereich ist nur für die BSQ gedacht. Hier sind die verschiedensten Bomben aufgelistet und die möglichen Situtaionen, wenn man eine Bombe entschärfen will.")			
		TextEntry:SetMultiline(true)
		local DermaListView = vgui.Create("DListView")											-- Spieler liste anzeigen
		DermaListView:SetParent(frame)
		DermaListView:SetPos(25, 200)
		DermaListView:SetSize(450, 110)
		DermaListView:SetMultiSelect(false)
		DermaListView:AddColumn("Situation")													-- Spalte mit Situationen
		DermaListView:AddColumn("Kabel")														-- Spalte mit Kabel zum anklicken
		DermaListView:AddLine( "Mehr als 1 Blaues Kabel", "2." )
		DermaListView:AddLine( "1. Kabel Gelb", "4." )
		DermaListView:AddLine( "4. Kabel Schwarz", "3." )
		DermaListView:AddLine( "1. und 4. Kabel Rot", "2." )
		DermaListView:AddLine( "Nichts zutreffend", "4." )
		
		local DermaListView = vgui.Create("DListView")											-- Liste anzeigen
		DermaListView:SetParent(frame)
		DermaListView:SetPos(25, 330)
		DermaListView:SetSize(450, 110)
		DermaListView:SetMultiSelect(false)
		DermaListView:AddColumn("Bombe")													-- Spalte mit Namen der Bombe
		DermaListView:AddColumn("Code")														-- Spalte für den Code
		DermaListView:AddLine( "Große MK2 Bombe", "10100011" )
		DermaListView:AddLine( "Mittlere MK2 Bombe", "10000000" )
		DermaListView:AddLine( "Kleine MK2 Bombe", "01010101" )
		DermaListView:AddLine( "Trainings MK2 Bombe", "00000100" )
		DermaListView:AddLine("Gas MK2 Bombe", "11010001")
end
usermessage.Hook("DrawTheDatapadMenu", DrawTheDatapadMenu)