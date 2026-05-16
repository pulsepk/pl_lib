-- OpenStashInventory(stashName, opts)
-- opts: { weight (number), slots (number), label (string) }
exports('OpenStashInventory', function(stashName, opts)
    opts = opts or {}
    local weight = opts.weight or 80000
    local slots  = opts.slots  or 30
    local label  = opts.label  or stashName

    if GetResourceState('ox_inventory') == 'started' then
        exports.ox_inventory:openInventory('stash', stashName)

    elseif GetResourceState('qb-inventory') == 'started' then
        if PLLib.CheckDependency('qb-inventory', '2.0.0') then
            TriggerServerEvent('pl_lib:server:openQBStash', stashName)
        else
            TriggerEvent('inventory:client:SetCurrentStash', stashName)
            TriggerServerEvent('inventory:server:OpenInventory', 'stash', stashName, {
                maxweight = weight, slots = slots
            })
        end

    elseif GetResourceState('qs-inventory') == 'started' then
        TriggerEvent('inventory:client:SetCurrentStash', stashName)
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', stashName, {
            maxweight = weight, slots = slots
        })

    elseif GetResourceState('ps-inventory') == 'started' then
        TriggerEvent('ps-inventory:client:SetCurrentStash', stashName)
        TriggerServerEvent('ps-inventory:server:OpenInventory', 'stash', stashName, {
            maxweight = weight, slots = slots
        })

    elseif GetResourceState('codem-inventory') == 'started' then
        TriggerServerEvent('codem-inventory:server:openstash', stashName, slots, weight, stashName)

    elseif GetResourceState('tgiann-inventory') == 'started' then
        exports['tgiann-inventory']:OpenInventory('stash', stashName)

    elseif GetResourceState('origen_inventory') == 'started' then
        exports.origen_inventory:openInventory('stash', stashName)

    elseif GetResourceState('jaksam_inventory') == 'started' then
        exports['jaksam_inventory']:openInventory(stashName)
    end
end)

-- Server-side relay for qb-inventory stash opening (newer versions require a server call)
RegisterNetEvent('pl_lib:client:openQBStashResponse')
AddEventHandler('pl_lib:client:openQBStashResponse', function(stashName, data)
    exports['qb-inventory']:OpenInventory(stashName, data)
end)
