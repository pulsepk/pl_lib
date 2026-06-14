local _system = PLLib.GetKeys()

-- GiveVehicleKeys(vehicle) — grants keys to the local player for the given vehicle entity
exports('GiveVehicleKeys', PLLib.Wrap('GiveVehicleKeys', function(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))

    if _system == 'qb-vehiclekeys' then
        TriggerEvent('vehiclekeys:client:SetOwner', plate)
    elseif _system == 'wasabi_carlock' then
        exports.wasabi_carlock:GiveKey(plate)
    elseif _system == 'qs-vehiclekeys' then
        exports['qs-vehiclekeys']:GiveKeys(plate, model, true)
    elseif _system == 'vehicles_keys' then
        TriggerServerEvent('vehicles_keys:selfGiveVehicleKeys', plate)
    end
    -- add additional key systems here as needed
end))
