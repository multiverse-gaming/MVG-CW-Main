--Hack Station commands

AddCSLuaFile()

if CLIENT then return end

drone_hacktool_commands = {}

table.insert(drone_hacktool_commands, {
	cmd = "hack",
	desc = "hacks drone",
	func = function(self, caller)
		if self.hacking then self:AddText(" . . . ") return end
		if not self.ht then self:AddText("Entered ID is not found!") return end
		if not self.ht:IsValid() then self:AddText("Entered ID is not valid!") return end

		if self.ht.AllowControl then self:AddText("This drone is already hacked. You may drive it.") return end

		self.hacking = true
		self.time_hacking = math.random(20, 40)

		self:AddText("Trying to hack this drone...")
		self:AddText(" ")

		if self.ht:GetDriver():IsValid() then self.ht:GetDriver():ChatPrint("Someone is trying to hack your drone!") end

		self:AddText("Hacking... It will take some time.")

		timer.Create("end_hack_htool" .. self:EntIndex(), self.time_hacking, 1, function()
			if not self:IsValid() then return end
			self.hacking = false
			if not self.ht:IsValid() then self:AddText("Signal lost.") return end

			if math.random(0, 2) == 1 then
				self:AddText("Hacked successfully!")
				self.ht.AllowControl = true
			else
				self:AddText("Cannot hack " .. self.ht:GetUnit())
			end

			self.ht = nil
			self:AddText(" ")
			self:AddText("Enter a valid drone id...")
		end)
	end
})

table.insert(drone_hacktool_commands, {
	cmd = "destroy",
	desc = "crashes drone",
	func = function(self, caller)
		if not self.ht then self:AddText("Entered ID is not found!") return end
		if not self.ht:IsValid() then self:AddText("Entered ID is not valid!") return end
		if not self.ht.Enabled then return end
		if not self.ht.AllowControl and self.ht.Owner != caller then self:AddText("This drone is locked!") return end

		self.ht:SetArm(1)
		self.ht:TakeDamage(20)
	end
})

table.insert(drone_hacktool_commands, {
	cmd = "help",
	desc = "prints this list",
	func = function(self, caller)
		self:AddText("|================================|")

		for k, v in ipairs(drone_hacktool_commands) do
			local buf = "NO DESCRIPTION"
			if v.desc then buf = v.desc end

			self:AddText(v.cmd .. " - " .. buf)
		end

		self:AddText("|================================|")
	end
})

table.insert(drone_hacktool_commands, {
	cmd = "consolelog",
	desc = "prints console log into your console",
	func = function(self, caller)
		caller:SendLua("print('|==============================================|')")

		for k, v in ipairs(self.console_log) do
			caller:SendLua("print('" .. v .. "')")
		end

		caller:SendLua("print('|==============================================|')")
	end
})

table.insert(drone_hacktool_commands, {
	cmd = "drive",
	desc = "drives selected drone",
	func = function(self, caller)
		if not self.ht then self:AddText("Entered ID is not found!") return end
		if not self.ht:IsValid() then self:AddText("Entered ID is not valid!") return end
		if not self.ht.AllowControl and self.ht.Owner != caller then self:AddText("This drone is locked!") return end

		self.ht:SetDriver(caller)
	end
})

table.insert(drone_hacktool_commands, {
	cmd = "echo",
	desc = "prints entered text into console",
	func = function(self, caller, args)
		if table.maxn(args) < 2 then return end
		local buf = ""
		for i = 2, table.maxn(args) do buf = buf .. args[i] .. " " end

		self:AddText(buf)
	end
})

table.insert(drone_hacktool_commands, {
	cmd = "list",
	desc = "prints ID of every drone",
	func = function(self, caller)
		local found = false
		for k, v in pairs(ents.GetAll()) do
			if string.sub(v:GetClass(), 1, 6) == "drone_" and v.Enabled then 
				self:AddText(string.lower(string.sub(v:GetClass(), 7, 7)) .. v:EntIndex())
				found = true
			end
		end

		if not found then self:AddText("Drones not found!") end
	end
})

table.insert(drone_hacktool_commands, {
	cmd = "findd",
	desc = "gets drone by its ID",
	func = function(self, caller, args)
		if table.maxn(args) < 2 then return end
		local id = args[2]

		local drone = NULL
		for k, v in pairs(ents.GetAll()) do
			if string.sub(v:GetClass(), 1, 6) == "drone_" and v.Enabled then 
				if string.lower(string.sub(v:GetClass(), 7, 7)) .. v:EntIndex() == string.lower(id) then
					drone = v
					self:AddText("Selected drone: " .. id)
					break
				end
			end
		end

		self.ht = drone
	end
})

table.insert(drone_hacktool_commands, {
	cmd = "clear",
	desc = "clears screen",
	func = function(self, caller) self:AddText("/clr") end
})

table.insert(drone_hacktool_commands, {
	cmd = "clearlog",
	desc = "clears console log",
	func = function(self, caller) self.console_log = {} end
})

table.insert(drone_hacktool_commands, {
	cmd = "kickowner",
	desc = "kicks drone's driver",
	func = function(self, caller) 
		if not self.ht then self:AddText("Entered ID is not found!") return end
		if not self.ht:IsValid() then self:AddText("Entered ID is not valid!") return end
		if not self.ht.AllowControl and self.ht.Owner != caller then self:AddText("This drone is locked!") return end

		self.ht:SetDriver(NULL)
		self:AddText("Owner kicked")
	end
})

table.insert(drone_hacktool_commands, {
	cmd = "dismotion",
	desc = "disables drone's motion",
	func = function(self, caller) 
		if not self.ht then self:AddText("Entered ID is not found!") return end
		if not self.ht:IsValid() then self:AddText("Entered ID is not valid!") return end
		if not self.ht.AllowControl and self.ht.Owner != caller then self:AddText("This drone is locked!") return end
		
		self.ht:StopMotionController()
	end
})

table.insert(drone_hacktool_commands, {
	cmd = "enmotion",
	desc = "enables drone's motion",
	func = function(self, caller) 
		if not self.ht then self:AddText("Entered ID is not found!") return end
		if not self.ht:IsValid() then self:AddText("Entered ID is not valid!") return end
		if not self.ht.AllowControl and self.ht.Owner != caller then self:AddText("This drone is locked!") return end
		
		self.ht:StartMotionController()
	end
})

table.insert(drone_hacktool_commands, {
	cmd = "getsel",
	desc = "prints selected drone's ID if found",
	func = function(self, caller)
		if not self.ht then self:AddText("Entered ID is not found!") return end
		if not self.ht:IsValid() then self:AddText("Entered ID is not valid!") return end

		self:AddText("Selected drone: " .. self.ht:GetUnit())
	end
})

table.insert(drone_hacktool_commands, {
	cmd = "getarm",
	desc = "prints selected drone's armor",
	func = function(self, caller)
		if not self.ht then self:AddText("Entered ID is not found!") return end
		if not self.ht:IsValid() then self:AddText("Entered ID is not valid!") return end

		self:AddText("Drone's armor: " .. self.ht.armor)
	end
})
