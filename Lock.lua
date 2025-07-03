-- SilentBeam WallHop V1 (Mobile Button Toggle)

-- SERVICES
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

-- VARIABLES
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local camera = workspace.CurrentCamera
local hopping = false
local hopPower = 50
local wallCheckRange = 3

-- FUNCTION: WallHop
local function wallhop()
	while hopping do
		RunService.RenderStepped:Wait()
		local ray = Ray.new(character.HumanoidRootPart.Position, character.HumanoidRootPart.CFrame.LookVector * wallCheckRange)
		local part = workspace:FindPartOnRay(ray, character)
		if part then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
