--[[---------------------------------------------------------------------------
Admintellall CL
---------------------------------------------------------------------------]]

local Scrw

local colors = {}
colors.brightred = Color(200, 30, 30, 255)
colors.darkblack = Color(0, 0, 0, 200)
colors.white = Color(255, 255, 255, 255)

local MVGAdminTell = function() end

usermessage.Hook("MVGAdminTell", function(msg)
    timer.Remove("DarkRP_MVGAdminTell")
    local Message = msg:ReadString()

    MVGAdminTell = function()
        draw.RoundedBox(4, 10, 10, Scrw - 20, 110, colors.darkblack)
        draw.DrawNonParsedText(DarkRP.getPhrase("listen_up"), "GModToolName", Scrw / 2 + 10, 10, colors.white, 1)
        draw.DrawNonParsedText(Message, "ChatFont", Scrw / 2 + 10, 90, colors.brightred, 1)
    end

    timer.Create("DarkRP_MVGAdminTell", 10, 1, function()
        MVGAdminTell = function() end
    end)
end)

--[[---------------------------------------------------------------------------
Actual HUDPaint hook
---------------------------------------------------------------------------]]

hook.Add( "HUDPaint", "MVGAdminTell", function()
    	Scrw = ScrW()
	MVGAdminTell()
end )
