local _system = PLLib.Progressbar

-- Lazy-init QBCore only when 'qb' progressbar is configured
local _qb
local function getQB()
    if not _qb then
        _qb = exports[PLLib.FrameworkResources.qb.resource][PLLib.FrameworkResources.qb.export]()
    end
    return _qb
end

-- ProgressBar(label, duration, animDict, anim, opts) → true when complete
-- animDict / anim: optional animation to play during the bar
-- opts: optional table overriding disable flags, e.g. { move = false } to allow walking
exports('ProgressBar', PLLib.Wrap('ProgressBar', function(label, duration, animDict, anim, opts)
    opts = opts or {}
    local animData = (animDict and anim) and { dict = animDict, clip = anim } or nil
    local disable  = {
        move   = opts.move   ~= false,
        car    = opts.car    ~= false,
        combat = opts.combat ~= false,
        mouse  = opts.mouse  ~= false,
    }

    if _system == 'ox_lib' then
        lib.progressBar({
            duration     = duration,
            label        = label,
            useWhileDead = false,
            canCancel    = false,
            disable      = disable,
            anim         = animData,
        })
        return true

    elseif _system == 'ox_lib_circle' then
        lib.progressCircle({
            duration     = duration,
            label        = label,
            useWhileDead = false,
            canCancel    = false,
            disable      = disable,
            anim         = animData,
        })
        return true

    elseif _system == 'qb' then
        getQB().Functions.Progressbar(label, label, duration, false, true, {
            disableMovement    = disable.move,
            disableCarMovement = disable.car,
            disableMouse       = disable.mouse,
            disableCombat      = disable.combat,
        }, animDict and { animDict = animDict, anim = anim } or {}, {}, {}, function() end)
        Wait(duration)
        return true

    elseif _system == 'lation_ui' then
        exports.lation_ui:progressBar({
            label        = label,
            duration     = duration,
            icon         = 'fas fa-spinner',
            useWhileDead = false,
            disable      = { car = disable.car, move = disable.move, combat = disable.combat },
            anim         = animData and { dict = animDict, clip = anim } or nil,
        })
        return true
    end

    -- fallback: just wait the duration
    Wait(duration)
    return true
end))
