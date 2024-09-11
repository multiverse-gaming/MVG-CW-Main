AddCSLuaFile()
CONFIG_SERVICES = {}



--Leave plyOnline = 0, as 0 please.





local function CreateConfig()

		CONFIG_SERVICES.Settings = {

			["Coruscant Guard"] = { Teams = {TEAM_CGRIOT, TEAM_CGARC, TEAM_ARCALPHACG, TEAM_CGGENERAL, TEAM_CGMCOMMANDER, TEAM_CGCOMMANDER, TEAM_CGEXECUTIVEOFFICER, TEAM_CGMJR, TEAM_CGLIEUTENANT, TEAM_CGHANDLER, TEAM_CGHOUND, TEAM_CGSERGEANT, TEAM_CGTROOPER, TEAM_FLEETHSO, TEAM_CGMEDOFFICER, TEAM_CGMEDTROOPER, TEAM_JEDIGENERALSHAAK, TEAM_CGGENERALSHAAK, TEAM_CGJEDI, TEAM_TGJEDI, TEAM_JEDITGCHIEF, TEAM_CGJEDICHIEF, TEAM_JEDIGENCINDRALLIG, TEAM_CGMASSIF,}, Description = "Request assistance from the ST.", icon = "services/cg.png", price = 0, CustomCheck = function(ply) return true end, FailMessage = "You failed the custom check!", colorCustom = Color(255, 77, 77),plyOnline = 0},

			["Regimental Medic"] = { Teams = {TEAM_MEDICALGENERAL, TEAM_501STMEDOFFICER, TEAM_501STMEDTROOPER, TEAM_212THMEDOFFICER, TEAM_212THMEDTROOPER, TEAM_GREENMEDOFFICER, TEAM_GREENMEDTROOPER, TEAM_CGMEDOFFICER, TEAM_CGMEDTROOPER, TEAM_CEMEDOFFICER, TEAM_CEMEDTROOPER, TEAM_ARCMEDOFFICER, TEAM_ARCMEDTROOPER, TEAM_GMMEDOFFICER, TEAM_GMMEDTROOPER, TEAM_PHONIXOFF, TEAM_PHOENIXTRP,TEAM_FLEETMO, TEAM_MEDICALDIRECTOR, TEAM_MEDICALMCO, TEAM_JEDICONSULAR,TEAM_ASSISTANTMEDICALDIRECTOR,TEAM_JEDICOUNCIL, TEAM_501STJEDI, TEAM_212THJEDI, TEAM_327THJEDI, TEAM_GMJEDI, TEAM_WPJEDI, TEAM_CGJEDI, TEAM_TGJEDI, TEAM_JEDITGCHIEF, TEAM_CGJEDICHIEF, TEAM_JEDIGENERALWINDU, TEAM_VALTRP, TEAM_VALL,}, Description = "Request assistance from a medic.", icon = "services/91.png", price = 0, CustomCheck = function(ply) return true end, colorCustom = Color(200, 20, 60), FailMessage = "You failed the custom check!", plyOnline = 0},

			["Engineer"] = { Teams = {TEAM_CEARC, TEAM_ARCALPHACE, TEAM_RCTECH, TEAM_RCFIXER, TEAM_CETROOPER, TEAM_CESPECIALIST, TEAM_CEFAB, TEAM_CEMECHANIC, TEAM_CELIEUTENANT, TEAM_CECHIEF, TEAM_CEEXECUTIVEOFFICER, TEAM_CEMCOMMANDER, TEAM_CECOMMANDER, TEAM_CEGENERAL, TEAM_FLEETEO, TEAM_JEDISENTINEL, TEAM_501STJEDI, TEAM_212THJEDI, TEAM_327THJEDI, TEAM_GMJEDI, TEAM_WPJEDI, TEAM_CGJEDI, TEAM_TGJEDI, TEAM_JEDITGCHIEF, TEAM_CGJEDICHIEF, TEAM_CEMEDOFFICER, TEAM_CEMEDTROOPER, TEAM_JEDIGENERALAAYLA, TEAM_327THGENERALAAYLA, TEAM_JEDICOUNCIL}, Description = "Request assistance from CE.", icon = "materials/services/engineer.png", price = 0, CustomCheck = function(ply) return true end, FailMessage = "You failed the custom check!", colorCustom = Color(156, 99, 0), plyOnline = 0},

			["Galactic Marines & Republic Commandos"] = { Teams = {TEAM_GMGENERAL, TEAM_GMMCOMMANDER, TEAM_GMCOMMANDER, TEAM_GMEXECUTIVEOFFICER, TEAM_GMMAJOR, TEAM_GMFLAMETROOPER, TEAM_GMKUTROOPER, TEAM_GMLIEUTENANT, TEAM_GMSERGEANT, TEAM_GMTROOPER, TEAM_GMARC, TEAM_ARCALPHAGM, TEAM_GMMEDOFFICER, TEAM_GMMEDTROOPER, TEAM_RCBOSS, TEAM_RCFIXER, TEAM_RCSEV, TEAM_RCSCORCH, TEAM_RCHUNTER, TEAM_RCCROSSHAIR, TEAM_RCWRECKER, TEAM_RCTECH, TEAM_RCSARGE, TEAM_RCDIKUT, TEAM_RCZAG, TEAM_RCTYTO, TEAM_RCGENERAL, TEAM_RCSPECIALIST, TEAM_REPUBLICCOMMANDO, TEAM_REPUBLICCOMMANDOSGT, TEAM_RCGREGOR, RC_VALE, RC_RIGGS, RC_WITT, RC_PLANK,TEAM_RCVALE,TEAM_RCPLANK,TEAM_RCRIGGS,TEAM_RCWITT,TEAM_RCHOPE,TEAM_RCAIWHA,TEAM_RCAQUILA,TEAM_RCION,TEAM_RCYAYAX,TEAM_RCNINER,TEAM_RCFI,TEAM_RCDARMAN,TEAM_RCATIN,TEAM_RCCORR,TEAM_RCHUNTER,TEAM_RCCROSSHAIR,TEAM_RCWRECKER,TEAM_RCTECH, TEAM_GMJEDI, TEAM_JEDIGENERALKIT, TEAM_RCGENERALKIT, TEAM_JEDIGENERALADI, TEAM_GMGENERALADI, TEAM_RCECHO,}, colorCustom = Color(212,175,55), Description = "Request assistance from the GM/RC.", icon = "services/br.png", price = 0, CustomCheck = function(ply) return true end, FailMessage = "You failed the custom check!", plyOnline = 0},
		
			["Wolfpack"] = {Teams = {TEAM_WPGENERAL, TEAM_ARCMCOMMANDER, TEAM_ARCCOMMANDER, TEAM_ARCEXECUTIVEOFFICER, TEAM_ARCMAJOR, TEAM_ARCLIEUTENANT, TEAM_ARCPATHFINDER, TEAM_ARCALPHAWP, TEAM_WPARC, TEAM_ARCMEDOFFICER, TEAM_ARCSERGEANT, TEAM_ARCMEDTROOPER, TEAM_WPGENERALPLO, TEAM_WPJEDI, TEAM_JEDIGENERALPLO, TEAM_ARCTROOPER,}, Description = "Request assistance from the Wolfpack.", icon = "materials/services/104th.png", price = 0, CustomCheck = function(ply) return true end, FailMessage = "You failed the custom check!", colorCustom = Color(153, 144, 144), plyOnline = 0}
		}

