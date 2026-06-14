local _inventory = PLLib.GetInventory()

-- OpenStashInventory(stashName, opts)
-- opts: { weight (number), slots (number), label (string) }
exports('OpenStashInventory', PLLib.Wrap('OpenStashInventory', function(stashName, opts)
    opts = opts or {}
    local weight = opts.weight or 80000
    local slots  = opts.slots  or 30
    local label  = opts.label  or stashName

    if _inventory == 'ox_inventory' then
        exports.ox_inventory:openInventory('stash', stashName)

    elseif _inventory == 'qb-inventory' then
        if PLLib.CheckDependency('qb-inventory', '2.0.0') then
            TriggerServerEvent('pl_lib:server:openQBStash', stashName)
        else
            TriggerEvent('inventory:client:SetCurrentStash', stashName)
            TriggerServerEvent('inventory:server:OpenInventory', 'stash', stashName, {
                maxweight = weight, slots = slots
            })
        end

    elseif _inventory == 'qs-inventory' then
        TriggerEvent('inventory:client:SetCurrentStash', stashName)
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', stashName, {
            maxweight = weight, slots = slots
        })

    elseif _inventory == 'ps-inventory' then
        TriggerEvent('ps-inventory:client:SetCurrentStash', stashName)
        TriggerServerEvent('ps-inventory:server:OpenInventory', 'stash', stashName, {
            maxweight = weight, slots = slots
        })

    elseif _inventory == 'codem-inventory' then
        TriggerServerEvent('codem-inventory:server:openstash', stashName, slots, weight, stashName)

    elseif _inventory == 'tgiann-inventory' then
        exports['tgiann-inventory']:OpenInventory('stash', stashName)

    elseif _inventory == 'origen_inventory' then
        exports.origen_inventory:openInventory('stash', stashName)

    elseif _inventory == 'jaksam_inventory' then
        exports['jaksam_inventory']:openInventory(stashName)
    end
end))

-- Server-side relay for qb-inventory stash opening (newer versions require a server call)
RegisterNetEvent('pl_lib:client:openQBStashResponse')
AddEventHandler('pl_lib:client:openQBStashResponse', function(stashName, data)
    exports['qb-inventory']:OpenInventory(stashName, data)
end)
