WatchFox = WatchFox or {}
WatchFox.Modules = WatchFox.Modules or {}
WatchFox.Modules.Net = WatchFox.Modules.Net or {}

WatchFox.Modules.Net.Config = WatchFox.Modules.Net.Config or {}

-- Retrieve the configuration for a specific network message
function WatchFox.Modules.Net.Config:GetNetMessageConfig(netName)
    -- Start with the default config
    local config = {
        CheckType = self.DefaultMessageCheck.CheckType,
        OnSuspiciousMessage = self.DefaultMessageCheck.OnSuspiciousMessage
    }

    -- If there's an override for this net message, use it
    local override = self.MessageOverrideChecks[netName]
    if override then
        -- Override the CheckType if it's provided
        if override.CheckType then
            config.CheckType = override.CheckType
        end
        
        -- If there's an OnSuspiciousMessage override, use it; otherwise, keep the default
        if override.OnSuspiciousMessage then
            config.OnSuspiciousMessage = override.OnSuspiciousMessage
        end
    end

    return config
end
