/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

zpn = zpn or {}
zpn.config = zpn.config or {}

/////////////////////////////////////////////////////////////////////////////

// Bought by 76561198018619040
// Version v3.4.3

/////////////////////////// Zeros PumpkinNight /////////////////////////////

// Developed by ZeroChain:
// http://steamcommunity.com/id/zerochain/
// https://www.gmodstore.com/users/view/76561198013322242

/////////////////////////////////////////////////////////////////////////////
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b



///////////////////////// zclib Config //////////////////////////////////////
/*
	This config can be used to overwrite the main config of zeros libary
*/
// The Currency
zclib.config.Currency = "$"

// Should the Currency symbol be in front or after the money value?
zclib.config.CurrencyInvert = true

// These Ranks are admins
// If xAdmin, sAdmin or SAM is installed then this table can be ignored
zclib.config.AdminRanks = {
	["superadmin"] = true
}

//zclib.config.CleanUp.SkipOnTeamChange[TEAM_STAFF] = true
/////////////////////////////////////////////////////////////////////////////
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3



// Console Commands:
/*
    zpn_ghost_removeall - Remove all Ghosts on the map.
    zpn_data_purge - Removes all the candy points and score data for all players on the server and purges all the save files.
    zpn_cl_draw_antighost - Displays the radius for AntiGhost signs
    zpn_boss_save - Saves the boss at his current position and angle to be later used for respawn
    zpn_boss_remove - Removes all the Boss Enemies
    zpn_data_migrate_from_mrevent - Migrates all the Candypoint data from the Mr.Event Script and adds it to the current candypoints of the Players. (Only works for Players online)
    zpn_candyadd AMOUNT - Gives the Player you are looking at this amount of candy
*/

// Chat Commands:
/*
    !zpn_save - Saves all the NPC´s, Scoreboards and AntiGhostSign´s on the Map.
    !candy - Tells you your current CandyPoints.
    !dropcandy NUMBER - Drops the defined amount of candy
    !sellcandy NUMBER - Sells the specified amount of candy. (Only works if zpn.config.Candy.SellValue is set to something bigger then 0)
*/


// Switches between FastDl and Workshop
zpn.config.FastDl = false

// The language , en , de , fr , es , ru , pl , dk
zpn.config.SelectedLanguage = "en"

// Since certain weapons like the stunstick inflict a shit ton of damage to entities we clamp the damage to this value
zpn.config.DamageClamp = {
    ["stunstick"] = 0,
}

// Themes define how the Objects, Enemies and Effects should look
/*
    1 = Halloween
    2 = Christmas
*/
zpn.config.Theme = 1

/*
	If this is set then players can just open the shop with this chat command
*/
// zpn.config.ShopCommand = "!candyshop"

/*
	Masks will give the player special perks and also look pretty spooky :)
*/
zpn.config.Mask = {

	// Should the player loose his mask if he dies?
	DropOnDeath = false,

	// If set to true then we dont render the mask models
	NoDraw = false,
}

/*
	Can be smashed and spawns candy
*/
zpn.config.Destructable = {

	// If set to true then the players cant damage the pumpkins/presents using guns.
	DisableProjectileDamage = false,

    // How much damage needs to be inflicted in order for the pumpkin to be destroyed.
    Health = {
        min = 20,
        max = 50,
    },

    // How much candy entities can a Pumpkin drop?
    Candy = {
        min = 1,
        max = 5,
    },

    // How long till the Pumpkin gets removed? -1 will disable the Despawn
    DespawnTime = -1, // seconds

    // Here you can define custom items/code which should be dropped/run from the pumpkin
    // This can be anything
    CustomDrop = {

        // Health
        [1] = {
            chance = 1, //%
            drop = function(ply,pos)
                /*
                    ply = Player who destroyed the pumpkin, in certain situation this could be nil so make sure to check if the player is valid
                    pos = Position of the destroyed pumpkin
                */
                ply:SetHealth(100)
                zclib.Notify(ply, "You got healed!", 0)
            end,
        }
    }
}

/*
	The System for randomly spawning Destructables around the map
*/
zpn.config.DestructableSpawner = {
    // Should we spawn Pumpkins randomly arround the Map?
    Enabled = true,

    // How often should we try to spawn a new Pumpkin?
    Interval = 120, // seconds

    // Whats the Chance that a pumpkin will spawn?
    Chance = 100, //1-100%

    // How many pumpkins are allowed to exist at the same time?
    Count = 30,

    // Should we only spawn pumpkins on predefind positions created by the Pumpkin Spawner Toolgun?
    UseCustomSpawns = false,
    /*
        if UseCustomSpawns is set to false then we get the spawn position from Players who are:
            Valid
            Alive
            Not In Vehicle
            On the Ground
            Not near a Anti GhostSign
            Not near another Pumpkin
    */
}

