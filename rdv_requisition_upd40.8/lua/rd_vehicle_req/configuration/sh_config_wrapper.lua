RDV.VEHICLE_REQ = RDV.VEHICLE_REQ or {}

function RDV.VEHICLE_REQ.AddSpawn(NAME)
    local TAB = RDV.VEHICLE_REQ

    TAB.SPAWNS = TAB.SPAWNS or {}
    
    for k, v in ipairs(TAB.SPAWNS) do
        if v.NAME and v.MAP and (v.NAME == NAME) and (v.MAP == game.GetMap()) then
            print("Duplicate Spawn Removed! ("..NAME..")")
            table.remove(TAB.SPAWNS, k)
        end
    end

    local VAL = table.insert(TAB.SPAWNS, {
        NAME = NAME,
        MAP = (game.GetMap() or "rp_jania_exile"),
        SPAWNS = {},
        TEAMS = {},
        GTEAMS = {},
        SetPosition = function(self, position)
            self.Position = position
        end,
        SetAngles = function(self, angle)
            self.Angles = angle
        end,
        AddRequestTeams = function(self, teams)
            if !teams then return end

            self.TEAMS = self.TEAMS or {}

            for k, v in ipairs(teams) do
                if isnumber(v) then
                    v = team.GetName(v)
                end

                self.TEAMS[v] = true
            end
        end,
        AddRequestTeam = function(self, name)
            self.TEAMS = self.TEAMS or {}

            self.TEAMS[name] = true
        end,
        AddGrantTeams = function(self, teams)
            if !teams then return end

            self.GTEAMS = self.GTEAMS or {}

            for k, v in ipairs(teams) do
                if isnumber(v) then
                    v = team.GetName(v)
                end

                self.GTEAMS[v] = true
            end
        end,
        AddGrantTeam = function(self, name)
            self.GTEAMS = self.GTEAMS or {}

            self.GTEAMS[name] = true
        end,
        SetMap = function(self, name)
            self.MAP = name
        end,
    })

    hook.Run("RDV_VR_SpawnAdded", TAB.SPAWNS[VAL])

    return TAB.SPAWNS[VAL]
end

function RDV.VEHICLE_REQ.AddVehicle(ID)
    local TAB = RDV.VEHICLE_REQ

    TAB.VEHICLES = TAB.VEHICLES or {}

    for k, v in ipairs(TAB.VEHICLES) do
        if v.NAME and (v.NAME == ID) then
            print("Duplicate Vehicle Removed! ("..ID..")")

            table.remove(TAB.VEHICLES, k)
        end
    end

    local VAL = table.insert(TAB.VEHICLES, {
        NAME = ID,
        BL_EMPTY = true,
        WL_EMPTY = true,

        SPAWNS = {},
        TEAMS = {},
        GTEAMS = {},
        CLASS = ID,
        REQUEST = true,
        Category = "Uncategorized",
        MODEL = "models/props_junk/cardboard_box001b.mdl",
        SKIN = 0,
        SetCategory = function(self, name)
            if !name or name == "" then return end

            self.Category = name
        end,
        SetSkin = function(self, name)
            self.SKIN = name
        end,
        SetName = function(self, name)
            self.NAME = name
        end,

        AddHangar = function(self, name)
            self.SPAWNS = self.SPAWNS or {}

            self.WL_EMPTY = false
            self.SPAWNS[name] = true
        end,
        BlacklistHangar = function(self, name)
            self.BLACKLIST = self.BLACKLIST or {}

            self.BL_EMPTY = false
            self.BLACKLIST[name] = true
        end,
        SetCustomizable = function(self, val)
            self.CUSTOMIZABLE = val
        end,
        AddGrantTeams = function(self, teams)
            if !teams then return end

            self.GTEAMS = self.GTEAMS or {}

            for k, v in ipairs(teams) do
                if isnumber(v) then
                    v = team.GetName(v)
                end
                
                self.GTEAMS[v] = true
            end
        end,
        AddGrantTeam = function(self, name)
            self.GTEAMS = self.GTEAMS or {}

            self.GTEAMS[name] = true
        end,
        AddRequestTeams = function(self, teams)
            if !teams then return end

            self.TEAMS = self.TEAMS or {}

            for k, v in ipairs(teams) do
                if isnumber(v) then
                    v = team.GetName(v)
                end

                self.TEAMS[v] = true
            end
        end,
        AddRequestTeam = function(self, name)
            self.TEAMS = self.TEAMS or {}

            self.TEAMS[name] = true
        end,
        SetRequest = function(self, boo)
            self.REQUEST = boo
        end,

        SetModel = function(self, model)
            self.MODEL = model
        end,
        SpawnAlone = function(self, value)
            self.SpawnAlone = value
        end,
        SetPrice = function(self, value)
            self.PRICE = value
        end,
        SetBodygroup = function(self, key, val)
            self.BODYGROUPS = self.BODYGROUPS or {}

            self.BODYGROUPS[key] = val
        end,
        SetClass = function(self, class)
            self.CLASS = class
            
            if !self.MODEL or self.MODEL == "models/props_junk/cardboard_box001b.mdl" then
                self.MODEL = class
            end
        end,
    })
    
    hook.Run("RDV_VR_VehicleAdded", TAB.VEHICLES[VAL])

    return TAB.VEHICLES[VAL]
end