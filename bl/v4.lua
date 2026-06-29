repeat task.wait() until game:IsLoaded()

wait(1)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local Workspace = workspace

local BL_ID = 2753915549
local BL_ID2 = 4442272183

local NotCheckID = "rbxassetid://80289121705754"
local CheckID = "rbxassetid://72382658"

local GUIS = {}

local Keybind = Enum.KeyCode.RightControl

local hasQueTelFunc = false

local PLR = Players.LocalPlayer

function MakeGui(name, z, ignore)

	local NewGui = Instance.new("ScreenGui", CoreGui)
	NewGui.Name = name
	NewGui.DisplayOrder = 9999 + z
	NewGui.IgnoreGuiInset = ignore or true
	NewGui.ResetOnSpawn = false

	table.insert(GUIS, NewGui)

	return NewGui

end

function RandomName(count)

	local text = ""

	for i=1, count do
		text = text.. string.char(math.random(97, 122))
	end

	return text

end

function OnError(err)

	if #GUIS > 0 then
		for i, v in pairs(GUIS) do
			v:Destroy()
		end
	end

	if setclipboard then

		setclipboard("ArteHack | BABFT Error: ".. err)

		StarterGui:SetCore("SendNotification", {
			Title = "Arte Hack | BLOX FRUITS",
			Text = "Error has been copied to your clipboard!",
			Duration = 5
		})

	else

		StarterGui:SetCore("SendNotification", {
			Title = "Arte Hack | BLOX FRUITS",
			Text = "Error: ".. err,
			Duration = 5
		})

	end

end

local CanOpen1 = true
local CanOpen2 = false

