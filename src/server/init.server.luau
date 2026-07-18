print("Hello world, from server!")

-- local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")

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

local tv2 = TvFactory.spawn({
    parent = Workspace,
    position = Vector3.new(20, 20, 0)
})

tv2.Anchored = true

-- local function manageScreen(screen: Part, i: number)
--     print("hello from " .. screen.Name .. i )
-- end

-- for i, screen in CollectionService:GetTagged("tvscreen") do
--     task.spawn(manageScreen, screen, i)
-- end