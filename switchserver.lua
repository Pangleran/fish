local SwitchServer = {}

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local PlaceId = game.PlaceId

function SwitchServer.Apply()
    local bestServer = nil
    local lowestPing = math.huge

    local success, response = pcall(function()
        return HttpService:JSONDecode(
            game:HttpGet("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
        )
    end)

    if not success or not response or not response.data then
        TeleportService:Teleport(PlaceId)
        return
    end

    for _, srv in ipairs(response.data) do
        if srv.playing < srv.maxPlayers then
            local ping = tonumber(srv.ping) or math.huge
            if ping < lowestPing then
                lowestPing = ping
                bestServer = srv
            end
        end
    end

    if bestServer then
        TeleportService:TeleportToPlaceInstance(PlaceId, bestServer.id)
    else
        TeleportService:Teleport(PlaceId)
    end
end

return SwitchServer