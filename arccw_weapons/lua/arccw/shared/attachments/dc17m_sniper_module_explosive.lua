att.PrintName = "Explosive Module"
att.Description = "Changes the gun to hold one round, and for that round to explode."
att.AutoStats = true
att.Mult_ShootPitch = 1
att.Mult_ShootVol = 1
att.SortOrder = 150
att.Silencer = false
att.IsMuzzleDevice = false
att.Free = true
att.HideIfUnavailable = true
att.Mult_ShootSpeedMult = 1
att.Mult_Sway = 1

att.Slot = {"dc17m_sniper_module"}

att.Mult_Recoil = 1.3
att.Mult_RecoilSide = 1.4
att.Add_ClipSize = -2
att.Mult_SightedSpeedMult = 1.1
att.Mult_ReloadTime = 1.5
att.Mult_Damage = 1.5
att.Mult_DamageMin = 1.5
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
							local distance = math.Clamp( (60 - v:GetPos():Distance(tr.HitPos)) / 60, 0.2, 1 )
							local damage = DamageInfo()
							damage:SetDamage( math.min(150 * distance, 150) )
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