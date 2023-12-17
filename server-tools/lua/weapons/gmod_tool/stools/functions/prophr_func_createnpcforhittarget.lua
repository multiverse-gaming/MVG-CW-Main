function createNPCforHitTarget(ply, ent, prophr_ent_npc_class)
	ent:SetCollisionGroup(COLLISION_GROUP_BREAKABLE_GLASS)
	--
	--
	local function createBullseye(player, ent_class, ent_parent, bullseye_name, position_vector_worldtolocal, angle_vector_worldtolocal)
		local ent_npc = ents.Create(ent_class)
		if (
			!IsValid(ent_npc)
		) then return PrintMessage(HUD_PRINTTALK, "Error: Could not create hit-entity for prop...") end
		
		-- Rekkefølgen er viktig her ...
		ent_npc:SetPos(ent_parent:LocalToWorld(position_vector_worldtolocal))
		ent_npc:SetAngles(ent_parent:LocalToWorldAngles(angle_vector_worldtolocal))
		ent_npc:SetParent(ent_parent)
		ent_npc:SetName(bullseye_name)
		ent_npc:SetOwner(player)
		ent_npc:SetModel("models/hunter/blocks/cube025x025x025.mdl") -- Veldig viktig for e.g. Zombie
		ent_npc:SetModelScale(ent:GetModelScale() * 0.15, 0)
		--
		-- Spawn
		ent_npc:Spawn()
		--
		ent_npc:SetColor(
			Color(255, 0, 0, 100)
		)
		ent_npc:SetRenderMode(RENDERMODE_TRANSALPHA)
		ent_npc:SetPersistent(true)
		ent_npc:SetMoveType(MOVETYPE_NONE)
		ent_npc:DrawShadow(false)
		ent_npc:SetSolid(SOLID_VPHYSICS) -- Veldig viktig for at skudd skal gå igjennom, og alle NPC som Zombie kan slå den
		--
		ent_parent:DeleteOnRemove(ent_npc)
		ent_parent:AddEFlags(EFL_DONTBLOCKLOS) -- Veldig viktig for at NPC som skyter, skal kunne sjå igjennom objektet inn til hitbox
	end
	--
	-- Create NPC-Hit-target
	local ent_aabb_min, ent_aabb_max = ent:GetPhysicsObject():GetAABB()
	local ent_center = ent:WorldToLocal(ent:WorldSpaceCenter())
	local ent_angles = ent:WorldToLocalAngles(ent:GetAngles())
	--
	-- Skap
	--
	local function leggTil(_z)
		if (GetConVar("prophr_optimized_hitbox_system"):GetInt() == 1) then
			--
			-- Legg berre til ein hitbox
			createBullseye(ply, prophr_ent_npc_class, ent, "prophr_npc_ent",
				Vector(
					ent_center.x,
					ent_center.y,
					ent_center.z-- + 30
				)
				, ent_angles
			)
		else
			--
			-- DETTE LAGER EIT KRYSS (på alle sider)
			createBullseye(ply, prophr_ent_npc_class, ent, "prophr_npc_ent",
				Vector(
					ent_center.x,
					ent_center.y,
					ent_center.z
				)
				, ent_angles
			)
			-- V
			createBullseye(ply, prophr_ent_npc_class, ent, "prophr_npc_ent",
				Vector(
					ent_aabb_max.x,
					ent_center.y,
					_z
				)
				, ent_angles
			)
			createBullseye(ply, prophr_ent_npc_class, ent, "prophr_npc_ent",
				Vector(
					ent_center.x,
					ent_aabb_max.y,
					_z
				)
				, ent_angles
			)
			-- H
			createBullseye(ply, prophr_ent_npc_class, ent, "prophr_npc_ent",
				Vector(
					ent_aabb_min.x,
					ent_center.y,
					_z
				)
				, ent_angles
			)
			createBullseye(ply, prophr_ent_npc_class, ent, "prophr_npc_ent",
				Vector(
					ent_center.x,
					ent_aabb_min.y,
					_z
				)
				, ent_angles
			)
		end
	end
	--
	-- Sentrum cirka
	leggTil(ent_aabb_min.z + 35)
end