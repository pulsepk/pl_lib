if PLLib.GetFramework() ~= 'qb' then return end

local QBCore = exports[PLLib.FrameworkResources.qb.resource][PLLib.FrameworkResources.qb.export]()

exports('GetPlayersInNearby', PLLib.Wrap('GetPlayersInNearby', function(coords, distance)
    return QBCore.Functions.GetPlayersFromCoords(coords, distance)
end))

exports('GetPlayerData', PLLib.Wrap('GetPlayerData', function()
    return QBCore.Functions.GetPlayerData()
end))

exports('GetPlayerDataJob', PLLib.Wrap('GetPlayerDataJob', function()
    return QBCore.Functions.GetPlayerData().job
end))

exports('GetPlayerGender', PLLib.Wrap('GetPlayerGender', function()
    local data = QBCore.Functions.GetPlayerData()
    return data.charinfo.gender == 1 and 'female' or 'male'
end))

-- Employee management is not implemented for plain QBCore
exports('GetEmployees',    PLLib.Wrap('GetEmployees',    function(_, cb)    cb({})            end))
exports('PromoteEmployee', PLLib.Wrap('PromoteEmployee', function(_, _, cb) if cb then cb() end end))
exports('DemoteEmployee',  PLLib.Wrap('DemoteEmployee',  function(_, _, cb) if cb then cb() end end))
exports('FireEmployee',    PLLib.Wrap('FireEmployee',    function(_, cb)    if cb then cb() end end))
exports('HireEmployee',    PLLib.Wrap('HireEmployee',    function(_, cb)    if cb then cb() end end))
exports('GetJobGrades',    PLLib.Wrap('GetJobGrades',    function(_)        return {}         end))
