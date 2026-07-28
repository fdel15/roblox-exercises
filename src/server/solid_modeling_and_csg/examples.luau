print("Hello world, from solid modeling and CSG!!")

local Workspace = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")
local Server = ServerScriptService:WaitForChild("Server")
local SolidModelingAndCSG = Server:WaitForChild("solid_modeling_and_csg")

local CerealBowlFactoryScript = SolidModelingAndCSG:WaitForChild("cereal_bowl_factory")
local SinkFactoryScript = SolidModelingAndCSG:WaitForChild("sink_factory")
local EngravingDetailScript = SolidModelingAndCSG:WaitForChild("engraving_detail_factory")

local CerealBowlFactory = require(CerealBowlFactoryScript)
local SinkFactory = require(SinkFactoryScript)
local EngravingDetailFactory = require(EngravingDetailScript)

-- SinkFactory.spawn({
--     cframe = CFrame.new(10,3,0),
--     parent = Workspace,
--     scale = 1
-- })

-- CerealBowlFactory.spawn({
--     parent = Workspace,
--     cframe = CFrame.new(-10, 3, 0),
--     scale = 1,
-- })

EngravingDetailFactory.spawn({
    parent = Workspace,
    cframe = CFrame.new(0, 10, 0),
    scale  = 1,
})

return {}