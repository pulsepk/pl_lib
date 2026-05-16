if PLLib.GetFramework() ~= 'esx' then return end

ESX = exports[PLLib.FrameworkResources.esx.resource][PLLib.FrameworkResources.esx.export]()

exports('GetPlayersInNearby', function(coords, distance)
    return ESX.Game.GetPlayersInArea(coords, distance)
end)

exports('GetPlayerData', function()
    return ESX.GetPlayerData()
end)

exports('GetPlayerDataJob', function()
    local data = ESX.GetPlayerData()
    return data and data.job
end)

exports('GetPlayerGender', function()
    ESX.PlayerData = ESX.GetPlayerData()
    return ESX.PlayerData.sex == 'f' and 'female' or 'male'
end)

-- Employee management stubs for ESX
exports('GetEmployees',      function(_, cb)          cb({})            end)
exports('PromoteEmployee',   function(_, _, cb)       if cb then cb() end end)
exports('DemoteEmployee',    function(_, _, cb)       if cb then cb() end end)
exports('FireEmployee',      function(_, cb)          if cb then cb() end end)
exports('HireEmployee',      function(_, cb)          if cb then cb() end end)
exports('GetJobGrades',      function(_)              return {}         end)
