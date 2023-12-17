if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "DC-17m Railgun"
ATTACHMENT.ShortName = "Railgun"
ATTACHMENT.Icon = "entities/dc17m_sniper.png"
ATTACHMENT.Description = { 
    TFA.AttachmentColors["="], "Railgun", 

}

ATTACHMENT.WeaponTable = {
    ["VElements"] = {
		["rifle_module"] = {["active"] = false},
		["rifle_mag"] = {["active"] = false},
		["sniper_module"] = {["active"] = true},
		--["sniper_module_scope"] = {["active"] = true},
		--["sniper_module_hp1"] = {["active"] = true},
		--["sniper_module_hp2"] = {["active"] = true},
		["sniper_mag"] = {["active"] = true},
	},
	["WElements"] = {
		["rifle_module"] = {["active"] = false},
		["rifle_mag"] = {["active"] = false},
		["sniper_module"] = {["active"] = true},
		--["sniper_module_scope"] = {["active"] = true},
		--["sniper_module_hp1"] = {["active"] = true},
		--["sniper_module_hp2"] = {["active"] = true},
		["sniper_mag"] = {["active"] = true},
	},

	["Primary"] = {
		["RPM"] = 600,
		["Damage"] = 200,
		["ClipSize"] = 100,
        ["AmmoConsumption"] = 100,
	},
}

function ATTACHMENT:Attach(wep)
	wep:Unload()
end

function ATTACHMENT:Detach(wep)
	wep:Unload()
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end

local delay = 3 -- How long the effect last



function ATTACHMENT:CustomBulletCallback(wep, attacker, trace, dmginfo)
	if CLIENT then return end

	local currentTarget = trace.Entity


	if (IsValid(currentTarget) and currentTarget:IsPlayer()) then
		if timer.Exists("effect_stun_" .. currentTarget:EntIndex()) then return end

		if currentTarget.OriginalMovementSpeed_Run == nil and currentTarget.OriginalMovementSpeed_Walk == nil then
			currentTarget.OriginalMovementSpeed_Run = currentTarget:GetRunSpeed()
			currentTarget.OriginalMovementSpeed_Walk = currentTarget:GetWalkSpeed()
		end



		currentTarget:SetRunSpeed(1)
		currentTarget:SetWalkSpeed(1)


		timer.Create("effect_stun_" .. currentTarget:EntIndex(), delay, 1, function()
			if currentTarget.OriginalMovementSpeed_Run != nil and currentTarget.OriginalMovementSpeed_Walk != nil then

				currentTarget:SetRunSpeed(currentTarget.OriginalMovementSpeed_Run)
				currentTarget:SetWalkSpeed(currentTarget.OriginalMovementSpeed_Walk)
			end

		end)
	end
end

-- Hook To Check if dies to reset stats:

hook.Add("PlayerDeath", "effect_stun_death", function(victim, inflictor, attacker)
	if timer.Exists("effect_stun_" .. victim:EntIndex()) then 
		victim:SetRunSpeed(victim.OriginalMovementSpeed_Run)
		victim:SetWalkSpeed(victim.OriginalMovementSpeed_Walk)

		victim.OriginalMovementSpeed_Run = nil
		victim.OriginalMovementSpeed_Walk = nil

		timer.Remove("effect_stun_" .. victim:EntIndex())
	end
end)