exports('LoadAnimDict', function(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(10) end
end)

-- blendIn/blendOut/duration/flags match TaskPlayAnim defaults used across pl_uwucafe
exports('PlayAnim', function(entity, dict, anim, blendIn, blendOut, duration, flags)
    TaskPlayAnim(
        entity, dict, anim,
        blendIn  or 8.0,
        blendOut or -8.0,
        duration or -1,
        flags    or 49,
        0, false, false, false
    )
end)

-- Turns the local player ped to face a vector3 coord (no-op if already facing)
exports('LookAt', function(coords)
    local ped = PlayerPedId()
    if not IsPedHeadingTowardsPosition(ped, coords, 10.0) then
        TaskTurnPedToFaceCoord(ped, coords, 1500)
    end
end)
