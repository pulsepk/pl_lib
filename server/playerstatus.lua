local function getQBPlayer(src)
    local fw = PLLib.GetFramework()
    if fw == 'qbox' then
        return exports.qbx_core:GetPlayer(src)
    elseif fw == 'qb' then
        return exports['qb-core']:GetCoreObject().Functions.GetPlayer(src)
    end
end

-- SetPlayerStatus(src, hunger, thirst)
-- hunger / thirst: points to ADD (0–100 scale). Pass 0 to skip either.
exports('SetPlayerStatus', PLLib.Wrap('SetPlayerStatus', function(src, hunger, thirst)
    hunger = hunger or 0
    thirst = thirst or 0

    local fw = PLLib.GetFramework()

    if fw == 'qbox' or fw == 'qb' then
        local Player = getQBPlayer(src)
        if not Player then return end
        local meta       = Player.PlayerData.metadata
        local newHunger  = math.min(100, (meta.hunger or 0) + hunger)
        local newThirst  = math.min(100, (meta.thirst or 0) + thirst)
        Player.Functions.SetMetaData('hunger', newHunger)
        Player.Functions.SetMetaData('thirst', newThirst)
        TriggerClientEvent('hud:client:UpdateNeeds', src, newHunger, newThirst)

    elseif fw == 'esx' then
        -- esx_status uses a 0–1,000,000 scale; multiply points by 10,000
        if hunger > 0 then
            TriggerClientEvent('esx_status:add', src, 'food',  hunger * 10000)
        end
        if thirst > 0 then
            TriggerClientEvent('esx_status:add', src, 'water', thirst * 10000)
        end
    end
end))
