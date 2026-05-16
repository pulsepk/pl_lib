-- SetVehicleFuel(vehicle, level)
-- level: 0-100 (float)
exports('SetVehicleFuel', function(vehicle, level)
    if GetResourceState('LegacyFuel')     == 'started' then
        exports['LegacyFuel']:SetFuel(vehicle, level)
    elseif GetResourceState('cdn-fuel')   == 'started' then
        exports['cdn-fuel']:SetFuel(vehicle, level)
    elseif GetResourceState('okokGasStation') == 'started' then
        exports['okokGasStation']:SetFuel(vehicle, level)
    elseif GetResourceState('rcore_fuel') == 'started' then
        exports['rcore_fuel']:AddVehicleFuelLiter(vehicle, level)
    elseif GetResourceState('ox_fuel')    == 'started' then
        Entity(vehicle).state.fuel = level
    end
end)
