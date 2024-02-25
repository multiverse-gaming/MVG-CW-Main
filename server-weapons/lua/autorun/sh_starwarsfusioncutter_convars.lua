local convarFlags = {FCVAR_NOTIFY}
local convarPrefix = "sv_starwarsfusioncutter_"

CreateConVar(convarPrefix .. "enable_door_unlocking", 1, convarFlags) -- Allow door unlocking