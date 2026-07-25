local SinkFactory = {}

local GeometryService = game:GetService("GeometryService")
local ServerStorage = game:GetService("ServerStorage")

local ServerStorageServer = ServerStorage:WaitForChild("Server")
local FaucetLogicScript = ServerStorageServer:WaitForChild("faucet")

local FaucetLogic = require(FaucetLogicScript)

type SinkConfig = {
    parent: Model,
    cframe: CFrame
}

function SinkFactory.spawn(config: SinkConfig): Model
    local model = Instance.new("Model")

    local success, sinkBasin = buildSinkBasin()
    if not success then return model end

    local success, sinkBowl = buildSinkBowl()
    if not success then return model end

    local drain = buildDrain()
    local faucet = buildFaucet()
    
    sinkBasin.Parent = model
    sinkBowl.Parent = model
    drain.Parent = model
    faucet.Parent = model
    
    model.PrimaryPart = sinkBasin
    weldToPrimary(model)

    model.Name = "Sink"
    model.Parent = config.parent
    model:PivotTo(config.cframe)
    return model
end

function buildSinkBasin(): (boolean, UnionOperation)
    -- Outer Countertop

    local counterBlock = Instance.new("Part")
    counterBlock.Size = Vector3.new(6,3,6)
    counterBlock.Position = Vector3.zero
    counterBlock.Color = Color3.fromRGB(220, 220, 225)
    counterBlock.Material = Enum.Material.SmoothPlastic
    counterBlock.Anchored = true

    -- The Bowl Cutter

    local bowlCutter = Instance.new("Part")
    bowlCutter.Shape = Enum.PartType.Ball
    bowlCutter.Size = Vector3.new(4.5, 4.5, 4.5)
    bowlCutter.Position = Vector3.new(0, 0.8, 0)

    -- Perform CSG Operations
    local cutters = { bowlCutter }

    local unioned, newParts = pcall(function()
        return GeometryService:SubtractAsync(counterBlock, cutters)
    end)

    -- Cleanup
    bowlCutter:Destroy()
    counterBlock:Destroy()

    local resultUnion = Instance.new("UnionOperation")
    local success = unioned and newParts and newParts[1]

    if success then
        resultUnion = newParts[1]
        resultUnion.Name = "SinkBasin"
        resultUnion.Anchored = true
    end

    return success, resultUnion
end

function buildSinkBowl(): (boolean, UnionOperation)
    local outerSphere = Instance.new("Part")
    outerSphere.Shape = Enum.PartType.Ball
    outerSphere.Size = Vector3.new(4.4, 4.4, 4.4)
    outerSphere.Position = Vector3.new(0, 0.8, 0)
    outerSphere.Color = Color3.fromRGB(180, 185, 190)
    outerSphere.Material = Enum.Material.Metal

    local innerCutter = Instance.new("Part")
    innerCutter.Shape = Enum.PartType.Ball
    innerCutter.Size = Vector3.new(4.2, 4.2, 4.2)
    innerCutter.Position = Vector3.new(0, 1.5, 0)

    local topCutter = Instance.new("Part")
    topCutter.Size = Vector3.new(6, 2, 6)
    topCutter.Position = Vector3.new(0, 2.5, 0)

    local unioned, newParts = pcall(function()
        return GeometryService:SubtractAsync(outerSphere, {innerCutter, topCutter})
    end)

    -- Cleanup
    outerSphere:Destroy()
    innerCutter:Destroy()
    topCutter:Destroy()

    local resultUnion = Instance.new("UnionOperation")
    local success = unioned and newParts and newParts[1]

    if success then
        resultUnion = newParts[1]
        resultUnion.Name = "SinkBowl"
        resultUnion.Anchored = true
    end

    return success, resultUnion
end

function buildDrain(): Part
    local drain = Instance.new("Part")

    drain.Name = "Drain"
    drain.Shape = Enum.PartType.Cylinder
    drain.Size = Vector3.new(0.1, 0.8, 0.8)
    drain.CFrame = CFrame.new(0, -1.25, 0) * CFrame.Angles(0, 0, math.rad(90))
    drain.Color = Color3.fromRGB(30, 30, 30)
    drain.Material = Enum.Material.Metal
    drain.Anchored = true

    return drain
