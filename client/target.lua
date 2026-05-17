local _system = PLLib.GetTarget()

-- Builds an ox_target option table from the normalised opt.
-- opt.event fires a client event with { entity, args }; serverEvent wires to server directly.
-- Fallback fires pl_lib:targetSelected.
local function oxOption(opt)
    local o = {
        name     = opt.name,
        icon     = opt.icon,
        label    = opt.label,
        distance = opt.distance or 1.5,
    }
    if opt.jobRequired ~= false and opt.jobname then
        o.groups = { [opt.jobname] = opt.grade or 0 }
    end
    if opt.serverEvent then
        o.serverEvent = opt.serverEvent
    elseif opt.event then
        local ev, args = opt.event, opt.args
        o.onSelect = function(data)
            TriggerEvent(ev, { entity = data.entity, args = args })
        end
    else
        o.onSelect = function(data)
            TriggerEvent('pl_lib:targetSelected', opt.name, data)
        end
    end
    return o
end

-- Builds a qb-target option table from the normalised opt.
local function qbOption(opt)
    local o = {
        icon  = opt.icon,
        label = opt.label,
    }
    if opt.jobRequired ~= false and opt.jobname then
        o.job = opt.jobname
    end
    if opt.serverEvent then
        o.type  = 'server'
        o.event = opt.serverEvent
    elseif opt.event then
        local ev, args = opt.event, opt.args
        o.action = function(data)
            local ent = type(data) == 'number' and data or data.entity
            TriggerEvent(ev, { entity = ent, args = args })
        end
    else
        o.action = function(data)
            TriggerEvent('pl_lib:targetSelected', opt.name, data)
        end
    end
    return o
end

-- Builds an ox_target model option (no serverEvent/job support — model targets are client-side).
local function oxModelOption(opt)
    local o = {
        name        = opt.name,
        icon        = opt.icon,
        label       = opt.label,
        distance    = opt.distance or 2.0,
        canInteract = opt.canInteract,
    }
    local item = opt.item
    if item then o.items = type(item) == 'table' and item or { item } end
    local ev, args = opt.event, opt.args
    o.onSelect = function(data)
        if ev then
            TriggerEvent(ev, { entity = data.entity, args = args })
        else
            TriggerEvent('pl_lib:targetSelected', opt.name, data)
        end
    end
    return o
end

-- Builds a qb-target model option.
local function qbModelOption(opt)
    local o = {
        label       = opt.label,
        icon        = opt.icon,
        canInteract = opt.canInteract,
    }
    local item = opt.item
    if item then o.item = type(item) == 'table' and item[1] or item end
    local ev, args = opt.event, opt.args
    o.action = function(data)
        local ent = type(data) == 'number' and data or data.entity
        if ev then
            TriggerEvent(ev, { entity = ent, args = args })
        else
            TriggerEvent('pl_lib:targetSelected', opt.name, data)
        end
    end
    return o
end

-- ── Entity targets ────────────────────────────────────────────────────────────

-- opt: { name, label, icon, distance, grade, jobRequired, serverEvent, jobname }
exports('AddEntityTarget', function(entity, opt)
    if _system == 'ox_target' then
        exports.ox_target:addLocalEntity(entity, { oxOption(opt) })
    elseif _system == 'qb-target' then
        exports['qb-target']:AddTargetEntity(entity, {
            options  = { qbOption(opt) },
            distance = opt.distance or 1.5,
        })
    end
end)

exports('RemoveEntityTarget', function(entity)
    if _system == 'ox_target' then
        exports.ox_target:removeLocalEntity(entity)
    elseif _system == 'qb-target' then
        exports['qb-target']:RemoveTargetEntity(entity)
    end
end)

-- ── Box zone targets ──────────────────────────────────────────────────────────

-- zone: { TargetCoords, w, h, height, heading, minZ, maxZ }
-- opt:  { name, label, icon, distance, grade, jobRequired, serverEvent, jobname, debug }
exports('AddBoxTarget', function(zone, opt)
    if _system == 'ox_target' then
        return exports.ox_target:addBoxZone({
            coords   = zone.TargetCoords,
            size     = vec3(zone.w, zone.h, zone.height),
            rotation = zone.heading,
            debug    = opt.debug or false,
            options  = { oxOption(opt) },
        })
    elseif _system == 'qb-target' then
        exports['qb-target']:AddBoxZone(opt.name, zone.TargetCoords, zone.h, zone.w, {
            name      = opt.name,
            heading   = zone.heading,
            debugPoly = opt.debug or false,
            minZ      = zone.minZ,
            maxZ      = zone.maxZ,
        }, { options = { qbOption(opt) }, distance = opt.distance or 1.5 })
        return opt.name
    end
end)

exports('RemoveBoxTarget', function(id)
    if _system == 'ox_target' then
        exports.ox_target:removeZone(id)
    elseif _system == 'qb-target' then
        exports['qb-target']:RemoveZone(id)
    end
end)

-- ── Chair targets ─────────────────────────────────────────────────────────────

-- chair: { coords (vec4), w, h, height, label, minZ, maxZ, stand }
-- Fires 'pl_lib:targetSelected' with { loc, stand } so the calling resource can
-- invoke HandleChairInteraction without passing a function across the boundary.
exports('AddChairTarget', function(zoneName, chair, debug)
    if _system == 'ox_target' then
        return exports.ox_target:addBoxZone({
            coords   = vec3(chair.coords.x, chair.coords.y, chair.coords.z - 0.5),
            size     = vec3(chair.w, chair.h, chair.height),
            rotation = chair.coords.w,
            debug    = debug or false,
            options  = {{
                name     = zoneName,
                icon     = 'fas fa-chair',
                label    = chair.label,
                distance = 2.2,
                onSelect = function()
                    TriggerEvent('pl_lib:targetSelected', zoneName, {
                        loc   = chair.coords,
                        stand = chair.stand,
                    })
                end,
            }},
        })
    elseif _system == 'qb-target' then
        exports['qb-target']:AddBoxZone(zoneName, chair.coords.xyz, chair.h, chair.w, {
            name      = zoneName,
            heading   = chair.coords.w,
            debugPoly = debug or false,
            minZ      = chair.minZ,
            maxZ      = chair.maxZ,
        }, {
            options  = {{
                icon   = 'fas fa-chair',
                label  = chair.label,
                action = function()
                    TriggerEvent('pl_lib:targetSelected', zoneName, {
                        loc   = chair.coords,
                        stand = chair.stand,
                    })
                end,
            }},
            distance = 2.2,
        })
        return zoneName
    end
end)

-- ── Model targets ─────────────────────────────────────────────────────────────

-- opts: array of { name, label, icon, distance, item, event, args, canInteract }
exports('AddModelTarget', function(model, opts)
    if _system == 'ox_target' then
        local options = {}
        for _, opt in ipairs(opts) do table.insert(options, oxModelOption(opt)) end
        exports.ox_target:addModel(model, options)
    elseif _system == 'qb-target' then
        local options  = {}
        local distance = 2.0
        for _, opt in ipairs(opts) do
            table.insert(options, qbModelOption(opt))
            if opt.distance then distance = opt.distance end
        end
        exports['qb-target']:AddTargetModel(model, { options = options, distance = distance })
    end
end)

exports('RemoveModelTarget', function(model)
    if _system == 'ox_target' then
        exports.ox_target:removeModel(model)
    elseif _system == 'qb-target' then
        exports['qb-target']:RemoveTargetModel(model)
    end
end)
