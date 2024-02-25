
local PLAYER = FindMetaTable("Player")

deceive.PLAYER = deceive.PLAYER or {}
if deceive.Config then
	if deceive.Config.FakeName then
		deceive.PLAYER.Name = deceive.PLAYER.Name or PLAYER.Name
	end
	if deceive.Config.FakeJob then
		deceive.PLAYER.Team = deceive.PLAYER.Team or PLAYER.Team
		if DarkRP then
			deceive.PLAYER.getJobTable = deceive.PLAYER.getJobTable or PLAYER.getJobTable
			deceive.PLAYER.getDarkRPVar = deceive.PLAYER.getDarkRPVar or PLAYER.getDarkRPVar
		end
	end
	if deceive.Config.FakeModelColor then
		deceive.PLAYER.GetPlayerColor = deceive.PLAYER.GetPlayerColor or PLAYER.GetPlayerColor
	end
end

local manualOverride = {
	getDarkRPVar = true,
	getJobTable = true,
	Team = true
}
local ignoreLPlayer = {
	GetPlayerColor = true
}
for k, v in next, deceive.PLAYER do
	if not manualOverride[k] then
		PLAYER[k] = function(self, ignore)
            if IsValid(self.Disguised) and not ignore then
				return deceive.PLAYER[k](self.Disguised, true)
			end
			return deceive.PLAYER[k](self)
		end
	end
end

if deceive.Config and deceive.Config.FakeName then
	PLAYER.GetName = PLAYER.Name
	PLAYER.Nick = PLAYER.Name
end

if DarkRP and deceive.Config and deceive.Config.FakeJob then
	local whitelist = {
		job = true
	}
	function PLAYER:getDarkRPVar(varName, ignore)
		if whitelist[varName] and IsValid(self.Disguised) and not ignore then
			local val = varName == "job" and RPExtraTeams[self.Disguised_Team].name or deceive.PLAYER.getDarkRPVar(self.Disguised, varName)
			return val
		end
		return deceive.PLAYER.getDarkRPVar(self, varName)
	end
	function PLAYER:getJobTable(ignore)
		local actualJobTable = deceive.PLAYER.getJobTable(self)

		if IsValid(self.Disguised) and not ignore then
			local val = table.Copy(RPExtraTeams[self.Disguised_Team])
			val.weapons = actualJobTable.weapons or {}
			return val
		end

		return actualJobTable
	end
	function PLAYER:Team(ignore)
		if self.Disguised_Team then
			if CLIENT then
				return self.Disguised_Team
			elseif SERVER then
				return deceive.PLAYER.Team(self), self.Disguised_Team
				-- We abuse the fact that functions can implicitly provide more than 1 argument to a function call as return values
				-- example: team.GetColor usually only takes one argument, so people only provide one.
				-- When you do team.GetColor(ply:Team()), if the player is disguised, it actually supplies two values...
				-- I overwrite team.GetColor to use that 2nd value if provided.
				-- Unless people decide to assign the team to a value before using it with that function... Let's hope they don't.
			end
		else
			return deceive.PLAYER.Team(self)
		end
	end
end
