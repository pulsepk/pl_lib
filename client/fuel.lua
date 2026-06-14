local _system = PLLib.GetFuel()

-- SetVehicleFuel(vehicle, level)
-- level: 0-100 (float)
exports('SetVehicleFuel', PLLib.Wrap('SetVehicleFuel', function(vehicle, level)
    if _system == 'LegacyFuel' then
        exports['LegacyFuel']:SetFuel(vehicle, level)
    elseif _system == 'cdn-fuel' then
        exports['cdn-fuel']:SetFuel(vehicle, level)
    elseif _system == 'okokGasStation' then
        exports['okokGasStation']:SetFuel(vehicle, level)
    elseif _system == 'rcore_fuel' then
        exports['rcore_fuel']:AddVehicleFuelLiter(vehicle, level)
    elseif _system == 'ox_fuel' then
        Entity(vehicle).state.fuel = level
    end
end))
