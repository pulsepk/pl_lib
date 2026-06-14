local _system = PLLib.GetPhone()

-- lb-phone SendNotification is server-side only.
-- Client-side ShowPhoneNotification routes through this event so the server can call it.
if _system == 'lb-phone' then
    RegisterNetEvent('pl_lib:phone:showNotification', function(title, message, icon)
        local src = source
        exports['lb-phone']:SendNotification(src, {
            app     = 'Notifications',
            title   = title,
            content = message,
        })
    end)
end

-- SendPhoneNotification(source, title, message, icon)
-- Pushes a notification to a specific player's phone.
exports('SendPhoneNotification', PLLib.Wrap('SendPhoneNotification', function(src, title, message, icon)
    icon = icon or 'fas fa-bell'

    if _system == 'lb-phone' then
        exports['lb-phone']:SendNotification(src, {
            app     = 'Notifications',
            title   = title,
            content = message,
        })

    elseif _system == 'gksphone' then
        -- gksphone Notification() is client-side; route to the target player's client
        TriggerClientEvent('pl_lib:phone:gksNotification', src, {
            title    = title,
            message  = message,
            icon     = icon,
            duration = 5000,
        })
    end
end))

-- GetPlayerPhoneNumber(source)
-- Returns the phone number string for the given player source, or nil if unavailable.
exports('GetPlayerPhoneNumber', PLLib.Wrap('GetPlayerPhoneNumber', function(src)
    if _system == 'lb-phone' then
        return Player(src).state.phoneNumber

    elseif _system == 'gksphone' then
        return exports['gksphone']:GetPhoneBySource(src)
    end
end))

-- SendPhoneMessage(fromNumber, toNumber, message)
-- Sends an SMS from one phone number to another.
-- Both lb-phone and gksphone identify players by phone number, not source ID.
exports('SendPhoneMessage', PLLib.Wrap('SendPhoneMessage', function(fromNumber, toNumber, message)
    if _system == 'lb-phone' then
        exports['lb-phone']:SendMessage(fromNumber, toNumber, message)

    elseif _system == 'gksphone' then
        exports['gksphone']:SendMessage(fromNumber, toNumber, message)
    end
end))
