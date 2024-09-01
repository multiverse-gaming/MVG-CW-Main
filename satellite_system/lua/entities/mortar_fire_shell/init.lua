AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/dolunity/starwars/mortar/shell.mdl")

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetCollisionGroup(COLLISION_GROUP_NONE)
    self:PhysWake()
end

function ENT:PhysicsCollide(colData, collider)
    if self:WaterLevel() > 0 then
        self:Remove()
        return
    end

    
    net.Start("kaito_net_sound_new_in")
		net.WriteVector(colData.HitPos)
	net.Broadcast()


	collider:EnableMotion(false)

	timer.Simple(5, function()
        local getINShellDamage = GetConVar("kmortar_in_impact_damagevalue"):GetInt()
		local cx,cy,cz = colData.HitPos:Unpack()
        pos = Vector(cx,cy,cz)
	    ParticleEffect("dusty_explosion_rockets", Vector(cx,cy,cz), Angle(0,0,0), nil)
        util.Decal("Scorch", Vector(cx,cy,cz),pos-Vector(0, 0, 30))
		util.BlastDamage(colData.PhysObject:GetEntity(), colData.PhysObject:GetEntity(), Vector(cx,cy,cz), 500, getINShellDamage)
        util.ScreenShake(Vector(cx,cy,cz), 9, 5, 2, 9500)
            local vfire = ents.Create("vfire_cluster")
        if (not IsValid(vfire)) then
            local fires = {}
            local r = 256
            for i = 1, 15 do
                local pos = Vector(cx,cy,cz) + Vector(math.random(-r, r), math.random(-r, r), 0)

                local fire = ents.Create("env_fire")
                fire:SetPos(pos)
                fire:SetKeyValue("health", "999999")
                fire:SetKeyValue("firesize", "64")
                fire:SetKeyValue("damagescale", "35")
                fire:SetKeyValue("spawnflags", "0")
                fire:SetOwner(self:GetOwner())
                fire:Spawn()
                fire:Fire("StartFire", "", 0)
                table.insert(fires, fire)
            end
            timer.Simple(25, function()
                if (istable(fires)) then
                    PrintTable(fires)
                    for i, v in pairs(fires) do
                        v:Remove()
                    end
                end
            end)
        else
            if (isfunction(CreateVFireBall)) then
                CreateVFireBall(60 * 15, 10, Vector(cx,cy,cz), Vector())
            end

            vfire:Spawn()
            local r = 256
            for i = 1, 3 do
                local pos = Vector(cx,cy,cz) + Vector(math.random(-r, r), math.random(-r, r), 0)
                vfire = ents.Create("vfire_cluster")
                vfire:SetPos(pos)
                vfire:Spawn()
            end
        end
	end)

	timer.Simple(6, function() 
		colData.PhysObject:GetEntity():Remove()
	end)


end