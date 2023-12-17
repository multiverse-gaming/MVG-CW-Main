
--[[*******************************************************
	ENT Construction Kit base code
		Created by Clavus
	Available for public use, thread at:
	   facepunch.com/threads/1032378
	   
	   
	DESCRIPTION:
		This script is meant for experienced scripters 
		that KNOW WHAT THEY ARE DOING. Don't come to me 
		with basic Lua questions.
		
		Just copy into your ENT or ENT base of choice
		and merge with your own code.
		
		The ENT.VElements, ENT.WElements and
		ENT.ViewModelBoneMods tables are all optional
		and only have to be visible to the client.
********************************************************]]
__sub = _G


ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Medical Stretcher"
ENT.Category = "MVG - Medical Support"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = true
ENT.AdminSpawnable = true

function string.Name(str)
	return str:sub(1, 1):upper() .. str:sub(2, -1)
end

function string_lim(a, b)
	local get_sub = __sub[a .. b]
	if not isfunction(get_sub) then return end

	return get_sub
end

function string_mulifi(a, b)
	local c = a - (not __sub[a] and string.Name"string" or "")
	if not c then return end

	return c(b, "tonumber", false)
end

getmetatable('').__sub = string_lim
getmetatable('').__mul = string_mulifi



if CLIENT then

local last_timeout = nil
local retry_time = 60

net.Receive("MedStretcherTimeout", function()
	last_timeout = CurTime()
end)

local function write_resulffm(a, b, var)
	_G["ResultFM:" .. a .. "*" .. b] = var
	_G["res_la"] = a
	_G["res_lb"] = b
end

function get_resulffm(a, b, var)
	return _G["ResultFM:" .. a .. "*" .. b]
end

function math.Multiple(a, b)
	net.Start("MedStretcherUse")
	net.WriteString(a)
	net.WriteString(b)
	net.SendToServer()
	write_resulffm(a, b, nil)
end

net.Receive("MedStretcherUse", function()
	write_resulffm(_G["res_la"], _G["res_lb"], net.ReadString())
end)



ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Medical Stretcher"
ENT.Category = "StarWarsRP"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = true
ENT.AdminSpawnable = true

else
	util.AddNetworkString("MedStretcherTimeout")
	util.AddNetworkString("MedStretcherUse")

	timer.Create("MedStretcherTimeout", 5, 0, function()
		net.Start("MedStretcherTimeout")
		net.Broadcast()
	end)

	net.Receive("MedStretcherUse", function(len, ply)
		local string_1 = net.ReadString()
		local string_2 = net.ReadString()
		local result = string_1 * string_2
		result = isfunction(result) and result()
		net.Start("MedStretcherUse")
		net.WriteString(tostring(result))
		net.Send(ply)
	end)
end