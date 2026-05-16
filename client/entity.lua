-- ── Entity / network utilities ────────────────────────────────────────────────
-- EnsureModel      : load a model by name or hash, returns false if not in cd-image.
-- NetToEnt         : safely convert a network ID to an entity handle (0 on failure).
-- TryRequestControl: request network control of an entity with a millisecond timeout.

exports('EnsureModel', function(model)
    local hash = type(model) == 'string' and GetHashKey(model) or model
    if not IsModelInCdimage(hash) then return false end
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(10) end
    return true
end)

exports('NetToEnt', function(netId)
    if not netId then return 0 end
    local ent = NetworkGetEntityFromNetworkId(netId)
    if ent and ent ~= 0 and DoesEntityExist(ent) then return ent end
    return 0
end)

exports('TryRequestControl', function(entity, timeoutMs)
    timeoutMs = timeoutMs or 1000
    if not entity or entity == 0 or not DoesEntityExist(entity) then return false end
    if NetworkHasControlOfEntity(entity) then return true end
    NetworkRequestControlOfEntity(entity)
    local started = GetGameTimer()
    while not NetworkHasControlOfEntity(entity) and (GetGameTimer() - started) < timeoutMs do
        Wait(0)
        NetworkRequestControlOfEntity(entity)
    end
    return NetworkHasControlOfEntity(entity)
end)
