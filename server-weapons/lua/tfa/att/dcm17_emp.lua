if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Emp"
ATTACHMENT.ShortName = "E.M"
ATTACHMENT.Icon = "entities/dc17m_magext.png"
ATTACHMENT.Description = { 
    TFA.AttachmentColors["="], "Slow effect",
    TFA.AttachmentColors["-"], "300 rpm",
    TFA.AttachmentColors["-"], "10 Damage",
}

ATTACHMENT.WeaponTable = {
    ["VElements"] = {
        ["rifle_module"] = {["active"] = false},
        ["rifle_mag"] = {["active"] = false},
        ["sniper_module"] = {["active"] = true},
        ["sniper_mag"] = {["active"] = true},
    },
    ["WElements"] = {
        ["rifle_module"] = {["active"] = false},
        ["rifle_mag"] = {["active"] = false},
        ["sniper_module"] = {["active"] = true},
        ["sniper_mag"] = {["active"] = true},
    },
	["Primary"] = {
		["Damage"] = 10,
		["RPM"] = 300,
	},
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end

local delay = 3 -- How long the effect last

function ATTACHMENT:CustomBulletCallback(wep, attacker, trace, dmginfo)
    if CLIENT then return end
    local currentTarget = trace.Entity
    if (IsValid(currentTarget) and currentTarget:IsPlayer()) then
        if timer.Exists("effectstun" .. currentTarget:EntIndex()) then return end
        if currentTarget.OriginalMovementSpeed_Run == nil and currentTarget.OriginalMovementSpeed_Walk == nil then
            currentTarget.OriginalMovementSpeed_Run = currentTarget:GetRunSpeed()
            currentTarget.OriginalMovementSpeed_Walk = currentTarget:GetWalkSpeed()
        end

        currentTarget:SetRunSpeed(1)
        currentTarget:SetWalkSpeed(1)
        timer.Create("effectstun" .. currentTarget:EntIndex(), delay, 1, function()
            if currentTarget.OriginalMovementSpeed_Run != nil and currentTarget.OriginalMovementSpeed_Walk != nil then
                currentTarget:SetRunSpeed(currentTarget.OriginalMovementSpeed_Run)
                currentTarget:SetWalkSpeed(currentTarget.OriginalMovementSpeed_Walk)
            end
        end)
    end
end

-- Hook To Check if dies to reset stats:

hook.Add("PlayerDeath", "effect_stun_death", function(victim, inflictor, attacker)
    if timer.Exists("effectstun" .. victim:EntIndex()) then 
        victim:SetRunSpeed(victim.OriginalMovementSpeed_Run)
        victim:SetWalkSpeed(victim.OriginalMovementSpeed_Walk)

        victim.OriginalMovementSpeed_Run = nil
        victim.OriginalMovementSpeed_Walk = nil

        timer.Remove("effectstun" .. victim:EntIndex())
    end
end)