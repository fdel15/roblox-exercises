local LadderFactory = {}

type LadderConfig = {
    parent: Model,
    position: Vector3,
    size: Vector3,
}

type TrussConfig = {
    position: Vector3,
    size: Vector3
}

function newTruss(config: TrussConfig): TrussPart
    local truss = Instance.new("TrussPart")
    truss.Anchored = true
    truss.Name = "Truss"
    truss.Position = config.position
    truss.Size = config.size

    -- adjust position since by default half of the height
    -- is below the base plate
    local heightOffset = Vector3.new(0, (truss.Size.Y / 2), 0)
    truss.Position += heightOffset

    return truss
end

function LadderFactory.spawn(config: LadderConfig): TrussPart
    local model = Instance.new("Model")
    model.Name = "Ladder"

    local truss = newTruss(config)
    truss.Parent = model

    model.Parent = config.parent
    return truss
end

type RopeWallConfig = {
    parent: Model,
    position: Vector3,
    size: Vector3,
}

function LadderFactory.spawnRopeWall(config: RopeWallConfig): Part
    local model = Instance.new("Model")
    model.Name = "RopeWall"

    local height = config.size.Y

    local wall = Instance.new("Part")
    wall.Anchored = true
    wall.BrickColor = BrickColor.new("White")
    wall.Name = "Wall"
    wall.Parent = model
    wall.Position = Vector3.new(
        config.position.X,
        config.position.Y + (height / 2),
        config.position.Z
    )
    wall.Size = config.size

    local rope = Instance.new("Part")
    rope.Anchored = true
    rope.BrickColor = BrickColor.new("Black")
    rope.Orientation = Vector3.new(0, 0, 90)
    rope.Material = Enum.Material.Fabric
    rope.Name = "Rope"
    rope.Parent = model
    rope.Position = Vector3.new(
        config.position.X,
        config.position.Y + (height / 2),
        config.position.Z + (config.size.Z / 2) + 0.25
    )
    rope.Shape = "Cylinder"
    rope.Size = Vector3.new(height, height, 0.5)

    local truss = newTruss({
        position = Vector3.new(
            config.position.X,
            config.position.Y,
            config.position.Z + (config.size.Z / 2) - 0.5
        ),
        size = Vector3.new(0.5, height, 0.5)
    })

    -- truss.Orientation = Vector3.new(0, 0, 90)
    truss.Parent = model
    truss.Transparency = 1
    
    model.Parent = config.parent
    return wall
end

return LadderFactory