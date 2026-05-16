local _system = PLLib.ContextMenu

-- ContextMenu(id, title, options, menu, header, description)
-- Registers and immediately opens a context menu.
-- options format follows ox_lib registerContext spec; lation_ui receives the same fields.
exports('ContextMenu', function(id, title, options, menu, header, description)
    if _system == 'ox_lib' then
        lib.registerContext({
            id          = id,
            title       = title,
            description = description or nil,
            options     = options,
            menu        = menu or nil,
            header      = header or nil,
        })
        lib.showContext(id)
    elseif _system == 'lation_ui' then
        exports.lation_ui:registerMenu({
            id       = id,
            title    = title,
            subtitle = description or nil,
            options  = options,
            menu     = menu or nil,
            header   = header or nil,
        })
        exports.lation_ui:showMenu(id)
    end
end)

-- RegisterListMenu(id, title, items, position)
-- items    : array of strings or {label=...} tables
-- position : (ox_lib) 'top-right' | 'top-left' | 'bottom-right' | 'bottom-left'
-- Fires TriggerEvent('pl_lib:listMenuSelected', id, index) on selection so calling
-- scripts can handle the result without passing functions across resource boundaries.
exports('RegisterListMenu', function(id, title, items, position)
    if _system == 'ox_lib' then
        lib.registerMenu({
            id       = id,
            title    = title,
            position = position or 'top-right',
            options  = {{ label = title, values = items, description = '' }},
            onClose  = function() lib.hideMenu(id) end,
        }, function(_, scrollIndex)
            TriggerEvent('pl_lib:listMenuSelected', id, scrollIndex)
        end)
        lib.showMenu(id)

    elseif _system == 'lation_ui' then
        local opts = {}
        for i, item in ipairs(items) do
            local idx = i
            opts[#opts + 1] = {
                title    = type(item) == 'table' and (item.label or tostring(item)) or item,
                icon     = 'fas fa-money-bill',
                onSelect = function()
                    TriggerEvent('pl_lib:listMenuSelected', id, idx)
                end,
            }
        end
        exports.lation_ui:registerMenu({
            id      = id,
            title   = title,
            options = opts,
            onExit  = function() exports.lation_ui:hideMenu(id) end,
        })
        exports.lation_ui:showMenu(id)
    end
end)
