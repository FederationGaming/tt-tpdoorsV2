Config = {}

-- Configurable teleport door locations
Config.Doors = {
    {
        id = 'public_door',
        name = 'Public Door',
        description = 'Everyone can enter.',
        coords = vector3(996.35, 3575.09, 34.61),
        targetCoords = vector3(903.2, -3182.2, -97.05),
        heading = 0.0,
        groups = {}, -- Public
        players = {}, -- Public
    }
}


-- Notification settings
Config.Notify = function(source, message, type)
    TriggerClientEvent('QBCore:Notify', source, message, type)
end
