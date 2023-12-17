if SERVER then
	hook.Add("playerBoughtCustomEntity","DidTheySpawnTurret", function(ply, entityTable, entity)
		if entity.PrintName ~= "Lazer Cannon" then return end

		undo.Create("turrets")

			undo.AddEntity(entity)

			undo.SetPlayer(ply)

		undo.Finish()
	end)
end
-- For Turret