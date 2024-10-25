OfficerBoost = {}

hook.Add("SummeLibrary.Loaded", "RegisterOfficerBoost", function()
    SummeLibrary:Register({
        class = "officerboost",
        name = "OfficerBoost",
        color = Color(59,62,255),
    })
end)




OfficerBoost.Config = {}

OfficerBoost.Config["Normal"] = {}
OfficerBoost.Config["Normal"].Color = Color(255,196,1) -- Ring and HUD color
OfficerBoost.Config["Normal"].SpeedBoost = 1.3 -- The speed boost: current speed * boost
OfficerBoost.Config["Normal"].JumpBoost = 1.3 -- The jump boost: current jump boost * boost
OfficerBoost.Config["Normal"].AdditionalHealth = 100  -- The additional health: current health + health
OfficerBoost.Config["Normal"].RPMBoost = 1.3  -- The TFA RPM Boost: current rpm * boost
OfficerBoost.Config["Normal"].Radius = 256 -- The radius of the sphere
OfficerBoost.Config["Normal"].Duration = 15 -- The duration of the effect
OfficerBoost.Config["Normal"].Sounds = {"summe/officer_boost/baseboost1.mp3", "summe/officer_boost/baseboost2.mp3", "summe/officer_boost/baseboost3.mp3", "summe/officer_boost/will1.mp3", "summe/officer_boost/will2.mp3", "summe/officer_boost/will3.mp3"}
OfficerBoost.Config["Normal"].GiveBack = 30 -- The cool down when you get the swep back -- false to disable

OfficerBoost.Config["LastStand"] = {}
OfficerBoost.Config["LastStand"].Color = Color(132,1,255)
OfficerBoost.Config["LastStand"].SpeedBoost = 0.4
OfficerBoost.Config["LastStand"].JumpBoost = 0.3
OfficerBoost.Config["LastStand"].AdditionalHealth = 100
OfficerBoost.Config["LastStand"].AdditionalArmor = 200
OfficerBoost.Config["LastStand"].Radius = 256
OfficerBoost.Config["LastStand"].Duration = 15
OfficerBoost.Config["LastStand"].Sounds = {"summe/officer_boost/laststand1.mp3", "summe/officer_boost/laststand2.mp3", "summe/officer_boost/laststand3.mp3"}
OfficerBoost.Config["LastStand"].GiveBack = 30

OfficerBoost.Config["501st"] = {}
OfficerBoost.Config["501st"].Color = Color(132,1,255)
OfficerBoost.Config["501st"].SpeedBoost = 0.4
OfficerBoost.Config["501st"].JumpBoost = 0.3
OfficerBoost.Config["501st"].AdditionalHealth = 100
OfficerBoost.Config["501st"].AdditionalArmor = 150
OfficerBoost.Config["501st"].Radius = 256
OfficerBoost.Config["501st"].Duration = 15
OfficerBoost.Config["501st"].Sounds = {"summe/officer_boost/laststand1.mp3", "summe/officer_boost/laststand2.mp3", "summe/officer_boost/laststand3.mp3"}
OfficerBoost.Config["501st"].GiveBack = 60

OfficerBoost.Config["BattleFocus"] = {}
OfficerBoost.Config["BattleFocus"].Color = Color(252, 144, 3)
OfficerBoost.Config["BattleFocus"].SpeedBoost = 1.5
OfficerBoost.Config["BattleFocus"].JumpBoost = 1.0
OfficerBoost.Config["BattleFocus"].AdditionalHealth = 0
OfficerBoost.Config["BattleFocus"].AdditionalArmor = 50
OfficerBoost.Config["BattleFocus"].Radius = 15
OfficerBoost.Config["BattleFocus"].Duration = 15
OfficerBoost.Config["BattleFocus"].Sounds = {"summe/officer_boost/laststand1.mp3", "summe/officer_boost/laststand2.mp3", "summe/officer_boost/laststand3.mp3"}
OfficerBoost.Config["BattleFocus"].GiveBack = 30

OfficerBoost.Config["LastWill"] = {}
OfficerBoost.Config["LastWill"].Color = Color(255,196,1) -- Ring and HUD color
OfficerBoost.Config["LastWill"].SpeedBoost = 1.3 -- The speed boost: current speed * boost
OfficerBoost.Config["LastWill"].JumpBoost = 1 -- The jump boost: current jump boost * boost
OfficerBoost.Config["LastWill"].AdditionalHealth = 100  -- The additional health: current health + health
OfficerBoost.Config["LastWill"].Radius = 256 -- The radius of the sphere
OfficerBoost.Config["LastWill"].Duration = 15 -- The duration of the effect
OfficerBoost.Config["LastWill"].Sounds = {"summe/officer_boost/baseboost1.mp3", "summe/officer_boost/baseboost2.mp3", "summe/officer_boost/baseboost3.mp3", "summe/officer_boost/will1.mp3", "summe/officer_boost/will2.mp3", "summe/officer_boost/will3.mp3"}
OfficerBoost.Config["LastWill"].GiveBack = 30 -- The cool down when you get the swep back -- false to disable