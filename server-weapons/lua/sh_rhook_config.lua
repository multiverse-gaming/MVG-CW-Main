//This is your config file.
rhook = rhook or {}


//These are wall-walking settings
rhook.BreakWindows = true 	--Whether people break windows when they jump it.
rhook.MaxDist = 200 		--How far to the left and right of the hook that players can walk. Set this to 0 to lock the player in up/down mode.
rhook.ReelSound = true 		--Whether to play the reel whirring and clicking while wall walking.
rhook.LedgeDistance = 0	--How far from a ledge the player can be and still press E to stand on it.

//These are the weapon config:
rhook.ShootPower = 2000		--How hard the hook is launched from the gun. Bigger number means the hook flies farther.
rhook.RemoveOnDeath = true	--Whether to remove the player's grappling hook when they die.
rhook.Slot = 6 				--The slot of the SWEP in weapon select.
rhook.SlotPos = 4 			--The position within the slot.

//Translation options:
rhook.LedgeMsg = "Press E to stand on ledge"

//These are TTT config settings:
rhook.TTTKind = WEAPON_EQUIP2 --[[
The type of equipment.
	WEAPON_PISTOL: small arms like the pistol and the deagle.
	WEAPON_HEAVY: rifles, shotguns, machineguns.
	WEAPON_NADE: grenades.
	WEAPON_EQUIP1: special equipment, typically bought with credits and Traitor/Detective-only.
	WEAPON_EQUIP2: same as above, secondary equipment slot. Players can carry one of each.
	WEAPON_ROLE: special equipment that is default equipment for a role, like the DNA Scanner.
]]
rhook.TTTCanBuy = { ROLE_TRAITOR,ROLE_DETECTIVE } --Which teams can buy this equipment
rhook.TTTInLoadoutFor = nil		-- Change to { ROLE_TRAITOR, ROLE_DETECTIVE } to add to the role's loadout.
rhook.TTTLimitedStock = false	-- Change to true to limit to one per round.
rhook.TTTDescription = "A grappling hook for rappelling.\n\nShoot a wall to place the hook.\n\nPress E to use the hook." --The description for the SWEP. "\n" means skip a line.
rhook.TTTCanDrop = true 		-- Whether this weapon can be dropped with Q.
