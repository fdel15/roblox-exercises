print("Hello world, from solid modeling and CSG!!")

local Workspace = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")
local Server = ServerScriptService:WaitForChild("Server")
local SolidModelingAndCSG = Server:WaitForChild("solid_modeling_and_csg")

local SinkFactoryScript = SolidModelingAndCSG:WaitForChild("sink_factory")

local SinkFactory = require(SinkFactoryScript)

SinkFactory.spawn({
    cframe = CFrame.new(10,6,0),
    parent = Workspace,
})


return {}