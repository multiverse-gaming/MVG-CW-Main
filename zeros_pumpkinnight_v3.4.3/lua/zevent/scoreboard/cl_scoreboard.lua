/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

if SERVER then return end
zpn = zpn or {}
zpn.Scoreboard = zpn.Scoreboard or {}

zpn.ScoreList = zpn.ScoreList or {}
local InsideTop10 = false
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

net.Receive("zpn_scoreboard_send", function(len)
	zclib.Debug("zpn_scoreboard_send Len: " .. len)

	local dataLength = net.ReadUInt(16)
	local boardDecompressed = util.Decompress(net.ReadData(dataLength))
	local scorelist = util.JSONToTable(boardDecompressed)

	local YourScore = net.ReadUInt(32)

	if scorelist then
		zpn.ScoreList = {}

		// Check if the player is inside the top 10
		local id = LocalPlayer():SteamID()
		for k, v in pairs(scorelist) do
			if v and v.id == id then
				InsideTop10 = true
				v.name = v.name
				break
			end
		end

		// If he is not then we overwrite the last place, so he is on the scoreboard atleast
		if not InsideTop10 then

			local name = LocalPlayer():Nick()
			if string.len(name) > 15 then
				name = string.gsub( name, "[^%w_]", "" )
				name = string.sub(name, 1, 15)
			end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

			scorelist[table.Count(scorelist)] = {
				name = name,
				val = YourScore,
				id = LocalPlayer():SteamID()
			}
		end

		table.CopyFromTo(scorelist, zpn.ScoreList)
	end
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4

function zpn.Scoreboard.Initialize(Scoreboard)
    zclib.Debug("zpn.Scoreboard.Initialize")
	zclib.EntityTracker.Add(Scoreboard)
	Scoreboard.HasEffect = false
end

local function DrawItem(textA, textB, first, pos)
	if first then
		surface.SetDrawColor(color_white)
		surface.SetMaterial(zpn.Theme.Scoreboard.materials["item"])
		surface.DrawTexturedRect(-100, -40, 250, 40)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

		surface.SetDrawColor(color_white)
		surface.SetMaterial(zpn.Theme.Scoreboard.materials["icon"])
		surface.DrawTexturedRect(45, -32, 25, 25)

		draw.SimpleText(textA, zclib.GetFont("zpn_scoreboard_item_font01"), -85, -20, zpn.Theme.Design.color03, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		draw.SimpleText(textB, zclib.GetFont("zpn_scoreboard_item_font01"), 80, -20, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		surface.SetDrawColor(color_white)
		surface.SetMaterial(zpn.Theme.Scoreboard.materials["first"])
		surface.DrawTexturedRect(-145, -35, 35, 35)
	else
		surface.SetDrawColor(color_white)
		surface.SetMaterial(zpn.Theme.Scoreboard.materials["item"])
		surface.DrawTexturedRect(-100, -65 + (35 * pos), 250, 30)

		surface.SetDrawColor(color_white)
		surface.SetMaterial(zpn.Theme.Scoreboard.materials["icon"])
		surface.DrawTexturedRect(47, -60 + (35 * pos), 20, 20)

		draw.SimpleText(textA, zclib.GetFont("zpn_scoreboard_item_font02"), -85, -50 + (35 * pos), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		draw.SimpleText(textB, zclib.GetFont("zpn_scoreboard_item_font02"), 80, -50 + (35 * pos), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		draw.SimpleText(pos, zclib.GetFont("zpn_scoreboard_item_font02"), -135, -48 + (35 * pos), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
end

function zpn.Scoreboard.OnDraw(Scoreboard)
	if zclib.Convar.Get("zclib_cl_drawui") ~= 1 then return end
	if not zclib.util.InDistance(LocalPlayer():GetPos(), Scoreboard:GetPos(), 500) then return end


	cam.Start3D2D(Scoreboard:LocalToWorld(zpn.Theme.Scoreboard.hud_pos), Scoreboard:LocalToWorldAngles(Angle(0, 90, 90)), 0.1)

	if Scoreboard.TextData == nil then
		local str = zpn.Theme.Scoreboard.title
		local font = zclib.util.FontSwitch(str, 17, zclib.GetFont("zpn_scoreboard_font01"), zclib.GetFont("zpn_scoreboard_font01_small"))

		Scoreboard.TextData = {
			txt = str,
			font = font
		}
	end

	draw.SimpleText(Scoreboard.TextData.txt, Scoreboard.TextData.font, 2, -78, zpn.Theme.Design.color02, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText(Scoreboard.TextData.txt, Scoreboard.TextData.font, 0, -80, zpn.Theme.Design.color01, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	if #zpn.ScoreList > 0 then
		DrawItem(zpn.ScoreList[1].name, zpn.ScoreList[1].val, true, nil)

		for i = 2, #zpn.ScoreList do
			if zpn.ScoreList[i] then
				DrawItem(zpn.ScoreList[i].name, zpn.ScoreList[i].val, false, i)
			end
		end
	end

	cam.End3D2D()
end
