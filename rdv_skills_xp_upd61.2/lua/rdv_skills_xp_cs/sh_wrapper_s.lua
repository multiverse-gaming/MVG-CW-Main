function RDV.SAL.AddSkill(NAME)
    RDV.SAL.SKILLS.LIST = RDV.SAL.SKILLS.LIST or {}

    RDV.SAL.SKILLS.LIST[NAME] = {
        LevelReq = {},
        AddHook = function(self, id, callback, p_obj)
            if not SERVER then return end

            hook.Add(id, "RDV.SKILLS.INFO."..NAME.."."..id, callback)
        end,
        SetMaxTiers = function(self, max)
            self.MAX = (max or 1)
        end,
        GetSkillTier = function(self, client)
            if not SERVER then return end
            
            if not IsValid(client) then return end

            local TIER = RDV.SAL.GetSkillTier(client, NAME)
            
            return math.Clamp( tonumber(TIER or 0), 0, self.MAX )
        end,
        SetCategory = function(self, cat)
            self.CATEGORY = cat
        end,
        SetDescription = function(self, desc)
            self.DESCRIPTION = desc
        end,
        SetColor = function(self, color)
            self.COLOR = color
        end,
        SetLevelRequirement = function(self, level, tier)
            if !tier then
                for i = 1, self.MAX do
                    self.LevelReq[i] = level
                end
            else
                self.LevelReq[tier] = level
            end
        end,
        SetNoEffectTeams = function(self, teams)
            self.NoEffect = {}

            for k, v in ipairs(teams) do
                self.NoEffect[v] = true
            end
        end,
        GetNoEffectTeams = function(self)
            return ( self.NoEffect or {} )
        end,
        SetOnlyEffectTeams = function(self, teams)
            self.OnlyEffect = {}

            for k, v in ipairs(teams) do
                self.OnlyEffect[v] = true
            end
        end,
        GetOnlyEffectTeams = function(self)
            return ( self.OnlyEffect or {} )
        end,
        GetID = function(self)
            return (NAME or "N/A")
        end,
    }

    return RDV.SAL.SKILLS.LIST[NAME]
end