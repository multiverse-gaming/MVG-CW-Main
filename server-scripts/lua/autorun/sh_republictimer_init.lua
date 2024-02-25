timer.Simple(0, function()
	if CAMI then
		MsgC(Color(252, 186, 3), "[Timers] ", Color(255,255,255), "CAMI loaded \n")
		CAMI.RegisterPrivilege({
    		Name = "Republic Timers",
    		MinAccess = "superadmin"
		})
	end
	MsgC(Color(252, 186, 3), "[Timers] ", Color(255,255,255), "Successfully loaded \n")
end)