/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

if SERVER then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4

// Called when the PumpkinBoss smashes on the ground
net.Receive("zpn_Boss_SmashImpact_net", function(len, ply)
	zclib.Debug("zpn_Boss_SmashImpact_net Len: " .. len)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

	local PumpkinBoss = net.ReadEntity()
	local pos = net.ReadVector()
	local scale = net.ReadFloat()

	if IsValid(PumpkinBoss) and pos and scale then

		// Effect
		local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetScale(500 * scale)
		effectdata:SetRadius( 100 )
		util.Effect("ThumperDust", effectdata, false, true)

		// Sound
		PumpkinBoss:EmitSound("coast.thumper_dust")
	end
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

// Called when the PumpkinBoss starts healing
net.Receive("zpn_Boss_StartHeal_net", function(len, ply)
	zclib.Debug("zpn_Boss_StartHeal_net Len: " .. len)

	local PumpkinBoss = net.ReadEntity()

	if IsValid(PumpkinBoss) then
		zclib.Animation.PlayTransition(PumpkinBoss,zpn.Theme.Boss.anim["action_heal_start"], 1,zpn.Theme.Boss.anim["action_heal_loop"],1)
	end
end)

// Called when the PumpkinBoss stops healing
net.Receive("zpn_Boss_StopHeal_net", function(len, ply)
	zclib.Debug("zpn_Boss_StopHeal_net Len: " .. len)

	local PumpkinBoss = net.ReadEntity()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

	if IsValid(PumpkinBoss) then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

		zclib.Animation.Play(PumpkinBoss,zpn.Theme.Boss.anim["action_heal_end"], 1)
	end
end)
