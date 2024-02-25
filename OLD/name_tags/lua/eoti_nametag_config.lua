---------------------------------------------------------------

------------------------- The NameTag -------------------------

---------------------------------------------------------------

EOTI_NameTag.Motif = 'blank.lua' -- Selected Motif from /hud/ folder

EOTI_NameTag.EditorRefresh = false -- Refreshes the LUA file every second, only use for customizing the HUD on your server



-- The Targeting HUD

EOTI_NameTag.Enable = true -- toggle on/off

EOTI_NameTag.TargetYOffset = 300 -- How far above their head the tag appears

EOTI_NameTag.Distance = 300 -- How close you need to be to see it (30 = 1 yard/meter)



-- Draw halo around target.

EOTI_NameTag.DrawHalo = false -- Creates a Left4Dead style halo around your target.

EOTI_NameTag.HaloColor = Color(100,100,255) -- Determines the color of the Halo.

EOTI_NameTag.HaloSize = 2 -- How large the halo is around the player.

EOTI_NameTag.HaloIntensity = 2 -- Increases brightness, causes FPS lag it set too high and only matters if you set EOTI_NameTag.HaloSize to higher than 3.



-- Who it displays on

EOTI_NameTag.ShowPlayer = true

EOTI_NameTag.ShowNPC = false

EOTI_NameTag.ShowVehicle = false

EOTI_NameTag.ShowProp = false -- Displays all entities; note: this will turn it on for players using roaming NPC addon from SF.



-- Which Targeting HUD boxes are displayed

EOTI_NameTag.ShowName = true -- Hides/shows the player name above their head.

EOTI_NameTag.ShowNPCName = true -- Hides/shows the NPC name or entity class name above their head.

EOTI_NameTag.ShowVehicleName = true -- Hides/shows the npc or entity class name above their head.

EOTI_NameTag.ShowHealth = false -- Hides/shows the health on the left

EOTI_NameTag.ShowArmor = false -- Hides/shows the armor in the middle

EOTI_NameTag.ShowTag = false -- Hides/shows the level or rank tag on the right

EOTI_NameTag.ShowInfo = true -- Hides/shows the information bar on the bottom

EOTI_NameTag.HideNameTag = true -- Hides/shows the DarkRP or default Garry's Mod Name Tag.



---------------------------------------------------------------

------------------------ The Healthbar ------------------------

---------------------------------------------------------------

EOTI_HPBar.Enable = true -- Toggle on/off

EOTI_HPBar.YOffset  = 170 -- How high above their head it is.

EOTI_HPBar.Distance = 350 -- How close you need to be to see it.

EOTI_HPBar.BarHeight = 8 -- How tall the health/armor bars are.

EOTI_HPBar.BarWidth = 150 -- How wide the health/armor bars are.

EOTI_HPBar.Max = 10 -- Max number of Health Bars visible at one time. Increasing this may low fps for lower-end players on your server.

EOTI_HPBar.ShowBots = false -- Shows the healthbar on nearby Bots.

EOTI_HPBar.ShowPlayers = true -- Shows the healthbar on nearby Players.



--------------------------------------------------------------

--------------------- Assign Custom Names --------------------

--------------------------------------------------------------



-- You can give names to entities or NPCs using this, The format is:

-- Entity_classname = 'name you want!',

EOTI_NameTag.CustomNames = {



    -- ENTITIES

    weapon_ak472 = 'AK-47 Rifle',



    -- VEHICLES

    prop_vehicle_jeep = 'Vehicle',

    prop_vehicle_prisoner_pod = 'Prison Pod',

    prop_vehicle_airboat = 'Airboat',



    -- NPCS

    npc_kleiner = 'Dr. Isaac Kleiner',

    npc_combine_s = 'Combine Soldier',

}



--------------------------------------------------------------

---------------------- Advanced Users ------------------------

--------------------------------------------------------------



-- EOTI_NameTag.getDarkRPJob() -- returns a string (DarkRP only)

-- EOTI_NameTag.getLevel() -- returns a number (works with vrondakis, leveling system, levelup, elevel)

-- EOTI_NameTag.hasDarkRPGunLicense() -- returns a boolean (DarkRP only)

-- EOTI_NameTag.isDarkRPWanted() -- returns boolean if they're wanted.

-- EOTI_NameTag.TargetIsInPlayerGroup(group) -- returns a boolean if they're in a user group (DarkRP only)



-- This is the bar at the bottom, this function will override it. Returning nil makes it not appear.

function EOTI_NameTag.overrideInfoBar(ply,target,isply,isnpc,isveh,isprop)

    local wanted = EOTI_NameTag.isDarkRPWanted( target ) and 'WANTED!' or nil

    local job = EOTI_NameTag.getDarkRPJob( target ) or ''

    local gun = EOTI_NameTag.hasDarkRPGunLicense( target ) and ' (Licensed)' or ''

    local det = EOTI_NameTag.isTTTDetective( target ) and 'DETECTIVE!' or ''

    local ttr = EOTI_NameTag.areBothTTTTraitors( target ) and 'TRAITOR!' or ''

    local lvl = EOTI_NameTag.getLevel()

    local lvl = isply and (lvl and 'Lv.'..lvl..' ' or '')

    local lvljobgun = lvl..job..gun

    return wanted or lvljobgun != '' and lvljobgun or nil

end



function EOTI_NameTag.addExtraInfoBar(ply,target,isply,isnpc,isveh,isprop)

    return nil -- Adds a 2nd info bar below the one above.

end



-- This is the bar on the right, this function will override it. Returning nil makes it not appear.

function EOTI_NameTag.overrideTag(ply,target,isply,isnpc,isveh,isprop)

    local own = EOTI_NameTag.TargetIsInPlayerGroup('owner') and ""--'OWNER' -- Is your target in user group 'owner'?

    local sen = isply and (target:IsSuperAdmin()) and ""--'SENIOR' -- Is your target an admin?

    local adm = isply and (target:IsAdmin()) and ""--'ADMIN' -- Is your target an admin?

    local mod = EOTI_NameTag.TargetIsInPlayerGroup('mod') and ""--'MODERATOR'

    local dev = EOTI_NameTag.TargetIsInPlayerGroup('activedeveloper') and ""--'DEVELOPER'

    local tmod = EOTI_NameTag.TargetIsInPlayerGroup('trialmod') and ""--'TRIAL-MOD'

    local adv = EOTI_NameTag.TargetIsInPlayerGroup('advisor') and ""--'ADVISOR'

  //  local vip = EOTI_NameTag.TargetIsInPlayerGroup({'donator','vip'}) and 'VIP' -- Is your target in either {'vip','donator'}

    local ply = isply and " "--'Player' -- Is your target a player, display Lv.5 or Player (if DarkRP doesn't exist)

    local veh = isveh and " "--'Vehicle' -- Is your target a vehicle?

    local npc = isnpc and " "--'NPC' -- Is your target an NPC?

    local prp = isprop and " "--'Prop' -- Is your target a prop?



    return own or sen or adm or mod or dev or tmod or adv or ply or npc or veh or prp or nil

    -- nil causes the bar to disappear if they're none of the above.

end
