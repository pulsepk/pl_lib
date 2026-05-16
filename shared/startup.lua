local isServer = IsDuplicityVersion()
local event    = isServer and 'onServerResourceStart' or 'onClientResourceStart'

local function dependsOnPlLib(name)
    local i = 0
    while true do
        local dep = GetResourceMetadata(name, 'dependency', i)
        if not dep then break end
        if dep == 'pl_lib' then return true end
        i = i + 1
    end
    return false
end

AddEventHandler(event, function(name)
    if not PLLib.Debug then return end
    if not dependsOnPlLib(name) then return end

    local tag = '^4[pl_lib → ' .. name .. '] ^7'

    if not PLLib.Debug then return end

    print(tag .. 'Framework  → ^2' .. (PLLib.GetFramework() or '^1none') .. '^7')

    if isServer then
        print(tag .. 'Society    → ^2' .. (PLLib.GetSociety()   or '^1none') .. '^7')
    else
        print(tag .. 'Target     → ^2' .. (PLLib.GetTarget()    or '^1none') .. '^7')
        print(tag .. 'TextUI     → ^2' .. (PLLib.GetTextUI()    or '^1none') .. '^7')
        print(tag .. 'Notify     → ^2' .. (PLLib.GetNotify()    or '^1none') .. '^7')
        print(tag .. 'Clothing   → ^2' .. (PLLib.GetClothing()  or '^1none') .. '^7')
        print(tag .. 'Dispatch   → ^2' .. (PLLib.GetDispatch()  or '^1none') .. '^7')
    end
end)
