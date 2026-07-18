print("Hello TV Screen!")

local ScreenLogic = {}

function ScreenLogic.init(screen: Part)
    print("Hello from Screen Init")
end

function ScreenLogic.setupChannelDisplay(screen: Part)
    local surfaceGui = Instance.new("SurfaceGui")
    surfaceGui.Name = "TVCanvas"
    surfaceGui.Face = Enum.NormalId.Back
    surfaceGui.Parent = screen

    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Name = "ChannelDisplay"
    imageLabel.Size = UDim2.new(1,0,1,0)
    imageLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)

    imageLabel.Image = "rbxassetid://13479116834"

    imageLabel.Visible = false
    imageLabel.Parent = surfaceGui

    return imageLabel
end

function ScreenLogic.AddOnOff(screen: Part, tvModel: Part, channelDisplay: ImageLabel)
    local clickDetector = Instance.new("ClickDetector")
    clickDetector.MaxActivationDistance = 50
    clickDetector.Parent = screen

    tvModel:SetAttribute("IsOn", false)

    tvModel:GetAttributeChangedSignal("IsOn"):Connect(function()
        local tvState = tvModel:GetAttribute("IsOn")
        channelDisplay.Visible = tvState
        print("📺 TV Power State Changed. Is On:", tvState)
    end)

    clickDetector.MouseClick:Connect(function(player)
        local currentState = tvModel:GetAttribute("IsOn")
        local newState = not currentState

        tvModel:SetAttribute("IsOn", newState)

        print("Toggled tv state!")
    end)
end

return ScreenLogic