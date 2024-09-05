if SERVER then return end

local function AddESPEffect(target)
    if not IsValid(target) then return end
    target:SetNWBool("ScanDartESPClient", true)
    timer.Simple(15, function()
        if IsValid(target) then
            target:SetNWBool("ScanDartESPClient", false)
        end
    end)
end

local function AddESPInRadius(pos, radius)
    local entities = ents.FindInSphere(pos, radius)
    for _, ent in ipairs(entities) do
        if ent:IsPlayer() or ent:IsNPC() then
            AddESPEffect(ent)
        end
    end
end

net.Receive("arccw_scandart", function()
    local pos = net.ReadVector()
    local radius = net.ReadInt(16)
    AddESPInRadius(pos, radius)
end)

hook.Add("PreDrawHalos", "ScanDartESPClient", function()
    for _, ply in pairs(player.GetAll()) do
        if ply:GetNWBool("ScanDartESPClient") then
            halo.Add({ply}, Color(0, 0, 255), 1, 1, 1, true, true)
        end
    end

    for _, npc in pairs(ents.FindByClass("npc_*")) do
        if npc:GetNWBool("ScanDartESPClient") then
            halo.Add({npc}, Color(0, 0, 255), 1, 1, 1, true, true)
        end
    end
end)