/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

if CLIENT then return end
zpn = zpn or {}
zpn.Partypopper = zpn.Partypopper or {}

function zpn.Partypopper.ProjectileExplosion(pos, dist, ply)
    for k, v in pairs(ents.FindInSphere(pos, dist)) do
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

        if IsValid(v) and zpn.config.PartyPopper.Damage[v:GetClass()] then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

            if v:GetClass() == "zpn_destructable" and v.Smashed == true then continue end
			// 115529856
            local d = DamageInfo()
            d:SetDamage(zpn.config.PartyPopper.Damage[v:GetClass()])
            d:SetAttacker(ply)
            d:SetDamageType(DMG_SONIC)
            v:TakeDamageInfo(d)
        end
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

// If the player allready has a pumpkin popper then we stop
zclib.Hook.Add("PlayerCanPickupWeapon", "zpn_PartyPopper", function(ply, wep)
    if (wep:GetClass() == "zpn_partypopper" or wep:GetClass() == "zpn_partypopper01") and ply:HasWeapon(wep:GetClass()) then return false end
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