/*
	The boss enemy who randomly spawns at a predefind position
*/
zpn.config.Boss = {

    // The autospawn function will allow the boss to spawn / respawn at its last saved location
    AutoSpawn = {
        // The interval at which we try to spawn the boss
        Interval = 600, // seconds

        // How high is the chance that the boss will spawn
        Chance = 8, // %

        // Defines how many bosses are allowed to exist simultaneously
        Limit = 1,
    },

    Notify = {
        // Should we notify all Players on the Server when a Boss spawns or dies?
        Enabled = true,
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

        // The Message we send each player when the Boss spawns
        notify_spawn = "A Pumpkin Boss just appeared!",

        // The Message we send each player when the Boss got defeated
        notify_death = "The Pumpkin Boss got defeated!",

		// Should the notify also be printed in the players chatbox?
		chatprint = true,
    },

    // What Music should play while the Boss is alive?
    // All the music files mentioned bellow will be send to the client via resource.AddSingleFile
	// This needs to be the path to the music file like inside the sound folder.
	/*
		Correct Path: 			mymusic/favsong.mp3
		Wrong Path: 			sound/mymusic/favsong.mp3
		Totally Wrong Path:		C:/Steam/steamapps/common/GarrysMod/garrysmod/sound/mymusic/favsong.mp3
	*/
    MusicPaths = {
        //"mymusic/favsong.mp3",
    },

    // How much damage needs to be inflicted in order for the boss to be killed.
    Health = 6500,

    // How much damage needs to be inflicted in order to stop the Boss from healing
    HealShield = 750,

    // How long afer the Boss has healed can he heal himself again
    HealCooldown = 20, // seconds

    // Should the Boss spawn with a Tornado Effect?
    Tornado = true,

    // Should we shine a spotlight on the Boss for better lightning?
    Spotlight = true,

    // The Distance at which the player causes more damage to the Boss
    // Being to far away will decrease the inflicted damage by 90%
    AttackDistance = 1500,

	// How long does the boss needs to be idle before he despawns?
	IdleDespawn = -1,

    // The Boss wont attack players with these ranks
    AttackBlackList = {
        //["superadmin"] = true,
    },

    // How long should the npc be idle/NotAttacking before he starts his next attack
    NoAttack = {
        time_min = 1,
        time_max = 3
    },

    // Close Range attacks include the aimed Smash at close Players or the Circular Smash
    CloseRangeAttack = {
        // How much damage do the CloseRange attacks inflict on the Players?
        Damage = 75,

        // Close Range Cooldown in seconds
        Cooldown = 3
    },

    // Far Range attacks include the Meteor and Bomb attacks
    FarRangeAttack = {
        // Far Range Cooldown in seconds
        Cooldown = 5
    },

    // The FireRain Attack shoots Meteors from the sky and at players
    FireRain = {
        // How many meteors should shoot at random positions arrond the boss
        Count = 3,

        // Should we spawn some extra meteors aiming at the players?
        AimedMeteors = true,

        // Should the meteors create firepits on impact?
        FirepitOnDeath = true,

        // How long should the firepit exist?
        Firepit_Duration = 10,
    },

    // The bomb attack shoots bombs at the Player
    Bombs = {
        // How many Bombs should be spawned per Bomb Attack?
        Count = 5,

        // How much damage does a Bomb inflict on the Player?
        Damage = 10,

        // How long till the bombs explode?
        ExploDelay = 4,
    },

    // The Minion attack summons minion monsters
    Minions = {

        // How often can the Boss spawn minions?
        Interval = 10, //seconds

        // How many Minions can the boss have?
        Count = 5,

        // How much damage needs to be inflicted in order for the minion to be killed.
        Health = 200,

        Shoot = {
            // How much damage does the minion inflict on the player?
            Damage = 35,

            // How often can the minion shoot a fireball?
            Interval = 1
        },

        // Should the minions circle arround the boss? This does impact the performance because of physics.
        CircleBoss = false,

        // How many candy entities should the Monster drop on death?
        CandyDropOnDeath = {
            max = 3,
            min = 1,
        },
    },

    // Should we spawn a little firework once the boss is defeated?
    FireworkOnDeath = true,

    // What loot should the boss drop on death?
    Loot = {
        ["zpn_destructable"] = 5,
        ["zpn_candy"] = 20,
        ["zpn_partypopper"] = 5,
    }
}

/*
	Smaller enemys who can shot projectiles
*/
zpn.config.Minion = {
    // The autospawn function will allow a minion to spawn / respawn at its last saved location
    AutoSpawn = {
        // The interval at which we try to spawn the minions
        Interval = 120, // seconds

        // How high is the chance that a minion will spawn
        Chance = 75, // %

        // Defines how many minions are allowed to exist simultaneously
        // Note: This only affects minions spawned by the AutoSpawner not the minions spawned from a boss
        Limit = 5,
    }
}

