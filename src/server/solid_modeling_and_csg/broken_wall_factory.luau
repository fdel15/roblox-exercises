local GeometryService = game:GetService("GeometryService")
local BrokenWallFactory = {}

type BrokenWallConfig = {
    parent: Model,
    cframe: CFrame,
    scale: number,
}

function BrokenWallFactory.spawn(config: BrokenWallConfig): Model
    local model = Instance.new("Model")
    model.Name = "BrokenWall"

    local wall = Instance.new("Part")
    wall.Anchored = true
    -- Note that we want y-axis to be half of y-size
    -- bc when roblox engine anchors block part, half will
    -- be below y-axis and half will be above y-axis
    wall.CFrame = CFrame.new(0, 17.5, 0)
    wall.Material = Enum.Material.Concrete
    wall.Name = "Wall"
    wall.Size = Vector3.new(60, 35, 4)
    wall.Parent = model

    local topCap = Instance.new("Part")
    topCap.Anchored = true
    topCap.Material = Enum.Material.Marble
    topCap.Name = "Top"
    topCap.Size = Vector3.new(1, 5, 60)
    topCap.CFrame = CFrame.new(0, 35.25, 0) * CFrame.Angles(0, math.rad(90), math.rad(90))
    topCap.Parent = model

    local leftCap = Instance.new("Part")
    leftCap.Anchored = true
    leftCap.Material = Enum.Material.Marble
    leftCap.Name = "Left"
    leftCap.CFrame = CFrame.new(-30.25, 18.25, 0)
    leftCap.Size = Vector3.new(5, 36.5, 5)
    leftCap.Parent = model

    local rightCap = leftCap:Clone()
    rightCap.CFrame = CFrame.new(30.25, 18.25, 0)
    rightCap.Name = "Right"
    rightCap.Parent = model

    local hole = buildHole()
    hole.Parent = model

    model.PrimaryPart = wall
    model:PivotTo(config.cframe)
    model:ScaleTo(config.scale)
    model.Parent = config.parent
    return model
end

function buildHole(): Model
    local model = Instance.new("Model")
    model.Name = "Hole"

    local base = {
        X = 0,
        Y = 20,
        Z = 1.05
    }

    local union = {}

    local blockParts = {
        {X = 4, Y = 2, Z = 0, angle = CFrame.Angles(0, 0, math.rad(30)), size = Vector3.new(10, 10, 2)},
        {X = -4, Y = 2, Z = 0, angle = CFrame.Angles(0, 0, math.rad(30)), size = Vector3.new(10, 10, 2)},
        {X = -4, Y = -2, Z = 0, angle = CFrame.Angles(0, 0, math.rad(-45)), size = Vector3.new(10, 10, 2)},
        {X = 4, Y = -4, Z = 0, angle = CFrame.Angles(0, 0, math.rad(-45)), size = Vector3.new(10, 10, 2)},
        {X = 0, Y = 0, Z = 0, angle = CFrame.Angles(0, 0, 0), size = Vector3.new(6, 20, 2)},
        {X = 0, Y = 0, Z = 0, angle = CFrame.Angles(0, 0, 0), size = Vector3.new(6, 20, 2)},
    }

    for _, part in ipairs(blockParts) do
        local block = Instance.new("Part")
        block.Anchored = true
        block.CFrame = CFrame.new(base.X + part.X, base.Y + part.Y, base.Z + part.Z) * part.angle
        block.Size = part.size
        table.insert(union, block)
    end

    local unioned, newParts = pcall(function()
        return GeometryService:UnionAsync(union[1], {table.unpack(union, 2)})
    end)

    if unioned and newParts and newParts[1] then
        local shape = newParts[1]
        shape.Material = Enum.Material.Brick
        shape.Name = "Shape"
        shape.Parent = model
    else
        warn("failed to create hole")
        warn(unioned)
        warn(newParts)
    end
    return model
end

return BrokenWallFactory