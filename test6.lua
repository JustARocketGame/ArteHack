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
NewGui.DisplayOrder = 99999999999

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

			script_settings.CloseButton.MouseButton1Up:Connect(function()
				ArteHackIsRunningBool:Destroy()
				NewGui:Destroy()
			end)

			local UICorenr2 = Instance.new("UICorner", script_settings.Podcherkovanie)
			UICorenr2.CornerRadius = UDim.new(0, 10)

			script_settings["SetupedUI"] = true

		else
			CreateNotify("Already setuped ui!")
		end

	end

	task.wait(0.5)

	local succes, err = pcall(function()

		SetupUI()

		script_settings["ToggleButton"] = Instance.new("TextButton", NewGui)
		script_settings.ToggleButton.Text = "Toggle"
		script_settings.ToggleButton.Position = UDim2.new(0.902, 0, 0.924, 0)
		script_settings.ToggleButton.Size = UDim2.new(0.092, 0, 0.061, 0)
		script_settings.ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
		script_settings.ToggleButton.TextColor3 = Color3.new(1, 1, 1)

		local UICorenr = Instance.new("UICorner", script_settings.ToggleButton)
		UICorenr.CornerRadius = UDim.new(0, 10)

		script_settings.ToggleButton.MouseButton1Up:Connect(function()
			script_settings.DragFrame.Visible = not script_settings.DragFrame.Visible
		end)

	end)

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
			NewGui:Destroy()
		end)

	end

	if succes then

		task.wait(0.5)

		script_settings.MainFrame.Visible = true

	else
		onError(err)
	end
	
else
	CreateNotify("ArteHack is already running!")
end
