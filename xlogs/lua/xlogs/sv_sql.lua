-- Databasing
xLogs.DB = xLogs.DB or {}

if xLogs.Config.UseMySQL then
    require("mysqloo")

    xLogs.DB.DB = mysqloo.connect(xLogs.Config.DBINFO.host,
                                    xLogs.Config.DBINFO.username,
                                    xLogs.Config.DBINFO.pass,
                                    xLogs.Config.DBINFO.db,
                                    xLogs.Config.DBINFO.port)

    function xLogs.DB.DB:onConnected()
        xLogs.log("Database connected")
        xLogs.DB.UsingMySQL = true
        hook.Run("xLogsDatabaseConnected")
    end

    function xLogs.DB.DB:onConnectionFailed(err)
        xLogs.log("Connection to database failed!", xLogs.LOG_ERROR)
        xLogs.log("Error:", err, xLogs.LOG_ERROR)
        xLogs.log("Will use internal SQL database instead")
        xLogs.DB.UsingMySQL = false
        -- SQLite needs this to run with a frame delay(?)
        timer.Simple(0, function() hook.Run("xLogsDatabaseConnected") end)
    end

    xLogs.DB.DB:connect()
else
    xLogs.log("Using local SQL")
    xLogs.DB.UsingMySQL = false
    timer.Simple(0, function() hook.Run("xLogsDatabaseConnected") end)
end

-- SQL/MySQL functions
function xLogs.DB:query(qs, callback)
    if xLogs.DB.UsingMySQL then
        local q = xLogs.DB.DB:query(qs)

        function q:onSuccess(data)
            if callback and isfunction(callback) then callback(data) end
        end

        function q:onError(err, sql)
            xLogs.log("MySQL error", xLogs.LOG_ERROR)
            xLogs.log(err, xLogs.LOG_ERROR)
        end

        q:start()
    else
        local q = sql.Query(qs)
        if callback and isfunction(callback) and (q ~= false) then
            callback(q)
        end

        if q == false then
            xLogs.log("SQL error", xLogs.LOG_ERROR)
            xLogs.log(sql.LastError(), xLogs.LOG_ERROR)
        end
    end
end

function xLogs.DB:escape(qs, wrapquotes)
    qs = tostring(qs)
    if xLogs.DB.UsingMySQL then
        if wrapquotes then
            return xLogs.DB.DB:escape(qs)
        else
            return string.format("'%s'", xLogs.DB.DB:escape(qs)) -- Wrap the query string into quotes
        end
    else
        return sql.SQLStr(qs, wrapquotes)
    end
end

-- Database formatting

-- Select from DB table
function xLogs.DB:selectQuery(tb, callback, clause)
    local qs = string.format("SELECT * FROM %s%s;", tb, clause and (" " .. clause) or "")
    xLogs.DB:query(qs, callback)
end

-- Insert into DB table
function xLogs.DB:insertQuery(tb, valueColumns, values, callback, duplicate)
    local valueColsStr = ""
    for k, v in ipairs(valueColumns) do
        valueColsStr = string.format("%s%s %s", valueColsStr, (k ~= 1) and "," or "", v)
    end

    local valuesStr = ""
    for k, v in ipairs(values) do
        valuesStr = string.format("%s%s %s", valuesStr, (k ~= 1) and "," or "", xLogs.DB:escape(v))
    end

    local qs = string.format("INSERT INTO %s(%s) VALUES(%s)%s;", tb, valueColsStr, valuesStr, duplicate or "")
    xLogs.DB:query(qs, callback)
end

-- Create DB table
function xLogs.DB:createTableQuery(tb, valueColumns, callback)
    local valuesStr = ""
    for k, v in ipairs(valueColumns) do
        valuesStr = string.format("%s%s %s %s%s", valuesStr, (k ~= 1) and "," or "", v.ColName, v.DatType, v.Extra and (string.format(" %s", v.Extra)) or "")
    end

    local qs = string.format("CREATE TABLE IF NOT EXISTS %s(%s);", tb, valuesStr)
    xLogs.DB:query(qs, callback)
end