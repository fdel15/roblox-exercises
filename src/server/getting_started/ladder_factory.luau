local LadderFactory = {}

type LadderConfig = {
    parent: Model,
    position: Vector3,
    size: Vector3,
}

function LadderFactory.spawn(config: LadderConfig): TrussPart
    local model = Instance.new("Model")
    model.Name = "Ladder"

    local truss = Instance.new("TrussPart")
    truss.Anchored = true
    truss.Name = "Truss"
    truss.Parent = model
    truss.Position = config.position
    truss.Size = config.size

    -- adjust position since by default half of the height
    -- is below the base plate
    local heightOffset = Vector3.new(0, (truss.Size.Y / 2), 0)
    truss.Position += heightOffset

    model.Parent = config.parent
    return truss
end

return LadderFactory