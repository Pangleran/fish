local SwitchServerModule = {}

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local PlaceId = game.PlaceId

function SwitchServerModule.Apply()
    local nextServer = nil
    local servers = {}

    local success, response = pcall(function()
        return HttpService:JSONDecode(
            game:HttpGet("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
        )
    end)

    if success and response and response.data then
        for _, srv in ipairs(response.data) do
            if srv.playing < srv.maxPlayers and srv.playing <= 5 then
                table.insert(servers, srv)
            end
        end

        table.sort(servers, function(a, b)
            return a.playing < b.playing
        end)

        nextServer = servers[1]
    end

    if nextServer then
        TeleportService:TeleportToPlaceInstance(PlaceId, nextServer.id)
    else
        TeleportService:Teleport(PlaceId)
    end
end

return SwitchServerModule