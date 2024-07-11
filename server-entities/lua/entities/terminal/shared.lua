ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Task Terminal"
ENT.Author = "Tomery"
ENT.Category = "Custom Engineering Entities"

ENT.Spawnable = true
ENT.AdminSpawnable = true

ENGINEER_TEAMS = {
    TEAM_CEGENERAL,
    TEAM_CEMCOMMANDER,
    TEAM_CECOMMANDER,
    TEAM_CEEXECUTIVEOFFICER,
    TEAM_CECHIEF,
    TEAM_CELIEUTENANT,
    TEAM_CEMECHANIC,
    TEAM_CEFAB,
    TEAM_ARCALPHACE,
    TEAM_CEARC,
    TEAM_CEMEDOFFICER,
    TEAM_CESPECIALIST,
    TEAM_CEMEDTROOPER,
    TEAM_CETROOPER
}

function IsEngineer(ply)
    return table.HasValue(ENGINEER_TEAMS, ply:Team())
end