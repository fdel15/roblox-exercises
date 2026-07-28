local GeometryService = game:GetService("GeometryService")
local EngravingDetailFactory = {}

type EngravingDetailConfig = {
    parent: Model,
    cframe: CFrame,
    scale: number,
}

function EngravingDetailFactory.spawn(config: EngravingDetailConfig): Model
    local model = Instance.new("Model")
    model.Name = "EngravingDetail"

    -- FaceCenter + Penetration Depth
    local sq = Instance.new("Part")
    sq.Size = Vector3.new(50, 10, 50)
    sq.CFrame = CFrame.new(0,0,0)
    sq.Anchored = true

    local stepProfile = { -- top to bottom steps
        { diameter = 45, depth = 1 },
        { diameter = 40, depth = 2 },
        { diameter = 35, depth = 3 },
        { diameter = 30, depth = 4 },
        { diameter = 25, depth = 5 },
        { diameter = 20, depth = 6 },
    }

    -- based on sq block surface face since that is the part we are cutting into
    -- for block part type, if height is 5, the surface area we need to be above to cut into is 2.5
    local topSurfaceY = sq.Size.Y / 2
    local cutters = {}

    for _, step in ipairs(stepProfile) do
        local cutter = Instance.new("Part")
        cutter.Shape = Enum.PartType.Cylinder
        cutter.Anchored = true

        -- overhead ensures that the cylinder is above the top surface
        -- cutters need to be above the top surface and extend beneath it
        -- to work as expected
        local overhead = 1

        cutter.Size = Vector3.new(step.depth + overhead, step.diameter, step.diameter)

        local cutterY = topSurfaceY - (step.depth / 2)

        cutter.CFrame = CFrame.new(0, cutterY, 0) * CFrame.Angles(0, 0, math.rad(90))

        table.insert(cutters, cutter)
    end

    local s, newParts = pcall(function()
        return GeometryService:SubtractAsync(sq, cutters)
    end)

    if s and newParts and newParts[1] then
        local steps = newParts[1]
        steps.Name = "Steps"
        steps.Parent = model
        model.PrimaryPart = steps
    else
        warn("failed to build steps")
        warn(s)
        warn(newParts)
    end

    -- Cleanup
    sq:Destroy()
    for _, c in ipairs(cutters) do
        c:Destroy()
    end

    model:PivotTo(config.cframe)
    model:ScaleTo(config.scale)
    model.Parent = config.parent
    return model
end

return EngravingDetailFactory