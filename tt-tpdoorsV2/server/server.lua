local QBCore = exports['qb-core']:GetCoreObject()

-- Check if a player has access to a door
RegisterNetEvent('teleport:checkAccess')
AddEventHandler('teleport:checkAccess', function(doorId, cb)
  print("Checking access for doorId:", doorId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local door = Config.Doors[doorId]

    if not door then
        TriggerClientEvent('teleport:checkAccessResult', src, false) -- Invalid door
        return
    end

    -- Check if access is public
    if #door.groups == 0 and #door.players == 0 then
        TriggerClientEvent('teleport:checkAccessResult', src, true)
        return
    end

    -- Check group access
    for _, group in ipairs(door.groups) do
        if Player.PlayerData.job.name == group then
            TriggerClientEvent('teleport:checkAccessResult', src, true)
            return
        end
    end

    -- Check player-specific access
    local playerIdentifier = Player.PlayerData.license -- Can use 'license' or 'steam' depending on your setup
    for _, identifier in ipairs(door.players) do
        if playerIdentifier == identifier then
            TriggerClientEvent('teleport:checkAccessResult', src, true)
            return
        end
    end

    -- Default: deny access if no condition is met
    TriggerClientEvent('teleport:checkAccessResult', src, false)
end)
