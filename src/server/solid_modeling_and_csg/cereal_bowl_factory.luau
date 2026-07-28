local GeometryService = game:GetService("GeometryService")
local CerealBowlFactory = {}

type CerealBowlConfig = {
    parent: Model,
    cframe: CFrame,
    scale: number,
}

function CerealBowlFactory.spawn(config: CerealBowlConfig): Model
    local model = Instance.new("Model")
    model.Name = "CerealBowl"
    
    -- Bowl
    local success, bowl = buildBowl()
    if not success then return model end

    -- Milk filling
    local milk = buildMilk()
    
    -- cereal Os
    local cereal = buildCereal()

    bowl.Parent = model
    milk.Parent = model
    cereal.Parent = model

    model.PrimaryPart = bowl
    model:PivotTo(config.cframe)
    model:ScaleTo(config.scale * 0.35)
    model.Parent = config.parent
    return model
end

function buildBowl(): (boolean, UnionOperation)
    local outside = Instance.new("Part")
    outside.Shape = Enum.PartType.Ball
    outside.Size = Vector3.new(4, 4, 4)
    outside.Position = Vector3.zero

    local inside = Instance.new("Part")
    inside.Shape = Enum.PartType.Ball
    inside.Size = Vector3.new(3.5, 3.5, 3.5)
    inside.Position = Vector3.zero

    -- Hollows inside of outside sphere
    local unioned, newParts = pcall(function()
        return GeometryService:SubtractAsync(outside, {inside})
    end)

    local sphere = Instance.new("UnionOperation")
    local success = unioned and newParts and newParts[1]

    if success then
        sphere = newParts[1]
        s1phere.Anchored = true
    else
        warn("failed build sphere: ")
        warn(newParts)
    end

    local cutter = Instance.new("Part")
    cutter.Shape = Enum.PartType.Block
    cutter.Size  = Vector3.new(4,4,4)
    cutter.Position = Vector3.new(0, 2, 0)

    local unioned, bowlParts = pcall(function()
        return GeometryService:SubtractAsync(sphere, {cutter})
    end)

    local bowl = Instance.new("UnionOperation")
    local success = unioned and bowlParts and bowlParts[1]

    if success then
        bowl = bowlParts[1]
        bowl.Name = "Bowl"
        bowl.Anchored = true
    else
        warn("failed build bowl: ")
        warn(newParts)
    end

    -- Cleanup
    cutter:Destroy()
    outside:Destroy()
    inside:Destroy()
    sphere:Destroy()

    return success, bowl
end

function buildMilk(): Part
    local milk = Instance.new("Part")
    milk.Name = "Milk"
    milk.Color = Color3.fromRGB(255, 255, 255)
    milk.Material = Enum.Material.SmoothPlastic
    milk.Shape = Enum.PartType.Cylinder
    milk.Size  = Vector3.new(0, 3.5, 3.5)
    milk.CFrame = CFrame.new(0, -0.25, 0) * CFrame.Angles(0, 0, math.rad(90))
    milk.Anchored = true

    return milk
end

function buildCereal(): Model
    local model = Instance.new("Model")
    model.Name = "Cereal"

    local outside = Instance.new("Part")
    outside.Shape = Enum.PartType.Cylinder
    outside.Size = Vector3.new(0.5, 3, 3)
    outside.Position = Vector3.zero
    outside.Color = Color3.fromRGB(198, 148, 0)

    local inside = outside:Clone()
    inside.Size = Vector3.new(2, 1.5, 1.5)
    inside.Position = Vector3.zero

    -- Hollows inside of outside sphere
    local unioned, newParts = pcall(function()
        return GeometryService:SubtractAsync(outside, {inside})
    end)

    local piece = Instance.new("UnionOperation")
    local success = unioned and newParts and newParts[1]

    if success then
        piece = newParts[1]
        piece.Anchored = true
        piece.Size = Vector3.new(0.05, 0.3, 0.3)

        local number_of_pieces = 25

        for i = 1, number_of_pieces do
            local p = piece:Clone()
            p.Name = string.format("Piece%02d", i)
            p.CFrame = cerealPieceCFrame()
            p.Parent = model
        end
    else
        warn("failed to build cereal")
        warn(newParts)
    end

    return model
end

function cerealPieceCFrame(): CFrame
    local x = math.random() * direction()
    local z = math.random() * direction()
    local a = 90 + (math.random(10,20) * direction())
    return CFrame.new(x, -0.25, z) * CFrame.Angles(0, 0, math.rad(a))
end

function direction(): number
    local n = math.random(1,2) == 1 and 1 or -1
    return n
end

return CerealBowlFactory