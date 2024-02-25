if CLIENT then 
DefColor = Color (100,130,255,255)
RepublicColor = Color (255,255,255,255)
WarColor = Color (255,100,70,255)
surface.CreateFont('Title',{font='Geometos',size=32})
surface.CreateFont('Aurebesh_Small',{font='aurebesh',size=28,weight=400})
local function Countdowner ()

----------------BODY-----------------
CountdownerBody = vgui.Create ("DFrame")
		if cd_theme == "Dark" then
	CountdownerBody:SetPos(ScrW()-460, 10)
	CountdownerBody:SetSize(ScrW(),0)
	CountdownerBody:SizeTo(ScrW(),200,1,0)
		end
	CountdownerBody:SetTitle ("")
	CountdownerBody:SetVisible (true)
	CountdownerBody:SetDraggable (false)
	CountdownerBody:ShowCloseButton (false)
	CountdownerBody.Paint = function (self,w,h)
	end

CountdownerImage = vgui.Create( "DImage", CountdownerBody )
	CountdownerImage:SetSize( 450, 150 )
	CountdownerImage:SetImage("republic_timers/timerhud.png", "vgui/avatar_default")

CountdownerMainLabel = vgui.Create ("DLabel", CountdownerBody)
		if cd_theme == "Dark" then
	CountdownerMainLabel:SetSize (utf8.len(cd_text)*30, 40)
	CountdownerMainLabel:SetX(50)
	CountdownerMainLabel:SetY(25)
		elseif cd_theme == "Light" then 
		end
	CountdownerMainLabel:SetText (cd_text)
	CountdownerMainLabel:SetFont ("Title")
	CountdownerMainLabel:SetColor (RepublicColor)

CountdownerNum = vgui.Create ("DLabel", CountdownerBody)
		if cd_theme == "Dark" then
	CountdownerNum:Center()
	CountdownerNum:SetPos(140,85)
	CountdownerNum:SetSize (200,55)
		end
	CountdownerNum:SetFont ("Aurebesh_Small")
	CountdownerNum:SetColor (RepublicColor)
	CountdownerNum:SetText ("XX:XX:XX")
	
-------------MAIN COUNTDOWNER-------------
local function CountdownerEnum () 
	timer.Create ("cd_countdowner", 1, cd_time, function ()
		cd_time = cd_time - 1
		sd_hours = math.floor(cd_time/3600)
		sd_minutes = math.floor(cd_time/60 - sd_hours*60)
		sd_seconds = math.floor(cd_time - sd_hours*3600 - sd_minutes*60)
			if sd_hours < 10 then tostring(sd_hours) sd_hours = ("0"..sd_hours) end
			if sd_minutes < 10 then tostring(sd_minutes) sd_minutes = ("0"..sd_minutes) end
			if sd_seconds < 10 then tostring(sd_seconds) sd_seconds = ("0"..sd_seconds) end
				if cd_theme == "Dark" then
					CountdownerNum:SetText (" "..sd_hours..":"..sd_minutes..":"..sd_seconds) 
				end
		-----------IMMENT----------
			if cd_time <= 0 then 
			CountdownerNum:SetText ("TIME UP!") 
			CountdownerClose() end
		end) 
	end
	CountdownerEnum ()
end 

function CountdownerClose()
	if cd_theme == "Dark" then
		CountdownerBody:SizeTo (ScrW(),0,1,2)
	end
	timer.Create ("cd_closecountdowner", 3, 1, function () CountdownerBody:SetVisible (false) end)
	timer.Stop ("cd_countdowner")
end

net.Receive ("cd_abort", function (len,ply)
	if IsValid(CountdownerBody) then
		if CountdownerBody:IsVisible (true) then
			CountdownerMainLabel:SetPos ((ScrW()-300)/2,8)
			CountdownerMainLabel:SetSize (300,40)
			CountdownerMainLabel:SetText ("Countdown aborted.")
			CountdownerNum:SetText ("") 
			CountdownerClose()
		end
	end
end)

net.Receive ("cd_start", function (len, ply)
	CDData = net.ReadTable ()
	cd_text = CDData.Title
	cd_time = CDData.Time
	cd_color = CDData.Color
	cd_theme = CDData.Theme
	cd_warning = CDData.Warning
	if IsValid(CountdownerBody) then
		if CountdownerBody:IsVisible (true) then
			timer.Stop ("cd_closecountdowner")
				if cd_theme == "Dark" then
					CountdownerBody:SizeTo (ScrW(),0,1,0)
				end
			timer.Create ("cd_cdreopener1", 1, 1, function () CountdownerBody:SetVisible (false) end )
			timer.Create ("cd_cdreopener2", 1.1, 1, function () Countdowner () end )
		else
			Countdowner ()
		end
	else
		Countdowner ()
	end
end)

net.Start ("cd_check")
net.SendToServer()

end