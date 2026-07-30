print("Hello world, from solid modeling and CSG!!")

local Workspace = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")
local Server = ServerScriptService:WaitForChild("Server")
local SolidModelingAndCSG = Server:WaitForChild("solid_modeling_and_csg")

local ArchFactoryScript = SolidModelingAndCSG:WaitForChild("arch_factory")
local BrokenWallFactoryScript = SolidModelingAndCSG:WaitForChild("broken_wall_factory")
local CerealBowlFactoryScript = SolidModelingAndCSG:WaitForChild("cereal_bowl_factory")
local EngravingDetailScript = SolidModelingAndCSG:WaitForChild("engraving_detail_factory")
local RockFactoryScript = SolidModelingAndCSG:WaitForChild("rock_factory")
local SinkFactoryScript = SolidModelingAndCSG:WaitForChild("sink_factory")

local ArchFactory = require(ArchFactoryScript)
local BrokenWallFactory = require(BrokenWallFactoryScript)
local CerealBowlFactory = require(CerealBowlFactoryScript)
local EngravingDetailFactory = require(EngravingDetailScript)
local RockFactory = require(RockFactoryScript)
local SinkFactory = require(SinkFactoryScript)

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

-- EngravingDetailFactory.spawn({
--     parent = Workspace,
--     cframe = CFrame.new(0, 10, 0),
--     scale  = 1,
-- })

-- ArchFactory.spawn({
--     parent = Workspace,
--     cframe = CFrame.new(0, 10, 0),
--     scale = 1,
-- })

-- BrokenWallFactory.spawn({
--     parent = Workspace,
--     cframe = CFrame.new(0, 10, 0),
--     scale = 1,
-- })

RockFactory.spawn({
    parent = Workspace,
    cframe = CFrame.new(0, 0, 0),
    scale = 1,
})

return {}