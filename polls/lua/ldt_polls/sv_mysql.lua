-- Which database mode to use.
-- Available modes: mysqloo, sqlite
LDT_Polls.Config.DatabaseMode = "sqlite"

-- If mysqloo is enabled above, the login info for the MySQL server.
-- The tables will be created automatically.
LDT_Polls.Config.DatabaseConfig = {
	host = "127.0.0.1",
	user = "username",
	password = "password",
	database = "dbname",
	port = 3306,
}