att.PrintName = "Z-6 Sentry Mode"
att.Free = true
att.HideIfUnavailable = true

att.SortOrder = 20
att.Icon = Material("interfaz/armas/sw_powercore.png", "smooth mips")
att.Description = "Drastically increases pressure of Tibana Gas in the barrels, causing shots to explode on impact"
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}
att.Slot = "z6_internal"

att.AutoStats = true

att.Silencer = false

att.Mult_Damage = 6 -- 100 Damage
att.Mult_DamageMin = 6 -- 100 Damage
att.Mult_RPM = 150 / 900
att.Override_ClipSize = 20

att.Mult_AccuracyMOA = 0.01
att.Override_DamageType = DMG_BLAST

att.Hook_FireBullets = function(wep, bullettable)
    wep.Owner:FireBullets({
        Src = wep.Owner:EyePos(),
        Num = 1,
        Damage = 0,
        Force = 0,
        Attacker = wep.Owner,
        Dir = wep.Owner:EyeAngles():Forward(),
        Callback = function(_, tr, dmg)
			if SERVER then
				for k, v in pairs( ents.FindInSphere( tr.HitPos, 60 ) ) do
					if v:IsPlayer() or v:IsNPC() then
						if v:GetPos():Distance( tr.HitPos ) < 60 then
							distance = math.Clamp( (60 - v:GetPos():Distance(tr.HitPos)) / 60, 0.2, 1 )
							damage = DamageInfo()
							damage:SetDamage( 150 * distance )
							damage:SetAttacker( wep.Owner )
							damage:SetDamageType( DMG_BLAST )
							v:TakeDamageInfo( damage )
						end
					end
				end
			end
        end
    })
end