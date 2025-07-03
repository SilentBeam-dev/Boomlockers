-- SilentBeam Aimbot v1 by XxRaptorScriptsXx
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- UI Setup using Rayfield
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({
    Name = "SilentBeam Aimbot 💀",
    LoadingTitle = "SilentLock",
    LoadingSubtitle = "by XxRaptorScriptsXx",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- Config
local AimbotEnabled = false
local AimbotFOV = 100
local TargetPart = "UpperTorso"
local Prediction = 0.143

-- UI Toggle
Rayfield:CreateToggle({
    Name = "Enable Aimbot",
    CurrentValue = false,
    Callback = function(Value)
        AimbotEnabled = Value
    end,
    Parent = Window
})

-- Function to get nearest player
local function GetClosestPlayer()
    local closest = nil
    local shortestDist = math.huge

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild(TargetPart) then
            local partPos = plr.Character[TargetPart].Position + (plr.Character[TargetPart].Velocity * Prediction)
            local screenPoint, onScreen = Camera:WorldToScreenPoint(partPos)

            if onScreen then
                local dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(screenPoint.X, screenPoint.Y)).Magnitude
                if dist < shortestDist and dist < AimbotFOV then
                    shortestDist = dist
                    closest = plr
                end
            end
        end
    end
    return closest
end

-- Lock function
RunService.RenderStepped:Connect(function()
    if AimbotEnabled then
        local target = GetClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild(TargetPart) then
