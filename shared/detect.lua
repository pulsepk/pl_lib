-- Detection helpers — all read from PLLib.* (config/config.lua) so you only
-- ever configure things in one place, even across multiple scripts.

function PLLib.GetFramework()
    if PLLib.Framework ~= 'autodetect' then
        return PLLib.Framework
    end
    if GetResourceState('qbx_core') == 'started' then
        return 'qbox'
    elseif GetResourceState('qb-core') == 'started' then
        return 'qb'
    elseif GetResourceState('es_extended') == 'started' then
        return 'esx'
    end
    print('^1[pl_lib] No compatible framework detected.^0')
    return nil
end

function PLLib.GetTextUI()
    if PLLib.TextUI ~= 'autodetect' then
        return PLLib.TextUI
    end
    if GetResourceState('ox_lib')        == 'started' then return 'ox_lib'        end
    if GetResourceState('qb-core')       == 'started' then return 'qb-core'       end
    if GetResourceState('jg-textui')     == 'started' then return 'jg-textui'     end
    if GetResourceState('esx_textui')    == 'started' then return 'esx_textui'    end
    if GetResourceState('cd_drawtextui') == 'started' then return 'cd_drawtextui' end
    if GetResourceState('brutal_textui') == 'started' then return 'brutal_textui' end
    if GetResourceState('lation_ui')     == 'started' then return 'lation_ui'     end
    print('^1[pl_lib] No compatible TextUI resource detected.^0')
    return nil
end

function PLLib.GetTarget()
    if PLLib.Target ~= 'autodetect' then
        return PLLib.Target
    end
    if GetResourceState('ox_target') == 'started' then return 'ox_target' end
    if GetResourceState('qb-target') == 'started' then return 'qb-target' end
    print('^1[pl_lib] No compatible Target resource detected.^0')
    return nil
end

function PLLib.GetNotify()
    if PLLib.Notify ~= 'autodetect' then
        return PLLib.Notify
    end
    if GetResourceState('ox_lib')        == 'started' then return 'ox_lib'        end
    if GetResourceState('lation_ui')     == 'started' then return 'lation_ui'     end
    if GetResourceState('esx_notify')    == 'started' then return 'esx_notify'    end
    if GetResourceState('okokNotify')    == 'started' then return 'okokNotify'    end
    if GetResourceState('wasabi_notify') == 'started' then return 'wasabi_notify' end
    if GetResourceState('brutal_notify') == 'started' then return 'brutal_notify' end
    if GetResourceState('mythic_notify') == 'started' then return 'mythic_notify' end
    print('^1[pl_lib] No compatible Notify resource detected.^0')
    return nil
end

function PLLib.GetClothing()
    if PLLib.Clothing ~= 'autodetect' then
        return PLLib.Clothing
    end
    if GetResourceState('esx_skin')            == 'started' then return 'esx_skin'            end
    if GetResourceState('illenium-appearance') == 'started' then return 'illenium-appearance' end
    if GetResourceState('fivem-appearance')    == 'started' then return 'fivem-appearance'    end
    if GetResourceState('qb-clothing')         == 'started' then return 'qb-clothing'         end
    if GetResourceState('tgiann-clothing')     == 'started' then return 'tgiann-clothing'     end
    if GetResourceState('rcore_clothing')      == 'started' then return 'rcore_clothing'      end
    print('^1[pl_lib] No compatible Clothing resource detected.^0')
    return nil
end

function PLLib.GetSociety()
    if PLLib.Society.resourcename ~= 'autodetect' then
        return PLLib.Society.resourcename
    end
    if GetResourceState('Renewed-Banking')   == 'started' then return 'Renewed-Banking'   end
    if GetResourceState('esx_addonaccount') == 'started' then return 'esx_addonaccount' end
    if GetResourceState('okokBanking')      == 'started' then return 'okokBanking'      end
    if GetResourceState('snipe-banking')    == 'started' then return 'snipe-banking'    end
    if GetResourceState('tgiann-bank')      == 'started' then return 'tgiann-bank'      end
    if GetResourceState('qb-banking')       == 'started' then return 'qb-banking'       end
    if GetResourceState('qb-management')    == 'started' then return 'qb-management'    end
    print('^1[pl_lib] No compatible Society resource detected.^0')
    return nil
end

function PLLib.GetDispatch()
    if PLLib.Dispatch ~= 'autodetect' then
        return PLLib.Dispatch
    end
    if GetResourceState('ps-dispatch')   == 'started' then return 'ps'    end
    if GetResourceState('aty_dispatch')  == 'started' then return 'aty'   end
    if GetResourceState('rcore_dispatch')== 'started' then return 'rcore' end
    if GetResourceState('cd_dispatch')   == 'started' then return 'cd'    end
    if GetResourceState('Opto_dispatch') == 'started' then return 'op'    end
    return nil
end

function PLLib.CheckDependency(name, minVersion)
    if GetResourceState(name) ~= 'started' then return false end
    local version = GetResourceMetadata(name, 'version', 0)
    if not version then return false end
    local function parts(v)
        local t = {}
        for n in v:gmatch('%d+') do t[#t + 1] = tonumber(n) end
        return t
    end
    local pa, pb = parts(version), parts(minVersion)
    for i = 1, math.max(#pa, #pb) do
        local x, y = pa[i] or 0, pb[i] or 0
        if x < y then return false end
        if x > y then return true end
    end
    return true
end

exports('GetFramework', PLLib.GetFramework)
exports('GetTarget',    PLLib.GetTarget)
exports('GetTextUI',    PLLib.GetTextUI)
exports('GetNotify',    PLLib.GetNotify)
exports('GetClothing',  PLLib.GetClothing)
exports('GetSociety',   PLLib.GetSociety)
exports('GetDispatch',  PLLib.GetDispatch)
