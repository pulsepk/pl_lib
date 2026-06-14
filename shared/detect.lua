-- Detection helpers — all read from PLLib.* (config/config.lua) so you only
-- ever configure things in one place, even across multiple scripts.
--
-- Results are cached after the first call so GetResourceState is never called
-- more than once per system per resource start.

PLLib._cache = {}

local function cache(key, detectFn)
    if PLLib._cache[key] ~= nil then
        return PLLib._cache[key] ~= false and PLLib._cache[key] or nil
    end
    local result = detectFn()
    PLLib._cache[key] = result ~= nil and result or false
    return result
end

function PLLib.GetFramework()
    return cache('Framework', function()
        if PLLib.Framework ~= 'autodetect' then return PLLib.Framework end
        if GetResourceState('qbx_core')    == 'started' then return 'qbox' end
        if GetResourceState('qb-core')     == 'started' then return 'qb'   end
        if GetResourceState('es_extended') == 'started' then return 'esx'  end
        print('^1[pl_lib] No compatible framework detected.^0')
    end)
end

function PLLib.GetTextUI()
    return cache('TextUI', function()
        if PLLib.TextUI ~= 'autodetect' then return PLLib.TextUI end
        if GetResourceState('ox_lib')        == 'started' then return 'ox_lib'        end
        if GetResourceState('qb-core')       == 'started' then return 'qb-core'       end
        if GetResourceState('jg-textui')     == 'started' then return 'jg-textui'     end
        if GetResourceState('esx_textui')    == 'started' then return 'esx_textui'    end
        if GetResourceState('cd_drawtextui') == 'started' then return 'cd_drawtextui' end
        if GetResourceState('brutal_textui') == 'started' then return 'brutal_textui' end
        if GetResourceState('lation_ui')     == 'started' then return 'lation_ui'     end
        print('^1[pl_lib] No compatible TextUI resource detected.^0')
    end)
end

function PLLib.GetTarget()
    return cache('Target', function()
        if PLLib.Target ~= 'autodetect' then return PLLib.Target end
        if GetResourceState('ox_target') == 'started' then return 'ox_target' end
        if GetResourceState('qb-target') == 'started' then return 'qb-target' end
        print('^1[pl_lib] No compatible Target resource detected.^0')
    end)
end

function PLLib.GetNotify()
    return cache('Notify', function()
        if PLLib.Notify ~= 'autodetect' then return PLLib.Notify end
        if GetResourceState('ox_lib')        == 'started' then return 'ox_lib'        end
        if GetResourceState('lation_ui')     == 'started' then return 'lation_ui'     end
        if GetResourceState('esx_notify')    == 'started' then return 'esx_notify'    end
        if GetResourceState('okokNotify')    == 'started' then return 'okokNotify'    end
        if GetResourceState('wasabi_notify') == 'started' then return 'wasabi_notify' end
        if GetResourceState('brutal_notify') == 'started' then return 'brutal_notify' end
        if GetResourceState('mythic_notify') == 'started' then return 'mythic_notify' end
        print('^1[pl_lib] No compatible Notify resource detected.^0')
    end)
end

function PLLib.GetClothing()
    return cache('Clothing', function()
        if PLLib.Clothing ~= 'autodetect' then return PLLib.Clothing end
        if GetResourceState('esx_skin')            == 'started' then return 'esx_skin'            end
        if GetResourceState('illenium-appearance') == 'started' then return 'illenium-appearance' end
        if GetResourceState('fivem-appearance')    == 'started' then return 'fivem-appearance'    end
        if GetResourceState('qb-clothing')         == 'started' then return 'qb-clothing'         end
        if GetResourceState('tgiann-clothing')     == 'started' then return 'tgiann-clothing'     end
        if GetResourceState('rcore_clothing')      == 'started' then return 'rcore_clothing'      end
        print('^1[pl_lib] No compatible Clothing resource detected.^0')
    end)
end

function PLLib.GetSociety()
    return cache('Society', function()
        if PLLib.Society.resourcename ~= 'autodetect' then return PLLib.Society.resourcename end
        if GetResourceState('Renewed-Banking')  == 'started' then return 'Renewed-Banking'  end
        if GetResourceState('esx_addonaccount') == 'started' then return 'esx_addonaccount' end
        if GetResourceState('okokBanking')      == 'started' then return 'okokBanking'      end
        if GetResourceState('snipe-banking')    == 'started' then return 'snipe-banking'    end
        if GetResourceState('tgiann-bank')      == 'started' then return 'tgiann-bank'      end
        if GetResourceState('kartik-banking')   == 'started' then return 'kartik-banking'   end
        if GetResourceState('qb-banking')       == 'started' then return 'qb-banking'       end
        if GetResourceState('qb-management')    == 'started' then return 'qb-management'    end
        print('^1[pl_lib] No compatible Society resource detected.^0')
    end)
end

function PLLib.GetDispatch()
    return cache('Dispatch', function()
        if PLLib.Dispatch ~= 'autodetect' then return PLLib.Dispatch end
        if GetResourceState('ps-dispatch')    == 'started' then return 'ps'    end
        if GetResourceState('aty_dispatch')   == 'started' then return 'aty'   end
        if GetResourceState('rcore_dispatch') == 'started' then return 'rcore' end
        if GetResourceState('cd_dispatch')    == 'started' then return 'cd'    end
        if GetResourceState('Opto_dispatch')  == 'started' then return 'op'    end
        if GetResourceState('tk_dispatch')    == 'started' then return 'tk'    end
        if GetResourceState('qs-dispatch')    == 'started' then return 'qs'    end
        if GetResourceState('codem-dispatch') == 'started' then return 'codem' end
    end)
