local fmsdk  = GetResourceState('fmsdk')   == 'started'
local fmlogs = GetResourceState('fm-logs') == 'started'

-- opts: { type, enable, webhook, jobname }
exports('Log', function(message, opts)
    if not opts or not opts.enable then return end

    if opts.type == 'fivemanage' then
        if not fmsdk then return end
        exports.fmsdk:LogMessage('info', message)

    elseif opts.type == 'fivemerr' then
        if not fmlogs then return end
        exports['fm-logs']:createLog({
            LogType  = 'Resource',
            Resource = opts.jobname or 'pl_lib',
            Level    = 'info',
            Message  = message,
        })

    elseif opts.type == 'discord' then
        if not opts.webhook or opts.webhook == '' then return end
        PerformHttpRequest(opts.webhook, function() end, 'POST', json.encode({
            username   = opts.jobname,
            embeds     = {{
                color       = 16711680,
                author      = {
                    name     = 'PL Logs',
                    icon_url = 'https://r2.fivemanage.com/JEc8nqRsuJODhwqwkKd7o/pulsescriptsps-logo.png',
                },
                title       = opts.jobname,
                description = message,
            }},
            avatar_url = 'https://r2.fivemanage.com/JEc8nqRsuJODhwqwkKd7o/pulsescriptsps-logo.png',
        }), { ['Content-Type'] = 'application/json' })
    end
end)
