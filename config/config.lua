-- PulseLib configuration — edit this file to control which systems pl_lib detects and uses.
-- All settings live in the PLLib namespace to avoid collisions with your script's Config table.

PLLib = {}

-- Set to true to print detected systems on resource start
PLLib.Debug = false

-- Framework: 'autodetect' | 'qbox' | 'qb' | 'esx'
PLLib.Framework = 'autodetect'

PLLib.FrameworkResources = {
    esx = { resource = 'es_extended', export = 'getSharedObject' },
    qb  = { resource = 'qb-core',     export = 'GetCoreObject'  },
}

-- UI system overrides — set to the resource name to pin a specific system,
-- or leave 'autodetect' to let pl_lib pick the first running resource.

-- TextUI: 'autodetect' | 'ox_lib' | 'qb-core' | 'jg-textui' | 'esx_textui' | 'cd_drawtextui' | 'brutal_textui' | 'lation_ui'
PLLib.TextUI = 'autodetect'

-- Target: 'autodetect' | 'ox_target' | 'qb-target'
PLLib.Target = 'autodetect'

-- Notify: 'autodetect' | 'ox_lib' | 'esx_notify' | 'okokNotify' | 'lation_ui' | 'wasabi_notify' | 'brutal_notify' | 'mythic_notify'
PLLib.Notify = 'autodetect'

-- Progressbar: 'ox_lib' | 'ox_lib_circle' | 'qb' | 'lation_ui'
PLLib.Progressbar = 'ox_lib'

-- SkillCheck: 'ox_lib' | 'lation_ui'
PLLib.SkillCheck = 'ox_lib'

-- Minigame: 'autodetect' | 'ox_lib' | 'utk_fingerprint' | 'ps-ui-circle' | 'ps-ui-maze' | 'ps-ui-scrambler'
PLLib.Minigame = 'autodetect'

-- InputDialog: 'ox_lib' | 'lation_ui'
PLLib.InputDialog = 'ox_lib'

-- ContextMenu: 'ox_lib' | 'lation_ui'
PLLib.ContextMenu = 'ox_lib'

-- Clothing: 'autodetect' | 'esx_skin' | 'illenium-appearance' | 'fivem-appearance' | 'qb-clothing' | 'tgiann-clothing' | 'rcore_clothing'
PLLib.Clothing = 'autodetect'

-- Society/banking: 'autodetect' | 'esx_addonaccount' | 'qb-management' | 'qb-banking' | 'okokBanking' | 'Renewed-Banking' | 'snipe-banking' | 'tgiann-bank'
PLLib.Society = { resourcename = 'autodetect' }

-- Dispatch: 'autodetect' | 'ps' | 'aty' | 'rcore' | 'cd' | 'op'
PLLib.Dispatch = 'autodetect'
