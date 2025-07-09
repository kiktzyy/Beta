local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

-- Buat ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LimeHubStatus"
screenGui.ResetOnSpawn = false
screenGui.Parent = gui

-- Container untuk link Discord dan tombol Copy
local discordContainer = Instance.new("Frame")
discordContainer.Size = UDim2.new(0, 230, 0, 20)
discordContainer.Position = UDim2.new(0.5, -115, 0, -20)
discordContainer.BackgroundTransparency = 1
discordContainer.Parent = screenGui

-- Label link Discord (berkedip seperti LimeHub Beta)
local discordLink = Instance.new("TextLabel")
discordLink.Size = UDim2.new(0.7, 0, 1, 0)
discordLink.Position = UDim2.new(0, 0, 0, 0)
discordLink.BackgroundTransparency = 1
discordLink.Text = "https://discord.gg/dVHNVcXK"
discordLink.Font = Enum.Font.GothamBold
discordLink.TextColor3 = Color3.fromRGB(255, 0, 0)
discordLink.TextSize = 14
discordLink.TextXAlignment = Enum.TextXAlignment.Left
discordLink.Parent = discordContainer

-- Tombol copy
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0.3, 0, 1, 0)
copyButton.Position = UDim2.new(0.7, 0, 0, 0)
copyButton.BackgroundTransparency = 1
copyButton.Text = "Copy"
copyButton.Font = Enum.Font.GothamBold
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.TextSize = 14
copyButton.Parent = discordContainer

copyButton.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard("https://discord.gg/GrHxdhMQ")
		copyButton.Text = "Copied!"
		task.wait(1.5)
		copyButton.Text = "Copy"
	else
		copyButton.Text = "Unavailable"
		task.wait(1.5)
		copyButton.Text = "Copy"
	end
end)

-- Frame utama
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 230, 0, 120)
mainFrame.Position = UDim2.new(0.5, -115, 0, 10)
mainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
mainFrame.BackgroundTransparency = 0.4
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local border = Instance.new("UIStroke")
border.Thickness = 1.5
border.Color = Color3.new(1, 1, 1)
border.Transparency = 0.2
border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
border.Parent = mainFrame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 20)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "LimeHub Beta"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.TextSize = 16
title.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -10, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 20)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status : -"
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextColor3 = Color3.new(1, 1, 1)
statusLabel.TextSize = 14
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = mainFrame

local levelLabel = Instance.new("TextLabel")
levelLabel.Size = UDim2.new(1, -10, 0, 20)
levelLabel.Position = UDim2.new(0, 10, 0, 40)
levelLabel.BackgroundTransparency = 1
levelLabel.Text = "Level : -"
levelLabel.Font = Enum.Font.Gotham
levelLabel.TextColor3 = Color3.new(1, 1, 1)
levelLabel.TextSize = 14
levelLabel.TextXAlignment = Enum.TextXAlignment.Left
levelLabel.Parent = mainFrame

local raceLabel = Instance.new("TextLabel")
raceLabel.Size = UDim2.new(1, -10, 0, 20)
raceLabel.Position = UDim2.new(0, 10, 0, 60)
raceLabel.BackgroundTransparency = 1
raceLabel.Text = "Race : -"
raceLabel.Font = Enum.Font.Gotham
raceLabel.TextColor3 = Color3.new(1, 1, 1)
raceLabel.TextSize = 14
raceLabel.TextXAlignment = Enum.TextXAlignment.Left
raceLabel.Parent = mainFrame

local styleLabel = Instance.new("TextLabel")
styleLabel.Size = UDim2.new(1, -10, 0, 20)
styleLabel.Position = UDim2.new(0, 10, 0, 80)
styleLabel.BackgroundTransparency = 1
styleLabel.Text = "Fightingstyle : -"
styleLabel.Font = Enum.Font.Gotham
styleLabel.TextColor3 = Color3.new(1, 1, 1)
styleLabel.TextSize = 14
styleLabel.TextXAlignment = Enum.TextXAlignment.Left
styleLabel.Parent = mainFrame

-- Update logic
local function updateStatusUI()
	while true do
		local text = "Status : Idle"
		local level = player:FindFirstChild("Data") and player.Data:FindFirstChild("Level")
		local race = player:FindFirstChild("Data") and player.Data:FindFirstChild("Race")
		local p = getgenv().progress or {}
		local isSea2 = game.PlaceId == 4442272183
		local isSea3 = game.PlaceId == 7449423635

		if getgenv().isUnlockingSea2 then
			text = "Status : Unlock Sea 2"
		elseif p.Sea3Progress ~= nil then
			text = "Status : Unlock Sea 3"
		elseif (not p.SudahSelesaiBartilo or p.SudahSelesaiBartilo == false) and isSea2 and (level and level.Value or 0) < 875 then
			text = "Status : Quest Bartilo"
		elseif player:FindFirstChild("PlayerGui")
			and player.PlayerGui:FindFirstChild("Main")
			and player.PlayerGui.Main:FindFirstChild("TopHUDList")
			and player.PlayerGui.Main.TopHUDList:FindFirstChild("RaidTimer")
			and player.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
			text = "Status : Raid"
		elseif getgenv().AutoFarmAktif then
			text = "Status : Farm Level"
		end

		statusLabel.Text = text
		levelLabel.Text = "Level : " .. (level and level.Value or "-")
		raceLabel.Text = "Race : " .. (race and race.Value or "-")

		local fightingStyles = {
			["God Human"] = 300,
			["Dragon Talon"] = 400,
			["Sharkman Karate"] = 400,
			["Electric Claw"] = 400,
			["Death Step"] = 400,
			["Superhuman"] = 400,
			["Dragon Claw"] = 400,
			["Fishman Karate"] = 400,
			["Electro"] = 400,
			["Black Leg"] = 400
		}
		local activeStyle = nil
		local targetMastery = nil

		local char = player.Character
		if char then
			for name, target in pairs(fightingStyles) do
				if char:FindFirstChild(name) then
					activeStyle = name
					targetMastery = target
					break
				end
			end

			if activeStyle then
				local tool = char:FindFirstChild(activeStyle)
				local mastery = (tool and tool:FindFirstChild("Level")) and tool.Level.Value or 0
				styleLabel.Text = "Fightingstyle : Farm Mastery " .. mastery .. "/" .. targetMastery
			elseif char:FindFirstChild("Combat") then
				styleLabel.Text = "Fightingstyle : Waiting Beli"
			else
				styleLabel.Text = "Fightingstyle : -"
			end
		else
			styleLabel.Text = "Fightingstyle : -"
		end

		task.wait(1)
	end
end

-- Efek berkedip merah ↔ putih untuk title dan Discord link
task.spawn(function()
	local warna = {
		Color3.fromRGB(255, 0, 0),
		Color3.fromRGB(255, 255, 255)
	}
	local i = 1
	while true do
		title.TextColor3 = warna[i]
		discordLink.TextColor3 = warna[i]
		i = i % #warna + 1
		task.wait(1)
	end
end)

task.spawn(updateStatusUI)
