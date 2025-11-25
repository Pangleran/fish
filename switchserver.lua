local SwitchServer = {}

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local PlaceId = game.PlaceId

function SwitchServer.Apply()
    local targetServer = nil
    local servers = {}

    local success, response = pcall(function()
        return HttpService:JSONDecode(
            game:HttpGet("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
        )
    end)

    if success and response and response.data then
        for _, srv in ipairs(response.data) do

            if srv.playing < srv.maxPlayers then

                -- FILTER SERVER SINGAPURA (Asia-Pacific = "ap-")
                if string.find(string.lower(srv.id), "ap-") then
                    table.insert(servers, srv)
                end
            end
        end

        -- urutkan berdasarkan jumlah pemain
        table.sort(servers, function(a, b)
            return a.playing < b.playing
        end)

        targetServer = servers[1]
    end

    if targetServer then
        TeleportService:TeleportToPlaceInstance(PlaceId, targetServer.id)
    else
        -- fallback kalau tidak ada server SG
        TeleportService:Teleport(PlaceId)
    end
end

return SwitchServer