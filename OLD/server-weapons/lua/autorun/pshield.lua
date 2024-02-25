hook.Add('ScalePlayerDamage','PShield',function(ply,hitgroup,dmg)
	if !dmg:IsFallDamage() and IsValid(ply:GetNWEntity('PShield')) then
		if ply:GetNWEntity('PShield'):GetActive() then
			return true
		end
	end
end)

if SERVER then

	hook.Add('EntityTakeDamage','PShield',function(ent,dmg)
		if ent:IsPlayer() and !dmg:IsFallDamage() and IsValid(ent:GetNWEntity('PShield')) and ent:GetNWEntity('PShield'):GetActive() then
			return true
		end
	end)

	hook.Add('EntityFireBullets','PShield',function(ent,data)
		local shield = ent:GetNWEntity('PShield')
		if IsValid(shield) then
			shield:ShotBullet()
			data.IgnoreEntity = shield
			return true
		end
	end)

	hook.Add('EntityFireBullets','PShield_PreventRevive',function(ent,data)
        local shield = ent:GetNWEntity('PShield')
        if IsValid(shield) and shield:GetActive() and ent == "weapon_defibrillator" then
            return false
        end
    end)

	hook.Add('PhysgunPickup','PShield',function(ply,ent)
		if ent:GetClass() == 'personal_shield' then return false end
	end)

end

if CLIENT then

	--local CDRAW = include('CDRAW.lua')--

	hook.Add('EntityFireBullets','PShield',function(ent,data)
		if ent ~= LocalPlayer() then return end
		local shield = ent:GetNWEntity('PShield')
		if IsValid(shield) then
			data.IgnoreEntity = shield
			return true
		end
	end)

	surface.CreateFont('SHLACK',{font='Trebuchet MS',size=32,weight=400})

	local MSW, MSH = ScrW(), ScrH()
	local off_h = MSH/2-32
	local col_bg = Color(0,0,0,192)
	local col_fill = Color(64,128,192,255)
	local col_fill_dmg = Color(128,64,64,255)
	local col_txt = Color(255,255,255)
	local mat_shuffle = Material('models/props_combine/stasisshield_sheet')

	hook.Add('HUDPaint','PShield',function()
		if !IsValid(LocalPlayer()) or !IsValid(LocalPlayer():GetActiveWeapon()) then return end
		local shield = LocalPlayer():GetNWEntity('PShield')
		if IsValid(shield) then
			if !(!shield:GetActive() and !shield:GetDamaged() and LocalPlayer():GetActiveWeapon():GetClass() ~= 'weapon_shield_activator') then
				if shield:GetActive() and !LocalPlayer():ShouldDrawLocalPlayer() then
					render.SetMaterial(mat_shuffle)
					render.OverrideBlend(true,2,4,BLENDFUNC_ADD)
					render.DrawScreenQuadEx(0,0,MSW,MSH)
					render.OverrideBlend(false,2,4,BLENDFUNC_ADD)
				end
				local hp = math.Clamp(shield:Health(),0,shield:GetMaxHealth())
				local distext = shield:GetActive() and ('Active: '..hp..'%') or (shield:GetDamaged() and 'Recharge in '..math.floor(shield:GetActiveOffset()-CurTime())..'...' or 'Shield is inactive')
				local fulfill = shield:GetActive() and (hp/shield:GetMaxHealth()) or (shield:GetDamaged() and (shield:GetActiveOffset()-CurTime())/shield.RechargeTime or 0)
				--[[CDRAW.DrawRect(col_bg,MSW-256-16,off_h,256,64)
				CDRAW.DrawRect((!shield:GetActive() and shield:GetDamaged()) and col_fill_dmg or col_fill,MSW-256-16+4,off_h+4,248*fulfill,56)
				CDRAW.DrawText('SHLACK',MSW-256-8,off_h+16,col_txt,distext)]]--
			end
		end
	end)

end