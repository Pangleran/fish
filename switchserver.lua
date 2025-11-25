local SwitchServer = {}

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local PlaceId = game.PlaceId

function SwitchServer.Apply()
    local servers = {}

    local success, response = pcall(function()
        return HttpService:JSONDecode(
            game:HttpGet("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
        )
    end)

    if success and response and response.data then
        for _, srv in ipairs(response.data) do
            if srv.playing < srv.maxPlayers then
                table.insert(servers, srv)
            end
        end
    end

    if #servers > 0 then
        local randomServer = servers[math.random(1, #servers)]
        TeleportService:TeleportToPlaceInstance(PlaceId, randomServer.id)
    else
        TeleportService:Teleport(PlaceId)
    end
end

return SwitchServer