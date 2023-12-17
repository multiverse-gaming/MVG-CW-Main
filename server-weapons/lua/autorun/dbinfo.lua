

include( "autorun/scifi_init.lua" )

local PANEL = {}

local color_bg_default		= Color( 150, 150, 150, 195 )
local color_bg_caption		= Color( 157, 160, 165, 75 ) --Color( 100, 100, 100, 180 )
local color_default			= Color( 150, 150, 150, 255 )
local color_default_2		= Color( 157, 160, 165, 255 ) --Color( 100, 100, 100, 180 )
local color_default_3		= Color( 117, 120, 125, 255 )
local color_default_opaq	= Color( 80, 80, 80, 180 )
local color_highlight		= Color( 220, 220, 220, 255 )

function PANEL:Init()

--	local w, h = self:GetSize()

	self:SetTitle( "SciFiWeapons - Update 16 'Midnight Dawn' (v16.1.2)" )
--	self:InvalidateLayout( true )
	self:SetSize( ScrW() * 0.4, ScrH() * 0.82 ) --( 720, 405 )
--	self:SetSizable( true )
--	self:SetPaintShadow( true )
	self:SetPos( ScrW() * 0.01, ScrH() * 0.05 )
	
	self.btnClose:SetDisabled( false )
	self.btnClose.Paint = function( panel, w, h ) draw.RoundedBox( 6, -1, 4, w * 1.05, h * 0.4, Color( 200, 20, 40, 255 ) ) end
	
	self.btnMaxim:SetDisabled( true )
	self.btnMaxim.Paint = function( panel, w, h )  end
	
	self.btnMinim:SetDisabled( true )
	self.btnMinim.Paint = function( panel, w, h )  end
	
	local sheet = vgui.Create( "DPropertySheet", self )	
	sheet.Paint = function( self, w, h ) draw.RoundedBox( 6, 0, 22, w, h - 22, color_default_2 ) end
	self.ContentPanel = sheet
	self.ContentPanel:InvalidateLayout( true )
	self.ContentPanel:Dock( FILL )
	self.ContentPanel:Center()
	
	local panel1 = vgui.Create( "DPanel", sheet )
	panel1.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, color_default_2 ) end
	sheet:AddSheet( "Debug Settings", panel1, "icon16/computer.png" )

	local panel2 = vgui.Create( "DPanel", sheet )
	panel2.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, color_default_2 ) end
	sheet:AddSheet( "Settings", panel2, "icon16/monitor_link.png" )

	local panel3 = vgui.Create( "DPanel", sheet )
	panel3.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, color_default_2 ) end
	sheet:AddSheet( "Graphics", panel3, "icon16/color_wheel.png" )
	
	local spanel1 = vgui.Create( "DScrollPanel", panel1 )
	spanel1:SetParent( panel1 )
	spanel1:SetSize( 700, 360 )
	spanel1:InvalidateLayout( true )
	spanel1:Dock( FILL )
	spanel1:Center()

	local offset = 8

	local dcbox1 = vgui.Create( "DCheckBoxLabel" )
	dcbox1:SetParent( spanel1 )
	dcbox1:SetPos( 16, offset )
	dcbox1:SetText( "Show item halos on world weapons, even if they weren't dropped by a NPC." )
	dcbox1:SetConVar( "sfw_debug_force_itemhalo" )
	dcbox1:SizeToContents()
	offset = offset + 20
		
	local dcbox2 = vgui.Create( "DCheckBoxLabel" )
	dcbox2:SetParent( spanel1 )
	dcbox2:SetPos( 16, offset )
	dcbox2:SetText( "Show current mouse/keyboard input on the screen." )
	dcbox2:SetConVar( "sfw_debug_kbinfo" )
	dcbox2:SizeToContents()
	offset = offset + 20	
	
	local dcbox3 = vgui.Create( "DCheckBoxLabel" )
	dcbox3:SetParent( spanel1 )
	dcbox3:SetPos( 16, offset )
	dcbox3:SetText( "Disable automatic weapon pickup." )
	dcbox3:SetConVar( "sfw_debug_preventautoequip" )
	dcbox3:SizeToContents()
	offset = offset + 20	
	
	local dcbox4 = vgui.Create( "DCheckBoxLabel" )
	dcbox4:SetParent( spanel1 )
	dcbox4:SetPos( 16, offset )
	dcbox4:SetText( "Show acc level on screen (mp only)" )
	dcbox4:SetConVar( "sfw_debug_showacc" )
	dcbox4:SizeToContents()
	offset = offset + 20
	
	local dcbox5 = vgui.Create( "DCheckBoxLabel" )
	dcbox5:SetParent( spanel1 )
	dcbox5:SetPos( 16, offset )
	dcbox5:SetText( "Enable advanced damage effectivities." )
	dcbox5:SetConVar( "sfw_allow_advanceddamage" )
	dcbox5:SizeToContents()
	offset = offset + 20
	
	local dDLabel_0 = vgui.Create( "DLabel", spanel1 )
	--DLabel_0:Center()
	dDLabel_0:SetPos( 166, offset )
	dDLabel_0:SetWrap( true )
	dDLabel_0:SetSize( 256, 52 )
	dDLabel_0:SetText( "Visualize damage ranges and damgage events. 1 = draw dmg ranges, 2 = show detailed info, 3 = print info into console." )
	offset = offset + 30
	
	local dsldr0 = vgui.Create( "DNumSlider", spanel1 )
	dsldr0:SetPos( -86, offset )
	dsldr0:SetSize( 250, 15 )
	dsldr0:SetMin( 0 )
	dsldr0:SetMax( 3 )
	dsldr0:SetDecimals( 0 )
	dsldr0:SetConVar( "sfw_debug_showdmgranges" )
	offset = offset + 30
	
	local dDLabel_1 = vgui.Create( "DLabel", spanel1 )
	--DLabel_0:Center()
	dDLabel_1:SetPos( 166, offset )
	dDLabel_1:SetWrap( true )
	dDLabel_1:SetSize( 256, 52 )
	dDLabel_1:SetText( "Show informations and visualizations about the elemental effect system. 1 = show ranges, 2 = print elemental info to console." )
	offset = offset + 30
	
	local dsldr1 = vgui.Create( "DNumSlider", spanel1 )
	dsldr1:SetPos( -86, offset )
	dsldr1:SetSize( 250, 15 )
	dsldr1:SetMin( 0 )
	dsldr1:SetMax( 2 )
	dsldr1:SetDecimals( 0 )
	dsldr1:SetConVar( "sfw_debug_showemlinfo" )
	offset = offset + 50
	
	local DComboBox = vgui.Create( "DComboBox", spanel1 )
	DComboBox:SetPos( 16, offset )
	DComboBox:SetSize( 128, 20 )
	DComboBox:SetValue( "Families" )
	DComboBox:AddChoice( "mtm" )
	DComboBox:AddChoice( "hwave" )
	DComboBox:AddChoice( "vprtec" )
	DComboBox:AddChoice( "nxs" )
	DComboBox:AddChoice( "t3i" )
	DComboBox:AddChoice( "dev" )
	DComboBox:AddChoice( "all" )
	DComboBox.OnSelect = function( panel, index, value )
		DComboBox:CloseMenu()
	end
	
	local DButton = vgui.Create( "DButton", spanel1 )
	DButton:SetPos( 146, offset )
	DButton:SetText( "spawn weapon family" )
	DButton:SetSize( 128, 20 )
	DButton.DoClick = function()
		if ( isstring( DComboBox:GetSelected() ) ) then
			RunConsoleCommand( "sfw_give", DComboBox:GetSelected(), "setpos", "1" )
		end
	end
	offset = offset + 60
	
	local dcbox6 = vgui.Create( "DCheckBoxLabel" )
	dcbox6:SetParent( spanel1 )
	dcbox6:SetPos( 16, offset )
	dcbox6:SetText( "Campaign mode (required for the below to work)" )
	dcbox6:SetConVar( "vh_campaign" )
	dcbox6:SizeToContents()
	offset = offset + 20
	
	local WTextLabel = vgui.Create( "DLabel", spanel1 )
	--DLabel_0:Center()
	WTextLabel:SetPos( 16, offset )
	WTextLabel:SetWrap( true )
	WTextLabel:SetSize( 512, 32 )
	WTextLabel:SetText( "Add a weapon to default loadout (ToDo: Improve!)" )
	offset = offset + 30
	
	local WTextEntry = vgui.Create( "DTextEntry", spanel1 )
	WTextEntry:SetPos( 16, offset )
	WTextEntry:SetSize( 256, 20 )
	WTextEntry:SetText( "" )
	WTextEntry.OnEnter = function( self )
		RunConsoleCommand( "vh_campaign_loadout", "add", self:GetValue() )
	end
	offset = offset + 40
	
	local DButton = vgui.Create( "DButton", spanel1 )
	DButton:SetPos( 16, offset )
	DButton:SetText( "Print current Loadout protocol into console." )
	DButton:SetSize( 140, 20 )
	DButton.DoClick = function()
		RunConsoleCommand( "vh_campaign_loadout", "print" )
	end
	offset = offset + 30
	
	local DButton = vgui.Create( "DButton", spanel1 )
	DButton:SetPos( 16, offset )
	DButton:SetText( "Clear Loadout Protocol" )
	DButton:SetSize( 140, 20 )
	DButton.DoClick = function()
		RunConsoleCommand( "vh_campaign_loadout", "clear" )
	end
	offset = offset + 30
	
	local dcbox6 = vgui.Create( "DCheckBoxLabel" )
	dcbox6:SetParent( spanel1 )
	dcbox6:SetPos( 16, offset )
	dcbox6:SetText( "Automatically add recently picked up weapons to the loadout." )
	dcbox6:SetConVar( "vh_campaign_loadout_autocompose" )
	dcbox6:SizeToContents()
	offset = offset + 20
			
