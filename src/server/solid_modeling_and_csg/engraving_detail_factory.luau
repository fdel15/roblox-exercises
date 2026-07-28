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
    sq.Size = Vector3.new(50, 5, 50)
    sq.CFrame = CFrame.new(0,0,0)
    sq.Anchored = true

    local disc = Instance.new("Part")
    disc.Shape = Enum.PartType.Cylinder
    disc.Anchored = true
    disc.Size = Vector3.new(1, 33, 33)
    disc.CFrame = CFrame.new(0, 2, 0) * CFrame.Angles(0, 0, math.rad(90))

    local disc2 = disc:Clone()
    disc2.Size = Vector3.new(1, 35, 34)
    disc2.CFrame = CFrame.new(0, 2.5, 0) * CFrame.Angles(0, 0, math.rad(90))

    local disc3 = disc2:Clone()
    disc3.Size = Vector3.new(2, 36, 35)
    disc3.CFrame = CFrame.new(0, 3.25, 0) * CFrame.Angles(0, 0, math.rad(90))

    local s, newParts = pcall(function()
        return GeometryService:SubtractAsync(sq, {disc, disc2, disc3})
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
    disc:Destroy()
    disc2:Destroy()
    disc3:Destroy()

    model:PivotTo(config.cframe)
    model:ScaleTo(config.scale * 0.5)
    model.Parent = config.parent
    return model
end

return EngravingDetailFactory