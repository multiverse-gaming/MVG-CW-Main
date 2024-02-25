local HUD = {}





function HUD.AddNotification(self, text, color) -- state is what to change it to.

	local size = size or 0

	for i,v in pairs (self.C.Notification.NotificationQueue) do
		size = size + 1
	end


	if size < self.C.Notification.MaxSize then
		self.C.Notification.NotificationQueue[size + 1] = {text, color}
	end

	if size == 0 then
		self.C.Notification:Paint()
	end


end

function HUD.Init(self, screen_x, screen_y)

	surface.CreateFont( "Fox.Main.Notification.Default", {
		font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 30,
		weight = 1000,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
	self.C.Notification = vgui.Create("Fox.Notification")


    self.C.Notification:SetSize(screen_x, screen_y * 0.03)
	self.C.Notification:SetPos(0, -(screen_y * 0.03) )

	pos_x, pos_y = self.C.Notification:GetPos()
	w, h = self.C.Notification:GetSize()

	self.C.BackgroundPanels.Panels[4] = {pos_x, pos_y, w, h} -- Notification -- This is useless rn?



	self.C.Notification.isSayingNotification = false
	self.C.Notification.currentText = ""
	self.C.Notification.Time = SysTime()
	self.C.Notification.NotificationQueue = {}
	self.C.Notification.MaxSize = 5 -- Stops them from griefing defcon system lol.
	self.C.Notification.WhereToGoToHide = -(screen_y * 0.03)

end






return HUD