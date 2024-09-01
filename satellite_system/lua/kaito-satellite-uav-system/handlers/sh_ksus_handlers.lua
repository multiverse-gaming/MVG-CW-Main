//  __   _  __     _ _          __ 
// | _| | |/ /__ _(_) |_ ___   |_ |
// | |  | ' // _` | | __/ _ \   | |
// | |  | . \ (_| | | || (_) |  | |
// | |  |_|\_\__,_|_|\__\___/   | |
// |__|                        |__|
                                                                      
/*
    Coucou.
*/


if CLIENT then
    
end

if SERVER then
    net.Receive('ksus.net.fromCLient.toServer.sendVmAnimationToPlayer',function(len,ply)
        -- print('Called')
        local vm = ply:GetViewModel() 
        vm:SendViewModelMatchingSequence( vm:LookupSequence( "attack" ) )   
        timer.Simple(4,function()
            vm:SendViewModelMatchingSequence( vm:LookupSequence( "draw" ) )   
            timer.Simple(2.25,function()
                vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle" ) )   
            end)
        end)
    end)
end