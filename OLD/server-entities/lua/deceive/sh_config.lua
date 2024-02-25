
deceive.Config = {}

deceive.Config.NoDisguiseAsJobs = {
    -- In here, put names of jobs that shouldn't be able to disguise into other players.
    -- Leave empty to let everyone disguise.
}

deceive.Config.NoDisguiseIntoJobs = {
    -- In here, put names of jobs that shouldn't be able to be disguised as.
    -- Leave empty to let everyone disguise as anything.

	"Grand Admiral","Supreme General","Admiral","Staff on Duty","Event Host" -- this is an example
}

deceive.Config.AllowedUserGroups = {
    -- In here, put names of usergroups that players need to have in order to disguise.
    -- Leave empty to let everyone disguise.

	-- "donator", -- this is an example
}

-- Message that shows up if you try to disguise with an incorrect usergroup.
deceive.Config.DonatorOnlyMessage = "You need to donate in order to use our server's Disguise feature!"

-- The command people will have to input in the chat / console to remove their own disguise.
-- Default is "undisguise".
deceive.Config.UndisguiseCommand = "undisguise"

-- Time in seconds until a player is able to disguise again after disguising.
-- 0 will disable the cooldown.
deceive.Config.UseCooldown = 5

-- Number of times a disguise drawer can be used until it breaks.
-- 0 will make the number of uses infinite.
deceive.Config.DrawerMaxUses = 10

-- Amount of damage a disguise drawer can take before breaking.
-- 0 will make the disguise drawer unbreakable.
deceive.Config.DrawerHealth = 200

-- If true, the disguised player's job will show as the job of their target.
-- Set to false if you don't want this.
deceive.Config.FakeJob = true

-- If true, the disguised player will show as the name of their target.
-- Set to false if you don't want this.
deceive.Config.FakeName = true

-- If true, the disguised player will appear as the model of their target.
-- Set to false if you don't want this.
deceive.Config.FakeModel = true

-- If true, the disguised player's model color will appear as the model color of their target.
-- Set to false if you don't want this.
deceive.Config.FakeModelColor = true

-- If true, we will use the default shipments included with the addon.
-- Set to false if you want to have your own way of handling the shipments.
-- Feel free to change them to your liking if they suffice in this state.
deceive.Config.NoDefaultShipments = false

-- If true, a disguised player will have their disguise removed when firing a weapon.
-- Not supported for everything, if you find out disguises don't get removed when they should, please create a support ticket telling me that, with a link to the weapon you're using so I can troubleshoot.
deceive.Config.RemoveOnAttack = true
