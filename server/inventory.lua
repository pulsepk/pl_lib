local _inventory = PLLib.GetInventory()

-- RegisterUsableItem(name, cb) — cb(src, item) fires when a player uses the item
exports('RegisterUsableItem', PLLib.Wrap('RegisterUsableItem', function(name, cb)
    local fw = PLLib.GetFramework()

    if fw == 'qbox' then
        exports.qbx_core:CreateUseableItem(name, function(src, item)
            cb(src, item)
        end)
    elseif fw == 'qb' then
        exports['qb-core']:GetCoreObject().Functions.CreateUseableItem(name, function(src, item)
            cb(src, item)
        end)
    elseif fw == 'esx' then
        exports.es_extended:getSharedObject().RegisterUsableItem(name, function(src, item)
            cb(src, item)
        end)
    else
        print('[pl_lib] RegisterUsableItem: unknown framework for item ' .. name)
    end
end))

-- qb-inventory stash relay (needed for newer qb-inventory versions that require a server-side open)
RegisterNetEvent('pl_lib:server:openQBStash')
AddEventHandler('pl_lib:server:openQBStash', function(stashName)
    local src = source
    -- The calling script is responsible for registering/configuring the stash.
    -- We just relay the open call back to the client.
    TriggerClientEvent('pl_lib:client:openQBStashResponse', src, stashName, {})
end)

-- AddItem(src, item, amount) → true on success, false on failure
exports('AddItem', PLLib.Wrap('AddItem', function(src, item, amount)
    if _inventory == 'ox_inventory' then
        return exports.ox_inventory:AddItem(src, item, amount, false) ~= false

    elseif _inventory == 'qb-inventory' then
        if PLLib.CheckDependency('qb-inventory', '2.0.0') then
            return exports['qb-inventory']:AddItem(src, item, amount, false, false) ~= false
        else
            local p = exports['qb-core']:GetCoreObject().Functions.GetPlayer(src)
            return p and p.Functions.AddItem(item, amount) ~= false
        end

    elseif _inventory == 'codem-inventory' then
        return exports['codem-inventory']:AddItem(src, item, amount) ~= false

    elseif _inventory == 'qs-inventory' then
        return exports['qs-inventory']:AddItem(src, item, amount) ~= false

    elseif _inventory == 'ps-inventory' then
        return exports['ps-inventory']:AddItem(src, item, amount, false, false) ~= false

    elseif _inventory == 'tgiann-inventory' then
        return exports['tgiann-inventory']:AddItem(src, item, amount) ~= false

    elseif _inventory == 'origen_inventory' then
        return exports.origen_inventory:addItem(src, item, amount) ~= false

    elseif _inventory == 'jaksam_inventory' then
        return exports['jaksam_inventory']:addItem(src, item, amount) ~= false

    elseif _inventory == 'core_inventory' then
        return exports['core_inventory']:addItem(src, item, amount) ~= false
    end

    print('[pl_lib] AddItem: no inventory resource found')
    return false
end))

-- RemoveItem(src, item, amount) → true on success, false on failure
exports('RemoveItem', PLLib.Wrap('RemoveItem', function(src, item, amount)
    if _inventory == 'ox_inventory' then
        return exports.ox_inventory:RemoveItem(src, item, amount, false) ~= false

    elseif _inventory == 'qb-inventory' then
        if PLLib.CheckDependency('qb-inventory', '2.0.0') then
            return exports['qb-inventory']:RemoveItem(src, item, amount, false, false) ~= false
        else
            local p = exports['qb-core']:GetCoreObject().Functions.GetPlayer(src)
            return p and p.Functions.RemoveItem(item, amount) ~= false
        end

    elseif _inventory == 'codem-inventory' then
        return exports['codem-inventory']:RemoveItem(src, item, amount) ~= false

    elseif _inventory == 'qs-inventory' then
        return exports['qs-inventory']:RemoveItem(src, item, amount) ~= false

    elseif _inventory == 'ps-inventory' then
        return exports['ps-inventory']:RemoveItem(src, item, amount, false, false) ~= false

    elseif _inventory == 'tgiann-inventory' then
        return exports['tgiann-inventory']:RemoveItem(src, item, amount) ~= false

    elseif _inventory == 'origen_inventory' then
        return exports.origen_inventory:RemoveItem(src, item, amount) ~= false

    elseif _inventory == 'jaksam_inventory' then
        return exports['jaksam_inventory']:removeItem(src, item, amount) ~= false

    elseif _inventory == 'core_inventory' then
        return exports['core_inventory']:removeItem(src, item, amount) ~= false
    end

    print('[pl_lib] RemoveItem: no inventory resource found')
    return false
end))

-- HasItem(src, item) → item count (number), or 0 if not found
exports('HasItem', PLLib.Wrap('HasItem', function(src, item)
    if _inventory == 'ox_inventory' then
        return exports.ox_inventory:GetItem(src, item, nil, true) or 0

    elseif _inventory == 'qb-inventory' then
        local p = exports['qb-core']:GetCoreObject().Functions.GetPlayer(src)
        return p and (p.Functions.GetItemByName(item)?.amount or 0) or 0

    elseif _inventory == 'esx_inventory' then
        local xp = ESX and ESX.GetPlayerFromId(src)
        return xp and (xp.getInventoryItem(item)?.count or 0) or 0

    elseif _inventory == 'qs-inventory' then
        return exports['qs-inventory']:GetItemTotalAmount(src, item) or 0

    elseif _inventory == 'codem-inventory' then
        return exports['codem-inventory']:GetItemsTotalAmount(src, item) or 0

    elseif _inventory == 'ps-inventory' then
        return exports['ps-inventory']:GetItemByName(src, item) or 0

    elseif _inventory == 'tgiann-inventory' then
        return exports['tgiann-inventory']:GetItem(src, item, false, true) or 0

    elseif _inventory == 'origen_inventory' then
        return exports.origen_inventory:getItemCount(src, item, false, false) or 0

    elseif _inventory == 'jaksam_inventory' then
        local slot = exports['jaksam_inventory']:getItemByName(src, item)
        return slot and slot.amount or 0

    elseif _inventory == 'core_inventory' then
        return exports['core_inventory']:hasItem(src, item, 1) and 1 or 0
    end

    print('[pl_lib] HasItem: no inventory resource found')
    return 0
end))
