local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ArteHackIsRunning = false

local ArteHackIsRunningBool = ReplicatedStorage:FindFirstChild("AHIR")
if ArteHackIsRunningBool and ArteHackIsRunningBool.Value == true then
	ArteHackIsRunning = true
else
	ArteHackIsRunningBool = Instance.new("BoolValue", ReplicatedStorage)
	ArteHackIsRunningBool.Name = "AHIR"
	ArteHackIsRunningBool.Value = true
end

local dragSettings = {
	IsDragging = false,
	OldMousePos = nil,
	OldDragPos = nil
}

local script_settings = {}
local v = "1.0"

function RandomName(Lenght)
	
	local lenght = Lenght or math.random(15, 30)
	
	local Symbols = "abcdefghijklmnopqrstuvwxyz"
	local Name = ""
	
	for i = 1, lenght do
		local RandomIndex = math.random(1, #Symbols)
		Name = Name .. Symbols:sub(RandomIndex, RandomIndex)
	end
	
	return Name
	
end

local NewGui = Instance.new("ScreenGui", game.CoreGui)
NewGui.Name = RandomName()
NewGui.DisplayOrder = 99999
NewGui.ResetOnSpawn = false

local NotifyFrame = Instance.new("Frame", NewGui)
NotifyFrame.Name = "NotifyFrame"
NotifyFrame.Size = UDim2.new(0.199, 0, 0.951, 0)
NotifyFrame.Position = UDim2.new(0.781, 0, 0.033, 0)
NotifyFrame.Transparency = 1

local UIListLayout = Instance.new("UIListLayout", NotifyFrame)
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local NotifyCount = 0

function CreateNotify(Text)
	
	local Notify = Instance.new("Frame", NotifyFrame)
	Notify.Size = UDim2.new(1,0, 0.206, 0)
	Notify.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	
	NotifyCount += 1
	
	Notify.LayoutOrder = 10000 - NotifyCount
	
	local UICorner = Instance.new("UICorner", Notify)
	UICorner.CornerRadius = UDim.new(0, 10)
	
	local NotifyText = Instance.new("TextLabel", Notify)
	NotifyText.BackgroundTransparency = 1
	NotifyText.Size = UDim2.new(0.9, 0, 0.9, 0)
	NotifyText.AnchorPoint = Vector2.new(0.5, 0.5)
	NotifyText.Position = UDim2.new(0.5, 0, 0.5, 0)
	NotifyText.TextXAlignment = Enum.TextXAlignment.Left
	NotifyText.TextYAlignment = Enum.TextYAlignment.Top
	NotifyText.Text = Text
	NotifyText.TextColor3 = Color3.new(1, 1, 1)
	NotifyText.TextWrapped = true
	
	task.spawn(function()
		task.wait(3)
		Notify:Destroy()
		NotifyCount -= 1
	end)
	
end

function onError(err)

	CreateNotify("ArteHack has error, it has been copied to clipboard")

	local executorName, executorVersion = identifyexecutor()
	local message = "ArteHack v".. v.. " has error! ".. executorName.. " ".. executorVersion.. " err: ".. err

	if setclipboard then
		setclipboard(message)
	else
		if toclipboard then
			toclipboard(message)
		else
			CreateNotify("Can't copy to clipboard!")
		end
	end

	task.spawn(function()

		task.wait(3)

		ClearTrash()
		ArteHackIsRunningBool:Destroy()
		NewGui:Destroy()

	end)

end

if ArteHackIsRunning == false then
	CreateNotify("Running ArteHack v".. v)

	local function onDragFrameInputBegan(input, gameProcessed)
		if gameProcessed then return end

		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragSettings.IsDragging = true
			dragSettings.OldMousePos = input.Position
			dragSettings.OldDragPos = script_settings.DragFrame.Position
		end
	end

	local function onDragFrameInputChanged(input, gameProcessed)
		if gameProcessed then return end

		if dragSettings.IsDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local mousePos = input.Position

			local newPosition = UDim2.new(
				dragSettings.OldDragPos.X.Scale,
				dragSettings.OldDragPos.X.Offset + (mousePos.X - dragSettings.OldMousePos.X),
				dragSettings.OldDragPos.Y.Scale,
				dragSettings.OldDragPos.Y.Offset + (mousePos.Y - dragSettings.OldMousePos.Y)
			)

			script_settings.DragFrame.Position = newPosition
		end
	end

	local function onDragFrameInputEnded(input, gameProcessed)
		if gameProcessed then return end

		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragSettings.IsDragging = false
			dragSettings.OldMousePos = nil
			dragSettings.OldDragPos = nil
		end
	end

	function ClearTrash()
		for _, v in pairs(workspace:GetDescendants()) do
			if v.Name == "AHHL" then
				v:Destroy()
			end
		end
	end
	
	function SetupSideBarButton(Text, Buttons)
		
		local ButtonID = #script_settings.SideBarButtons + 1
		
		local Button = Instance.new("TextButton", script_settings.SideBar)
		
		if not script_settings["SideBarButtonsA"] then
			script_settings.SideBarButtonsA = {}
		end
		
		script_settings.SideBarButtonsA[Text] = Instance.new("Frame", script_settings.ButtonsFrame)
		script_settings.SideBarButtonsA[Text].Size = UDim2.new(1, 0, 1, 0)
		script_settings.SideBarButtonsA[Text].Position = UDim2.new(0, 0, 0, 0)
		script_settings.SideBarButtonsA[Text].BackgroundTransparency = 1
		script_settings.SideBarButtonsA[Text].Visible = false
		
		local UIListLayout = Instance.new("UIListLayout", script_settings.SideBarButtonsA[Text])
		UIListLayout.Padding = UDim.new(0, 5)
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		
		if not script_settings["SelectedTab"] then
			script_settings.SelectedTab = Text
			script_settings.ButtonsFrameTitle.Text = Text
			script_settings.SideBarButtonsA[Text].Visible = true
		end
		
		Button.Size = UDim2.new(1, 0, 0.08, 0)
		Button.Text = Text
		Button.TextScaled = true
		Button.TextColor3 = Color3.new(1, 1, 1)
		Button.BackgroundTransparency = 1
		
		Button.LayoutOrder = ButtonID
		
		Button.MouseButton1Up:Connect(function()
			script_settings.ButtonsFrameTitle.Text = Text
			script_settings.SideBarButtonsA[script_settings.SelectedTab].Visible = false
			script_settings.SelectedTab = Text
			script_settings.SideBarButtonsA[Text].Visible = true
		end)
		
		script_settings.SideBarButtons[ButtonID] = Button
		
		if not script_settings["ButtonsEnabled"] then
			script_settings.ButtonsEnabled = {}
		end

		for index, v in pairs(Buttons) do
			
			local IsToggle = true
			
			if v[3] ~= nil and v[3] == false then
				IsToggle = false
			end
			
			local NewButton = Instance.new("TextButton", script_settings.SideBarButtonsA[Text])
			NewButton.Size = UDim2.new(1, 0, 0.108, 0)
			
			script_settings.ButtonsEnabled[v[1]] = false
			
			if IsToggle == true then
				NewButton.Text = v[1].. ": -"
			else
				NewButton.Text = v[1]
			end
			
			NewButton.TextScaled = true
			NewButton.TextColor3 = Color3.new(1, 1, 1)
			NewButton.BackgroundTransparency = 1
			
			local buttonPressed = false
			
			NewButton.MouseButton1Up:Connect(function()
				script_settings.ButtonsEnabled[v[1]] = not script_settings.ButtonsEnabled[v[1]]
				v[2](buttonPressed)
			end)
			
			task.spawn(function()
				while task.wait(0.1) do
					if IsToggle == true then
						if script_settings.ButtonsEnabled[v[1]] == false then
							NewButton.Text = v[1].. ": -"
						else
							NewButton.Text = v[1].. ": +"
						end
					else
						NewButton.Text = v[1]
					end
				end
			end)
			
		end

	end
	
	function DoorESP(enable)
		
		script_settings.HighLight.Door = enable
		ClearTrash()
		
	end
	
	function KeyESP(enable)

		script_settings.HighLight.Key = enable
		ClearTrash()

	end
	
	function EntityNotify(enable)
		script_settings.EntityNotify = enable
	end
	
	function DisableCutscenes(enable)
		script_settings.DisableCutscenes = enable
	end
	
	function LoadConfig()
		
		if not isfolder("ArteHack") then
			makefolder("ArteHack")
		end

		if not isfile("ArteHack/config.txt") then
			CreateNotify("Config file not found!")
			return
		end
		
		local config = game.HttpService:JSONDecode(readfile("ArteHack/config.txt"))
		
		if not script_settings["ButtonsEnabled"] then
			script_settings.ButtonsEnabled = {}
		end
		
		script_settings.HighLight.Door = config["DoorESP"] or false
		script_settings.ButtonsEnabled["Door ESP"] = config["DoorESP"] or false
		
		script_settings.HighLight.Key = config["KeyESP"] or false
		script_settings.ButtonsEnabled["Key ESP"] = config["KeyESP"] or false
		
		script_settings.EntityNotify = config["EntityNotify"] or false
		script_settings.ButtonsEnabled["Entity Notify"] = config["EntityNotify"] or false

		script_settings.DisableCutscenes = config["DisableCutscenes"] or false
		script_settings.ButtonsEnabled["Third Person"] = config["DisableCutscenes"] or false
		
		script_settings.ButtonsEnabled["Disable Screech"] = config["DisableScreech"] or false
		if config["DisableScreech"] == true then
			if game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):FindFirstChild("Screech") then
				game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("Screech"):Destroy()
			end
		else
			if not game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):FindFirstChild("Screech") then
				local newEvent = Instance.new("RemoteEvent", game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"))
				newEvent.Name = "Screech"
			end
		end
		
		task.wait(0.1)
		
		ClearTrash()
		
		CreateNotify("Loaded config!")
		
	end
	
	function SaveConfig()
		
		if not isfolder("ArteHack") then
			makefolder("ArteHack")
		end

		if not isfile("ArteHack/config.txt") then
			writefile("ArteHack/config.txt", "NONE")
		end
		
		local config = {}
		
		config["DoorESP"] = script_settings.HighLight.Door or false
		config["KeyESP"] = script_settings.HighLight.Key or false
		config["EntityNotify"] = script_settings.EntityNotify or false
		config["DisableCutscenes"] = script_settings.DisableCutscenes or false
		config["DisableScreech"] = script_settings.DisableScreech or false
		
		local config = game.HttpService:JSONEncode(config)
		
		writefile("ArteHack/config.txt", config)
		
		CreateNotify("Saved config!")
		
	end
	
	function DisableScreech(enable)
		script_settings.DisableScreech = enable
		if enable == true then
			if game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):FindFirstChild("Screech") then
				game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("Screech"):Destroy()
			end
			CreateNotify("Screech was deleted!")
		else
			local newEvent = Instance.new("RemoteEvent", game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"))
			newEvent.Name = "Screech"
			CreateNotify("Screech was restored!")
		end
	end

	function SetupUI()

		local Setuped = script_settings["SetupedUI"] or false
		if Setuped == false then

			script_settings["DragFrame"] = Instance.new("Frame", NewGui)
			script_settings.DragFrame.Position = UDim2.new(0, 100, 0, 100)
			script_settings.DragFrame.Size = UDim2.new(0.392, 0, 0.117, 0)
			script_settings.DragFrame.BackgroundTransparency = 1

			script_settings.DragFrame.InputBegan:Connect(onDragFrameInputBegan)
			script_settings.DragFrame.InputChanged:Connect(onDragFrameInputChanged)
			script_settings.DragFrame.InputEnded:Connect(onDragFrameInputEnded)

			script_settings["MainFrame"] = Instance.new("Frame", script_settings.DragFrame)
			script_settings.MainFrame.Visible = false

			script_settings.MainFrame.Size = UDim2.new(1, 0, 6.338, 0)
			script_settings.MainFrame.Position = UDim2.new(0, 0, 0.493, 0)
			script_settings.MainFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)

			local UICorenr = Instance.new("UICorner", script_settings.MainFrame)
			UICorenr.CornerRadius = UDim.new(0, 10)

			script_settings["Title"] = Instance.new("TextLabel", script_settings.MainFrame)
			script_settings.Title.Text = "ArteHack v".. v
			script_settings.Title.Size = UDim2.new(1, 0, 0.078, 0)
			script_settings.Title.Position = UDim2.new(0, 0, 0, 0)
			script_settings.Title.BackgroundTransparency = 1
			script_settings.Title.TextColor3 = Color3.new(1, 1, 1)

			script_settings["Podcherkovanie"] = Instance.new("Frame", script_settings.MainFrame)
			script_settings.Podcherkovanie.Position = UDim2.new(0.5, 0, 0.08, 0)
			script_settings.Podcherkovanie.Size = UDim2.new(0.9, 0, 0.013, 0)
			script_settings.Podcherkovanie.AnchorPoint = Vector2.new(0.5, 0)
			script_settings.Podcherkovanie.BackgroundColor3 = Color3.new(1, 1, 1)

			script_settings["CloseButton"] = Instance.new("TextButton", script_settings.MainFrame)
			script_settings.CloseButton.Text = "x"
			script_settings.CloseButton.TextScaled = true
			script_settings.CloseButton.BackgroundTransparency = 1
			script_settings.CloseButton.TextColor3 = Color3.new(1, 0, 0)
			script_settings.CloseButton.Size = UDim2.new(0.063, 0, 0.076, 0)
			script_settings.CloseButton.Position = UDim2.new(0.937, 0, 0, 0)

			script_settings.CloseButton.MouseButton1Up:Connect(function()
				ClearTrash()
				ArteHackIsRunningBool:Destroy()
				NewGui:Destroy()
			end)

			local UICorenr2 = Instance.new("UICorner", script_settings.Podcherkovanie)
			UICorenr2.CornerRadius = UDim.new(0, 10)
			
			script_settings["SideBar"] = Instance.new('Frame', script_settings.MainFrame)
			script_settings.SideBar.Position = UDim2.new(0.022, 0, 0.109, 0)
			script_settings.SideBar.Size = UDim2.new(0.185, 0, 0.865, 0)
			script_settings.SideBar.BackgroundColor3 = Color3.fromRGB(56, 56, 56)
			
			local UICorenr3 = Instance.new("UICorner", script_settings.SideBar)
			UICorenr3.CornerRadius = UDim.new(0, 10)
			
			local UIListLayout = Instance.new("UIListLayout", script_settings.SideBar)
			UIListLayout.Padding = UDim.new(0, 5)
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			
			script_settings["SideBarButtons"] = {}
			
			local FakeSideBarButton = Instance.new("Frame", script_settings.SideBar)
			FakeSideBarButton.Size = UDim2.new(1, 0, 0.08, 0)
			FakeSideBarButton.BackgroundTransparency = 1
			FakeSideBarButton.LayoutOrder = 0
			
			script_settings["ButtonsFrame"] = Instance.new("Frame", script_settings.MainFrame)
			script_settings.ButtonsFrame.Position = UDim2.new(0.231, 0, 0.109, 0)
			script_settings.ButtonsFrame.Size = UDim2.new(0.753, 0, 0.865, 0)
			script_settings.ButtonsFrame.BackgroundColor3 = Color3.fromRGB(56, 56, 56)
			
			local UICorenr4 = Instance.new("UICorner", script_settings.ButtonsFrame)
			UICorenr4.CornerRadius = UDim.new(0, 10)
			
			local UIListLayout = Instance.new("UIListLayout", script_settings.ButtonsFrame)
			UIListLayout.Padding = UDim.new(0, 5)
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			
			script_settings["ButtonsFrameTitle"] = Instance.new("TextLabel", script_settings.ButtonsFrame)
			script_settings.ButtonsFrameTitle.Size = UDim2.new(1, 0, 0.062, 0)
			script_settings.ButtonsFrameTitle.Position = UDim2.new(0, 0, 0, 0)
			script_settings.ButtonsFrameTitle.Text = "If you see this, arte hack has error"
			script_settings.ButtonsFrameTitle.BackgroundTransparency = 1
			script_settings.ButtonsFrameTitle.TextColor3 = Color3.new(1, 1, 1)
			script_settings.ButtonsFrameTitle.TextScaled = true
			
			local VisualsButtons = {
				[1] = {
					[1] = "Door ESP", 
					[2] = DoorESP
				},
				[2] = {
					[1] = "Key ESP",
					[2] = KeyESP
				},
				[3] = {
					[1] = "Entity Notify",
					[2] = EntityNotify
				},
				[4] = {
					[1] = "Third Person",
					[2] = DisableCutscenes
				}
			}
			
			local ConfigButtons = {
				[1] = {
					[1] = "Load Config",
					[2] = LoadConfig,
					[3] = false
				},
				[2] = {
					[1] = "Save Config",
					[2] = SaveConfig,
					[3] = false
				}
			}
			
			local PlayerButtons = {
				[1] = {
					[1] = "Disable Screech",
					[2] = DisableScreech
				}
			}
			
			SetupSideBarButton("Visuals", VisualsButtons)
			SetupSideBarButton("Player", PlayerButtons)
			SetupSideBarButton("Config", ConfigButtons)
			
			task.wait(0.5)
			
			local count = 0
			
			for _ in pairs(script_settings.Plugins) do
				
				local succes, err = pcall(function()

					count = count + 1

					local Encoded = script_settings.Plugins[count]
					print(Encoded)
					
					local Plugin = game:GetService("HttpService"):JSONDecode(Encoded)
					local Tabs = Plugin["Tabs"]

					for tabName, tab in pairs(Tabs) do

						local buttons = {}

						local Buttons = tab["Buttons"]
						for index, button in pairs(Buttons) do
							
							local funcSTR = button[2]
							local compiled = loadstring("return " .. funcSTR)
							
							button[2] = compiled
							
							buttons[index] = button
							
						end

						SetupSideBarButton(tabName.. " ADDON", buttons)

					end

				end)
				
				if not succes then
					onError(err)
				end
				
			end

			script_settings["SetupedUI"] = true

		else
			CreateNotify("Already setuped ui!")
		end

	end

	task.wait(0.5)

	local succes, err = pcall(function()

		local cho_ito = "065114116101072097099107077121083099114105112116095079077071095110111095087065089095087084072095110111112101"

		local function abc(text)
			local result = {}
			for i = 1, #text do
				local charCode = string.byte(text, i)
				table.insert(result, string.format("%03d", charCode))
			end
			return table.concat(result, "")
		end
		
		if not isfolder("ArteHack") then
			makefolder("ArteHack")
		end
		
		local CodeFrame = Instance.new("Frame", NewGui)
		CodeFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
		CodeFrame.Size = UDim2.new(0.397,0,0.473,0)
		CodeFrame.Position = UDim2.new(0.5,0,0.5,0)
		CodeFrame.AnchorPoint = Vector2.new(0.5,0.5)
		CodeFrame.Visible = true
		
		local UICorner = Instance.new("UICorner", CodeFrame)
		UICorner.CornerRadius = UDim.new(0, 10)
		
		local UIStroke = Instance.new("UIStroke", NewGui)
		UIStroke.Thickness = 3
		UIStroke.Color = Color3.fromRGB(0, 0, 0)
		
		local TextLabel = Instance.new("TextLabel", CodeFrame)
		TextLabel.Text = "ArteHack v".. v
		TextLabel.Size = UDim2.new(1,0,0.174,0)
		TextLabel.Position = UDim2.new(0.5, 0, 0, 0)
		TextLabel.AnchorPoint = Vector2.new(0.5,0)
		TextLabel.BackgroundTransparency = 1
		TextLabel.TextScaled = true
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		
		local TextLabel2 = Instance.new("TextLabel", CodeFrame)
		TextLabel2.Text = "Enter the code"
		TextLabel2.Size = UDim2.new(0.625,0,0.174,0)
		TextLabel2.Position = UDim2.new(0.5, 0, 0.174, 0)
		TextLabel2.AnchorPoint = Vector2.new(0.5,0)
		TextLabel2.BackgroundTransparency = 1
		TextLabel2.TextScaled = true
		TextLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
		
		local TextBox = Instance.new("TextBox", CodeFrame)
		TextBox.AnchorPoint = Vector2.new(0.5,0)
		TextBox.Position = UDim2.new(0.5,0,0.413,0)
		TextBox.Size = UDim2.new(0.528, 0, 0.174, 0)
		TextBox.Text = ""
		TextBox.PlaceholderText = "Here"
		TextBox.TextColor3 = Color3.new(1, 1, 1)
		TextBox.BackgroundTransparency = 1
		TextBox.TextScaled = true
		
		local TextButton = Instance.new("TextButton", CodeFrame)
		TextButton.Text = "Check"
		TextButton.AnchorPoint = Vector2.new(0.5,0)
		TextButton.Position = UDim2.new(0.5, 0, 0.642, 0)
		TextButton.BackgroundTransparency = 1
		TextButton.TextScaled = 1
		TextButton.TextColor3 = Color3.new(1,1,1)
		TextButton.Size = UDim2.new(0.364, 0, 0.174, 0)
		
		local function wth()
			
			SetupUI()

			script_settings["ToggleButton"] = Instance.new("TextButton", NewGui)
			script_settings.ToggleButton.Text = "Toggle"
			script_settings.ToggleButton.Position = UDim2.new(0.902, 0, 0.924, 0)
			script_settings.ToggleButton.Size = UDim2.new(0.092, 0, 0.061, 0)
			script_settings.ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			script_settings.ToggleButton.TextColor3 = Color3.new(1, 1, 1)
			script_settings.ToggleButton.TextScaled = true

			local UICorenr = Instance.new("UICorner", script_settings.ToggleButton)
			UICorenr.CornerRadius = UDim.new(0, 10)

			script_settings.ToggleButton.MouseButton1Up:Connect(function()
				script_settings.DragFrame.Visible = not script_settings.DragFrame.Visible
			end)

			local CurrentRooms = workspace.CurrentRooms

			if #CurrentRooms:GetChildren() == 0 then
				error("You is playing in the lobby!")
			end

			script_settings["EntityNotify"] = false

			script_settings["HighLight"] = {}
			script_settings.HighLight["Door"] = false
			script_settings.HighLight["Key"] = false

			task.spawn(function()
				while task.wait(0.1) do
					if not ArteHackIsRunningBool or not ArteHackIsRunningBool.Parent then
						break
					end
					for _, v in pairs(CurrentRooms:GetDescendants()) do
						if not v:FindFirstChild("AHHL") then
							if v.Name == "Door" and v.Parent.Parent.Parent == CurrentRooms and v.Parent.Name == "Door" then

								local HighLight = Instance.new("Highlight", v)
								HighLight.Name = "AHHL"
								HighLight.FillColor = Color3.new(0.184314, 1, 0)

								if script_settings.HighLight.Door == true then
									HighLight.FillTransparency = 0.5
								else
									HighLight.FillTransparency = 1
								end

								HighLight.OutlineTransparency = 1

							elseif v.Name == "KeyObtain" then

								local HighLight = Instance.new("Highlight", v)
								HighLight.Name = "AHHL"
								HighLight.FillColor = Color3.new(0.0666667, 0, 1)

								if script_settings.HighLight.Key == true then
									HighLight.FillTransparency = 0.5
								else
									HighLight.FillTransparency = 1
								end

								HighLight.OutlineTransparency = 1

							end
						end
					end
				end
			end)

			local EntitysName = {
				["RushMoving"] = "Rush",
				["AmbushMoving"] = "Ambush",
				["Eyes"] = "Eyes",
				["BlitzMoving"] = "Blitz",
				["Blitz"] = "Blitz",
			}

			workspace.DescendantAdded:Connect(function(Child)
				if EntitysName[Child.Name] ~= nil and script_settings.EntityNotify == true and ArteHackIsRunningBool and ArteHackIsRunningBool.Parent then
					CreateNotify(EntitysName[Child.Name].. " has spawned!")
				end
			end)

			task.spawn(function()
				while task.wait() do
					if script_settings["DisableCutscenes"] == true then
						workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
						game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
					else
						game.Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
					end
				end
			end)

		end
		
		local function CheckCode(code, notifyWrong)
			local abc2 = abc(code)
			if abc2 == cho_ito then

				CreateNotify("Loading ArteHack...")

				CodeFrame:Destroy()

				if not isfolder("ArteHack") then
					makefolder("ArteHack")
				end

				if not isfolder("ArteHack/Plugins") then
					makefolder("ArteHack/Plugins")
				end

				script_settings["Plugins"] = {}

				local count = 0

				local files_ = listfiles("ArteHack/Plugins")
				for index, filePath in ipairs(files_) do
					if filePath then

						local fileName = filePath:match("([^/\\]+)%.lua$") or filePath:match("([^/\\]+)$")
						local fileContent = readfile(filePath)

						if fileContent then
							print("Загружаю плагин: " .. fileName)

							count += 1

							script_settings.Plugins[count] = fileContent

							task.wait(0.1)

						end

					end
				end

				task.wait(0.5)

				--writefile("ArteHack/test.txt", game:GetService("HttpService"):JSONEncode(script_settings.Plugins))

				--[[

-- 1. Кодируем и сразу декодируем строку
local jsonStr = game.HttpService:JSONEncode(config)
local decoded = game.HttpService:JSONDecode(jsonStr)

-- 2. Аккуратно извлекаем данные по числовым индексам
local tab = decoded["Tabs"]
local buttons = tab["Buttons"]
local button = buttons[1] -- После JSONDecode это обычный массив! Индекс равен числу 1.

local funcSTR = button[2] -- Индекс равен числу 2. Теперь здесь лежит строка функции.

-- 3. Компилируем строку в реальный код (добавляем return)
local compiled = loadstring("return " .. funcSTR)()

-- 4. Проверяем работоспособность
compiled() -- Выведет в консоль: Hello World!

				]]--

				wth()

				task.wait(0.5)

				writefile("ArteHack/key_".. v, code)
				script_settings.MainFrame.Visible = true

			else
				if notifyWrong ~= false then
					CreateNotify("Wrong code!")
				end
			end
		end
		
		TextButton.MouseButton1Up:Connect(function()
			local code = TextBox.Text
			CheckCode(code)
		end)
		
		if isfile("ArteHack/key_".. v) then
			local code = readfile("ArteHack/key_".. v)
			CheckCode(code, false)
		end

	end)

	if succes then
		print("A")
	else
		onError(err)
	end
	
else
	CreateNotify("ArteHack is already running!")
end
