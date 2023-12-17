local CONFIG = {}
------------------------------------------------ CONFIG ------------------------------------------------------------
CONFIG.Enabled = true 




function CONFIG:AllowUserSpecific(ply)
    -- Overridable
        -- INFO: Please don't change this if you don't know what you're doing.
            -- This listens for a return condition inside the HUD class. If it fails to find one it will still execute the code, so take caution.

end

function CONFIG:PreInit(screen_x, screen_y)
    -- Overridable
        -- INFO: Please don't change this if you don't know what you're doing.

end

function CONFIG:PostInit(screen_x, screen_y)
    -- Overridable
        -- INFO: Please don't change this if you don't know what you're doing.

end




--------------------------------------------------------------------------------------------------------------------
return CONFIG
