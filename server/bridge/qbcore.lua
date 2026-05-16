if PLLib.GetFramework() ~= 'qb' then return end

local QBCore = exports[PLLib.FrameworkResources.qb.resource][PLLib.FrameworkResources.qb.export]()

exports('GetPlayer', function(target)
    return QBCore.Functions.GetPlayer(target)
end)

exports('GetPlayerIdentifier', function(target)
    local p = QBCore.Functions.GetPlayer(target)
    return p and p.PlayerData.citizenid
end)

exports('GetPlayerName', function(target)
    local p = QBCore.Functions.GetPlayer(target)
    if not p then return '' end
    return p.PlayerData.charinfo.firstname .. ' ' .. p.PlayerData.charinfo.lastname
end)

exports('GetJob', function(target)
    local p = QBCore.Functions.GetPlayer(target)
    return p and p.PlayerData.job.name
end)

exports('GetJobGrade', function(target)
    local p = QBCore.Functions.GetPlayer(target)
    return p and p.PlayerData.job.grade.level or 0
end)

exports('RemovePlayerMoney', function(target, account, amount, _reason)
    local p = QBCore.Functions.GetPlayer(target)
    if not p then return end
    if account == 'money' then
        p.Functions.RemoveMoney('cash', amount)
    elseif account == 'bank' then
        p.Functions.RemoveMoney('bank', amount)
    end
end)

exports('AddPlayerMoney', function(target, account, amount, _reason)
    local p = QBCore.Functions.GetPlayer(target)
    if not p then return end
    if account == 'bank' then
        p.Functions.AddMoney('bank', amount)
    elseif account == 'money' then
        p.Functions.AddMoney('cash', amount)
    elseif account == 'dirty' then
        if GetResourceState('ox_inventory') == 'started' then
            exports.ox_inventory:AddItem(target, 'markedbills', 1, { worth = amount })
        else
            p.Functions.AddMoney('cash', amount)
        end
    end
end)

exports('GetPlayerAccountMoney', function(target, account, amount)
    local p = QBCore.Functions.GetPlayer(target)
    if not p then return false end
    if account == 'bank' then
        return p.PlayerData.money.bank >= amount
    elseif account == 'money' then
        return p.PlayerData.money.cash >= amount
    end
    return false
end)

exports('PlayerCanCarryItems', function(_target, _item, _amount)
    -- qb-inventory handles carry checks internally
    return true
end)
