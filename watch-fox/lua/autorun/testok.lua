if SERVER then
    util.AddNetworkString("FoxNetTest") -- Make sure to add the network string

    -- Define the server-side behavior when receiving the test net message
    net.Receive("FoxNetTest", function(len, ply)
        local testValue = net.ReadString() -- Reading the string sent from the client
        print(ply:Nick() .. " sent a test net message with value: " .. testValue)
        -- You can add more logic here to handle the test message as needed
    end)
else
    -- Client-side function to send the test net message
    local function SendFoxNetTest(ply, cmd, args)
        if #args < 1 then
            print("Please provide a test value to send.")
            return
        end

        local testValue = args[1]
        net.Start("FoxNetTest")
        net.WriteString(testValue)
        net.SendToServer() -- Sends the message to the server
        print("Test net message sent with value: " .. testValue)
    end

    -- Adding the console command on the client
    concommand.Add("fox_net_test", SendFoxNetTest)
end

