if PLLib.GetFramework() ~= 'qbox' then return end

local QBCore = exports[PLLib.FrameworkResources.qb.resource][PLLib.FrameworkResources.qb.export]()

exports('GetPlayer', PLLib.Wrap('GetPlayer', function(target)
    return exports.qbx_core:GetPlayer(target)
end))

exports('GetPlayerIdentifier', PLLib.Wrap('GetPlayerIdentifier', function(target)
    local p = QBCore.Functions.GetPlayer(target)
    return p and p.PlayerData.citizenid
end))

exports('GetPlayerName', PLLib.Wrap('GetPlayerName', function(target)
    local p = QBCore.Functions.GetPlayer(target)
    if not p then return '' end
    return p.PlayerData.charinfo.firstname .. ' ' .. p.PlayerData.charinfo.lastname
end))

exports('GetJob', PLLib.Wrap('GetJob', function(target)
    local p = QBCore.Functions.GetPlayer(target)
    return p and p.PlayerData.job.name
end))

exports('GetJobGrade', PLLib.Wrap('GetJobGrade', function(target)
    local p = QBCore.Functions.GetPlayer(target)
    return p and p.PlayerData.job.grade.level or 0
end))

-- account: 'money' (cash) | 'bank'
-- reason:  optional label for the transaction log
exports('RemovePlayerMoney', PLLib.Wrap('RemovePlayerMoney', function(target, account, amount, reason)
    reason = reason or 'pl_lib'
    if account == 'money' then
        exports.qbx_core:RemoveMoney(target, 'cash', amount, reason)
    elseif account == 'bank' then
        exports.qbx_core:RemoveMoney(target, 'bank', amount, reason)
    end
end))

exports('AddPlayerMoney', PLLib.Wrap('AddPlayerMoney', function(target, account, amount, reason)
    reason = reason or 'pl_lib'
    if account == 'bank' then
        exports.qbx_core:AddMoney(target, 'bank', amount, reason)
    elseif account == 'money' then
        exports.qbx_core:AddMoney(target, 'cash', amount, reason)
    elseif account == 'dirty' then
        if GetResourceState('ox_inventory') == 'started' then
            exports.ox_inventory:AddItem(target, 'markedbills', 1, { worth = amount })
        else
            exports.qbx_core:AddMoney(target, 'cash', amount, reason)
        end
    end
end))

-- Returns true if the player has at least `amount` in the given account
exports('GetPlayerAccountMoney', PLLib.Wrap('GetPlayerAccountMoney', function(target, account, amount)
    if account == 'bank' then
        return exports.qbx_core:GetMoney(target, 'bank') >= amount
    elseif account == 'money' then
        return exports.qbx_core:GetMoney(target, 'cash') >= amount
    end
    return false
end))

exports('PlayerCanCarryItems', PLLib.Wrap('PlayerCanCarryItems', function(target, item, amount)
    return exports.ox_inventory:CanCarryItem(target, item, amount) == true
end))
