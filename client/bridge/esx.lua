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

-- Employee management — requires esx_society.
-- All grade/hire/fire actions route through esx_society:setJob which validates
-- boss status server-side and sends the appropriate in-game notifications.

exports('GetEmployees', PLLib.Wrap('GetEmployees', function(jobname, cb)
    if GetResourceState('esx_society') ~= 'started' then cb({}) return end
    ESX.TriggerServerCallback('esx_society:getEmployees', function(employees)
        local list = {}
        for _, emp in ipairs(employees or {}) do
            local job = emp.job or {}
            list[#list + 1] = {
                identifier = emp.identifier,
                name       = emp.name,
                grade      = job.grade,
                gradeLabel = job.grade_label or job.grade_name or ('Grade ' .. tostring(job.grade)),
                online     = false, -- esx_society merges online+offline in one list, can't distinguish
            }
        end
        cb(list)
    end, jobname)
end))

exports('PromoteEmployee', PLLib.Wrap('PromoteEmployee', function(identifier, currentGrade, cb)
    local jobname = ESX.GetPlayerData().job.name
    ESX.TriggerServerCallback('esx_society:setJob', function()
        if cb then cb() end
    end, identifier, jobname, currentGrade + 1, 'promote')
end))

exports('DemoteEmployee', PLLib.Wrap('DemoteEmployee', function(identifier, currentGrade, cb)
    local jobname = ESX.GetPlayerData().job.name
    ESX.TriggerServerCallback('esx_society:setJob', function()
        if cb then cb() end
    end, identifier, jobname, math.max(0, currentGrade - 1), 'promote')
end))

exports('FireEmployee', PLLib.Wrap('FireEmployee', function(identifier, cb)
    ESX.TriggerServerCallback('esx_society:setJob', function()
        if cb then cb() end
    end, identifier, 'unemployed', 0, 'fire')
end))

exports('HireEmployee', PLLib.Wrap('HireEmployee', function(targetServerId, cb)
    local jobname = ESX.GetPlayerData().job.name
    ESX.TriggerServerCallback('esx_society:setJob', function()
        if cb then cb() end
    end, targetServerId, jobname, 0, 'hire')
end))

exports('GetJobGrades', PLLib.Wrap('GetJobGrades', function(jobname)
    if GetResourceState('esx_society') ~= 'started' then return {} end
    local p = promise.new()
    ESX.TriggerServerCallback('esx_society:getJob', function(job)
        if not job then p:resolve({}) return end
        local grades = {}
        for _, g in ipairs(job.grades or {}) do
            grades[#grades + 1] = {
                value = g.grade,
                label = g.label or g.grade_name or ('Grade ' .. tostring(g.grade)),
            }
        end
        p:resolve(grades)
    end, jobname)
    return Citizen.Await(p)
end))
