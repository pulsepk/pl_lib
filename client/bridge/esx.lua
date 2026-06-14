if PLLib.GetFramework() ~= 'esx' then return end

ESX = exports[PLLib.FrameworkResources.esx.resource][PLLib.FrameworkResources.esx.export]()

exports('GetPlayersInNearby', PLLib.Wrap('GetPlayersInNearby', function(coords, distance)
    return ESX.Game.GetPlayersInArea(coords, distance)
end))

exports('GetPlayerData', PLLib.Wrap('GetPlayerData', function()
    return ESX.GetPlayerData()
end))

exports('GetPlayerDataJob', PLLib.Wrap('GetPlayerDataJob', function()
    local data = ESX.GetPlayerData()
    return data and data.job
end))

exports('GetPlayerGender', PLLib.Wrap('GetPlayerGender', function()
    ESX.PlayerData = ESX.GetPlayerData()
    return ESX.PlayerData.sex == 'f' and 'female' or 'male'
end))

-- Employee management stubs for ESX
exports('GetEmployees',    PLLib.Wrap('GetEmployees',    function(_, cb)    cb({})            end))
exports('PromoteEmployee', PLLib.Wrap('PromoteEmployee', function(_, _, cb) if cb then cb() end end))
exports('DemoteEmployee',  PLLib.Wrap('DemoteEmployee',  function(_, _, cb) if cb then cb() end end))
exports('FireEmployee',    PLLib.Wrap('FireEmployee',    function(_, cb)    if cb then cb() end end))
exports('HireEmployee',    PLLib.Wrap('HireEmployee',    function(_, cb)    if cb then cb() end end))
exports('GetJobGrades',    PLLib.Wrap('GetJobGrades',    function(_)        return {}         end))
