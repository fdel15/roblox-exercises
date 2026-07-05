-- Create a crate

local CrateFactory = {}

type CrateOptions = {
    centerPosition: Vector3,
    parent: Instance,

    -- optional
    brickColor: BrickColor?,
    material: Enum.Material?,
    name: string?,
    scaleFactor: number?
}

-- Default values for crate options
local CrateDefaults = {
    brickColor = BrickColor.new("Burnt Sienna"),
    material = Enum.Material.Wood,
    name = "DefaultCrate",
    scaleFactor = 1
}

--[[
    SIZES and CFRAMEs
    The factory uses the same size every time it creates a new crate. 
    4 x 4 x 4 is used as Roblox standard best practice. 4 studs works well with Roblox engine while not being
    too small to nest pieces.
    
    We hard code the CFrame values for each part so that we only have to figure out how
    to align them once during development.

    We use scaleFactor to get different sized crates.
]]

local CRATE_SIZE = Vector3.new(4,4,4)
local CAP_SIZE   = Vector3.new(4.4, 0.4, 4.4)
local COL_SIZE = Vector3.new(0.4, 4, 0.4)

local function createStaticPart(name: string, size: Vector3, localCFrame: CFrame, basePart: Part, model: Model)
    local part = Instance.new("Part")
    part.Name = name
    part.Size = size
    part.CFrame = basePart.CFrame * localCFrame
    part.Material = Enum.Material.WoodPlanks
    part.BrickColor = BrickColor.new("Medium stone grey")
    part.TopSurface = Enum.SurfaceType.Smooth
    part.BottomSurface = Enum.SurfaceType.Smooth
    part.Anchored = true
    part.Parent = model
    return part
end

local function weldThenUnanchorParts(crate: Model, base: Part)
    for _, child in ipairs(crate:GetChildren()) do
        if child:IsA("BasePart") and child ~= base then
            local weld = Instance.new("WeldConstraint")
            weld.Name = child.Name .. "Weld"
            weld.Part0 = base
            weld.Part1 = child
            weld.Parent = child
            child.Anchored = false
        end
    end
end

function CrateFactory.spawnCrate(opts: CrateOptions): Model
    local crate = Instance.new("Model")

    crate.Parent = opts.parent
    crate.Name = opts.name or CrateDefaults.name

    -- base of the crate
    local base = Instance.new("Part")
    base.Anchored = true
    base.Name = "Base"
    crate.PrimaryPart = base

    base.Position = opts.centerPosition

    base.BrickColor = opts.brickColor or CrateDefaults.brickColor
    base.Material = opts.material or CrateDefaults.material
    base.Size = CRATE_SIZE

    base.Parent = crate

    -- Cap Dimensions
    createStaticPart("TopCap", CAP_SIZE, CFrame.new(0, 2.2, 0),  base, crate)
    createStaticPart("BottomCap", CAP_SIZE, CFrame.new(0, -2.2, 0), base, crate)

    -- Column Dimensions & Layout
    local colPos = 1.9 -- Hardcoded step-out vector
    
    createStaticPart("Column_FR", COL_SIZE, CFrame.new(colPos, 0, colPos),   base, crate)
    createStaticPart("Column_FL", COL_SIZE, CFrame.new(-colPos, 0, colPos),  base, crate)
    createStaticPart("Column_BR", COL_SIZE, CFrame.new(colPos, 0, -colPos),  base, crate)
    createStaticPart("Column_BL", COL_SIZE, CFrame.new(-colPos, 0, -colPos), base, crate)

    -- Scale
    local scaleFactor = opts.scaleFactor or CrateDefaults.scaleFactor
    if scaleFactor ~= 1 then
        crate:ScaleTo(scaleFactor)
    end
    
    weldThenUnanchorParts(crate, base)
    base.Anchored = false

    return crate
end

return CrateFactory