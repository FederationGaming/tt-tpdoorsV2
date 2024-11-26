local QBCore = exports['qb-core']:GetCoreObject()



-- Register teleport doors with ox_target
Citizen.CreateThread(function()
    for index, door in ipairs(Config.Doors) do
        exports.ox_target:addBoxZone({
            name = door.id,
            coords = door.coords,
            size = vec3(1,1,1),
            options = {
                {
                    event = 'teleport:attemptEnter',
                    icon = 'fas fa-door-open',
                    label = door.name,
                    description = door.description,
                    doorId = index,
                }
            },
            distance = 2.0
        })
    end
end)

-- Attempt to enter a teleport door
RegisterNetEvent('teleport:attemptEnter')
AddEventHandler('teleport:attemptEnter', function(data)
print("Teleport event fired for doorId:", data.doorId)
    local door = Config.Doors[data.doorId]
    print("Teleporting to:", door.targetCoords.x, door.targetCoords.y, door.targetCoords.z)
    if not door then return end
    print("Target Coordinates:", door.targetCoords)

    -- Request access check from the server
    TriggerServerEvent('teleport:checkAccess', data.doorId)
end)

-- Receive access result from the server
RegisterNetEvent('teleport:checkAccessResult')
AddEventHandler('teleport:checkAccessResult', function(hasAccess, doorId)
    local door = Config.Doors[doorId]
    if not door then return end

    if hasAccess then
        -- Teleport the player
        local ped = PlayerPedId()
        ClearPedTasksImmediately(ped)  -- Remove any ongoing actions
        FreezeEntityPosition(ped, true)  -- Freeze the player briefly for safety
        Citizen.Wait(100)
        DoScreenFadeOut(500)
        Citizen.Wait(500)
        SetEntityCoords(ped, door.targetCoords.x, door.targetCoords.y, door.targetCoords.z)
        SetEntityHeading(ped, door.heading or 0.0)
        Citizen.Wait(500)
        DoScreenFadeIn(500)

        QBCore.Functions.Notify('You have entered the door.', 'success')
    else
        QBCore.Functions.Notify('Access denied.', 'error')
    end
end)

