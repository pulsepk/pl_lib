if PLLib.GetFramework() ~= 'qbox' then return end

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

exports('GetEmployees', function(jobname, cb)
    lib.callback('qbx_management:server:getEmployees', false, function(data)
        if not data then cb({}) return end
        local jobGrades = (QBCore.Shared.Jobs[jobname] or {}).grades or {}
        local list = {}
        for _, emp in ipairs(data) do
            local gradeInfo = jobGrades[emp.grade]
            list[#list + 1] = {
                identifier = emp.cid,
                name       = emp.name,
                grade      = emp.grade,
                gradeLabel = (gradeInfo and gradeInfo.name) or ('Grade ' .. emp.grade),
                online     = emp.onduty,
            }
        end
        cb(list)
    end, jobname, 'job')
end)

exports('PromoteEmployee', function(identifier, currentGrade, cb)
    lib.callback('qbx_management:server:updateGrade', false,
        function() if cb then cb() end end,
        identifier, currentGrade, currentGrade + 1, 'job')
end)

exports('DemoteEmployee', function(identifier, currentGrade, cb)
    lib.callback('qbx_management:server:updateGrade', false,
        function() if cb then cb() end end,
        identifier, currentGrade, currentGrade - 1, 'job')
end)

exports('FireEmployee', function(identifier, cb)
    lib.callback('qbx_management:server:fireEmployee', false,
        function() if cb then cb() end end,
        identifier, 'job')
end)

exports('HireEmployee', function(targetServerId, cb)
    lib.callback('qbx_management:server:hireEmployee', false,
        function() if cb then cb() end end,
        targetServerId, 'job')
end)

exports('GetJobGrades', function(jobname)
    local raw  = (QBCore.Shared.Jobs[jobname] or {}).grades or {}
    local keys = {}
    for k in pairs(raw) do keys[#keys + 1] = k end
    table.sort(keys)
    local grades = {}
    for _, k in ipairs(keys) do
        grades[#grades + 1] = { value = k, label = raw[k].name or ('Grade ' .. k) }
    end
    return grades
end)