--	function spanel1:Paint( w, h )
	--	draw.RoundedBox( 3, 0, 0, w, h, color_default_opaq )
--	end
--[[
	local spanel2 = vgui.Create( "DScrollPanel", panel2 )
	spanel2:SetParent( panel2 )
	spanel2:SetSize( 700, 360 )
	spanel2:InvalidateLayout( true )
	spanel2:Dock( FILL )
	spanel2:Center()
	
	function spanel2:Paint( w, h )
	--	draw.RoundedBox( 3, 0, 0, w, h, color_default_opaq )
	end
	
	local AppList = vgui.Create( "DListView" )
	AppList:SetParent( spanel2 )
	AppList:SetMultiSelect( false )
	AppList:AddColumn( "Weapon" )
	AppList:AddColumn( "Index" )
	AppList:AddColumn( "Owner" )

	timer.Create( "entscan", 0, 0, function ()
		for k,v in pairs( ents.GetAll() ) do
			if ( v:IsWeapon() && string.StartWith( v:GetClass(), "sfw_" ) ) then
				AppList:AddLine( tostring( v:GetClass() ), tostring( v:EntIndex() ), tostring( v:GetOwner() ) )
			end
		end
	end )
]]--
	local DScrollPanel = vgui.Create( "DScrollPanel", panel3 )
	DScrollPanel:SetParent( panel3 )
	DScrollPanel:SetSize( 700, 360 )
	DScrollPanel:InvalidateLayout( true )
	DScrollPanel:Dock( FILL )
	DScrollPanel:Center()
	