end

function buildFaucet(): Model
    local color = Color3.fromRGB(200,205,210)
    local material = Enum.Material.Metal

    local model = Instance.new("Model")
    model.Name = "Faucet"

    local base = Instance.new("Part")
    base.Name = "Base"
    base.Shape = Enum.PartType.Cylinder
    base.Size = Vector3.new(0.1, 0.9, 0.9)
    base.CFrame = CFrame.new(0, 1.55, -2.5) * CFrame.Angles(0, 0, math.rad(90))
    base.Color = color
    base.Material = material
    base.Anchored = true
    base.Parent = model

    local stem = Instance.new("Part")
    stem.Name = "Stem"
    stem.Shape = Enum.PartType.Cylinder
    stem.Size = Vector3.new(1.2, 0.4, 0.4)
    stem.CFrame = CFrame.new(0, 2.1, -2.5) * CFrame.Angles(0, 0, math.rad(90))
    stem.Color = color
    stem.Material = material
    stem.Anchored = true
    stem.Parent = model

    local neck = Instance.new("Part")
    neck.Name = "Neck"
    neck.Shape = Enum.PartType.Cylinder
    neck.Size = Vector3.new(1.4, 0.35, 0.35)
    neck.CFrame = CFrame.new(0, 2.6, -2.25) * CFrame.Angles(math.rad(45), 0, 0)
    neck.Color = color
    neck.Material = material
    neck.Anchored = true
    neck.Parent = model


    local spout = Instance.new("Attachment")
    spout.Name = "Spout"
    spout.Parent = neck

    local waterEmitter = Instance.new("ParticleEmitter")
    waterEmitter.Name = "WaterEmitter"
    waterEmitter.Enabled = false
    waterEmitter.EmissionDirection = Enum.NormalId.Back
    waterEmitter.Rate = 0
    waterEmitter.Speed = NumberRange.new(6, 7)
    waterEmitter.Lifetime = NumberRange.new(0.4, 0.5)
    waterEmitter.Size = NumberSequence.new(0.25)
    waterEmitter.Transparency = NumberSequence.new(0.3)
    waterEmitter.Color = ColorSequence.new(Color3.fromRGB(180, 220, 255))
    waterEmitter.Parent = spout

    local handleHot = Instance.new("Part")
    handleHot.Name = "HandleHot"
    handleHot.Shape = Enum.PartType.Cylinder
    handleHot.Size = Vector3.new(0.5, 0.5, 0.5)
    handleHot.CFrame = CFrame.new(-1, 1.75, -2.25) * CFrame.Angles(0, 0, math.rad(90))
    handleHot.Color = Color3.fromRGB(200, 60, 60)
    handleHot.Material = material
    handleHot.Anchored = true
    handleHot.Parent = model

    local handleCold = Instance.new("Part")
    handleCold.Name = "HandleCold"
    handleCold.Shape = Enum.PartType.Cylinder
    handleCold.Size = Vector3.new(0.5, 0.5, 0.5)
    handleCold.CFrame = CFrame.new(1, 1.75, -2.25) * CFrame.Angles(0, 0, math.rad(90))
    handleCold.Color = Color3.fromRGB(60, 120, 200)
    handleCold.Material = material
    handleCold.Anchored = true
    handleCold.Parent = model

    model.PrimaryPart = base
    weldToPrimary(model)
    FaucetLogic.AddHandleActions(handleCold, handleHot, waterEmitter)


    return model
end

function weldToPrimary(model: Model)
    local primary = model.PrimaryPart
    if not primary then return end

    for _, child in ipairs(model:GetChildren()) do
        if child:IsA("BasePart") and child ~= primary then
            local weld = Instance.new("WeldConstraint")
            weld.Name = child.Name .. "_Weld"
            weld.Part0 = primary
            weld.Part1 = child
            weld.Parent = primary
        end
    end
end

return SinkFactory