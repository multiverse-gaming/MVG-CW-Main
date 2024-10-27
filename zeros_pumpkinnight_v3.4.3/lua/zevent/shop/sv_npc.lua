/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

if CLIENT then return end
zpn = zpn or {}
zpn.NPC = zpn.NPC or {}
zpn.PurchaseType = zpn.PurchaseType or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

function zpn.NPC.USE(ply, npc)
    zpn.Shop.Open(ply, npc)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4

// Sets up the saving / loading and removing of the entity for the map
zclib.STM.Setup("zpn_npc","zpn/" .. string.lower(game.GetMap()) .. "_shopnpc" .. ".txt",function()
    local data = {}

    for u, j in pairs(ents.FindByClass("zpn_npc")) do
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
        local ent = ents.Create("zpn_npc")
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

    zpn.Print("Finished loading Shop NPC Entities.")
end,function()
    for k, v in pairs(ents.FindByClass("zpn_npc")) do
        if IsValid(v) then
            v:Remove()
        end
    end
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

concommand.Add("zpn_save_npc", function(ply, cmd, args)
    if zclib.Player.IsAdmin(ply) and zclib.STM.Save("zpn_npc") then
        zclib.Notify(ply, "Shop NPC entities have been saved for the map " .. game.GetMap() .. "!", 0)
    end
end)

concommand.Add("zpn_remove_npc", function(ply, cmd, args)
    if zclib.Player.IsAdmin(ply) then
        zclib.Notify(ply, "Shop NPC entities have been removed for the map " .. game.GetMap() .. "!", 0)
        zclib.STM.Remove("zpn_npc")
    end
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065
