hook.Add("EntityRemoved", "PropHr:EntRemoved", function(ent)
    if (ent:EntIndex()) then
        timer.Stop("prophr_health_reset_"..ent:EntIndex())
    end
end)