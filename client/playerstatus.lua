local _fw = PLLib.GetFramework()

-- Lazy-init QB core object only when needed
local _qb
local function getQB()
    if not _qb then
        _qb = exports[PLLib.FrameworkResources.qb.resource][PLLib.FrameworkResources.qb.export]()
    end
    return _qb
end

-- GetPlayerStatus() → hunger (0–100), thirst (0–100)
-- Mirrors the server-side SetPlayerStatus scale so callers can use the same numbers.
exports('GetPlayerStatus', PLLib.Wrap('GetPlayerStatus', function()
    if _fw == 'qbox' or _fw == 'qb' then
        local data = getQB().Functions.GetPlayerData()
        if not data then return 0, 0 end
        local meta = data.metadata or {}
        return meta.hunger or 0, meta.thirst or 0

    elseif _fw == 'esx' then
        if GetResourceState('esx_status') ~= 'started' then return 0, 0 end
        local p = promise.new()
        TriggerEvent('esx_status:getStatuses', function(statuses)
            local hunger, thirst = 0, 0
            for _, s in ipairs(statuses) do
                -- esx_status uses a 0–1,000,000 scale; divide by 10,000 to get 0–100
                if s.name == 'food'  then hunger = math.floor(s.val / 10000) end
                if s.name == 'water' then thirst = math.floor(s.val / 10000) end
            end
            p:resolve({ hunger, thirst })
        end)
        local result = Citizen.Await(p)
        return result[1], result[2]
    end

    return 0, 0
end))
