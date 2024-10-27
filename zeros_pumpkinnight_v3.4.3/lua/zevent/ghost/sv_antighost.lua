/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

if CLIENT then return end
zpn = zpn or {}
zpn.Sign = zpn.Sign or {}


////////////////////////////////////////////
////////////////// ENTITY //////////////////
////////////////////////////////////////////
function zpn.Sign.Initialize(Sign)
    zclib.Debug("zpn.Sign.Initialize")

    zclib.EntityTracker.Add(Sign)

    zpn.Sign.Add(Sign)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

function zpn.Sign.OnRemove(Sign)
    table.RemoveByValue(zpn.AntiGhostSigns,Sign)
end
////////////////////////////////////////////
////////////////////////////////////////////

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

////////////////////////////////////////////
/////////////// Anti Ghost Sign //////////////////
////////////////////////////////////////////
zpn.AntiGhostSigns = zpn.AntiGhostSigns or {}

// Gets called when the score changes
function zpn.Sign.Add(Sign)
    table.insert(zpn.AntiGhostSigns,Sign)
end

// Checks if the player is near a AntiGhost Sign
function zpn.Sign.EntityInDistance(ent)
    local InDistance = false
    local entPos = ent:GetPos()

    for k, v in pairs(zpn.AntiGhostSigns) do
        if IsValid(v) and zclib.util.InDistance(entPos, v:GetPos(), zpn.config.AntiGhostSign.Distance) then
            InDistance = true
            break
        end
    end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

    return InDistance
end


// Sets up the saving / loading and removing of the entity for the map
zclib.STM.Setup("zpn_AntiGhostSigns","zpn/" .. string.lower(game.GetMap()) .. "_AntiGhostSigns" .. ".txt",function()
    local data = {}

    for u, j in pairs(ents.FindByClass("zpn_sign")) do
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
        local ent = ents.Create("zpn_sign")
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

    zpn.Print("Finished loading AntiGhostSign Entities.")
end,function()
    for k, v in pairs(ents.FindByClass("zpn_sign")) do
        if IsValid(v) then
            v:Remove()
        end
    end
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

// Save functions
concommand.Add( "zpn_save_Sign", function( ply, cmd, args )
    if zclib.Player.IsAdmin(ply) then
        zclib.Notify(ply, "AntiGhostSign entities have been saved for the map " .. game.GetMap() .. "!", 0)
        zclib.STM.Save("zpn_AntiGhostSigns")
    end
end )
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

concommand.Add( "zpn_remove_Sign", function( ply, cmd, args )
    if zclib.Player.IsAdmin(ply) then
        zclib.Notify(ply, "AntiGhostSign entities have been removed for the map " .. game.GetMap() .. "!", 0)
        zclib.STM.Remove("zpn_AntiGhostSigns")
    end
end )
