PropertyUtils = {}

local CoreProperties = {
    "Anchored",
    "BrickColor",
    "CFrame",
    "Material",
    "Name",
    "Parent",
    "Size",
}

function PropertyUtils.CloneProperties(copyTo: Instance, copyFrom: Instance): Instance
    for _, prop in ipairs(CoreProperties) do
        copyTo[prop] = copyFrom[prop]
    end
    return copyTo
end

function PropertyUtils.WeldFrameToBase(model: Model, base: Part)
    for _, child in ipairs(model:GetChildren()) do
        if child:IsA("BasePart") then
            child.Anchored = false

            if child ~= base then
                local weld = Instance.new("WeldConstraint")
                weld.Part0 = base
                weld.Part1 = child
                weld.Name = child.Name .. "Weld"
                weld.Parent = child
            end
        end
    end
end

return PropertyUtils