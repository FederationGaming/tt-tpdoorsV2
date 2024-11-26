fx_version 'cerulean'
game 'gta5'

author 'Tiny Tim'
description 'Public Teleport Door Script with ox_target Integration'
version '1.0.0'

shared_script 'shared/config.lua'

client_script 'client/client.lua'

server_script 'server/server.lua'

dependencies {
    'ox_target',
    'qb-core'
}

