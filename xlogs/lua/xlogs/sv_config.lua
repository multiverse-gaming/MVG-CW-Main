xLogs.Config = xLogs.Config or {}

-- If you are using MySQL, please ensure you have the MySQLOO module installed!
xLogs.Config.UseMySQL = false

xLogs.Config.DBINFO = xLogs.Config.DBINFO or {} -- Do not touch this

-- The host for your MySQL database ie. 127.0.0.1
xLogs.Config.DBINFO.host = "127.0.0.1"
-- The username for your database - ensure this has permissions for the DB you are accessing
xLogs.Config.DBINFO.username = "username"
-- The password for the above user
xLogs.Config.DBINFO.pass = "password"
-- The database to use (ensure your user has access to this)
xLogs.Config.DBINFO.db = "database"
-- The database port
xLogs.Config.DBINFO.port = 3306

-- Limit for how many logs to load from each category from DB
-- Higher values may result in some performance issues
xLogs.Config.DBLoadLimit = 1000

-- Table name prefix for xLogs to store logs
-- Table names will append the category of log types, ie. xlogs_logginginfo_darkrp
xLogs.Config.LogsTableNamePrefix = "xlogs_logginginfo_"

-- Whether or not to use Discord relay (requires RelayURL, DiscordWebhook and RelayKey to be assigned)
xLogs.Config.DoDiscordRelay = true
-- URL for Discord relay
-- Change this if you have uploaded 'discordrelay.php' to your own website with the relevant URL. If not, you can leave this as the default URL.
xLogs.Config.RelayURL = "https://www.thexnator.dev/gms/discordrelay.php"
-- This is the private key for the Discord relay - You don't need to change this unless you use the proxy on your own webserver
-- If using the proxy on your own webserver, find your key in the discordrelay.php file
xLogs.Config.RelayKey = "KSwWrN6bApvKfJx7"
-- Webhook for Discord channel to relay logs to
xLogs.Config.DiscordWebhook = "https://discord.com/api/webhooks/1192126250010038302/KqsSgd0dYA8fptfME7OFSEkznom7lnt_7ho3uXmpvoG1ZmVScfvXs3baQcMVx3miX8lB"
-- Webhook for Jedi Discord channel to relay logs to
xLogs.Config.JediDiscordWebhook = "https://discordapp.com/api/webhooks/1228397978952405052/hodw1bhuwkoALxj6HId5hI-Qe3SWl0YhhY36TFYQYWf9JPdi6bQwPoruJCu-R6iZp6Qr"