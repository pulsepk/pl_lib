local VERSION_URL = 'https://raw.githubusercontent.com/pulsepk/scriptversion/main/version.json'

-- Returns -1 if a < b, 0 if equal, 1 if a > b
local function compareSemver(a, b)
    local function parts(v)
        local t = {}
        for n in v:gmatch('%d+') do t[#t + 1] = tonumber(n) end
        return t
    end
    local pa, pb = parts(a), parts(b)
    for i = 1, math.max(#pa, #pb) do
        local x, y = pa[i] or 0, pb[i] or 0
        if x < y then return -1 end
        if x > y then return  1 end
    end
    return 0
end

function PLLib.CheckVersion(resourceName, enable)
    if not enable then return end
    local current = GetResourceMetadata(resourceName, 'version', 0)

    PerformHttpRequest(VERSION_URL, function(code, body)
        if code ~= 200 then
            print('^1[pl_lib] Version check failed for ' .. resourceName .. ': server unreachable.^0')
            return
        end

        local data  = json.decode(body)
        local entry = data and data[resourceName]

        if not entry or not entry.version then
            print('^1[pl_lib] Version check failed for ' .. resourceName .. ': no entry in manifest.^0')
            return
        end

        if compareSemver(current, entry.version) < 0 then
            print('\n^1==================================================================^0')
            print('^1[' .. resourceName .. '] Outdated! Current: ' .. current .. ' | Latest: ' .. entry.version .. '^0')
            print('^1==================================================================^0')
            if entry.notes and #entry.notes > 0 then
                print('^3Patch Notes:^0')
                for _, note in ipairs(entry.notes) do
                    print('  • ^2' .. note .. '^0')
                end
            end
            print('^1[' .. resourceName .. '] ^2Need help? Join our Discord: https://discord.gg/c6gXmtEf3H^0\n')
        else
            print('^2[' .. resourceName .. '] Up to date (' .. current .. ').^0')
            print('^2[' .. resourceName .. '] ^0Need help? Join our Discord: ^2https://discord.gg/c6gXmtEf3H^0')
        end
    end, 'GET')
end

exports('CheckVersion', PLLib.Wrap('CheckVersion', PLLib.CheckVersion))

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    local current = GetResourceMetadata('pl_lib', 'version', 0) or 'unknown'

    PerformHttpRequest(VERSION_URL, function(code, body)
        if code ~= 200 then
            print('^2[pl_lib] ^0Loaded ^2v' .. current .. '^0 (version check unavailable)')
            return
        end

        local data  = json.decode(body)
        local entry = data and data['pl_lib']

        if not entry or not entry.version then
            print('^2[pl_lib] ^0Loaded ^2v' .. current .. '^0')
            return
        end

        if compareSemver(current, entry.version) < 0 then
            print('\n^1==================================================================^0')
            print('^1[pl_lib] Outdated! Current: ' .. current .. ' | Latest: ' .. entry.version .. '^0')
            print('^1[pl_lib] Download: https://github.com/pulsepk/pl_lib^0')
            print('^1==================================================================^0')
            if entry.notes and #entry.notes > 0 then
                print('^3Patch Notes:^0')
                for _, note in ipairs(entry.notes) do
                    print('  • ^2' .. note .. '^0')
                end
            end
            print('')
        else
            print('^2[pl_lib] ^0Loaded ^2v' .. current .. '^0 — up to date.')
            print('^2[pl_lib] ^0Discord: ^2https://discord.gg/c6gXmtEf3H^0')
        end
    end, 'GET')
end)
