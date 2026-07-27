print("Hello world, from getting started!!")

-- local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")
local Server = ServerScriptService:WaitForChild("Server")
local GettingStarted = Server:WaitForChild("getting_started")

local CrateFactoryScript = GettingStarted:WaitForChild("crate_factory")
local TvFactoryScript = GettingStarted:WaitForChild("tv_factory")
local LadderFactoryScript = GettingStarted:WaitForChild("ladder_factory")


local CrateFactory = require(CrateFactoryScript)
local TvFactory = require(TvFactoryScript)
local LadderFactory = require(LadderFactoryScript)

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

LadderFactory.spawn({
    parent = Workspace,
    position = Vector3.new(55,1,0),
    size = Vector3.new(2,20,2)
})

LadderFactory.spawnRopeWall({
    parent = Workspace,
    position = Vector3.new(65, 1, 0),
    size = Vector3.new(25, 25, 3)
})

-- local function manageScreen(screen: Part, i: number)
--     print("hello from " .. screen.Name .. i )
-- end

-- for i, screen in CollectionService:GetTagged("tvscreen") do
--     task.spawn(manageScreen, screen, i)
-- end

-- -75.343, 27.705, -35.512

local brightonLadder = LadderFactory.spawnRopeWall({
    parent = Workspace,
    position = Vector3.new(-80, 0, -14),
    size = Vector3.new(25, 75, 3)
})

brightonLadder.Parent:ScaleTo(2)
brightonLadder.Position = Vector3.new(-80, 0, -14)
return {}