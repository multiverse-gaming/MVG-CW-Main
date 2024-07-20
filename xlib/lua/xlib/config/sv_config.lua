xLib.Config = xLib.Config or {}

-- If you are using MySQL, please ensure you have the MySQLOO module installed!
xLib.Config.UseMySQL = false

xLib.Config.DBINFO = xLib.Config.DBINFO or {} -- Do not touch this

-- The host for your MySQL database ie. 127.0.0.1
xLib.Config.DBINFO.host = "localhost"
-- The username for your database - ensure this has permissions for the DB you are accessing
xLib.Config.DBINFO.username = "username"
-- The password for the above user
xLib.Config.DBINFO.pass = "password"
-- The database to use (ensure your user has access to this)
xLib.Config.DBINFO.db = "database"
-- The database port
xLib.Config.DBINFO.port = 3306

-- Setting this to true will print all failed MySQL / SQLite queries to console
xLib.Config.EnableDebug = true

xLib.Config.TableNamePrefix = "xlib_"
