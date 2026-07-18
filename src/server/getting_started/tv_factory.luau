-- create TV

--[[
 ** NOTES **
   - scaling strategy is going to be different than crate_factory. We want z to stay
     at 0.25, and a 2:1 ration between x and y
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- local TvScreenLogicModule = ServerStorage:WaitForChild("tv_screen")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local PropertyUtilsScript = Shared:WaitForChild("property_utils")
local ServerStorageServer = ServerStorage:WaitForChild("Server")
local TvScreenScript = ServerStorageServer:WaitForChild("tv_screen")

local PropertyUtils = require(PropertyUtilsScript)
local ScreenLogic = require(TvScreenScript)


local TvFactory = {}

type TvConfig = {
    parent: Model,
    position: Vector3
}

local SCREEN_COLOR = Color3.new(159, 158, 161)

function createScreen(base: Part, parent: Instance): Part
    local screen = base:Clone()
    screen.Color = SCREEN_COLOR
    screen.CFrame = base.CFrame * CFrame.new(0, 0, 0.3)
    screen.Material = Enum.Material.Neon
    screen.Name = "Screen"
    screen.Parent = parent

    -- add surface light
    local sf = Instance.new("SurfaceLight")
    sf.Parent = screen
    sf.Enabled = true
    sf.Face = Enum.NormalId.Back
    sf.Brightness = 1
    sf.Color = Color3.new(255,255,255)
    sf.Range = 5
    sf.Shadows = true

    -- tag  object so we can use CollectionService to add script
    screen.AddTag(screen, "tvscreen")

    local channelDisplay = ScreenLogic.setupChannelDisplay(screen)
    ScreenLogic.AddOnOff(screen, parent, channelDisplay)

    return screen
end

function TvFactory.spawn(config: TvConfig): Model
    local model = Instance.new("Model")
    model.Name = "TV"

    -- create base
    local base = Instance.new("Part")
    base.Anchored = true
    base.BrickColor = BrickColor.new("Black")
    base.Name = "Base"
    base.Parent = model
    base.Position = config.position
    base.Size = Vector3.new(12,6,0.25)

    -- create Screen
    createScreen(base, model)

    -- create frame around base
    local verticalFrameL = Instance.new("Part")
    verticalFrameL.Anchored = true
    verticalFrameL.BrickColor = BrickColor.new("Black")
    verticalFrameL.Material = Enum.Material.SmoothPlastic
    verticalFrameL.Name = "Left"
    verticalFrameL.Parent = model
    verticalFrameL.Size = Vector3.new(0.5, 6.5, 0.5)
    verticalFrameL.CFrame = base.CFrame * CFrame.new(6, 0, 0.2)

    local verticalFrameR = verticalFrameL:Clone()
    verticalFrameR.Name = "Right"
    verticalFrameR.CFrame = base.CFrame * CFrame.new(-6, 0, 0.2)
    verticalFrameR.Parent = model

    local horizontalFrameT = verticalFrameL:Clone()
    horizontalFrameT.Name = "Top"
    horizontalFrameT.Size = Vector3.new(12.5, 0.5, 0.5)
    horizontalFrameT.CFrame = base.CFrame * CFrame.new(0, 3, 0.2)
    horizontalFrameT.Parent = model

    local horizontalFrameB = horizontalFrameT:Clone()
    horizontalFrameB.Name = "Bottom"
    horizontalFrameB.CFrame = base.CFrame * CFrame.new(0, -3, 0.2)
    horizontalFrameB.Parent = model

    -- Create anchor in the back so it can hang from walls
    local anchorPlate = verticalFrameR:Clone()
    anchorPlate.CFrame = base.CFrame * CFrame.new(0, 0, -0.25)
    anchorPlate.Parent = model
    anchorPlate.Size = Vector3.new(1,1,0.25)

    -- on/off button
    local powerButton = Instance.new("Part")
    
    powerButton.BrickColor = BrickColor.new("Crimson")
    powerButton.CFrame = base.CFrame * CFrame.new(5, -3, 0.4)
    powerButton.Material = Enum.Material.Neon
    powerButton.Name = "PowerButton"
    powerButton.Size = Vector3.new(0.5, 0.3, 0.2)
    powerButton.Parent = model

    PropertyUtils.WeldFrameToBase(model, base)

    model.PrimaryPart = base
    model.Parent = config.parent
    return base
end

return TvFactory