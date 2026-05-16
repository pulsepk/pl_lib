if PLLib.GetFramework() ~= 'qb' then return end

local QBCore = exports[PLLib.FrameworkResources.qb.resource][PLLib.FrameworkResources.qb.export]()

exports('GetPlayersInNearby', function(coords, distance)
    return QBCore.Functions.GetPlayersFromCoords(coords, distance)
end)

exports('GetPlayerData', function()
    return QBCore.Functions.GetPlayerData()
end)

exports('GetPlayerDataJob', function()
    return QBCore.Functions.GetPlayerData().job
end)

exports('GetPlayerGender', function()
    local data = QBCore.Functions.GetPlayerData()
    return data.charinfo.gender == 1 and 'female' or 'male'
end)

-- Employee management is not implemented for plain QBCore
exports('GetEmployees',      function(_, cb)          cb({})            end)
exports('PromoteEmployee',   function(_, _, cb)       if cb then cb() end end)
exports('DemoteEmployee',    function(_, _, cb)       if cb then cb() end end)
exports('FireEmployee',      function(_, cb)          if cb then cb() end end)
exports('HireEmployee',      function(_, cb)          if cb then cb() end end)
exports('GetJobGrades',      function(_)              return {}         end)
