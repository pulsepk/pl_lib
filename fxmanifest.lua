fx_version 'cerulean'
games { 'gta5' }

author 'PulseScripts - pulsescripts.com'
description 'PulseLib - Shared Framework Bridge'
version '1.0.0'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config/config.lua',
    'shared/detect.lua',
    'shared/startup.lua',
}

client_scripts {
    'client/bridge/qbox.lua',
    'client/bridge/qbcore.lua',
    'client/bridge/esx.lua',
    'client/notify.lua',
    'client/textui.lua',
    'client/contextmenu.lua',
    'client/inputdialog.lua',
    'client/skillcheck.lua',
    'client/progressbar.lua',
    'client/appearance.lua',
    'client/inventory.lua',
    'client/fuel.lua',
    'client/keys.lua',
    'client/target.lua',
    'client/animation.lua',
    'client/dispatch.lua',
    'client/entity.lua',
    'client/minigame.lua',
}

server_scripts {
    'server/bridge/qbox.lua',
    'server/bridge/qbcore.lua',
    'server/bridge/esx.lua',
    'server/inventory.lua',
    'server/society.lua',
    'server/logger.lua',
    'server/playerstatus.lua',
    'server/version.lua',
}

dependencies {
    'ox_lib',
}
