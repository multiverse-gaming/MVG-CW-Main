BF2_Scoreboard.Config = {}

BF2_Scoreboard.Config.Theme = {
    white = color_white,
    grey = Color(173,173,173),
    primary = Color(255,196,0)
}

-- Configuration of the display of the usergroups
BF2_Scoreboard.Config.Usergroups = {
    ["owner"] = {
        name = "Owner",
        color = Color(255, 0, 0)
    },
    ["superadmin"] = {
        name = "Senior Staff",
        color = Color(255, 0, 0)
    },
    ["headadmin"] = {
        name = "Head Admin",
        color = Color(4, 84, 252)
    },
    ["activedeveloper"] = {
        name = "Developer",
        color = Color(252, 148, 4)
    },
    ["admin"] = {
        name = "Administrator",
        color = Color(220, 36, 252)
    },
    ["mod"] = {
        name = "Moderator",
        color = Color(60, 188, 236)
    },
    ["trialmod"] = {
        name = "Trial Moderator",
        color = Color(4, 252, 156)
    },
    ["advisor"] = {
        name = "Advisor",
        color = Color(246, 201, 103)
    },
    ["eventleader"] = {
        name = "Event Team Leader",
        color = Color(80,50,800)
    },
    ["eventexpert"] = {
        name = "Event Expert",
        color = Color(155, 89, 182)
    },
    ["eventmaster"] = {
        name = "Event Master",
        color = Color(193, 3, 252)
    },
    ["eventspecialist"] = {
        name = "Event Specialist",
        color = Color(246, 201, 103)
    },
    ["eventadept"] = {
        name = "Event Adept",
        color = Color(500, 100, 60)
    },
    ["eventnovice"] = {
        name = "Event Novice",
        color = Color(250, 202, 42)
    },
    ["developer"] = {
        name = "Developer",
        color = Color(252, 148, 4)
    },
    ["veteran"] = {
        name = "Veteran",
        color = Color(230,230,3)
    },
    ["user"] = {
        name = "User",
        color = Color(194,194,194)
    },
}

-- The titles on top of the scoreboard
BF2_Scoreboard.Config.Texts = {
    title = "STAR WARS ROLEPLAY",
    subtitle = "Multiverse Gaming | Clone Wars",
}

-- Language selection
-- en / de / fr / ru
BF2_Scoreboard.Config.Language = "en"

-- Action buttons (SAM, ULX etc.)
-- Only touch if you have experience!
BF2_Scoreboard.Config.Actions = {
    ["goto"] = {
        name = "Goto",
        icon = Material("summe/bf2_scoreboard/goto.png", "smooth"),
        func = function(ply)
            if ULib then
                RunConsoleCommand("ulx", "goto", ply:Name())
            elseif serverguard then
                serverguard.command.Run("goto", "false", ply:Name())
            elseif sam then
                RunConsoleCommand("sam", "goto", ply:Name())
            end
        end
    },
    ["return"] = {
        name = "Return",
        icon = Material("summe/bf2_scoreboard/return.png", "smooth"),
        func = function(ply)
            if ULib then
                RunConsoleCommand("ulx", "return", ply:Name())
            elseif serverguard then
                serverguard.command.Run("return", "false", ply:Name())
            elseif sam then
                RunConsoleCommand("sam", "return", ply:Name())
            end
        end
    },
    ["bring"] = {
        name = "Bring",
        icon = Material("summe/bf2_scoreboard/bring.png", "smooth"),
        func = function(ply)
            if ULib then
                RunConsoleCommand("ulx", "bring", ply:Name())
            elseif serverguard then
                serverguard.command.Run("bring", "false", ply:Name())
            elseif sam then
                RunConsoleCommand("sam", "bring", ply:Name())
            end
        end
    },
    ["freeze"] = {
        name = "Freeze",
        icon = Material("summe/bf2_scoreboard/freeze.png", "smooth"),
        func = function(ply)
            if ply:IsFlagSet(FL_FROZEN) then
                if ULib then
                    RunConsoleCommand("ulx", "unfreeze", ply:Name())
                elseif serverguard then
                    serverguard.command.Run("unfreeze", "false", ply:Name())
                elseif sam then
                    RunConsoleCommand("sam", "unfreeze", ply:Name())
                end
            else
                if ULib then
                    RunConsoleCommand("ulx", "freeze", ply:Name())
                elseif serverguard then
                    serverguard.command.Run("freeze", "false", ply:Name())
                elseif sam then
                    RunConsoleCommand("sam", "freeze", ply:Name())
                end
            end
        end
    },
    ["kick"] = {
        name = "Kick",
        icon = Material("summe/bf2_scoreboard/disconnect.png", "smooth"),
        func = function(ply)
            if ULib then
                RunConsoleCommand("ulx", "kick", ply:Name())
            elseif serverguard then
                serverguard.command.Run("kick", "false", ply:Name())
            elseif sam then
                RunConsoleCommand("sam", "kick", ply:Name())
            end
        end
    },
    ["steamid"] = {
        name = "SteamID",
        icon = Material("summe/bf2_scoreboard/copy.png"),
        func = function(ply)
            SetClipboardText(ply:SteamID() or "BOT")
        end
    },

}
