local AutoFish = {}

function AutoFish.Aktif()
    pcall(function()
        -- code
    end)
end

-- code reel / tarikan
pcall(function()
        Events.fishing:FireServer()
        print("[Fishing] âœ… Reel")
    end)

return AutoFish