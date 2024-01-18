WatchFox = WatchFox or {}
WatchFox.Core = WatchFox.Core or {}

WatchFox.Core.Notifications = WatchFox.Core.Notifications or {}

function WatchFox.Core.Notifications:DiscordMessage(discordPayload)
    
    HTTP({
        method = "POST",
        url = WatchFox.Config.Communication.DiscordWebhookLink,
        headers = {
            ["Content-Type"] = "application/json"
        },
        body = util.TableToJSON(discordPayload),
        success = function(code, body, headers)
            print("Discord Webhook sent successfully. Status code: " .. code)
        end,
        failed = function(reason)
            print("Failed to send Discord Webhook: " .. reason)
        end
    })
end

function WatchFox.Core.Notifications:AdminChat(messageContent)
    if sam then
        timer.Simple(0, function()
            RunConsoleCommand("sam", "asay", messageContent)
        end)
    end


end