end

function PLLib.GetMinigame()
    return cache('Minigame', function()
        if PLLib.Minigame ~= 'autodetect' then return PLLib.Minigame end
        if GetResourceState('ox_lib')          == 'started' then return 'ox_lib'          end
        if GetResourceState('utk_fingerprint') == 'started' then return 'utk_fingerprint' end
        if GetResourceState('ps-ui')           == 'started' then return 'ps-ui-circle'    end
        print('^1[pl_lib] No compatible Minigame resource detected.^0')
    end)
end

function PLLib.GetFuel()
    return cache('Fuel', function()
        if PLLib.Fuel ~= 'autodetect' then return PLLib.Fuel end
        if GetResourceState('LegacyFuel')     == 'started' then return 'LegacyFuel'     end
        if GetResourceState('cdn-fuel')       == 'started' then return 'cdn-fuel'       end
        if GetResourceState('okokGasStation') == 'started' then return 'okokGasStation' end
        if GetResourceState('rcore_fuel')     == 'started' then return 'rcore_fuel'     end
        if GetResourceState('ox_fuel')        == 'started' then return 'ox_fuel'        end
    end)
end

function PLLib.GetKeys()
    return cache('Keys', function()
        if PLLib.Keys ~= 'autodetect' then return PLLib.Keys end
        if GetResourceState('qb-vehiclekeys') == 'started' then return 'qb-vehiclekeys' end
        if GetResourceState('wasabi_carlock') == 'started' then return 'wasabi_carlock' end
        if GetResourceState('qs-vehiclekeys') == 'started' then return 'qs-vehiclekeys' end
        if GetResourceState('vehicles_keys')  == 'started' then return 'vehicles_keys'  end
    end)
end

function PLLib.GetInventory()
    return cache('Inventory', function()
        if PLLib.Inventory ~= 'autodetect' then return PLLib.Inventory end
        if GetResourceState('ox_inventory')     == 'started' then return 'ox_inventory'     end
        if GetResourceState('qb-inventory')     == 'started' then return 'qb-inventory'     end
        if GetResourceState('qs-inventory')     == 'started' then return 'qs-inventory'     end
        if GetResourceState('ps-inventory')     == 'started' then return 'ps-inventory'     end
        if GetResourceState('codem-inventory')  == 'started' then return 'codem-inventory'  end
        if GetResourceState('tgiann-inventory') == 'started' then return 'tgiann-inventory' end
        if GetResourceState('origen_inventory') == 'started' then return 'origen_inventory' end
        if GetResourceState('jaksam_inventory') == 'started' then return 'jaksam_inventory' end
        if GetResourceState('core_inventory')   == 'started' then return 'core_inventory'   end
        if GetResourceState('esx_inventory')    == 'started' then return 'esx_inventory'    end
        print('^1[pl_lib] No compatible Inventory resource detected.^0')
    end)
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

function PLLib.GetImagesPath()
    return cache('ImagesPath', function()
        local order = {
            'ox_inventory', 'qb-inventory', 'qs-inventory', 'ps-inventory',
            'codem-inventory', 'tgiann-inventory', 'origen_inventory',
            'jaksam_inventory', 'core_inventory',
        }
        for _, resource in ipairs(order) do
            if GetResourceState(resource) == 'started' then
                local path = PLLib.InventoryImages[resource]
                if path then return path end
            end
        end
        print('^1[pl_lib] GetImagesPath: no compatible inventory resource detected.^0')
    end)
end

function PLLib.Wrap(name, fn)
    return function(...)
        local results = table.pack(pcall(fn, ...))
        if not results[1] then
            print(('[pl_lib] ^1Error in export "%s": %s^0'):format(name, tostring(results[2])))
            return nil
        end
        return table.unpack(results, 2, results.n)
    end
end

exports('GetFramework',  PLLib.Wrap('GetFramework',  PLLib.GetFramework))
exports('GetTarget',     PLLib.Wrap('GetTarget',     PLLib.GetTarget))
exports('GetTextUI',     PLLib.Wrap('GetTextUI',     PLLib.GetTextUI))
exports('GetNotify',     PLLib.Wrap('GetNotify',     PLLib.GetNotify))
exports('GetClothing',   PLLib.Wrap('GetClothing',   PLLib.GetClothing))
exports('GetSociety',    PLLib.Wrap('GetSociety',    PLLib.GetSociety))
exports('GetDispatch',   PLLib.Wrap('GetDispatch',   PLLib.GetDispatch))
exports('GetMinigame',   PLLib.Wrap('GetMinigame',   PLLib.GetMinigame))
exports('GetImagesPath', PLLib.Wrap('GetImagesPath', PLLib.GetImagesPath))
exports('GetFuel',       PLLib.Wrap('GetFuel',       PLLib.GetFuel))
exports('GetKeys',       PLLib.Wrap('GetKeys',       PLLib.GetKeys))
exports('GetInventory',  PLLib.Wrap('GetInventory',  PLLib.GetInventory))
