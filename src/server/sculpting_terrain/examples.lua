print("Hello world, from sculpting terrain!!")

local Workspace = game:GetService("Workspace")
local Terrain = Workspace.Terrain

local ServerScriptService = game:GetService("ServerScriptService")
local Server = ServerScriptService:WaitForChild("Server")
local ScupltingTerrain = Server:WaitForChild("sculpting_terrain")

local SimpleGrassRockBiomeScript = ScupltingTerrain:WaitForChild("simple_rock_grass_biome")

local SimpleBiome = require(SimpleGrassRockBiomeScript)

SimpleBiome.generate({
    terrain = Terrain,
})

--[[
    World building in a nutshell:

    1. Generate Terrain Voxel Geometry
    2. Analyze/Sample Generated Terrain
    3. Place Static & Dynamic Objects
]]

return {}