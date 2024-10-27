/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

zpn = zpn or {}
zpn.LootSpawner = zpn.LootSpawner or {}

function zpn.LootSpawner.Initialize(LootSpawner)
    zclib.Debug("zpn.LootSpawner.Initialize")

	LootSpawner:SetModel(zpn.Theme.LootSpawner.model)

	LootSpawner:PhysicsInit(SOLID_VPHYSICS)
	LootSpawner:SetSolid(SOLID_VPHYSICS)
	LootSpawner:SetMoveType(MOVETYPE_VPHYSICS)
	LootSpawner:SetUseType(SIMPLE_USE)
	LootSpawner:SetCollisionGroup(COLLISION_GROUP_WEAPON)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

	local phys = LootSpawner:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(false)
	end

	LootSpawner.SpawnedLoot = {}
	for i = 1, zpn.config.LootSpawner.Count do
		local ang = (180 / zpn.config.LootSpawner.Count) * i
		local Radius = zpn.config.LootSpawner.Radius
		LootSpawner.SpawnedLoot[i] = {
			pos = Vector(math.cos(ang) * Radius, math.sin(ang) * Radius, 0),
			ent = nil,
		}
	end

	if zpn.config.LootSpawner.RandomStyle then
		LootSpawner:SetBodygroup(4,math.random(0,1))
		//LootSpawner:SetBodygroup(5,math.random(0,1))
		LootSpawner:SetBodygroup(6,math.random(0,1))
		LootSpawner:SetBodygroup(7,math.random(0,1))
		LootSpawner:SetBodygroup(8,math.random(0,1))
		LootSpawner:SetBodygroup(9,math.random(0,1))
		LootSpawner:SetBodygroup(10,math.random(0,1))
		LootSpawner:SetBodygroup(11,math.random(0,1))
		LootSpawner:SetBodygroup(12,math.random(0,1))
	end
end

/*
	Returns the first id without a present it can find
*/
function zpn.LootSpawner.GetFreePos(LootSpawner)
	local id
	for k,v in ipairs(LootSpawner.SpawnedLoot) do
		if not IsValid(v.ent) then
			id = k
			break
		end
	end
	return id
end

/*
	Spawns loot
*/
function zpn.LootSpawner.SpawnLoot(LootSpawner,SpawnID)
	if not LootSpawner.SpawnedLoot[SpawnID] then return end
	if not LootSpawner.SpawnedLoot[SpawnID].pos then return end
    zclib.Debug("zpn.LootSpawner.SpawnLoot")

	local ent = ents.Create("zpn_loot")
	ent:SetPos(LootSpawner:GetPos() + LootSpawner.SpawnedLoot[SpawnID].pos)
	ent:SetAngles(LootSpawner:LocalToWorldAngles(Angle(0,math.random(360,0))))
	ent:Spawn()
	ent:Activate()

	LootSpawner.SpawnedLoot[SpawnID].ent = ent
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

	timer.Simple(0.1,function()
		if IsValid(ent) then
			zclib.NetEvent.Create("zpn_loot_spawn", {ent})
		end
	end)

	table.insert(LootSpawner.SpawnedLoot,ent)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

function zpn.LootSpawner.OnRemove(LootSpawner)
	zclib.Debug("zpn.LootSpawner.OnRemove")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

	for k, v in pairs(LootSpawner.SpawnedLoot) do
		if IsValid(v) then
			v:Remove()
		end
	end
end

function zpn.LootSpawner.Start()
	local timerid = "zpn_lootspawner"
	zclib.Timer.Remove(timerid)
	zclib.Timer.Create(timerid, zpn.config.LootSpawner.Interval, 0, function()

		if table.Count(ents.FindByClass("zpn_loot")) >= zpn.config.LootSpawner.Limit then return end

		local Spawners = ents.FindByClass("zpn_loot_spawner")
		if not Spawners or table.Count(Spawners) <= 0 then return end

		local ValidSpawners = {}
		for k,v in pairs(Spawners) do
			if not zpn.LootSpawner.GetFreePos(v) then continue end
			table.insert(ValidSpawners,v)
		end

		local ent = ValidSpawners[math.random(#ValidSpawners)]
		if not IsValid(ent) then return end

		local SpawnID = zpn.LootSpawner.GetFreePos(ent)
		if not SpawnID then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

		zpn.LootSpawner.SpawnLoot(ent,SpawnID)
	end)
end
timer.Simple(1,function() zpn.LootSpawner.Start() end)

concommand.Add("zpn_lootspawner_trigger", function(ply, cmd, args)
	if zclib.Player.IsAdmin(ply) then
		local Spawners = ents.FindByClass("zpn_loot_spawner")
		if not Spawners or table.Count(Spawners) <= 0 then return end
		local ValidSpawners = {}

		for k, v in pairs(Spawners) do
			if not zpn.LootSpawner.GetFreePos(v) then continue end
			table.insert(ValidSpawners, v)
		end

		local ent = ValidSpawners[ math.random(#ValidSpawners) ]
		if not IsValid(ent) then return end
		local SpawnID = zpn.LootSpawner.GetFreePos(ent)
		if not SpawnID then return end
		zpn.LootSpawner.SpawnLoot(ent, SpawnID)
	end
end)

// Sets up the saving / loading and removing of the entity for the map
zclib.STM.Setup("zpn_LootSpawner","zpn/" .. string.lower(game.GetMap()) .. "_LootSpawner" .. ".txt",function()
    local data = {}

    for u, j in pairs(ents.FindByClass("zpn_loot_spawner")) do
        if IsValid(j) then
            table.insert(data, {
                pos = j:GetPos(),
                ang = j:GetAngles()
            })
        end
    end

    return data
end,function(data)

    for k, v in pairs(data) do
        local ent = ents.Create("zpn_loot_spawner")
        ent:SetPos(v.pos)
        ent:SetAngles(v.ang)
        ent:Spawn()
        ent:Activate()
        local phys = ent:GetPhysicsObject()

        if IsValid(phys) then
            phys:Wake()
            phys:EnableMotion(false)
        end
    end

    zpn.Print("Finished loading LootSpawner Entities.")
end,function()
    for k, v in pairs(ents.FindByClass("zpn_loot_spawner")) do
        if IsValid(v) then
            v:Remove()
        end
    end
end)

// Save functions
concommand.Add( "zpn_save_lootspawner", function( ply, cmd, args )
    if zclib.Player.IsAdmin(ply) then
        zclib.Notify(ply, "LootSpawner entities have been saved for the map " .. game.GetMap() .. "!", 0)
        zclib.STM.Save("zpn_LootSpawner")
    end
end )

concommand.Add( "zpn_remove_lootspawner", function( ply, cmd, args )
    if zclib.Player.IsAdmin(ply) then
        zclib.Notify(ply, "LootSpawner entities have been removed for the map " .. game.GetMap() .. "!", 0)
        zclib.STM.Remove("zpn_LootSpawner")
    end
end )
