local TweenService = game:GetService("TweenService")


FaucetLogic = {}

function FaucetLogic.AddHandleActions(cold: Part, hot: Part, emitter: ParticleEmitter)
    toggleHandle(cold, emitter)
    toggleHandle(hot, emitter)
end

function toggleHandle(handle: Part, emitter: ParticleEmitter)
    local clickDetector = Instance.new("ClickDetector")
    clickDetector.MaxActivationDistance = 10
    clickDetector.Parent = handle

    handle:SetAttribute("IsOpen", false)

    handle:GetAttributeChangedSignal("IsOpen"):Connect(function()
        updateWaterState(handle, emitter)
    end)

    clickDetector.MouseClick:Connect(function()
        handleClick(handle)
    end)
end

function updateWaterState(handle: Part, emitter: ParticleEmitter)
    local open = handle:GetAttribute("IsOpen")

    if open then
        emitter.Enabled = true
        local rate = emitter.Rate + 50
        emitter.Rate = math.min(100, rate)
    else
        local rate = emitter.Rate - 50
        emitter.Rate = math.max(0, rate)
        if emitter.Rate == 0 then emitter.Enabled = false end
    end
end

function handleClick(handle: Part)
    local currentState = handle:GetAttribute("IsOpen")
    local newState = not currentState
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    -- Reverse rotation when currentState is open and we are closing it
    local rotationAngle = 60
    if currentState then rotationAngle *= -1 end

    local targetCFrame = handle.CFrame * CFrame.Angles(0, math.rad(rotationAngle), 0)

    TweenService:Create(handle, tweenInfo, { CFrame = targetCFrame}):Play()

    handle:SetAttribute("IsOpen", newState)
end

return FaucetLogic