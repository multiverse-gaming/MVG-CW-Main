/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

zpn = zpn or {}
zpn.Candy = zpn.Candy or {}

if SERVER then
	util.AddNetworkString("zpn_candy_notify")
	function zpn.Candy.Notify(ply,candy)
		net.Start("zpn_candy_notify")
		net.WriteInt(candy,16)
		net.WriteUInt(zpn.Candy.ReturnPoints(ply),16)
		net.Send(ply)
	end
end

if CLIENT then
	net.Receive("zpn_candy_notify", function(len)
		local candy_gain = net.ReadInt(16)
		local candy = net.ReadUInt(16)
		zclib.Debug("zpn_candy_notify Length: " .. len)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4

		if candy_gain and candy then
			zpn.Candy.Notify(candy_gain,candy)
		end
	end)

	local function SetupNotify()
		if zpn.CandyNotify and IsValid(zpn.CandyNotify.main) then
			zpn.CandyNotify.main:Remove()
		end

		if zpn.CandyNotify and IsValid(zpn.CandyNotify.thunder_panel) then
			zpn.CandyNotify.thunder_panel:Remove()
		end

		zpn.CandyNotify = {}


		zpn.CandyNotify.thunder_panel = vgui.Create("DPanel")
		zpn.CandyNotify.thunder_panel:SetPos(810 * zclib.wM, 390 * zclib.hM)
		zpn.CandyNotify.thunder_panel:SetSize(300 * zclib.wM, 300 * zclib.hM)
		zpn.CandyNotify.thunder_panel:SizeToContentsX(3)
		zpn.CandyNotify.thunder_panel:SizeToContentsY(3)
		zpn.CandyNotify.thunder_panel:SetAlpha( 0 )
		zpn.CandyNotify.thunder_panel:ParentToHUD()
		zpn.CandyNotify.thunder_panel:SetPaintBackground( false )

		zpn.CandyNotify.thunder_img = vgui.Create("DImage",zpn.CandyNotify.thunder_panel)
		zpn.CandyNotify.thunder_img:Dock(FILL)
		zpn.CandyNotify.thunder_img:SetImage("zerochain/zpn/ui/zpn_thunder.png")
		zpn.CandyNotify.thunder_img:SetImageColor(color_white)

		zpn.CandyNotify.main = vgui.Create("DPanel")
		zpn.CandyNotify.main:SetPos(zclib.wM * 810, zclib.hM * 390)
		zpn.CandyNotify.main:SetSize(300 * zclib.wM, 300 * zclib.hM)
		zpn.CandyNotify.main:SizeToContentsX(3)
		zpn.CandyNotify.main:SizeToContentsY(3)
		zpn.CandyNotify.main:SetAlpha( 0 )
		zpn.CandyNotify.main:SetPaintBackground( false )

		zpn.CandyNotify.bg = vgui.Create("DPanel", zpn.CandyNotify.main)
		zpn.CandyNotify.bg:Dock(FILL)
		zpn.CandyNotify.bg:SetPaintBackground( false )

		zpn.CandyNotify.candy_img = vgui.Create("DImage", zpn.CandyNotify.bg)
		zpn.CandyNotify.candy_img:SetPos(50 * zclib.wM, 100 * zclib.hM)
		zpn.CandyNotify.candy_img:SetSize(100 * zclib.wM, 100 * zclib.hM)
		zpn.CandyNotify.candy_img:SetImage("zerochain/zpn/ui/zpn_candy.png")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

		zpn.CandyNotify.lbl_gain = vgui.Create("DLabel", zpn.CandyNotify.bg)
		zpn.CandyNotify.lbl_gain:SetPos(150 * zclib.wM, 115 * zclib.hM)
		zpn.CandyNotify.lbl_gain:SetSize(150 * zclib.wM, 100 * zclib.hM)
		zpn.CandyNotify.lbl_gain:SetTextColor(zpn.default_colors["violett02"])
		zpn.CandyNotify.lbl_gain:SetFont(zclib.GetFont("zpn_notify_font01"))
		zpn.CandyNotify.lbl_gain:SetContentAlignment(7)
	end

	local LastCandyGain = -1
	local LastGainAmount = -1

	function zpn.Candy.Notify(candy_gain,candy)

		if zpn.CandyNotify == nil then
			SetupNotify()
		end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

		if CurTime() < (LastCandyGain + 0.6) then
			candy_gain = candy_gain + LastGainAmount
		end


		zpn.CandyNotify.thunder_panel:Stop()
		zpn.CandyNotify.thunder_panel:SetPos(810 * zclib.wM, 390 * zclib.hM)
		zpn.CandyNotify.thunder_panel:SetSize(300 * zclib.wM, 300 * zclib.hM)
		zpn.CandyNotify.thunder_panel:SetAlpha( 150 )

		zpn.CandyNotify.thunder_panel:AlphaTo( 0, 0.5, 0)
		zpn.CandyNotify.thunder_panel:MoveTo(660 * zclib.wM, 240 * zclib.hM,0.5, 0, -1)
		zpn.CandyNotify.thunder_panel:SizeTo(600 * zclib.wM, 600 * zclib.hM,0.5, 0,-1 )

		zpn.CandyNotify.main:Stop()
		zpn.CandyNotify.main:SetPos(zclib.wM * 810, zclib.hM * 390)
		zpn.CandyNotify.main:SetAlpha( 255 )
		zpn.CandyNotify.main:MoveTo( ScrW() / 2 - zpn.CandyNotify.main:GetWide() / 2, ScrH() / 3 - zpn.CandyNotify.main:GetTall() / 2,1, 0, -1)
		zpn.CandyNotify.main:AlphaTo( 0, 0.6, 0.25)

		if candy_gain > 0 then
			zpn.CandyNotify.candy_img:SetImage("zerochain/zpn/ui/" .. zpn.CandyIcon(candy_gain,50) .. ".png")
			zpn.CandyNotify.thunder_img:SetImageColor(color_white)
			zpn.CandyNotify.lbl_gain:SetText("+" .. candy_gain)
			zpn.CandyNotify.lbl_gain:SetTextColor(zpn.default_colors["green01"])
		else
			zpn.CandyNotify.candy_img:SetImage("zerochain/zpn/ui/" .. zpn.CandyIcon(candy_gain,50) .. ".png")
			zpn.CandyNotify.thunder_img:SetImageColor(zpn.default_colors["red01"])
			zpn.CandyNotify.lbl_gain:SetText(candy_gain)
			zpn.CandyNotify.lbl_gain:SetTextColor(zpn.default_colors["red01"])
		end

		LastCandyGain = CurTime()
		LastGainAmount = candy_gain
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

		local timerid = "zpn_scorelist_updater"
		zclib.Timer.Remove(timerid)
		zclib.Timer.Create(timerid, 1, 0, function()

			if zpn.CandyNotify and IsValid(zpn.CandyNotify.main) then
				zpn.CandyNotify.main:Remove()
			end

			if zpn.CandyNotify and IsValid(zpn.CandyNotify.thunder_panel) then
				zpn.CandyNotify.thunder_panel:Remove()
			end

			zpn.CandyNotify = nil

			zclib.Timer.Remove(timerid)
		end)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b
