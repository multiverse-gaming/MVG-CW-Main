local OBJ = NCS_DATAPAD.GetPlugin()

local function UseData(ply, data)
	NCS_DATAPAD.E_DATA[ply] = {}
	
    if not data or data[1] == nil then 
		return 
	end

    for k, v in ipairs(data) do
		NCS_DATAPAD.E_DATA[ply][tonumber(v.CONTENT_ID)] = {
            TITLE = v.TITLE,
            GIVER = v.GIVER,
			CONTENT = v.ENTRY,
        }
    end
end

local function SelectData(ply, slot)
	if not IsValid(ply) or not ply.SteamID64 then
		return
	end

	local q = RDV_DP_Mysql:Select("RDV_DATAPAD_ENTRIES")
		q:Select("CONTENT_ID")
		q:Select("TITLE")
		q:Select("ENTRY")
		q:Select("GIVER")
		q:Select("PCHARACTER")
		q:Where("PLAYER", ply:SteamID64())
		q:Where("PCHARACTER", slot)
		q:Callback(function(data)
			UseData(ply, data)
		end)
	q:Execute()
end

timer.Simple(0, function()
	local q = RDV_DP_Mysql:Create("RDV_DATAPAD_ENTRIES")
		q:Create("CONTENT_ID", "INTEGER NOT NULL AUTO_INCREMENT")
		q:Create("PLAYER", "VARCHAR(255)")
		q:Create("PCHARACTER", "INT")
		q:Create("TITLE", "VARCHAR(255)")
		q:Create("ENTRY", "VARCHAR(8000)")
		q:Create("GIVER", "VARCHAR(255)")
		q:PrimaryKey("CONTENT_ID")
	q:Execute()

	local q = RDV_DP_Mysql:Create("RDV_DATAPAD_ARCHIVE")
		q:Create("CONTENT_ID", "INTEGER NOT NULL AUTO_INCREMENT")
		q:Create("CREATOR", "VARCHAR(255)")
		q:Create("ARCHIVER", "VARCHAR(255)")
		q:Create("TITLE", "VARCHAR(255)")
		q:Create("ENTRY", "TEXT")
		q:Create("TIME", "TEXT")
		q:PrimaryKey("CONTENT_ID")
	q:Execute()
end )


NCS_DATAPAD.OnCharacterDeleted(nil, function(ply, slot)
	if !NCS_DATAPAD.GetCharacterEnabled() then return end

	local SID64 = ply:SteamID64()

	local q = RDV_DP_Mysql:Delete("RDV_DATAPAD_ENTRIES")
		q:Where("PLAYER", SID64)
		q:Where("PCHARACTER", slot)
	q:Execute()
end)

NCS_DATAPAD.OnCharacterLoaded(nil, function(ply, slot)
	if !NCS_DATAPAD.GetCharacterEnabled() then return end

	SelectData(ply, slot)
end)

hook.Add("NCS_DATAPAD_PlayerReadyForNetworking", "NCS_DATAPAD.ENTRIES.NETWORKING", function(ply)
	if NCS_DATAPAD.GetCharacterEnabled() then return end

	SelectData(ply, 1)
end)

--]]------------------------------------------------]]--
--	Network Strings
--]]------------------------------------------------]]--

util.AddNetworkString("RDV_DATAPAD_OpenConsoleMenu")
util.AddNetworkString("RDV_DATAPAD_StartConsoleHack")
util.AddNetworkString("RDV_DATAPAD_ConsoleEdited")

util.AddNetworkString("RDV_DATAPAD_GetDescription")
util.AddNetworkString("RDV_DATAPAD_CreateEntry")
util.AddNetworkString("RDV_DATAPAD_GetEntry")
util.AddNetworkString("RDV_DATAPAD_DeleteEntry")
util.AddNetworkString("RDV_DATAPAD_SendEntry")

--]]------------------------------------------------]]--
--	Local Values
--]]------------------------------------------------]]--

local function SendNotification(ply, msg)
	local CFG = {
		Appension = NCS_DATAPAD.CONFIG.PREFIX,
		Color = NCS_DATAPAD.CONFIG.PREFIX_C,
	}

	NCS_SHARED.AddText(ply, CFG.Color, "["..CFG.Appension.."] ", color_white, msg)
end

--]]------------------------------------------------]]--
--	Networking
--]]------------------------------------------------]]--

local C_DELAY = {}

util.AddNetworkString("RDV_DATAPAD_ARREST_REPORT")

net.Receive("RDV_DATAPAD_ARREST_REPORT", function(msg)
	local msg = net.ReadString()

	for i, ply in ipairs( player.GetAll() ) do
		NCS_SHARED.AddText(ply, Color( 255, 0, 0 ), "[RFA] ", Color( 255, 255, 0 ), msg)
        //ply:ChatPrint(msg)
    end
end)

local NS_DELAY = {}

local plyMeta = FindMetaTable("Player")

