local _system = PLLib.SkillCheck

-- DoSkillCheck(opts) → true (passed) | false (failed)
-- opts: {
--   difficulty = 'easy' | {'easy','medium',...}  (ox_lib)
--   keys       = {'w','a','s','d'}               (ox_lib)
--   lation     = { Title, Difficulties, Keys }   (lation_ui)
-- }
exports('DoSkillCheck', function(opts)
    opts = opts or {}

    if _system == 'ox_lib' then
        return lib.skillCheck(opts.difficulty or { 'easy' }, opts.keys or { 'w', 'a', 's', 'd' })

    elseif _system == 'lation_ui' then
        local l = opts.lation or {}
        return exports.lation_ui:skillCheck(
            l.Title        or 'Skill Check',
            l.Difficulties or { 'easy' },
            l.Keys         or { 'W', 'A', 'S', 'D' }
        )
    end

    return false
end)
