local _system = PLLib.GetPhone()

-- gksphone Notification() is client-side only.
-- Server-side SendPhoneNotification routes through this event so it can call the export locally.
RegisterNetEvent('pl_lib:phone:gksNotification', function(data)
    if _system == 'gksphone' then
        exports['gksphone']:Notification(data)
    end
end)

-- ShowPhoneNotification(title, message, icon)
-- Pops a notification on the local player's phone UI.
exports('ShowPhoneNotification', PLLib.Wrap('ShowPhoneNotification', function(title, message, icon)
    icon = icon or 'fas fa-bell'

    if _system == 'lb-phone' then
        -- lb-phone SendNotification is server-side only; route through server
        TriggerServerEvent('pl_lib:phone:showNotification', title, message, icon)

    elseif _system == 'gksphone' then
        exports['gksphone']:Notification({
            title    = title,
            message  = message,
            icon     = icon,
            duration = 5000,
        })
    end
end))
