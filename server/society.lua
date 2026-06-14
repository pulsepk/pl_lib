local _system = PLLib.GetSociety()

exports('AddSocietyMoney', PLLib.Wrap('AddSocietyMoney', function(account, money)
    if _system == 'esx_addonaccount' then
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. account, function(acc)
            acc.addMoney(money)
        end)
    elseif _system == 'Renewed-Banking' then
        exports['Renewed-Banking']:addAccountMoney(account, money)
    elseif _system == 'qb-management' then
        exports['qb-management']:AddMoney(account, money)
    elseif _system == 'qb-banking' then
        exports['qb-banking']:AddMoney(account, money)
    elseif _system == 'okokBanking' then
        exports['okokBanking']:AddMoney(account, money)
    elseif _system == 'snipe-banking' then
        exports['snipe-banking']:AddMoneyToAccount(account, money)
    elseif _system == 'tgiann-bank' then
        exports['tgiann-bank']:AddJobMoney(account, money)
    elseif _system == 'kartik-banking' then
        exports['kartik-banking']:AddAccountMoney(account, money)
    end
end))

exports('RemoveSocietyMoney', PLLib.Wrap('RemoveSocietyMoney', function(account, money)
    if _system == 'esx_addonaccount' then
        TriggerEvent('esx_society:getSociety', account, function(society)
            TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(acc)
                acc.removeMoney(money)
            end)
        end)
    elseif _system == 'Renewed-Banking' then
        exports['Renewed-Banking']:removeAccountMoney(account, money)
    elseif _system == 'qb-management' then
        exports['qb-management']:RemoveMoney(account, money)
    elseif _system == 'qb-banking' then
        exports['qb-banking']:RemoveMoney(account, money)
    elseif _system == 'okokBanking' then
        exports['okokBanking']:RemoveMoney(account, money)
    elseif _system == 'snipe-banking' then
        exports['snipe-banking']:RemoveMoneyFromAccount(account, money)
    elseif _system == 'tgiann-bank' then
        exports['tgiann-bank']:RemoveJobMoney(account, money)
    elseif _system == 'kartik-banking' then
        exports['kartik-banking']:RemoveAccountMoney(account, money)
    end
end))

-- Returns the balance as a number
exports('GetSocietyMoney', PLLib.Wrap('GetSocietyMoney', function(account)
    if _system == 'esx_addonaccount' then
        local p = promise.new()
        TriggerEvent('esx_society:getSociety', account, function(data)
            if not data then p:resolve(0) return end
            TriggerEvent('esx_addonaccount:getSharedAccount', data.account, function(acc)
                p:resolve(acc.money)
            end)
        end)
        return Citizen.Await(p)
    elseif _system == 'Renewed-Banking' then
        return exports['Renewed-Banking']:getAccountMoney(account)
    elseif _system == 'qb-management' then
        return exports['qb-management']:GetAccount(account)
    elseif _system == 'qb-banking' then
        return exports['qb-banking']:GetAccountBalance(account)
    elseif _system == 'okokBanking' then
        return exports['okokBanking']:GetAccount(account)
    elseif _system == 'snipe-banking' then
        return exports['snipe-banking']:GetAccountBalance(account)
    elseif _system == 'tgiann-bank' then
        return exports['tgiann-bank']:GetJobAccountBalance(account)
    elseif _system == 'kartik-banking' then
        return exports['kartik-banking']:GetAccountMoney(account)
    end
    return 0
end))
