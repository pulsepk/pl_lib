local _system = PLLib.GetNotify()

-- Notify(title, message, type)
-- type: 'success' | 'error' | 'info' | 'warning'
exports('Notify', function(title, message, ntype)
    ntype = ntype or 'success'
    if _system == 'ox_lib' then
        lib.notify({ title = title, description = message, type = ntype })
    elseif _system == 'esx_notify' then
        exports['esx_notify']:Notify(ntype, message, 4000, title)
    elseif _system == 'okokNotify' then
        exports['okokNotify']:Alert(title, message, 6000, ntype, true)
    elseif _system == 'lation_ui' then
        exports.lation_ui:notify({ title = title, message = message, type = ntype })
    elseif _system == 'wasabi_notify' then
        exports.wasabi_notify:notify(title, message, 6000, ntype, false, 'fas fa-bell')
    elseif _system == 'brutal_notify' then
        exports['brutal_notify']:SendAlert(title, message, 6000, ntype, false)
    elseif _system == 'mythic_notify' then
        exports['mythic_notify']:SendAlert(ntype, message)
    else
        print(('[pl_lib] Notify: %s — %s'):format(title, message))
    end
end)
