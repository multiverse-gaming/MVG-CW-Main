local READ = RDV.LIBRARY.Mysql.CFG

local HOST = READ.Host
local PASSWORD = READ.Password
local DATABASE = READ.Name
local USERNAME = READ.Username
local PORT = READ.Port
            
local MODULE = ( READ.Module or "sqlite" )

RDV_Mysql:SetModule(MODULE)

RDV_Mysql:Connect(HOST, USERNAME, PASSWORD, DATABASE, PORT)