local succes, err = pcall(function()

	local a = true

	if game.PlaceId ~= BL_ID and game.PlaceId ~= BL_ID2 then
		OnError("You need to use this script in Blox Fruits!")
		a = false
	end

	if a == true then

		local LoadingGUI = MakeGui(RandomName(10).. "_loading", 1)

		UserInputService.InputBegan:Connect(function(inp, proc)
			if inp.KeyCode == Keybind and CanOpen1 == true then
				LoadingGUI.Enabled = not LoadingGUI.Enabled
			end
		end)

		local LoadingFrame = Instance.new("Frame", LoadingGUI)
		LoadingFrame.Position = UDim2.new(0.5,0,0.5,0)
		LoadingFrame.AnchorPoint = Vector2.new(0.5,0.5)
		LoadingFrame.Size = UDim2.new(0.398, 0, 0.478, 0)
		LoadingFrame.BorderSizePixel = 0
		LoadingFrame.BackgroundColor3 = Color3.new(0, 0.156863, 0.145098)
		LoadingFrame.BackgroundTransparency = 0

		local Corner = Instance.new("UICorner", LoadingFrame)
		Corner.CornerRadius = UDim.new(0, 5)

		local LoadingText = Instance.new("TextLabel", LoadingFrame)
		LoadingText.BackgroundTransparency = 1
		LoadingText.TextColor3 = Color3.new(1, 1, 1)
		LoadingText.Text = "ArteHack | BLOX FRUITS is checking your executor..."
		LoadingText.TextScaled = true
		LoadingText.TextWrapped = true
		LoadingText.Position = UDim2.new(0.5, 0, 0.052, 0)
		LoadingText.AnchorPoint = Vector2.new(0.5, 0)
		LoadingText.Size = UDim2.new(1, 0, 0.201, 0)

		local LoadingInfoFrame = Instance.new("CanvasGroup", LoadingFrame)
		LoadingInfoFrame.BackgroundTransparency = 0
		LoadingInfoFrame.BorderSizePixel = 0
		LoadingInfoFrame.BackgroundColor3 = Color3.new(0.223529, 0.223529, 0.223529)
		LoadingInfoFrame.Position = UDim2.new(0.5, 0, 0.311, 0)
		LoadingInfoFrame.AnchorPoint = Vector2.new(0.5, 0)
		LoadingInfoFrame.Size = UDim2.new(0.776, 0, 0.644, 0)

		local Corner = Instance.new("UICorner", LoadingInfoFrame)
		Corner.CornerRadius = UDim.new(0, 5)

		local UIListLayout = Instance.new("UIListLayout", LoadingInfoFrame)
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 5)

		LoadingInfoFrame.ClipsDescendants = true

		local InfoCount = 0

		local function AddInfo(text, succes)

			local Info = Instance.new("Frame", LoadingInfoFrame)
			Info.Size = UDim2.new(1, 0, 0.125, 0)
			Info.BackgroundTransparency = 1

			local Image = Instance.new("ImageLabel", Info)
			Image.BackgroundTransparency = 1
			Image.Size = UDim2.new(0.087, 0, 1, 0)
			Image.Position = UDim2.new(0, 0, 0, 0)

			InfoCount += 1
			Info.LayoutOrder = 999 - InfoCount

			if succes then
				Image.Image = CheckID
			else
				Image.Image = NotCheckID
			end

			local UIAspect = Instance.new("UIAspectRatioConstraint", Image)

			local Text = Instance.new("TextLabel", Info)
			Text.BackgroundTransparency = 1
			Text.Text = text
			Text.TextColor3 = Color3.new(1, 1, 1)
			Text.TextScaled = true
			Text.TextWrapped = true
			Text.Position = UDim2.new(0.125, 0, 0, 0)
			Text.Size = UDim2.new(0.875, 0, 1, 0)
			Text.TextXAlignment = Enum.TextXAlignment.Left

		end

		task.wait(0.01)

		if setclipboard then
			AddInfo("setclipboard", true)
		else
			AddInfo("setclipboard", false)
			task.wait(0.5)
		end

		task.wait(0.25)

		if identifyexecutor then
			AddInfo("identifyexecutor", true)
		else
			AddInfo("identifyexecutor", false)
			task.wait(0.5)
		end

		task.wait(0.25)
		if getexecutor then
			AddInfo("getexecutor", true)
		else
			AddInfo("getexecutor", false)
			task.wait(0.5)
		end

		task.wait(0.25)

		if getexecutorname then
			AddInfo("getexecutorname", true)
		else
			AddInfo("getexecutorname", false)
			task.wait(0.5)
		end

		task.wait(0.25)

		if get_info then
			AddInfo("get_info", true)
		else
			AddInfo("get_info", false)
			task.wait(0.5)
		end

		task.wait(0.25)

		if loadstring then
			AddInfo("loadstring", true)
		else
			AddInfo("loadstring", false)
			task.wait(0.5)
		end

		task.wait(0.25)

		if loadfile then
			AddInfo("loadfile", true)
		else
			AddInfo("loadfile", false)
			task.wait(0.5)
		end

		task.wait(0.25)

		if writefile then
			AddInfo("writefile", true)
		else
			AddInfo("writefile", false)
			task.wait(0.5)
		end

		task.wait(0.25)

		if makefolder then
			AddInfo("makefolder", true)
		else
			AddInfo("makefolder", false)
			task.wait(0.5)
		end

		task.wait(0.25)

		if listfiles then
			AddInfo("listfiles", true)
		else
			AddInfo("listfiles", false)
			task.wait(0.5)
		end

		task.wait(0.25)

		if delfile then
			AddInfo("delfile", true)
		else
			AddInfo("delfile", false)
			task.wait(0.5)
		end

		task.wait(0.25)

		if renamefile then
			AddInfo("renamefile", true)
		else
			AddInfo("renamefile", false)
			task.wait(0.5)
		end

		task.wait(0.25)

		if getgenv then
			AddInfo("getgenv", true)
		else
			AddInfo("getgenv", false)
			task.wait(0.5)
		end

		task.wait(0.25)

		if isfolder then
			AddInfo("isfolder", true)
		else
			AddInfo("isfolder", false)
			task.wait(0.5)
		end

		task.wait(0.25)

		if isfile then
			AddInfo("isfile", true)
		else
			AddInfo("isfile", false)
			task.wait(0.5)
		end

		task.wait(0.25)

		if getfolder then
			AddInfo("getfolder", true)
		else
			AddInfo("getfolder", false)
			task.wait(0.5)
		end

		task.wait(0.25)

		if getfileinfo then
			AddInfo("getfileinfo", true)
		else
			AddInfo("getfileinfo", false)
			task.wait(0.5)
		end

		task.wait(0.25)

		if queue_on_teleport then
			AddInfo("queue_on_teleport", true)
			hasQueTelFunc = true
		else
			AddInfo("queue_on_teleport", false)
			hasQueTelFunc = false
			task.wait(0.5)
		end

		LoadingText.Text = "ArteHack | BLOX FRUITS is loading..."

		wait(1)

		AddInfo(LoadingGUI.Name, true)
		task.wait(0.01)

		local MainGui = nil

		local suc3 = true
		local firstError = nil

		for i=1, 100 do

			local suc2, err2 = pcall(function()
				if i == 2 then
					MainGui = MakeGui(RandomName(10).. "_Main", 3, true)
				elseif i == 5 then
					MainGui.Enabled = false
				elseif i == 15 then

					local Frame = Instance.new("Frame", MainGui)
					Frame.Name = "MainFrame"
					Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
					Frame.Size = UDim2.new(0.46, 0, 0.725, 0)
					Frame.AnchorPoint = Vector2.new(0.5, 0.5)

				elseif i == 20 then

					local Frame = MainGui:WaitForChild("MainFrame"):: Frame
					Frame.BackgroundColor3 = Color3.new(0, 0.215686, 0.219608)
					Frame.BorderSizePixel = 0
					
				elseif i == 25 then
					
					local Frame = MainGui:WaitForChild("MainFrame"):: Frame
					local UICorner = Instance.new("UICorner", Frame)
					UICorner.CornerRadius = UDim.new(0, 5)

				elseif i == 35 then

					UserInputService.InputBegan:Connect(function(inp, proc)
						if inp.KeyCode == Keybind and CanOpen2 == true then
							MainGui.Enabled = not MainGui.Enabled
						end
					end)

				elseif i == 40 then
					if hasQueTelFunc then
						local TeleportCheck = false
						Players.LocalPlayer.OnTeleport:Connect(function(State)
							TeleportCheck = true
							queue_on_teleport("loadstring(game:HttpGet(\"https://raw.githubusercontent.com/JustARocketGame/ArteHack/refs/heads/main/bl/v4.lua\"))()")
						end)
					end
					
				elseif i == 50 then
					
					local Frame = MainGui:WaitForChild("MainFrame"):: Frame
					local Title = Instance.new("TextLabel", Frame)
					Title.Name = "Title"
					Title.Size = UDim2.new(0.9, 0, 0.1, 0)
					Title.Position = UDim2.new(0.5, 0, 0.05, 0)
					Title.AnchorPoint = Vector2.new(0.5, 0.5)
					Title.BackgroundTransparency = 1
					Title.Text = "ArteHack | BLOX FRUITS"
					Title.TextColor3 = Color3.new(1, 1, 1)
					Title.TextScaled = true
					Title.TextWrapped = true
					
				elseif i == 60 then
					
					local Frame = MainGui:WaitForChild("MainFrame"):: Frame
					local ScrollingFrame = Instance.new("ScrollingFrame", Frame)
					ScrollingFrame.Name = "ScrollingFrame"
					ScrollingFrame.Size = UDim2.new(0.872, 0, 0.728, 0)
					ScrollingFrame.Position = UDim2.new(0.5, 0, 0.219, 0)
					ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0)
					ScrollingFrame.BackgroundColor3 = Color3.new(0.00784314, 0.415686, 0.541176)
					ScrollingFrame.BackgroundTransparency = 0.5
					
				elseif i == 65 then
					
					local Frame = MainGui:WaitForChild("MainFrame"):: Frame
					local Hide = Instance.new("TextLabel", Frame)
					Hide.Name = "Hide"
					Hide.Size = UDim2.new(0.9, 0, 0.1, 0)
					Hide.Position = UDim2.new(0.5, 0, 0.155, 0)
					Hide.AnchorPoint = Vector2.new(0.5, 0.5)
					Hide.BackgroundTransparency = 1
					Hide.Text = "To hide press: Right CTRL"
					Hide.TextColor3 = Color3.new(1, 1, 1)
					Hide.TextScaled = true
					Hide.TextWrapped = true
					
				elseif i == 70 then
					
					local Frame = MainGui:WaitForChild("MainFrame"):: Frame
					local ScrollingFrame = Frame:WaitForChild("ScrollingFrame"):: ScrollingFrame
					local UIListLayout = Instance.new("UIListLayout", ScrollingFrame)
					UIListLayout.Padding = UDim.new(0, 5)
					UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
					UIListLayout.FillDirection = Enum.FillDirection.Vertical
					
				elseif i == 75 then
					
					local Frame = MainGui:WaitForChild("MainFrame"):: Frame
					local ScrollingFrame = Frame:WaitForChild("ScrollingFrame"):: ScrollingFrame
					
					local Buttons = 0
					
					local function AddButton(text, isToggle, func)
						
						local button = Instance.new("TextButton", ScrollingFrame)
						button:SetAttribute("Enabled", false)
						
						Buttons += 1
						button.LayoutOrder = Buttons
						
						button.Size = UDim2.new(1, 0, 0.1, 0)
						button.BackgroundTransparency = 1
						button.TextColor3 = Color3.new(1, 1, 1)
						button.TextScaled = true
						button.TextWrapped = true
						
						if isToggle then
							task.spawn(function()
								while task.wait() do
									if button:GetAttribute("Enabled") == true then
										button.Text = text.. ": ON"
									else
										button.Text = text.. ": OFF"
									end
								end
							end)
						else
							button.Text = text
						end
						
						button.Name =  text
						
						button.MouseButton1Up:Connect(function()
							if isToggle then
								button:SetAttribute("Enabled", not button:GetAttribute("Enabled"))
							end
							if func then
								func(button:GetAttribute("Enabled"))
							else
								print("BUTTON ".. text.. " HAS NO FUNC!")
							end
						end)
						
					end
					
					local NoStun = false
					local WaterWalking = false
					local AttackSpeed = false
					
					local OldWaterWalking = false
					local OldAttackSpeed = 1
					
					local infEnergy = false
					
					task.spawn(function()
						while task.wait() do
							if NoStun == true then
								PLR.Character:WaitForChild("Stun").Value = 0
								PLR.Character:WaitForChild("Busy").Value = false
							end
							if WaterWalking == true then
								PLR.Character:SetAttribute("WaterWalking", true)
							end
							if AttackSpeed == true then
								PLR.Character:SetAttribute("AttackSpeedMultiplier", -2)
							end
							if infEnergy == true then
								PLR.Character:WaitForChild("Energy").Value = 10000
							end
						end
					end)
					
					AddButton("No Stun", true, function(enabled)
						NoStun = enabled
					end)
					
					AddButton("Water Walking", true, function(enabled)
						if enabled == true then
							OldWaterWalking = PLR.Character:GetAttribute("WaterWalking")
							WaterWalking = true
						else
							PLR.Character:SetAttribute("WaterWalking", OldWaterWalking)
							WaterWalking = false
						end
					end)
					
					AddButton("Fast Attack", true, function(enabled)
						if enabled then
							OldAttackSpeed = PLR.Character:GetAttribute("AttackSpeedMultiplier")
							AttackSpeed = true
						else
							PLR.Character:SetAttribute("AttackSpeedMultiplier", OldAttackSpeed)
							AttackSpeed = false
						end
					end)
					
					AddButton("Infinity Energy", true, function(enabled)
						infEnergy = enabled
					end)
					
				elseif i == 80 then
					
					local Frame = MainGui:WaitForChild("MainFrame"):: Frame
					local ScrollingFrame = Frame:WaitForChild("ScrollingFrame"):: ScrollingFrame
					local UIListLayout = ScrollingFrame:WaitForChild("UIListLayout"):: UIListLayout
					
					ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
					
				elseif i == 95 then
					
					local Frame = MainGui:WaitForChild("MainFrame"):: Frame
					local CloseButton = Instance.new("TextButton", Frame)
					CloseButton.Position = UDim2.new(0, 0, 0, 0)
					CloseButton.BackgroundTransparency = 1
					CloseButton.TextColor3 = Color3.new(1, 0, 0.0156863)
					CloseButton.Text = "x"
					CloseButton.Size = UDim2.new(0.08, 0, 0.114, 0)
					CloseButton.TextScaled = true
					CloseButton.TextWrapped = true
					
					local aspect = Instance.new("UIAspectRatioConstraint", CloseButton)
					
					CloseButton.MouseButton1Up:Connect(function()
						OnError("CLOSED")
					end)
		
				end
			end)

			AddInfo("Loading: ".. i.. "%", suc2)
			task.wait(math.random(0.1, 0.3))

			if suc2 == false then
				suc3 = false
				if firstError == nil then
					firstError = err2
				end
			end

		end

		if suc3 == false then
			OnError(firstError)
		end

		LoadingGUI.Enabled = false
		CanOpen1 = false
		CanOpen2 = true
		MainGui.Enabled = true

	end

end)

if not succes then
	OnError(err)
end
