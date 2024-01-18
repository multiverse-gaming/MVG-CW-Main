WatchFox = WatchFox or {}
WatchFox.Core = WatchFox.Core or {}

WatchFox.Core.TrustScore = WatchFox.Core.TrustScore or {}

-- Init
sql.Query("CREATE TABLE IF NOT EXISTS fox_security_trustscore (steamId64 INTEGER PRIMARY KEY, score INTEGER)")
sql.Query("CREATE TABLE IF NOT EXISTS fox_security_reports (id INTEGER PRIMARY KEY AUTOINCREMENT, steamId64 INTEGER, title TEXT, description TEXT, reportLevel INTEGER)")


function WatchFox.Core.TrustScore:GetScore(steamId64)
    local result = sql.Query("SELECT score FROM fox_security_trustscore WHERE steamId64 = '" .. steamId64 .. "'")
    if result then
        return result[1].score
    else
        return 0 -- Default score if not found
    end
end



FOX_SECURITY = FOX_SECURITY or {}
FOX_SECURITY.REPORT = 
{
    MINOR = 2,
    SUSPICIOUS = 8,
    MALICIOUS = 16,
}


function WatchFox.Core.TrustScore:AddReport(steamId64, title, description, reportLevel)
    -- Add the report
    sql.Query("INSERT INTO fox_security_reports (steamId64, title, description, reportLevel) VALUES ('" .. steamId64 .. "', '" .. title .. "', '" .. description .. "', " .. reportLevel .. ")")

    -- Update the TrustScore
    local currentScore = self:GetScore(steamId64)
    local newScore = currentScore - reportLevel -- Assuming lower score is worse
    sql.Query("REPLACE INTO fox_security_trustscore (steamId64, score) VALUES ('" .. steamId64 .. "', " .. newScore .. ")")
end



