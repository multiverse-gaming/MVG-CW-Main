

--include("sh_services_config.lua")



surface.CreateFont( "911_font_36", { font = "DermaDefault", size = 36, weight = 600, bold = true, strikeout = false, outline = false, shadow = false, outline = false,})

surface.CreateFont( "911_font_24", { font = "DermaDefault", size = 24, weight = 600, bold = true, strikeout = false, outline = false, shadow = false, outline = false,})

surface.CreateFont( "911_font_20", { font = "DermaDefault", size = 20, weight = 600, bold = true, strikeout = false, outline = false, shadow = false, outline = false,})

surface.CreateFont( "911_font_18", { font = "DermaDefault", size = 18, weight = 600, bold = true, strikeout = false, outline = false, shadow = false, outline = false,})

surface.CreateFont( "911_font_16", { font = "DermaDefault", size = 16, weight = 600, bold = true, strikeout = false, outline = false, shadow = false, outline = false,})

surface.CreateFont( "911_font_14", { font = "DermaDefault", size = 14, weight = 600, bold = true, strikeout = false, outline = false, shadow = false, outline = false,})

surface.CreateFont( "911_font_11", { font = "DermaDefault", size = 11, weight = 600, bold = true, strikeout = false, outline = false, shadow = false, outline = false,})



local x = ScrW()

local y = ScrH()





net.Receive("services_location", function(len,ply)


	local Message = net.ReadString()

	local Location = net.ReadVector()

	local Caller = net.ReadEntity()

	local pad = 100

	

	timer.Create("call timer", CONFIG_SERVICES.CoolDown, 1, function()

	

	end)

	hook.Add("HUDPaint", "Location", function()

		if IsValid(Caller) then 

			if timer.Exists("call timer") then

				if Location:Distance(LocalPlayer():GetPos()) < CONFIG_SERVICES.MaxDistance and Location:Distance(LocalPlayer():GetPos()) > CONFIG_SERVICES.MinDistance then

					draw.SimpleText(Caller:GetName()..": "..Message, "911_font_16", Location:ToScreen().x + 33, Location:ToScreen().y - 160 + pad + 1, color_black)

					draw.SimpleText(Caller:GetName()..": "..Message, "911_font_16", Location:ToScreen().x + 32, Location:ToScreen().y - 160 + pad, color_white)

					draw.SimpleText("Expires in: "..math.Round(timer.TimeLeft("call timer")).." seconds", "911_font_16", Location:ToScreen().x + 33, Location:ToScreen().y - 140 + pad + 1, color_black)

					draw.SimpleText("Expires in: "..math.Round(timer.TimeLeft("call timer")).." seconds", "911_font_16", Location:ToScreen().x + 32, Location:ToScreen().y - 140 + pad, color_white)

					draw.SimpleText(math.Round(Location:Distance(LocalPlayer():GetPos()) / 60).."m" , "911_font_16", Location:ToScreen().x + 33, Location:ToScreen().y - 120 + pad + 1, color_black)

					draw.SimpleText(math.Round(Location:Distance(LocalPlayer():GetPos()) / 60).."m" , "911_font_16", Location:ToScreen().x + 32, Location:ToScreen().y - 120 + pad, color_white)

				end			

				if Location:Distance(LocalPlayer():GetPos()) > CONFIG_SERVICES.MinDistance then

					surface.SetDrawColor(color_white)
					
					--surface.SetMaterial(Material(Image))

					local xpos, ypos = math.Clamp(Location:ToScreen().x, 0, ScrW() - 32), math.Clamp(Location:ToScreen().y - 162 + pad, 0, ScrH() - 32)

					
					surface.DrawTexturedRect( xpos, ypos, 32, 32)

				end

			end

		end

	end)





end)