--	function DScrollPanel:Paint( w, h )
	--	draw.RoundedBox( 3, 0, 0, w, h, color_default_opaq )
--	end
	
	local DLabel_0 = vgui.Create( "DLabel", DScrollPanel )
	--DLabel_0:Center()
	DLabel_0:SetPos( 10, 0 )
	DLabel_0:SetWrap( true )
	DLabel_0:SetText( "CPU handling" )
	
	local cbox0 = vgui.Create( "DCheckBoxLabel" )
	cbox0:SetParent( DScrollPanel )
	cbox0:SetPos( 25, 25 )
	cbox0:SetText( "Multi-core CPU support (Experimental!)" )
	cbox0:SetConVar( "gmod_mcore_test" )
	cbox0:SizeToContents()

	local cbox1 = vgui.Create( "DCheckBoxLabel" )
	cbox1:SetParent( DScrollPanel )
	cbox1:SetPos( 25, 45 )
	cbox1:SetText( "Shadow manager in multiple threads" )
	cbox1:SetConVar( "r_threaded_client_shadow_manager" )
	cbox1:SizeToContents()
	
	local cbox2 = vgui.Create( "DCheckBoxLabel" )
	cbox2:SetParent( DScrollPanel )
	cbox2:SetPos( 25, 65 )
	cbox2:SetText( "Rendering in multiple threads" )
	cbox2:SetConVar( "r_threaded_renderables" )
	cbox2:SizeToContents()	
	
	local cbox3 = vgui.Create( "DCheckBoxLabel" )
	cbox3:SetParent( DScrollPanel )
	cbox3:SetPos( 25, 85 )
	cbox3:SetText( "Multi thread particle computation" )
	cbox3:SetConVar( "r_threaded_particles" )
	cbox3:SizeToContents()	
	
	local cbox4 = vgui.Create( "DCheckBoxLabel" )
	cbox4:SetParent( DScrollPanel )
	cbox4:SetPos( 25, 105 )
	cbox4:SetText( "Multi thread bone setup" )
	cbox4:SetConVar( "cl_threaded_bone_setup" )
	cbox4:SizeToContents()	
	
	local cbox5 = vgui.Create( "DCheckBoxLabel" )
	cbox5:SetParent( DScrollPanel )
	cbox5:SetPos( 25, 125 )
	cbox5:SetText( "Multi thread leaf system (client)" )
	cbox5:SetConVar( "cl_threaded_client_leaf_system" )
	cbox5:SizeToContents()
	
	local DLabel_1 = vgui.Create( "DLabel", DScrollPanel )
	--DLabel_0:Center()
	DLabel_1:SetPos( 10, 160 )
	DLabel_1:SetSize( 200, 15 )
	DLabel_1:SetWrap( false )
	DLabel_1:SetText( "Materials and texture handling" )
	
	local sldr0 = vgui.Create( "DNumSlider", DScrollPanel )
	sldr0:SetPos( 25, 185 )
	sldr0:SetSize( 250, 15 )
	sldr0:SetText( "Material queue mode" )
	sldr0:SetMin( -1 )
	sldr0:SetMax( 2 )
	sldr0:SetDecimals( 0 )
	sldr0:SetConVar( "mat_queue_mode" )
	
	local DLabel_2 = vgui.Create( "DLabel", DScrollPanel )
	DLabel_2:SetPos( 260, 185 )
	DLabel_2:SetSize( 400, 15 )
	DLabel_2:SetWrap( false )
	DLabel_2:SetText( "(-1 = default, 0 = synchronous single thread, 2 = queued multithreaded)" )
	
	local cbox6 = vgui.Create( "DCheckBoxLabel" )
	cbox6:SetParent( DScrollPanel )
	cbox6:SetPos( 25, 205 )
	cbox6:SetText( "Auto. precache textures" )
	cbox6:SetConVar( "mat_loadtextures" )
	cbox6:SizeToContents()
	
	local DLabel_3 = vgui.Create( "DLabel", DScrollPanel )
	--DLabel_0:Center()
	DLabel_3:SetPos( 10, 240 )
	DLabel_3:SetSize( 200, 15 )
	DLabel_3:SetWrap( false )
	DLabel_3:SetText( "Bloom effects" )
	
	local cbox7 = vgui.Create( "DCheckBoxLabel" )
	cbox7:SetParent( DScrollPanel )
	cbox7:SetPos( 25, 265 )
	cbox7:SetText( "Force bloom effect" )
	cbox7:SetConVar( "mat_force_bloom" )
	cbox7:SizeToContents()
	
	local sldr1 = vgui.Create( "DNumSlider", DScrollPanel )
	sldr1:SetPos( 25, 290 )
	sldr1:SetSize( 250, 15 )
	sldr1:SetText( "Bloom effect scale (may not have a visible effect on some HDR maps)" )
	sldr1:SetMin( 0.1 )
	sldr1:SetMax( 32 )
	sldr1:SetDecimals( 1 )
	sldr1:SetConVar( "mat_bloomscale" )
	
	local sldr2 = vgui.Create( "DNumSlider", DScrollPanel )
	sldr2:SetPos( 25, 315 )
	sldr2:SetSize( 250, 15 )
	sldr2:SetText( "Scalar factor" )
	sldr2:SetMin( 0.1 )
	sldr2:SetMax( 16 )
	sldr2:SetDecimals( 2 )
	sldr2:SetConVar( "mat_bloom_scalefactor_scalar" )
	
	local sldr3 = vgui.Create( "DNumSlider", DScrollPanel )
	sldr3:SetPos( 25, 340 )
	sldr3:SetSize( 250, 15 )
	sldr3:SetText( "Bloom tint exponent" )
	sldr3:SetMin( 0.01 )
	sldr3:SetMax( 64 )
	sldr3:SetDecimals( 2 )
	sldr3:SetConVar( "r_bloomtintexponent" )
	
	local DLabel_4 = vgui.Create( "DLabel", DScrollPanel )
	--DLabel_0:Center()
	DLabel_4:SetPos( 10, 375 )
	DLabel_4:SetSize( 200, 15 )
	DLabel_4:SetWrap( false )
	DLabel_4:SetText( "Gamma, brightness and contrast" )
	
	local sldr4 = vgui.Create( "DNumSlider", DScrollPanel )
	sldr4:SetPos( 25, 400 )
	sldr4:SetSize( 250, 15 )
	sldr4:SetText( "Monitor Gamma" )
	sldr4:SetMin( 1.6 )
	sldr4:SetMax( 2.6 )
	sldr4:SetDecimals( 1 )
	sldr4:SetConVar( "mat_monitorgamma" )
	
	local cbox8 = vgui.Create( "DCheckBoxLabel" )
	cbox8:SetParent( DScrollPanel )
	cbox8:SetPos( 25, 425 )
	cbox8:SetText( "Advanced monitor gamma (TV-Gamma)" )
	cbox8:SetConVar( "mat_monitorgamma_tv_enabled" )
	cbox8:SizeToContents()
	
	local sldr5 = vgui.Create( "DNumSlider", DScrollPanel )
	sldr5:SetPos( 25, 450 )
	sldr5:SetSize( 250, 15 )
	sldr5:SetText( "Gamma" )
	sldr5:SetMin( 1 )
	sldr5:SetMax( 5 )
	sldr5:SetDecimals( 1 )
	sldr5:SetConVar( "mat_monitorgamma_tv_exp" )
	
	local sldr6 = vgui.Create( "DNumSlider", DScrollPanel )
	sldr6:SetPos( 25, 475 )
	sldr6:SetSize( 250, 15 )
	sldr6:SetText( "Maximum brightness" )
	sldr6:SetMin( 100 )
	sldr6:SetMax( 300 )
	sldr6:SetDecimals( 0 )
	sldr6:SetConVar( "mat_monitorgamma_tv_range_max" )
	
	local sldr7 = vgui.Create( "DNumSlider", DScrollPanel )
	sldr7:SetPos( 25, 500 )
	sldr7:SetSize( 250, 15 )
	sldr7:SetText( "Contrast range" )
	sldr7:SetMin( -64 )
	sldr7:SetMax( 64 )
	sldr7:SetDecimals( 1 )
	sldr7:SetConVar( "mat_monitorgamma_tv_range_min" )
	
	local DLabel_4 = vgui.Create( "DLabel", DScrollPanel )
	--DLabel_0:Center()
	DLabel_4:SetPos( 10, 535 )
	DLabel_4:SetSize( 200, 15 )
	DLabel_4:SetWrap( false )
	DLabel_4:SetText( "Misc. and performance options" )
	
	local cbox9 = vgui.Create( "DCheckBoxLabel" )
	cbox9:SetParent( DScrollPanel )
	cbox9:SetPos( 25, 560 )
	cbox9:SetText( "Enable/Disable specularity. Will cause a material reload upon change." )
	cbox9:SetConVar( "mat_specular" )
	cbox9:SizeToContents()
	
	local cbox10 = vgui.Create( "DCheckBoxLabel" )
	cbox10:SetParent( DScrollPanel )
	cbox10:SetPos( 25, 585 )
	cbox10:SetText( "Enable/Disable shadows being rendered to textures. This may conflict with other addons/shaders." )
	cbox10:SetConVar( "r_shadowrendertotexture" )
	cbox10:SizeToContents()
	
	local DComboBox = vgui.Create( "DComboBox" )
	DComboBox:SetPos( 25, 610 )
	DComboBox:SetSize( 128, 20 )
	DComboBox:SetParent( DScrollPanel )
	DComboBox:SetValue( GetConVarNumber( "r_flashlightdepthres" ) )
	DComboBox:AddChoice( 64 )
	DComboBox:AddChoice( 128 )
	DComboBox:AddChoice( 256 )
	DComboBox:AddChoice( 512 )
	DComboBox:AddChoice( 1024 )
	DComboBox:AddChoice( 2048 )
	DComboBox:AddChoice( 4096 )
	DComboBox.OnSelect = function( panel, index, value )
	RunConsoleCommand( "r_flashlightdepthres", value )
	end
	
	local DLabel_5 = vgui.Create( "DLabel", DScrollPanel )
	DLabel_5:SetPos( 160, 610 )
	DLabel_5:SetSize( 400, 15 )
	DLabel_5:SetWrap( false )
	DLabel_5:SetText( "Projected texture resolution (as seen with flashlights, lamps, etc.)" )
	
	local cbox0 = vgui.Create( "DCheckBoxLabel" )
	cbox0:SetParent( DScrollPanel )
	cbox0:SetPos( 25, 640 )
	cbox0:SetText( "Force postprocess in one pass. Disabling this may cause PP to desynch." )
	cbox0:SetConVar( "mat_postprocessing_combine" )
	cbox0:SizeToContents()
	
	local DLabel_99 = vgui.Create( "DLabel", DScrollPanel )
	DLabel_99:SetPos( 10, 680 )
	DLabel_99:SetSize( 30, 30 )
	DLabel_99:SetWrap( false )
	DLabel_99:SetText( "" )
	
