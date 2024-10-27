do
	local usedPowerArmors = {}
	local PLY = FindMetaTable("Player")
	function PLY:GivePowerArmor(owner)
		self._mk_powerArmorEquipped = true

		if IsValid(owner) then
			self._mk_givenBy = owner
			usedPowerArmors[owner] = true
		end

		self:SetRunSpeed(GAMEMODE.Config.walkspeed * 0.35)
		self:SetWalkSpeed(GAMEMODE.Config.walkspeed * 0.35)
		self:SetJumpPower(140)
		self:SetCrouchedWalkSpeed(0.3)

		self._originalModel = self:GetModel()
		self:SetModel("models/moxfort/501st-juggernaut.mdl")
	end

	function PLY:RemovePowerArmor()
		self._mk_powerArmorEquipped = false

		if IsValid(self._mk_givenBy) then
			usedPowerArmors[self._mk_givenBy] = false
		end

		self:SetRunSpeed(GAMEMODE.Config.runspeed)
		self:SetWalkSpeed(GAMEMODE.Config.walkspeed)
		self:SetJumpPower(200)
		self:SetCrouchedWalkSpeed(0.4)
		self:SetModel(self._originalModel or RPExtraTeams[self:Team()].model[1])
	end

	function PLY:HasPowerArmor()
		return self._mk_powerArmorEquipped
	end

	function PLY:GivenPowerArmor()
		return usedPowerArmors[self] or false
	end

	-- DONT UNDO: IT OVERRIDES THE BASE AND I AM AN IDIOT, TO DEAL WITH THIS NEED TO GO AROUND AND FIX THE LOOP HOLES REALLY (BodyGroupR and SetModel command, as DarkRP already does override shit etc or I put in base idek)

	--[[
	function PLY:SetModel(owner)
		if self._mk_powerArmorEquipped == true then
			self:RemovePowerArmor()
		end
	end
	]]
end

hook.Add("PlayerSpawn", "PWOnPlayerSpawn", function(ply)
	if(ply:HasPowerArmor()) then ply:RemovePowerArmor() end
end )

--[[
hook.Add("IsNoTarget", "Player:SetNoTarget", function(ply, npc)
		if ply:SetNoTarget(true) then

			npc:SetEnemy(nil)

			npc:ClearEnemyMemory()

			self:SpotForEnemies(self.npc)
			return
		end
end)
--]]

