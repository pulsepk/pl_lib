local _system     = PLLib.GetClothing()
local _savedLook  = nil -- original appearance snapshot for supported systems

-- SetPlayerUniform(playerPed, uniformData)
-- uniformData: { tshirt_1, tshirt_2, torso_1, torso_2, arms, pants_1, pants_2,
--               shoes_1, shoes_2, helmet_1, helmet_2, chain_1, chain_2, ears_1, ears_2 }
exports('SetPlayerUniform', PLLib.Wrap('SetPlayerUniform', function(playerPed, uniformData)
    if not uniformData then return end

    if _system == 'esx_skin' then
        TriggerEvent('skinchanger:getSkin', function(skin)
            TriggerEvent('skinchanger:loadClothes', skin, uniformData)
        end)

    elseif _system == 'illenium-appearance' then
        if not _savedLook then
            _savedLook = exports['illenium-appearance']:getPedAppearance(playerPed)
        end
        Wait(100)
        exports['illenium-appearance']:setPedComponents(playerPed, {
            { component_id = 11, drawable = uniformData.torso_1,  texture = uniformData.torso_2  },
            { component_id = 8,  drawable = uniformData.tshirt_1, texture = uniformData.tshirt_2 },
            { component_id = 3,  drawable = uniformData.arms,     texture = 0                    },
            { component_id = 4,  drawable = uniformData.pants_1,  texture = uniformData.pants_2  },
            { component_id = 6,  drawable = uniformData.shoes_1,  texture = uniformData.shoes_2  },
            { component_id = 7,  drawable = uniformData.chain_1,  texture = uniformData.chain_2  },
            { props = {
                { prop_id = 1, drawable = uniformData.glasses_1 or 0, texture = uniformData.glasses_2 or 0 },
                { prop_id = 2, drawable = uniformData.ears_1    or 0, texture = uniformData.ears_2    or 0 },
            }},
        })

    elseif _system == 'fivem-appearance' then
        if not _savedLook then
            _savedLook = exports['fivem-appearance']:getPedAppearance(playerPed)
        end
        Wait(100)
        exports['fivem-appearance']:setPedComponents(playerPed, {
            { component_id = 11, drawable = uniformData.torso_1,  texture = uniformData.torso_2  },
            { component_id = 8,  drawable = uniformData.tshirt_1, texture = uniformData.tshirt_2 },
            { component_id = 3,  drawable = uniformData.arms,     texture = 0                    },
            { component_id = 4,  drawable = uniformData.pants_1,  texture = uniformData.pants_2  },
            { component_id = 6,  drawable = uniformData.shoes_1,  texture = uniformData.shoes_2  },
            { component_id = 7,  drawable = uniformData.chain_1,  texture = uniformData.chain_2  },
            { props = {
                { prop_id = 1, drawable = uniformData.glasses_1 or 0, texture = uniformData.glasses_2 or 0 },
                { prop_id = 2, drawable = uniformData.ears_1    or 0, texture = uniformData.ears_2    or 0 },
            }},
        })

    elseif _system == 'tgiann-clothing' then
        exports['tgiann-clothing']:ChangeScriptClothe({
            { name = 'tshirt_1', val = uniformData.tshirt_1 }, { name = 'tshirt_2', val = uniformData.tshirt_2 },
            { name = 'torso_1',  val = uniformData.torso_1  }, { name = 'torso_2',  val = uniformData.torso_2  },
            { name = 'decals_1', val = uniformData.decals_1 }, { name = 'decals_2', val = uniformData.decals_2 },
            { name = 'arms_1',   val = uniformData.arms     }, { name = 'arms_2',   val = 0                    },
            { name = 'pants_1',  val = uniformData.pants_1  }, { name = 'pants_2',  val = uniformData.pants_2  },
            { name = 'shoes_1',  val = uniformData.shoes_1  }, { name = 'shoes_2',  val = uniformData.shoes_2  },
            { name = 'helmet_1', val = uniformData.helmet_1 }, { name = 'helmet_2', val = uniformData.helmet_2 },
            { name = 'chain_1',  val = uniformData.chain_1  }, { name = 'chain_2',  val = uniformData.chain_2  },
            { name = 'ears_1',   val = uniformData.ears_1   }, { name = 'ears_2',   val = uniformData.ears_2   },
            { name = 'bags_1',   val = 0 }, { name = 'bags_2',      val = 0 },
            { name = 'glasses_1',val = 0 }, { name = 'glasses_2',   val = 0 },
            { name = 'watches_1',val = 0 }, { name = 'watches_2',   val = 0 },
            { name = 'bracelets_1',val=0 }, { name = 'bracelets_2', val = 0 },
            { name = 'bproof_1', val = 0 }, { name = 'bproof_2',    val = 0 },
            { name = 'mask_1',   val = 0 }, { name = 'mask_2',      val = 0 },
        })

    elseif _system == 'rcore_clothing' then
        if not _savedLook then
            _savedLook = exports['rcore_clothing']:getPlayerClothing()
        end
        Wait(100)
        exports['rcore_clothing']:setPedSkin(playerPed, {
            { name = 'tshirt_1', val = uniformData.tshirt_1 }, { name = 'tshirt_2', val = uniformData.tshirt_2 },
            { name = 'torso_1',  val = uniformData.torso_1  }, { name = 'torso_2',  val = uniformData.torso_2  },
            { name = 'decals_1', val = uniformData.decals_1 }, { name = 'decals_2', val = uniformData.decals_2 },
            { name = 'arms',     val = uniformData.arms     },
            { name = 'pants_1',  val = uniformData.pants_1  }, { name = 'pants_2',  val = uniformData.pants_2  },
            { name = 'shoes_1',  val = uniformData.shoes_1  }, { name = 'shoes_2',  val = uniformData.shoes_2  },
            { name = 'helmet_1', val = uniformData.helmet_1 }, { name = 'helmet_2', val = uniformData.helmet_2 },
            { name = 'chain_1',  val = uniformData.chain_1  }, { name = 'chain_2',  val = uniformData.chain_2  },
            { name = 'ears_1',   val = uniformData.ears_1   }, { name = 'ears_2',   val = uniformData.ears_2   },
            { name = 'bags_1',   val = 0 }, { name = 'bags_2',    val = 0 },
            { name = 'glasses_1',val = -1},  { name = 'glasses_2', val = 0 },
            { name = 'watches_1',val = -1},  { name = 'watches_2', val = 0 },
            { name = 'bracelets_1',val=-1},  { name = 'bracelets_2',val= 0 },
            { name = 'bproof_1', val = 0 }, { name = 'bproof_2',  val = 0 },
            { name = 'mask_1',   val = 0 }, { name = 'mask_2',    val = 0 },
        })

    elseif _system == 'qb-clothing' then
        TriggerEvent('qb-clothing:client:loadOutfit', {
            outfitData = {
                ['pants']   = { item = uniformData.pants_1,  texture = uniformData.pants_2  },
                ['arms']    = { item = uniformData.arms,      texture = 0                    },
                ['t-shirt'] = { item = uniformData.tshirt_1, texture = uniformData.tshirt_2 },
                ['torso2']  = { item = uniformData.torso_1,  texture = uniformData.torso_2  },
                ['shoes']   = { item = uniformData.shoes_1,  texture = uniformData.shoes_2  },
                ['glass']   = { item = uniformData.glasses_1,texture = uniformData.glasses_2},
                ['ear']     = { item = uniformData.ears_1,   texture = uniformData.ears_2   },
                ['mask']    = { item = uniformData.mask_1,   texture = uniformData.mask_2   },
                ['hat']     = { item = uniformData.helmet_1, texture = uniformData.helmet_2 },
            },
        })
    end
end))

-- RevertPlayerClothing() — restores the player's original appearance
exports('RevertPlayerClothing', PLLib.Wrap('RevertPlayerClothing', function()
    if _system == 'esx_skin' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
    elseif _system == 'illenium-appearance' then
        if _savedLook then
            exports['illenium-appearance']:setPedAppearance(PlayerPedId(), _savedLook)
            _savedLook = nil
        end
    elseif _system == 'fivem-appearance' then
        if _savedLook then
            exports['fivem-appearance']:setPedAppearance(PlayerPedId(), _savedLook)
            _savedLook = nil
        end
    elseif _system == 'tgiann-clothing' then
        exports['tgiann-clothing']:ChangeScriptClothe()
    elseif _system == 'qb-clothing' then
        TriggerServerEvent('qb-clothes:loadPlayerSkin')
    elseif _system == 'rcore_clothing' then
        TriggerServerEvent('rcore_clothing:reloadSkin')
        _savedLook = nil
    end
end))
