BF2_Scoreboard.Languages = {}

function BF2_Scoreboard:L(key)
    return BF2_Scoreboard.Languages[BF2_Scoreboard.Config.Language][key] or "ERROR"
end

BF2_Scoreboard.Languages["en"] = {
    PLAYER = "PLAYER",
    RANK = "RANK",
    USERGROUP = "USERGROUP",
    NPCKILLS = "NPC KILLS",
    KILLS = "KILLS",
    DEATHS = "DEATHS",
    PING = "PING",
    MY_STATS = "MY STATS",
}

BF2_Scoreboard.Languages["de"] = {
    PLAYER = "SPIELER",
    RANK = "RANG",
    USERGROUP = "BENUTZERGRUPPE",
    KILLS = "KILLS",
    DEATHS = "TODE",
    PING = "PING",
    MY_STATS = "MEINE STATS",
}

BF2_Scoreboard.Languages["fr"] = {
    PLAYER = "JOUEUR",
    RANK = "RANK",
    USERGROUP = "GROUPE D'UTILISATEURS",
    KILLS = "KILLS",
    DEATHS = "DEATHS",
    PING = "PING",
    MY_STATS = "MES STATISTIQUES",
}

BF2_Scoreboard.Languages["ru"] = {
    PLAYER = "ИГРОК",
    RANK = "РАНГ",
    USERGROUP = "ГРУППА ПОЛЬЗОВАТЕЛЕЙ",
    KILLS = "УБИВАЕТ",
    DEATHS = "СМЕРТЬ",
    PING = "ПИНГ",
    MY_STATS = "МОЯ СТАТИСТИКА",
}