end



if DCONFIG then

	hook.Add("DConfigDataLoaded", "CreateServicesConfig", function() //ANY CHANGES REQUIRE  A RESTART

		CreateConfig()

	end)



else

	hook.Add("Initialize", "CreateServicesConfig", function()

		CreateConfig()

	end)

end





CONFIG_SERVICES.ChatCommand = "!services"

CONFIG_SERVICES.ChatCommand2 = "/services"

CONFIG_SERVICES.MenuTitle = "Services" //Title of raffle menu

CONFIG_SERVICES.BackgroundColor = Color(60,60,60,255)

CONFIG_SERVICES.HighlightColor = Color(255,255,255,10)

CONFIG_SERVICES.ThemeColor = Color(108,140,168,255)//Color(69,176,151,255)//Color(84,199,139,255)//Color(0,115,153,255)

CONFIG_SERVICES.CallPanelColor = Color(50,50,50,255)

CONFIG_SERVICES.ImagePanel = Color(45,45,45,255)

CONFIG_SERVICES.MaxDistance = 2000

CONFIG_SERVICES.MinDistance = 600

CONFIG_SERVICES.UseDefaultNotifications = false // Use DarkRP Notifications, replaces the custom notifications with the default darkrp ones

CONFIG_SERVICES.Confirmation = "Your service request has been sent."

CONFIG_SERVICES.CallAccepted = " has accepted your service request."

CONFIG_SERVICES.CantAfford = "Can't afford that request."

CONFIG_SERVICES.CoolDown = 60 // Time players have to wait between calls

CONFIG_SERVICES.AutoCloseTime = 15 // Time for the accept/decline to disappear.

CONFIG_SERVICES.PopupYPos = 10 // Bottom of screen, increase to make it go higher on the screen.





//CUSTOM CHECK UPDATE:



--["Police"] = { Teams = {TEAM_POLICE, TEAM_MAYOR, TEAM_CHIEF,}, Description = "Call the police!", icon = "services/siren.png", price = 0, CustomCheck = function(ply) return true end, FailMessage = "You failed the custom check!", plyOnline = 0},



--CustomCheck = function(ply) ply refers to the player that is calling

--By default the CustomCheck is set to (return true end) meaning that the custom check is going to return true allowing the player to caller

--However if we did CustomCheck = function(ply) return ply:Health() > 100 end It will check if the player's health is above 100, if is they can call, if not they can't.

--If the player fails to achieve the custom check, a notification will appear notifying the player the FailMessage

--I will not provide any support for custom CustomChecks, it follows the same format as DarkRP's custom check for jobs, look at that for examples.
