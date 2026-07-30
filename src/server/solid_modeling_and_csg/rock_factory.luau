local GeometryService = game:GetService("GeometryService")
local RockFactory = {}

type RockConfig = {
    parent: Model,
    cframe: CFrame,
    scale: number,
}

function RockFactory.spawn(config: RockConfig): Model
    local model = Instance.new("Model")
    model.Name = "Rock"

    local base = Instance.new("Part")
    base.Anchored = true
    base.Material = Enum.Material.Slate
    base.Size = Vector3.new(20,40,20)
    -- base.Parent = model

    local baseBottom = base.CFrame.Y - (base.Size.Y / 2)
    local baseTop = base.CFrame.Y + (base.Size.Y / 2)

    local cutters = {}

    -- In theory we could spend time designing different chisel patterns and naming them
    -- This way we could create specific rock shapes by using a name for the pattern
    local chisels = {
        {shape = "Block", size = {20, 40, 5}, cframe = {0, baseBottom, 10}, angle = {0, math.rad(20), 0}},
        {shape = "Block", size = {20, 60, 5}, cframe = {10, baseBottom, 10}, angle = {0, math.rad(-20), 0}},
        {shape = "Cylinder", size = {20, 20, 15}, cframe = {-10, baseTop / 2, 10}, angle = {0, 0, math.rad(45)}},
        {shape = "Block", size = {20, 20, 7}, cframe = {-10, baseTop / 2, -10}, angle = {0, 0, math.rad(45)}},
        {shape = "Block", size = {20, 20, 10}, cframe = {0, baseTop, 0}, angle = {0, 0, math.rad(-45)}},
        {shape = "Ball", size = {30, 30, 30}, cframe = {0, baseTop, 10}, angle = {0, 0, 0}},
        {shape = "Block", size = {20, 60, 20}, cframe = {20, -10, 0}, angle = {0, 0, math.rad(30)}},
        {shape = "Wedge", size = {30, 30, 30}, cframe = {20, 0, 0}, angle = {0, 0, 0}},
        {shape = "Block", size = {20, 40, 20}, cframe = {16, 0, 0}, angle = {0, 0, 0}},
        {shape = "Ball", size = {30, 30, 30}, cframe = {0, baseTop, -10}, angle = {0, 0, 0}},
        {shape = "Ball", size = {50, 50, 50}, cframe = {-30, baseBottom + 15, 0}, angle = {0, 0, 0}},
        {shape = "Block", size = {20, 20, 20}, cframe = {0, baseTop, 0}, angle = {0, 0, math.rad(90)}},        
    }

    for _, c in ipairs(chisels) do
        local chisel = Instance.new("Part")
        chisel.Shape = Enum.PartType[c.shape]
        chisel.Size = Vector3.new(c.size[1], c.size[2], c.size[3])
        chisel.CFrame = CFrame.new(c.cframe[1], c.cframe[2], c.cframe[3]) * CFrame.Angles(c.angle[1], c.angle[2], c.angle[3])
        
        table.insert(cutters, chisel)
    end

    local unioned, newParts = pcall(function()
        return GeometryService:SubtractAsync(base, cutters)
    end)

    local rock = Instance.new("UnionOperation")

    if unioned and newParts and newParts[1] then
        rock = newParts[1]
        rock.Name = "Rock"
        rock.Parent = model
    else
        warn("failed to create rock")
        warn(unioned)
        warn(newParts)
    end

    model.PrimaryPart = rock
    model:ScaleTo(config.scale)

    local targetCFrame = CFrame.new(config.cframe.X, rock.Size.Y / 2, config.cframe.Y)
    model:PivotTo(targetCFrame)
    model.Parent = config.parent
    return model
end

return RockFactory