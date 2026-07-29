local GeometryService = game:GetService("GeometryService")
local ArchFactory = {}

type ArchConfig = {
    parent: Model,
    cframe: CFrame,
    scale: number,
}

function ArchFactory.spawn(config: ArchConfig): Model
    local model = Instance.new("Model")
    model.Name = "Arch"

    local outerwall = Instance.new("Part")
    outerwall.Anchored = true
    outerwall.Size = Vector3.new(27, 44, 4)

    local innerwall = Instance.new("Part")
    innerwall.Anchored = true
    innerwall.Size = Vector3.new(18,22,5)

    local cylinder = Instance.new("Part")
    cylinder.Anchored = true
    cylinder.CFrame = CFrame.new(0, 11, 0) * CFrame.Angles(0, math.rad(90), 0)
    cylinder.Shape = Enum.PartType.Cylinder
    cylinder.Size = Vector3.new(5, 19, 18)

    local unioned, newParts = pcall(function()
        return GeometryService:SubtractAsync(outerwall, {innerwall, cylinder})
    end)

    if unioned and newParts and newParts[1] then
        local arch = newParts[1]
        arch.Anchored = true
        arch.Name = "Archway"
        arch.Parent = model
    else
        warn("error creating arch")
        warn(unioned)
        warn(newParts)
    end

    -- Cleanup
    outerwall:Destroy()
    innerwall:Destroy()
    cylinder:Destroy()

    model:PivotTo(config.cframe)
    model:ScaleTo(config.scale)
    model.Parent = config.parent
    return model
end

return ArchFactory