/*
	Can be collected and traded for goodies at the shop npc
*/
zpn.config.Candy = {

    // How long does it take for the Candy to despawn? -1 will disable the Despawn
    DespawnTime = 60, // seconds

    // The money value per candy point, this will enabled the chat command !sellcandy AMOUNT
    // NOTE Set to 0 to disable this function
    SellValue = 10,
}

/*
	The candy point data
*/
zpn.config.Data = {
    // Should the CandyPoints and SmashedPumpkin Count be saved on the server?
    Save = true,

    // How often should we auto save the data of players. Set to -1 to disable the autosave.
    // The data will also get saved when the player disconnects from the Server so the autosave is just a safety measure.
    Save_Interval = 300,

    // If specified then only data for Players with these Ranks get saved. Leave empty to save the data for every player.
    Whitelist = {
        //["superadmin"] = true
    }
}

/*
	Displays which player collected how many pumpkins
*/
zpn.config.Scoreboard = {
    // How often should we update the scoreboard if the score has changed?
    UpdateInterval = 60,

    // Should the sign display the top 10 global Pumpkin Smasher or only the players who are currently on the server?
    ShowGlobal = true,

    // Players with these ranks will not be displayed on the scoreboard
    RankBlackList = {
        //["owner"] = true,
    }
}

/*
	The Ghost sometimes appears and steals candy from Destructables and players
*/
zpn.config.Ghost = {
    // How much damage needs to be inflicted in order for the Ghost to be killed.
    Health = 500,
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

    // How much Health should the Ghost gain/recover on successfully stealing candy or smashing a Destructable?
    Health_OnSuccess = 0.1, // 10%

    // This position will be used when the ghost is hiding
    HidingPos = Vector(0,0,0),

    // How much candy can the ghost steal from the Player
    Steal = {
        max = 10,
        min = 2
    },

    // How often should the ghost try to steal candy or smash a Destructable
    Action_Interval = 120, // seconds,

    // How long should the Ghost be paralized when damaged before hiding again?
    ParalizeTime = 3,

    // How long should the ghost be idle and do nothing? This defines the max value for a math.random
    IdleTime = 5,

    // Who does the ghost attack?
    Targets = {
        Destructables = true,
        Players = true,
    },

    // How long has the ghost to wait before he can attack each player again?
    PlayerAttack_Cooldown = 340, // seconds

    // The ghost wont steal candy from players with these ranks
    BlackList = {
        //["superadmin"] = true,
    },
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

    // Should we spawn another Ghost everytime a Ghost dies?
    Rebirth = false,

    // Should a Ghost spawn once the map has loaded?
    SpawnOnMapLoad = false,
}

/*
	The Anti Ghost sign prevents the Ghost stealing candy from Players near the sign.
	It also prevents pumpkins spawning near it.
	Its usally used in areas like the Player Spawn
*/
zpn.config.AntiGhostSign = {
    // How close does the player needs to be near the sign to be save from the Ghosts?
    Distance = 500
}

/*
	The PartyPopper Swep can be bought by the Shop NPC
	There is a non lethal version which shoots confetty and a lethal version which shoots a projectile.
*/
zpn.config.PartyPopper = {

    // How much damage does the Projectile of the PartyPopper inflict upon explosion?
    Damage = {
        // Destroy them bombs
        ["zpn_bomb"] = 10000,

        // Insta kill the Destructables
        ["zpn_destructable"] = 10000,

        // Inflict a lot of damage against the Ghost
        ["zpn_ghost"] = 300,

        // Inflict some damage against the Minion
        ["zpn_minion"] = 100,

        // Do some damage against the Boss
        ["zpn_boss"] = 200,
    },

    // How much damage should the projectile inflict on players in TTT
    ttt_damage = 100,

    // How often can the PumpkinSlayer Swep (Red PartyPopper) can be used before it gets removed?
    Ammo = 5,
}

/*
	The shop NPC
*/
zpn.config.NPC = {
    // Setting this to false will improve network performance but disables the npc reactions for the player
    Capabilities = true,
}

/*
	The LootSpawner (ChristmasTree) will spawn special loot (presents) rarely
*/
zpn.config.LootSpawner = {

	// How far away from the lootspawner should the loot spawn
	Radius = 50,

	// How many loot entities can one lootspawner spawn
	Count = 8,

	// How often should loot be spawned by one of the LootSpawner
	// Default 1800 seconds : 30 Minutes
	Interval = 1800,

	// How much loot is allowed to exist at once, just so there is a limit
	Limit = 6,

	// Randomizes the look of the LootSpawner by switching On/Off random Bodygroups
    RandomStyle = true,
}

/*
	The saw beartrap
*/
zpn.config.Beartrap = {
	// How long does the player have time
	Duration = 60,

	// How long after its use will the trap be disabled
	TrapCooldown = 30
}
