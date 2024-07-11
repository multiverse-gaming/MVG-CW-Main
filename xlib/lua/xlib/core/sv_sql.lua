-- Databasing
xLib.DB = xLib.DB or {}

if xLib.Config.UseMySQL then
    require("mysqloo")

    xLib.DB.DB = mysqloo.connect(xLib.Config.DBINFO.host,
                                    xLib.Config.DBINFO.username,
                                    xLib.Config.DBINFO.pass,
                                    xLib.Config.DBINFO.db,
                                    xLib.Config.DBINFO.port)

    function xLib.DB.DB:onConnected()
        xLib.log(xLib, "Database connected")
        xLib.DB.UsingMySQL = true
        hook.Run("xLibDatabaseConnected")
    end

    function xLib.DB.DB:onConnectionFailed(err)
        xLib.log(xLib, "Connection to database failed!", xLib.LOG_ERROR)
        xLib.log(xLib, "Error:", err, xLib.LOG_ERROR)
        xLib.log(xLib, "Will use internal SQL database instead")
        xLib.DB.UsingMySQL = false
        -- SQLite needs this to run with a frame delay(?)
        timer.Simple(0, function() hook.Run("xLibDatabaseConnected") end)
    end

    xLib.DB.DB:connect()
else
    xLib.log(xLib, "Using local SQL")
    xLib.DB.UsingMySQL = false
    timer.Simple(0, function() hook.Run("xLibDatabaseConnected") end)
end

-- SQL/MySQL functions
function xLib.DB:query(qs, callback)
    if xLib.DB.UsingMySQL then
        local q = xLib.DB.DB:query(qs)

        function q:onSuccess(data)
            if callback and isfunction(callback) then callback(data) end
        end

        function q:onError(err, sql)
            xLib.log(xLib, "MySQL error", xLib.LOG_ERROR)
            xLib.log(xLib, "Query: " .. qs, xLib.LOG_ERROR)
            xLib.log(xLib, err, xLib.LOG_ERROR)
        end

        q:start()
    else
        local q = sql.Query(qs)
        if callback and isfunction(callback) and (q ~= false) then
            callback(q)
        end

        if q == false then
            xLib.log(xLib, "SQL error", xLib.LOG_ERROR)
            xLib.log(xLib, "Query: " .. qs, xLib.LOG_ERROR)
            xLib.log(xLib, sql.LastError(), xLib.LOG_ERROR)
        end
    end
end

function xLib.DB:escape(qs, wrapquotes)
    qs = tostring(qs)
    if xLib.DB.UsingMySQL then
        if wrapquotes then
            return xLib.DB.DB:escape(qs)
        else
            return string.format("'%s'", xLib.DB.DB:escape(qs)) -- Wrap the query string into quotes
        end
    else
        return sql.SQLStr(qs, wrapquotes)
    end
end

-- Database formatting

-- Select from DB table
function xLib.DB:selectQuery(tb, callback, clause)
    local qs = string.format("SELECT * FROM %s%s;", tb, clause and (" " .. clause) or "")
    xLib.DB:query(qs, callback)
end

-- Insert into DB table
function xLib.DB:insertQuery(tb, valueColumns, values, callback, duplicate)
    local valueColsStr = ""
    for k, v in ipairs(valueColumns) do
        valueColsStr = string.format("%s%s `%s`", valueColsStr, (k ~= 1) and "," or "", v)
    end

    local valuesStr = ""
    for k, v in ipairs(values) do
        valuesStr = string.format("%s%s %s", valuesStr, (k ~= 1) and "," or "", xLib.DB:escape(v))
    end

    local qs = string.format("REPLACE INTO %s(%s) VALUES(%s)%s;", tb, valueColsStr, valuesStr, duplicate or "")
    xLib.DB:query(qs, callback)
end

-- Create DB table
function xLib.DB:createTableQuery(tb, valueColumns, callback, extra)
    local valuesStr = ""
    for k, v in ipairs(valueColumns) do
        valuesStr = string.format("%s%s `%s` %s%s", valuesStr, (k ~= 1) and "," or "", v.ColName, v.DatType, v.Extra and (string.format(" %s", v.Extra)) or "")
    end

    local qs = string.format("CREATE TABLE IF NOT EXISTS %s(%s%s);", tb, valuesStr, extra and string.format(", %s", extra) or "")
    xLib.DB:query(qs, callback)
end