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

return PropertyUtils