function plyMeta:GiveDatapadEntry(TITLE, CONTENT, GIVER, CALLBACK)
	if !TITLE || !CONTENT then
		return
	end

	if !GIVER then
		GIVER = "N/A"
	end

	if IsValid(GIVER) then
		GIVER = GIVER:SteamID64()
	end

	local CHARACTER =  ( NCS_DATAPAD.GetCharacterEnabled() and NCS_DATAPAD.GetCharacterID(self, nil) or 1 )

	NCS_DATAPAD.E_DATA[self] = NCS_DATAPAD.E_DATA[self] or {}

	local q = RDV_DP_Mysql:Insert("RDV_DATAPAD_ENTRIES")
		q:Insert("PLAYER", self:SteamID64())
		q:Insert("PCHARACTER", CHARACTER)
		q:Insert("TITLE", TITLE)
		q:Insert("ENTRY", CONTENT)
		q:Insert("GIVER", GIVER)
		q:Callback(function(data, idk, last)
			local entry = last

			NCS_DATAPAD.E_DATA[self][tonumber(entry)] = {
				TITLE = TITLE,
				CONTENT = CONTENT,
				GIVER = GIVER
			}

			if CALLBACK then
				CALLBACK(entry)
			end
		end)
	q:Execute()
end

local NS_ArchiveDelay = {}

util.AddNetworkString("NS_DATAPAD_ArchiveConsole")

net.Receive("NS_DATAPAD_ArchiveConsole", function(_, P)
	if NS_ArchiveDelay[P] and NS_ArchiveDelay[P] > CurTime() then return end

	NCS_DATAPAD.IsAdmin(P, function(ACCESS)
		if ACCESS or NCS_DATAPAD.CONFIG.ArchiveAccess[team.GetName(P:Team())] then
			local KEY = net.ReadUInt(16)

			local TAB = P:GetDatapadEntries()

			if !TAB[KEY] then return end

			local CONTENT = TAB[KEY].CONTENT
			local TITLE = TAB[KEY].TITLE
			local GIVER = TAB[KEY].GIVER

			local q = RDV_DP_Mysql:Insert("RDV_DATAPAD_ARCHIVE")
				q:Insert("ARCHIVER", P:SteamID64())
				q:Insert("CREATOR", P:SteamID64())
				q:Insert("TITLE", TITLE)
				q:Insert("ENTRY", CONTENT)
				q:Insert("TIME", os.time())
				q:Callback(function(data, idk, last)
					local entry = last

					table.insert(NCS_DATAPAD.E_ARCHIVED, {
						UID = entry,
						TITLE = TITLE,
						TIME = os.time(),
						CONTENT = CONTENT,
						GIVER = GIVER,
						ARCHIVER = P:SteamID64(),
					})

					SendNotification(P, NCS_DATAPAD.GetLang(nil, "DAP_archivedSuccess", {TITLE}))
				end)
			q:Execute()
		else
			SendNotification(P, NCS_DATAPAD.GetLang(nil, "DAP_noArchiveAccess"))
		end
	end )

	NS_ArchiveDelay[P] = CurTime() + 5
end )

util.AddNetworkString("NS_DATAPAD_DeleteArchived")
net.Receive("NS_DATAPAD_DeleteArchived", function(_, P)
	local EUID = net.ReadUInt(32)

	if NS_ArchiveDelay[P] and NS_ArchiveDelay[P] > CurTime() then return end

	NCS_DATAPAD.IsAdmin(P, function(ACCESS)
		if ACCESS or NCS_DATAPAD.CONFIG.ArchiveAccess[team.GetName(P:Team())] then
			local q = RDV_DP_Mysql:Delete("RDV_DATAPAD_ARCHIVE")
				q:Where("CONTENT_ID", EUID)
				q:Callback(function(data, idk, last)
					for k, v in pairs(NCS_DATAPAD.E_ARCHIVED) do
						if tonumber(v.UID) == tonumber(EUID) then
							NCS_DATAPAD.E_ARCHIVED[k] = nil
						end
					end
				end )
			q:Execute()
		else
			SendNotification(P, NCS_DATAPAD.GetLang(nil, "DAP_noArchiveAccess"))
		end
	end )
end )

util.AddNetworkString("NS_DATAPAD_GetArchived")
net.Receive("NS_DATAPAD_GetArchived", function(_, P)
	if NS_ArchiveDelay[P] and NS_ArchiveDelay[P] > CurTime() then return end

	NCS_DATAPAD.IsAdmin(P, function(ACCESS)
		if ACCESS or NCS_DATAPAD.CONFIG.ArchiveAccess[team.GetName(P:Team())] then
			local PAGE = net.ReadUInt(8)
			local DidSearch = net.ReadBool()
			local SEARCH = false

			if DidSearch then SEARCH = net.ReadString() end

			local QUERY 

			if SEARCH and SEARCH ~= "" then
				QUERY = "SELECT * FROM RDV_DATAPAD_ARCHIVE WHERE TITLE LIKE '%"..SEARCH.."%' ORDER BY CONTENT_ID DESC LIMIT 4 OFFSET "..(PAGE * 4)..""
			else
				QUERY = "SELECT * FROM RDV_DATAPAD_ARCHIVE ORDER BY CONTENT_ID DESC LIMIT 4 OFFSET "..(PAGE * 4)..""
			end

			local TEST = RDV_DP_Mysql:RawQuery(QUERY, function(data)
				net.Start("NS_DATAPAD_GetArchived")
					if !data or data[1] == nil then
						net.WriteBool(false)
					else
						net.WriteBool(true)
						net.WriteTable(data)
					end
				net.Send(P)
			end )
		else
			SendNotification(P, NCS_DATAPAD.GetLang(nil, "DAP_noArchiveAccess"))
		end
	end )

	NS_ArchiveDelay[P] = CurTime() + 1
end )

