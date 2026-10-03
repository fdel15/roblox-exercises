local Biome = {}

type BiomeConfig = {
    terrain: Terrain,
    seed: number?,
    size: number?,
    resolution: number?,
    maxHeight: number?,
    frequency: number?,
}

local defaults = {
    size = 256,
    resolution = 4,
    frequency = 0.015,
    maxHeight = 50,
}

local rock = Enum.Material.Rock
local grass = Enum.Material.Grass
local snow = Enum.Material.Snow


function Biome.generate(config: BiomeConfig)
    local mapConfig = {
        terrain = config.terrain,
        size = config.size or defaults.size,
        resolution = config.resolution or defaults.resolution,
        frequency = config.frequency or defaults.frequency,
        maxHeight = config.maxHeight or defaults.maxHeight,
        seed = config.seed or math.random(1, 999999)
    }

    config.terrain:Clear()

    heightMap(mapConfig)
end

type MapConfig = {
    terrain: Terrain,
    seed: number,
    size: number,
    resolution: number,
    frequency: number,
    maxHeight: number,
}

function heightMap(config: MapConfig)
    local terrain = config.terrain
    local halfMap = config.size / 2
    local resolution = config.resolution
    local frequency = config.frequency
    local maxHeight = config.maxHeight
    local seed = config.seed

    print("--------------------------------")
    print("HEIGHT MAP GENERATED WITH SEED: ", seed)
    print("--------------------------------")

    for x = -halfMap, halfMap, resolution do
        for z = -halfMap, halfMap, resolution do
            local noiseVal = math.noise(
                (x + seed) * frequency, 0, (z + seed) * frequency
            )

            local height = math.floor(
                (noiseVal + 1) * 0.5 * maxHeight
            )

            if height > 0 then
                local material = grass
                if height > 20 then material = rock end
                if height > 28 then material = snow end
                local cframe = CFrame.new(x, height/2, z)
                local size = Vector3.new(resolution, height, resolution)

                terrain:FillBlock(cframe, size, material)
            end
        end
    end
end

function moistureMap(config: MapConfig)
end

return Biome