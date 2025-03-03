--[]
    ______   ______        ______     ______     __     __   __     ______        ______     __         __        
    /\  ___\ /\  ___\      /\  == \   /\  == \   /\ \   /\ "-.\ \   /\  ___\      /\  __ \   /\ \       /\ \       
    \ \  __\ \ \  __\      \ \  __<   \ \  __<   \ \ \  \ \ \-.  \  \ \ \__ \     \ \  __ \  \ \ \____  \ \ \____  
     \ \_\    \ \_____\     \ \_____\  \ \_\ \_\  \ \_\  \ \_\\"\_\  \ \_____\     \ \_\ \_\  \ \_____\  \ \_____\ 
      \/_/     \/_____/      \/_____/   \/_/ /_/   \/_/   \/_/ \/_/   \/_____/      \/_/\/_/   \/_____/   \/_____/ 
                                                                                                                   
-- // Services \\ --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- // Variables \\ --
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- // Function to get a player's HumanoidRootPart \\ --
local function getHumanoidRootPart(player)
    return player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end

-- // Function to bring a player in front of the local player \\ --
local function bringPlayerToFront(targetHRP)
    if targetHRP and HumanoidRootPart then
        targetHRP.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -5) -- Position 5 studs in front
    end
end

-- // Function to make the player smoothly follow the local player \\ --
local function followPlayer(targetHRP)
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if targetHRP and HumanoidRootPart then
            -- Lerp to smoothly move the target in front
            targetHRP.CFrame = targetHRP.CFrame:Lerp(HumanoidRootPart.CFrame * CFrame.new(0, 0, -5), 0.1)
        else
            connection:Disconnect() -- Disconnect if targetHRP or HumanoidRootPart is invalid
        end
    end)
    return connection
end

-- // Main function to bring and make a player follow \\ --
local function bringAndFollow(target)
    local targetHRP = getHumanoidRootPart(target)
    if targetHRP then
        bringPlayerToFront(targetHRP)
        local followConnection = followPlayer(targetHRP)
        task.wait(0.5) -- Small delay for smooth execution
        followConnection:Disconnect() -- Disconnect after bringing and following
    end
end

-- // Loop through all players and apply the function \\ --
while true do
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then -- Ignore the local player
            bringAndFollow(player)
        end
    end
    task.wait(1) -- Prevent excessive looping
end

-- FE BRING ALL MADE BY LUXBYTE
-- DISCORD: catwix