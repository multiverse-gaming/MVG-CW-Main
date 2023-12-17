if not ATTACHMENT then
    ATTACHMENT = {}
end

ATTACHMENT.Name = "EMP Bullets"
ATTACHMENT.ShortName = "EMP"
ATTACHMENT.Icon = "entities/dc17m_holosight.png"
ATTACHMENT.Description = { 
    TFA.AttachmentColors["+"], "Movement Speed Reduction on inflicted.",
    TFA.AttachmentColors["-"], "RPM is 250",
    TFA.AttachmentColors["-"], "Damage is 10",


}

ATTACHMENT.WeaponTable = {
    ["Primary"] = {
        ["RPM"] = 250,
        ["Damage"] = 10,
        ["ClipSize"] = 30,
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

local delay = 1 -- How long the effect last
local movementSpeed = 0.3 -- How much movement speed is reduced to.


function ATTACHMENT:CustomBulletCallback(wep, attacker, trace, dmginfo)
    if CLIENT then return end

    local currentTarget = trace.Entity


    if (IsValid(currentTarget) and currentTarget:IsPlayer()) then
        if timer.Exists("effectemp" .. currentTarget:EntIndex()) then return end

        if currentTarget.OriginalMovementSpeed_Run == nil and currentTarget.OriginalMovementSpeed_Walk == nil then
            currentTarget.OriginalMovementSpeed_Run = currentTarget:GetRunSpeed()
            currentTarget.OriginalMovementSpeed_Walk = currentTarget:GetWalkSpeed()
        end



        currentTarget:SetRunSpeed(currentTarget.OriginalMovementSpeed_Run * movementSpeed)
        currentTarget:SetWalkSpeed(currentTarget.OriginalMovementSpeed_Walk * movementSpeed)


        timer.Create("effectemp" .. currentTarget:EntIndex(), delay, 1, function()
            if currentTarget.OriginalMovementSpeed_Run != nil and currentTarget.OriginalMovementSpeed_Walk != nil then

                currentTarget:SetRunSpeed(currentTarget.OriginalMovementSpeed_Run)
                currentTarget:SetWalkSpeed(currentTarget.OriginalMovementSpeed_Walk)
            end

        end)
    end
end

-- Hook To Check if dies to reset stats:

hook.Add("PlayerDeath", "effect_emp_death", function(victim, inflictor, attacker)
    if timer.Exists("effectemp" .. victim:EntIndex()) then 
        victim:SetRunSpeed(victim.OriginalMovementSpeed_Run)
        victim:SetWalkSpeed(victim.OriginalMovementSpeed_Walk)

        victim.OriginalMovementSpeed_Run = nil
        victim.OriginalMovementSpeed_Walk = nil

        timer.Remove("effectemp" .. victim:EntIndex())
    end
end)