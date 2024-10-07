/*local OBJ = RDV.SAL.AddOpportunity("Game Activity")

local AC_REQ = {}

OBJ:AddHook("PlayerReadyForNetworking", function(client)
    AC_REQ[client] = CurTime() + 300
end)

OBJ:AddHook("PlayerTick", function(client)
    if AC_REQ[client] and AC_REQ[client] > CurTime() then return end

    OBJ:AddExperience(client, 200)

    AC_REQ[client] = CurTime() + 300
end)
*/

