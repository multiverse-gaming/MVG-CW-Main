att.PrintName = "Stealth Rounds"

att.SortOrder = 17
att.Icon = Material("interfaz/armas/sw_blastersilencer.png", "smooth mips")
att.Description = [[Stealth load low enough to make the plasma travel slower than the normal speed. This reduces range significantly, but makes gunfire very comfortable and quiet.
The sonic boom typical of the round is eliminated, rendering it even more silent than usual with a suppressed firearm.]]
att.Desc_Pros = {
    "Invisible tracers",
    -- "uc.subsonic"
}

att.Slot = "SDWAmmo"

att.AutoStats = true

--att.Mult_ShootPitch = 1.1 please don't

att.Override_PhysTracerProfile = 7
att.Override_TracerNum = 0

att.Override_Tracer = "tracer_stealth"
att.Override_TracerCol = Color(0, 0, 0, 0)
att.Override_MuzzleEffect = false

--[[att.Mult_MalfunctionMean = 1.3
att.Override_PhysBulletMuzzleVelocity = 339
att.Override_PhysBulletMuzzleVelocity_Priority = 2--]]