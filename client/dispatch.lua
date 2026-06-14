local function streetText(coords)
    local s1, s2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local name1  = GetStreetNameFromHashKey(s1)
    local name2  = s2 ~= 0 and GetStreetNameFromHashKey(s2) or nil
    return name2 and (name1 .. ' & ' .. name2) or name1
end

-- SendDispatch(opts)
-- opts.title   : string  — alert title            e.g. 'ATM Robbery'
-- opts.code    : string  — police code            e.g. '10-90'
-- opts.message : string  — body / description text
-- opts.coords  : vector3 — defaults to player position if nil
-- opts.jobs    : table   — { 'police' }
-- opts.sprite  : number  — blip sprite   (default 431)
-- opts.color   : number  — blip color    (default 1)
-- opts.scale   : number  — blip scale    (default 1.0)
-- opts.radius  : number  — blip radius   (default 0)
-- opts.length  : number  — duration mins (default 3)
exports('SendDispatch', PLLib.Wrap('SendDispatch', function(opts)
    local dispatch = PLLib.GetDispatch()
    if not dispatch then
        print('^1[pl_lib] SendDispatch: no compatible dispatch resource detected.^0')
        return
    end

    local coords = opts.coords or GetEntityCoords(PlayerPedId())
    local street = streetText(coords)
    local jobs   = opts.jobs   or { 'police' }
    local title  = opts.title  or 'Alert'
    local code   = opts.code   or '10-0'
    local msg    = opts.message or title
    local sprite = opts.sprite or 431
    local color  = opts.color  or 1
    local scale  = opts.scale  or 1.0
    local radius = opts.radius or 0
    local length = opts.length or 3

    if dispatch == 'ps' then
        exports['ps-dispatch']:CustomAlert({
            coords       = coords,
            message      = msg .. ' ' .. street,
            dispatchCode = code,
            description  = title,
            radius       = radius,
            sprite       = sprite,
            color        = color,
            scale        = scale,
            length       = length,
        })

    elseif dispatch == 'aty' then
        local s1, s2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        local loc = GetStreetNameFromHashKey(s1)
        if s2 ~= 0 then loc = loc .. ' ' .. GetStreetNameFromHashKey(s2) end
        TriggerServerEvent('aty_dispatch:server:customDispatch',
            title, code, loc, coords,
            nil, nil, nil, nil,
            sprite, jobs
        )

    elseif dispatch == 'rcore' then
        TriggerServerEvent('rcore_dispatch:server:sendAlert', {
            code             = code .. ' - ' .. title,
            default_priority = 'low',
            coords           = coords,
            job              = jobs,
            text             = msg .. ' on ' .. street,
            type             = 'alerts',
            blip_time        = length * 60,
            blip = {
                sprite  = sprite,
                colour  = color,
                scale   = scale,
                text    = code .. ' - ' .. title,
                flashes = false,
                radius  = radius,
            },
        })

    elseif dispatch == 'cd' then
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table  = jobs,
            coords     = coords,
            title      = code .. ' - ' .. title,
            message    = msg .. ' at ' .. street,
            flash      = 0,
            unique_id  = tostring(GetGameTimer()),
            sound      = 1,
            blip = {
                sprite  = sprite,
                scale   = scale,
                colour  = color,
                flashes = false,
                text    = '911 - ' .. title,
                time    = length,
                radius  = radius,
            },
        })

    elseif dispatch == 'op' then
        TriggerServerEvent('Opto_dispatch:Server:SendAlert',
            jobs, title,
            msg .. ' at ' .. street,
            coords, false,
            GetPlayerServerId(PlayerId())
        )

    elseif dispatch == 'codem' then
        exports['codem-dispatch']:CustomDispatch({
            type   = title,
            header = title,
            text   = msg .. ' at ' .. street,
            code   = code,
        })

    elseif dispatch == 'qs' then
        TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
            job          = jobs,
            callLocation = coords,
            callCode     = { code = code, snippet = title },
            message      = msg .. ' at ' .. street,
            flashes      = false,
            image        = opts.image or nil,
            blip         = {
                sprite  = sprite,
                scale   = scale,
                colour  = color,
                flashes = false,
                text    = title,
                time    = length * 60 * 1000,
            },
        })

    elseif dispatch == 'tk' then
        exports.tk_dispatch:addCall({
            title         = title,
            code          = opts.code,
            priority      = opts.priority,
            coords        = coords,
            message       = opts.message,
            showLocation  = true,
            showDirection = true,
            showGender    = true,
            showVehicle   = true,
            showWeapon    = true,
            playSound     = true,
            removeTime    = length * 60 * 1000,
            jobs          = jobs,
            blip          = {
                sprite     = sprite,
                scale      = scale,
                color      = color,
                radius     = radius > 0 and radius or nil,
            },
        })
    end
end))
