local _system = PLLib.GetMinigame()

-- DoMinigame(callback, opts)
-- callback(success: bool) is always called once.
-- opts (all optional):
--   system         → override the auto-detected minigame for this call only
--   ox_lib         → difficulty (table), keys (table)
--   utk_fingerprint → circles (int), matches (int), time (int)
--   ps-ui-circle   → circles (int), speed (int)
--   ps-ui-maze     → time (int)
--   ps-ui-scrambler → time (int), numbers (int)
--   M-drilling     → (no extra opts; uses Drilling:Start event)
exports('DoMinigame', PLLib.Wrap('DoMinigame', function(callback, opts)
    opts = opts or {}
    local system = opts.system or _system

    if system == 'ox_lib' then
        CreateThread(function()
            local difficulty = opts.difficulty or { 'easy', 'easy', { areaSize = 60, speedMultiplier = 1 }, 'easy' }
            local keys       = opts.keys       or { 'w', 'a', 's', 'd' }
            callback(lib.skillCheck(difficulty, keys) == true)
        end)

    elseif system == 'M-drilling' then
        TriggerEvent('Drilling:Start', function(success) callback(success == true) end)

    elseif system == 'utk_fingerprint' then
        TriggerEvent('utk_fingerprint:Start',
            opts.circles or 1,
            opts.matches or 6,
            opts.time    or 1,
            function(outcome) callback(outcome == true) end
        )

    elseif system == 'ps-ui-circle' then
        exports['ps-ui']:Circle(
            function(success) callback(success) end,
            opts.circles or 4,
            opts.speed   or 60
        )

    elseif system == 'ps-ui-maze' then
        exports['ps-ui']:Maze(
            function(success) callback(success) end,
            opts.time or 120
        )

    elseif system == 'ps-ui-scrambler' then
        exports['ps-ui']:Scrambler(
            function(success) callback(success) end,
            'numeric',
            opts.time    or 120,
            opts.numbers or 1
        )

    else
        print('^1[pl_lib] DoMinigame: no compatible minigame resource detected.^0')
        callback(false)
    end
end))
