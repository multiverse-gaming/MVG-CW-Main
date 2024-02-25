    local function InsertFunctions(obj)
        obj.AddRequestRanks = function(self, ranks)
            if !ranks then return end

            self.RANKS = self.RANKS or {}

            for k, v in ipairs(ranks) do
                self.RANKS[v] = true
            end
        end

        obj.AddGrantRanks = function(self, ranks)
            if !ranks then return end

            self.GRANKS = self.GRANKS or {}

            for k, v in ipairs(ranks) do
                self.GRANKS[v] = true
            end
        end
    end

    hook.Add("RDV_VR_CanGrant", "RDV.RANKS", function(ply, ship, hangar)
        if !RDV.RANK then return end

        local TAB = RDV.VEHICLE_REQ.VEHICLES[ship]
        local TAB2 = RDV.VEHICLE_REQ.SPAWNS[hangar]

        local R = RDV.RANK.GetPlayerRank(ply)
        local T = RDV.RANK.GetPlayerRankTree(ply)

        local RANK = RDV.RANK.GetRankName(R, T)

        -- Vehicles
        if TAB.GRANKS and !TAB.GRANKS[RANK] then
            return false
        end

        -- Spawns
        if TAB2.GRANKS and !TAB2.GRANKS[RANK] then
            return false
        end
    end)

    hook.Add("RDV_VR_CanRequest", "RDV.RANKS", function(ply, ship, hangar)
        if !RDV.RANK then return end

        local TAB = RDV.VEHICLE_REQ.VEHICLES[ship]
        local TAB2 = RDV.VEHICLE_REQ.SPAWNS[hangar]

        local R = RDV.RANK.GetPlayerRank(ply)
        local T = RDV.RANK.GetPlayerRankTree(ply)

        local RANK = RDV.RANK.GetRankName(R, T)

        -- Vehicles
        if TAB.RANKS and !TAB.RANKS[RANK] then
            return false
        end

        -- Spawns
        if TAB2.RANKS and !TAB2.RANKS[RANK] then
            return false
        end
    end)

    hook.Add("RDV_VR_SpawnAdded", "RDV.RANKS", InsertFunctions)
    hook.Add("RDV_VR_VehicleAdded", "RDV.RANKS", InsertFunctions)
