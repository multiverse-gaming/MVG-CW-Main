function RDV.SAL.AddOpportunity(NAME)
    RDV.SAL.OPPORTUNITIES = RDV.SAL.OPPORTUNITIES or {}

    RDV.SAL.OPPORTUNITIES[NAME] = {
        AddHook = function(self, id, callback)
            if not SERVER then return end

            hook.Add(id, "RDV.LEVELS.OPPOR."..NAME.."."..id, callback)
        end,
        AddExperience = function(self, client, xp)
            if not SERVER then return end

            RDV.SAL.AddExperience(client, xp)
        end,
    }

    return RDV.SAL.OPPORTUNITIES[NAME]
end