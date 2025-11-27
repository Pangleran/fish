local AutoSell = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local net = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net

local sell = net:WaitForChild("RF/SellAllItems")
local LoopSell = false

function AutoSell.run()
  LoopSell = true
  task.wait(1)
  
  while LoopSell do
    pcall(function()
        sell:InvokeServer()
      end)
    task.wait(1 * 60)
  end
end

function AutoSell.stop()
  LoopSell = false
end

return AutoSell
