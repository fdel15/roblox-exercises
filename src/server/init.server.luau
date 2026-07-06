print("Hello world, from server!")

-- local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")

local CrateFactory = require(script.getting_started.crate_factory)
local TvFactory = require(script.getting_started.tv_factory)

CrateFactory.spawnCrate({
    centerPosition = Vector3.new(10, 2.4, 0),
    parent = Workspace,
})

CrateFactory.spawnCrate({
    centerPosition = Vector3.new(30, 2.4, 0),
    parent = Workspace,
    scaleFactor = 5,
    name = "GiantCrate",
    lightWeight = true,
    material = Enum.Material.SmoothPlastic,
})

CrateFactory.spawnCrate({
    centerPosition = Vector3.new(-10, 2.4, 0),
    parent = Workspace,
    name = "DynamicCrate",
    scaleFactor = 2,
    lightWeight = true,
})

CrateFactory.spawnCrate({
    centerPosition = Vector3.new(-20, 2.4, 0),
    parent = Workspace,
    name = "TinyCrate",
    scaleFactor = 0.5,
})

local tv = TvFactory.spawn({
    parent = Workspace,
    position = Vector3.new(10, 10, 0)
})

tv.Anchored = true