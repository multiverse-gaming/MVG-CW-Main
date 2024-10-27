/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

if CLIENT then return end
zpn = zpn or {}
zpn.Mask = zpn.Mask or {}

/*
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

	Masks will give the player special perks and also look pretty spooky :)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

*/

util.AddNetworkString("zpn_Mask_Equipt")
function zpn.Mask.Equipt(ply,MaskID, show)

    if show then
		hook.Run("zpn_OnMaskEquipped", ply, MaskID)
        zpn.Mask.Give(ply, MaskID)
    else
		hook.Run("zpn_OnMaskDropped", ply, ply:GetNWInt("zpn_MaskID",0))
        zpn.Mask.Remove(ply)
    end

    zclib.Debug("zpn_Mask_Equipt: " .. tostring(ply) .. " " .. tostring(show) .. " MaskID: " .. MaskID .. " Uses: " .. zpn.Mask.GetUses(ply))
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

    net.Start("zpn_Mask_Equipt")
    net.WriteEntity(ply)
    net.WriteBool(show)
    net.WriteInt(MaskID,6)
    net.Broadcast()
end

function zpn.Mask.HasGhostProtection(ply)
	if ply.zpn_MaskUses and ply.zpn_MaskUses > 0 then
		return true
	else
		return false
	end
end

function zpn.Mask.SetUses(ply, val)
	ply.zpn_MaskUses = val
end

function zpn.Mask.GetMaxUses(MaskID)
    local Uses = 1
	local MaskData = zpn.config.Masks[MaskID]
    if MaskData and MaskData.ghost_protect then
        Uses = MaskData.ghost_protect
    end
    return Uses
end


function zpn.Mask.ReduceUses(ply, val)
	zclib.Notify(ply, zpn.language.General[ "MaskGhostAttackPrevented" ], 0)
	ply.zpn_MaskUses = (ply.zpn_MaskUses or 0) - val

	if ply.zpn_MaskUses <= 0 then
		zpn.Mask.Equipt(ply, 0, false)
		zclib.Notify(ply, zpn.language.General[ "Maskbroke" ], 0)
	else
		zclib.Notify(ply, "[ " .. zpn.Mask.GetMaxUses(ply:GetNWInt("zpn_MaskID",0)) .. " / " .. ply.zpn_MaskUses .. " ]", 0)
	end
end

function zpn.Mask.Give(ply, MaskID)
	ply:SetNWInt("zpn_MaskID",MaskID)
    zpn.Mask.SetUses(ply, zpn.Mask.GetMaxUses(MaskID))
end

function zpn.Mask.Remove(ply)
    ply:SetNWInt("zpn_MaskID",0)
    zpn.Mask.SetUses(ply, 0)
end

/*
	Drop the mask on death
*/
zclib.Hook.Add("PlayerDeath", "zpn_mask", function(victim, inflictor, attacker)
	if zpn.config.Mask.DropOnDeath and zpn.Mask.Has(victim) then
		zpn.Mask.Equipt(victim, 0, false)
	end
end)

local Targets = {
	//["zpn_destructable"] = true,
	["zpn_ghost"] = true,
	["zpn_minion"] = true,
	["zpn_boss"] = true,
}

/*
	Increase attack damage if mask is Equipted
*/
zclib.Hook.Add("EntityTakeDamage", "zpn_mask", function(ent, dmginfo)
	if IsValid(ent) and dmginfo and Targets[ ent:GetClass() ] then

		local Attacker = dmginfo:GetAttacker()
		if IsValid(Attacker) and Attacker:IsPlayer() then

			// We dont allow the player to cause damage to monsters if he wears the monster friend mask
			if zpn.Mask.GetMonsterFriend(Attacker) then return true end

			local DamageScale = zpn.Mask.GetAttackMul(Attacker)
			if DamageScale then
				dmginfo:ScaleDamage(DamageScale)
			end
		end
	end
end)

/*
	Reflects a certain amount of damage back
*/
zclib.Hook.Add("EntityTakeDamage", "zpn_mask_protect", function(ent, dmginfo)
	if IsValid(ent) and dmginfo and ent:IsPlayer() then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

		// Is the attacker a monster?
		local Attacker = dmginfo:GetAttacker()
		if IsValid(Attacker) and Targets[ Attacker:GetClass() ] then

			// We dont attack the player if he wears the friendlymode mask
			if zpn.Mask.GetMonsterFriend(ent) then
				// Dont do anything
			else
				local DamageReflectScale = zpn.Mask.GetReflectMul(ent)
				if DamageReflectScale then

					local dmg = dmginfo:GetDamage()

					// This is how much damage the player will get
					dmginfo:ScaleDamage(math.Clamp(1 - DamageReflectScale,0,100))

					// This is how much damage the attack / enemy will get
					Attacker:TakeDamage( dmg * DamageReflectScale, ent, ent )
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0

					local spawnpos = ent:LocalToWorld(Vector(0, 0, 60))
					local dir = spawnpos - Attacker:GetPos()
					local look = dir:Angle()

					local aent = ents.Create("zpn_partypopper_projectile")
					aent:SetPos(spawnpos)
					aent.KillTime = 0.5
					aent.FlyDir = -look:Forward()
					aent:Spawn()
					aent:Activate()
				end
			end
		end
	end
end)