end

function PANEL:Paint( w, h )


	draw.RoundedBox( 6, 0, 0, w, h, color_bg_caption )
	draw.RoundedBox( 6, 4.6, 30, w - 10, h - 35, color_default_3 )
	
--	draw.RoundedBoxEx( 6, 0, 0, w, h * 0.0625, color_bg_caption, true, true, false, false )
	
end

function PANEL:SwitchTo( name )

	self.ContentPanel:SwitchToName( name )
	
end

if ( CLIENT ) then

	local vguiExampleWindow = vgui.RegisterTable( PANEL, "DFrame" )

	local SciFiConPanel = nil

	concommand.Add( 

		"+sfw_debug_ui", 
		
		function( player, command, arguments, args )
			if ( IsValid( SciFiConPanel ) ) then
				SciFiConPanel:Remove()
			return end
			SciFiConPanel = vgui.CreateFromTable( vguiExampleWindow )
			SciFiConPanel:SwitchTo( args )
			SciFiConPanel:MakePopup()
			--SciFiConPanel:Center()
		end, 
		nil, 
		"", 
		{ FCVAR_DONTRECORD } 
	)

	concommand.Add( 

		"-sfw_debug_ui", 
		
		function( player, command, arguments, args )
			if ( IsValid( SciFiConPanel ) ) then
				for k,v in pairs( SciFiConPanel:GetChildren() ) do
					if ( IsValid( v ) ) then
						v:Remove()
					end
				end
				SciFiConPanel:Remove()
			end
		end, 
		nil, 
		"", 
		{ FCVAR_DONTRECORD } 
	)
	
end