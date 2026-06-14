if PLLib.GetFramework() ~= 'esx' then return end

ESX = exports[PLLib.FrameworkResources.esx.resource][PLLib.FrameworkResources.esx.export]()

exports('GetPlayer', PLLib.Wrap('GetPlayer', function(target)
    return ESX.GetPlayerFromId(target)
end))

exports('GetPlayerIdentifier', PLLib.Wrap('GetPlayerIdentifier', function(target)
    local p = ESX.GetPlayerFromId(target)
    return p and p.getIdentifier()
end))

exports('GetPlayerName', PLLib.Wrap('GetPlayerName', function(target)
    local p = ESX.GetPlayerFromId(target)
    return p and p.getName() or ''
end))

exports('GetJob', PLLib.Wrap('GetJob', function(target)
    local p = ESX.GetPlayerFromId(target)
    return p and p.getJob().name
end))

exports('GetJobGrade', PLLib.Wrap('GetJobGrade', function(target)
    local p = ESX.GetPlayerFromId(target)
    return p and p.getJob().grade or 0
end))

exports('RemovePlayerMoney', PLLib.Wrap('RemovePlayerMoney', function(target, account, amount, _reason)
    local p = ESX.GetPlayerFromId(target)
    if not p then return end
    if account == 'bank' then
        p.removeAccountMoney('bank', amount)
    elseif account == 'money' then
        p.removeAccountMoney('money', amount)
    end
end))

exports('AddPlayerMoney', PLLib.Wrap('AddPlayerMoney', function(target, account, amount, _reason)
    local p = ESX.GetPlayerFromId(target)
    if not p then return end
    if account == 'bank' then
        p.addAccountMoney('bank', amount)
    elseif account == 'money' then
        p.addAccountMoney('money', amount)
    elseif account == 'dirty' then
        p.addAccountMoney('black_money', amount)
    end
end))

exports('GetPlayerAccountMoney', PLLib.Wrap('GetPlayerAccountMoney', function(target, account, amount)
    local p = ESX.GetPlayerFromId(target)
    if not p then return false end
    if account == 'bank' then
        return p.getAccount('bank').money >= amount
    elseif account == 'money' then
        return p.getAccount('money').money >= amount
    end
    return false
end))

exports('PlayerCanCarryItems', PLLib.Wrap('PlayerCanCarryItems', function(target, item, amount)
    local p = ESX.GetPlayerFromId(target)
    if not p then return false end
    return p.canCarryItem(item, amount) == true
end))
