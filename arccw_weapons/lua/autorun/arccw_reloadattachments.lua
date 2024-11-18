-- For some reason, some attachments are loading in too early and not getting added to the server. This will fix it.
timer.Simple(135, function()
    RunConsoleCommand("arccw_reloadatts")
end)