net.Receive("serivces_notification", function(len,ply)



	surface.PlaySound( "weapons/ar2/ar2_reload_push.wav" )

	

	local Text = net.ReadString()

	

	local FrameW = 400

	

	local Frame = vgui.Create("DFrame")

	

	Frame:SetSize(FrameW, 40)

	

	Frame:SetPos(- 600, 200)

	

	Frame:MoveTo(30, 200, .3)

	

	Frame:SetTitle("")

	

	Frame:ShowCloseButton(false)

	

	Frame.Paint = function(me,w,h)

	

		surface.SetDrawColor(CONFIG_SERVICES.ThemeColor)

		surface.DrawRect(0,0,w,h)

		

		surface.SetDrawColor(CONFIG_SERVICES.BackgroundColor)

		surface.DrawRect(2,2,w - 4,h - 4)

		

		

		draw.SimpleText(Text,"911_font_16", 5, 20, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

			

	end

	

	timer.Simple(3.5, function()

	

	Frame:MoveTo(- 600, 200, .3)

	

	timer.Simple(3.5, function()

	

	Frame:Remove()

	

		end)

		

	end)









end)




net.Receive("services_open", function()

	local senderPos = net.ReadVector()

	ServiceMenu(senderPos)


end)





function ServiceMenu(senderPos)

	

	local sender = LocalPlayer()

	local Frame = vgui.Create("DFrame")

	Frame:SetSize(420,520)

	Frame:Center()

	Frame:SetTitle("")

	Frame:MakePopup()

	

	local ScrollList = vgui.Create("DScrollPanel", Frame)

	ScrollList:SetPos(0,60)

	ScrollList:SetSize(Frame:GetWide() + 20,Frame:GetTall() - 60)

	ScrollList.Paint = function(me, w, h)

	end



	local ypos = 0



	local Acceleration = 200



	for k, v in pairs(CONFIG_SERVICES.Settings) do 

		

		local CallPanel = vgui.Create("DPanel", ScrollList)

		CallPanel:SetSize(Frame:GetWide() - 40, 60)

		CallPanel:SetPos(20, ypos)

		

		local CallButton = vgui.Create("DButton", CallPanel)

		CallButton:SetSize(50,40)

		CallButton:SetPos(CallPanel:GetWide() - 60, 10)

		CallButton:SetText("")

		CallButton.textXpos1 = CallButton:GetWide() / 2

		CallButton.textXpos2 = -50

		

		CallButton.DoClick = function()

		

		ServicesCall(k, senderPos)

		Frame:Close()

	end

	Frame.Paint = function(me,w,h)

	

		surface.SetDrawColor(CONFIG_SERVICES.BackgroundColor)

		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(CONFIG_SERVICES.ThemeColor)

		surface.DrawRect(0,0,w,40)

		surface.SetDrawColor(CONFIG_SERVICES.CallPanelColor)

		surface.DrawRect(0,40,w,2)

		draw.SimpleText(CONFIG_SERVICES.MenuTitle,"911_font_24", w / 2, 20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	

	end

	
	
	CallPanel.Paint = function(me,w,h)

		
		surface.SetDrawColor(CONFIG_SERVICES.CallPanelColor)

		surface.DrawRect(0,0,w,h)
		--[[

		surface.SetDrawColor(CONFIG_SERVICES.ImagePanel)

		surface.DrawRect(10,10,40,40)

		surface.SetDrawColor(color_white)

		surface.SetMaterial(Material(CONFIG_SERVICES.Settings[k].icon))

		surface.DrawTexturedRect(14, 14, 32, 32)
		]]

		surface.SetDrawColor(CONFIG_SERVICES.ThemeColor)

		surface.DrawRect(0, h - 2, w, 2)

		surface.DrawRect(0, 0, w, 2)

		draw.SimpleText(k, "911_font_18", 10, 10, CONFIG_SERVICES.Settings[k].colorCustom, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		
		draw.SimpleText("Currently Online: "..CONFIG_SERVICES.Settings[k].plyOnline, "911_font_16", 10, 25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		draw.SimpleText(CONFIG_SERVICES.Settings[k].Description, "911_font_16", 10, 40, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		

	end

	

	



	CallButton.Paint = function(me,w,h)

		local price = CONFIG_SERVICES.Settings[k].price

		

		surface.SetDrawColor(CONFIG_SERVICES.ImagePanel)

		surface.DrawRect(0,0,w,h)

		

		surface.SetDrawColor(CONFIG_SERVICES.ThemeColor)

		surface.DrawRect(0, h - 2, w, 2)

		surface.DrawRect(0, 0, w, 2)

		draw.SimpleText("Call", "911_font_14", me.textXpos1, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)



		draw.SimpleText("Call", "911_font_18", me.textXpos2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if !me:IsHovered() then

		

			if me.textXpos1 > w / 2 then



				me.textXpos1 = me.textXpos1 - Acceleration * FrameTime()

			

			end

			

			if me.textXpos2 > -50 then

			

				me.textXpos2 = me.textXpos2 - Acceleration * FrameTime()

			

			end

		

		end

		

		if me:IsHovered() then

		

			surface.SetDrawColor(CONFIG_SERVICES.HighlightColor)

			surface.DrawRect(0,0,w,h)

		

			if me.textXpos1 < w + 50 then

				me.textXpos1 = me.textXpos1 + Acceleration * FrameTime()

			end

			

			if me.textXpos2 < w / 2  then

				me.textXpos2 = me.textXpos2 + Acceleration * FrameTime()

			end

			

		end

	end
	ypos = ypos + 80

end





end





function ServicesCall(title, senderPos)





	local CallFrame = vgui.Create("DFrame")

	

	CallFrame:SetSize(400, 110)

	CallFrame:Center()

	CallFrame:SetTitle("")

	CallFrame:MakePopup()

	

	local CallPanel = vgui.Create("DPanel", CallFrame)

	CallPanel:SetSize(CallFrame:GetWide() - 40, 60)

	CallPanel:SetPos(20, 40)

	

	local TextEntry = vgui.Create( "DTextEntry", CallPanel ) -- create the form as a child of frame

	TextEntry:SetPos( 55, 20 )

	TextEntry:SetSize( CallPanel:GetWide() - 110, 20 )

	TextEntry:SetText( "" )

	

	local SendButton = vgui.Create("DButton", CallPanel)

	SendButton:SetSize(40,40)

	SendButton:SetPos(CallPanel:GetWide() - 50, 10)

	SendButton:SetText("")

	

	SendButton.DoClick = function()

	net.Start("services_request")

	net.WriteVector(senderPos)

	net.WriteString(title)

	net.WriteString(TextEntry:GetValue())


	net.SendToServer()

	CallFrame:Close()

	

	end

	
	

	CallFrame.Paint = function(me,w,h)

	

		surface.SetDrawColor(CONFIG_SERVICES.BackgroundColor)

		surface.DrawRect(0,0,w,h)

		

		surface.SetDrawColor(CONFIG_SERVICES.ThemeColor)

		surface.DrawRect(0,0,w,30)

		

		surface.SetDrawColor(CONFIG_SERVICES.CallPanelColor)

		surface.DrawRect(0,30,w,2)

		

		draw.SimpleText(title,"911_font_24", w / 2, 15, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	

	

	end

	
	CallPanel.Paint = function(me,w,h)

	

		surface.SetDrawColor(CONFIG_SERVICES.CallPanelColor)

		surface.DrawRect(0,0,w,h)

		--[[


		surface.SetDrawColor(CONFIG_SERVICES.ImagePanel)

		surface.DrawRect(10,10,40,40)

		surface.SetDrawColor(color_white)

		surface.SetMaterial(Material(image))

		surface.DrawTexturedRect(14, 14, 32, 32)

			]]--


		surface.SetDrawColor(CONFIG_SERVICES.ThemeColor)

		surface.DrawRect(0, h - 2, w, 2)

		surface.DrawRect(0, 0, w, 2)

		

	end
	

	SendButton.Paint = function(me,w,h)

		

		surface.SetDrawColor(CONFIG_SERVICES.ImagePanel)

		surface.DrawRect(0,0,w,h)

		

		surface.SetDrawColor(CONFIG_SERVICES.ThemeColor)

		surface.DrawRect(0, h, w, 2)

		surface.DrawRect(0, 0, w, 2)

		

		draw.SimpleText("Call", "911_font_18", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		

		if me:IsHovered() then 

		

			surface.SetDrawColor(CONFIG_SERVICES.HighlightColor)

			surface.DrawRect(0,0,w,h)

			

		end

	

	

	

	end

	

	TextEntry.Paint = function(me,w,h)



		surface.SetDrawColor(CONFIG_SERVICES.ThemeColor)

		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(CONFIG_SERVICES.ImagePanel)

		surface.DrawRect(0,2,w, h -4)

		draw.SimpleText(TextEntry:GetValue(), "911_font_11", 5, me:GetTall() / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		

		if TextEntry:IsHovered() then 

		

			surface.SetDrawColor(Color(CONFIG_SERVICES.ThemeColor.r, CONFIG_SERVICES.ThemeColor.g, CONFIG_SERVICES.ThemeColor.b, 30))

			surface.DrawRect(0,0,w,h)



		end

	

	end





end



net.Receive("services_receive", function()


	local message = net.ReadString()

	local location = net.ReadVector()

	local sender = net.ReadEntity()


	local Frame = vgui.Create("DFrame")

	Frame:SetSize(300, 130)

	Frame:SetPos(x - Frame:GetWide() - 10, y - Frame:GetTall() - CONFIG_SERVICES.PopupYPos)

	Frame:SetTitle("")

	Frame:ShowCloseButton(false)

	

	local CallPanel = vgui.Create("DPanel", Frame)

	CallPanel:SetSize(Frame:GetWide() - 40, 60)

	CallPanel:SetPos(20, 40)

	

	local AcceptButton = vgui.Create("DButton", Frame)

	AcceptButton:SetSize(60,30)

	AcceptButton:SetPos(Frame:GetWide() - AcceptButton:GetWide() - 85, Frame:GetTall() - AcceptButton:GetTall() - 2)

	AcceptButton:SetText("")

	

	local DeclineButton = vgui.Create("DButton", Frame)

	DeclineButton:SetSize(60,30)

	DeclineButton:SetPos(Frame:GetWide() - DeclineButton:GetWide() - 20, Frame:GetTall() - DeclineButton:GetTall() - 2)

	DeclineButton:SetText("")

	

	local MessageLabel = vgui.Create("DLabel", CallPanel)

	MessageLabel:SetPos(50,0)

	MessageLabel:SetSize(CallPanel:GetWide() - 50, CallPanel:GetTall())

	MessageLabel:SetFont("911_font_16")

	MessageLabel:SetText(sender:GetName()..": "..message)

	MessageLabel:SetWrap(true)

	

	DeclineButton.DoClick = function()

		Frame:Close()

	end

	

	AcceptButton.DoClick = function()

	net.Start("services_accept")

	net.WriteString(message)

	net.WriteVector(location)

	net.WriteEntity(sender)
	
	net.SendToServer()

	Frame:Close()



	end

	

	Frame.Paint = function(me,w,h)

	

		surface.SetDrawColor(CONFIG_SERVICES.BackgroundColor)

		surface.DrawRect(0,0,w,h)

		

		surface.SetDrawColor(CONFIG_SERVICES.ThemeColor)

		surface.DrawRect(0,0,w,30)

		

		surface.SetDrawColor(CONFIG_SERVICES.CallPanelColor)

		surface.DrawRect(0,30,w,2)

		

		draw.SimpleText("Services","911_font_24", w / 2, 15, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	

	

	end

	

		

	CallPanel.Paint = function(me,w,h)

	

	surface.SetDrawColor(CONFIG_SERVICES.CallPanelColor)

	surface.DrawRect(0,0,w,h)

	

	surface.SetDrawColor(CONFIG_SERVICES.ImagePanel)

	surface.DrawRect(10,10,40,40)

	surface.SetDrawColor(color_white)

	--surface.SetMaterial(Material(image))

	surface.DrawTexturedRect(14, 14, 32, 32)

	

	surface.SetDrawColor(CONFIG_SERVICES.ThemeColor)

	surface.DrawRect(0, h - 2, w, 2)

	surface.DrawRect(0, 0, w, 2)

	

	

	end

	

	AcceptButton.Paint = function(me,w,h)

	

		surface.SetDrawColor(CONFIG_SERVICES.ImagePanel)

		surface.DrawRect(0,0,w,h)

		

		surface.SetDrawColor(CONFIG_SERVICES.ThemeColor)

		surface.DrawRect(0, h - 2, w, 2)

		surface.DrawRect(0, 0, w, 2)

		

		draw.SimpleText("Accept", "911_font_18", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		

		if me:IsHovered() then 

		

			surface.SetDrawColor(CONFIG_SERVICES.HighlightColor)

			surface.DrawRect(0,0,w,h)

			

		end

	

	

	end

	

	DeclineButton.Paint = function(me,w,h)

	

		surface.SetDrawColor(CONFIG_SERVICES.ImagePanel)

		surface.DrawRect(0,0,w,h)

		

		surface.SetDrawColor(CONFIG_SERVICES.ThemeColor)

		surface.DrawRect(0, h - 2, w, 2)

		surface.DrawRect(0, 0, w, 2)

		

		draw.SimpleText("Decline", "911_font_18", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		

		if me:IsHovered() then 

		

			surface.SetDrawColor(CONFIG_SERVICES.HighlightColor)

			surface.DrawRect(0,0,w,h)

			

		end

	

	

	end

	

	timer.Simple(CONFIG_SERVICES.AutoCloseTime, function()

	

		if IsValid(Frame) then

		

			Frame:Remove()

		

		end



	end)



end)


hook.Add("InitPostEntity", "services_clientupdateplayers", function()
	--include("sh_services_config.lua")
	net.Receive("services_updatenums", function()
		for g,v in pairs(CONFIG_SERVICES.Settings) do
			CONFIG_SERVICES.Settings[g].plyOnline = 0
			for k, p in pairs(player.GetAll()) do 
				if table.HasValue(CONFIG_SERVICES.Settings[g].Teams, p:Team()) then
					CONFIG_SERVICES.Settings[g].plyOnline = CONFIG_SERVICES.Settings[g].plyOnline + 1
				end
			end
		end
	end)

end)