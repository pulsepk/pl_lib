local _system  = PLLib.GetTextUI()
local _isOpen  = false
local _current = nil

-- TextUIShow(text, opts)
-- opts: { position, icon, style, align, color }
exports('TextUIShow', function(text, opts)
    if _current == text then return end
    _current = text
    opts = opts or {}

    if _system == 'ox_lib' then
        lib.showTextUI(text, {
            position = opts.position or 'left-center',
            icon     = opts.icon or 'fa-solid fa-circle-info',
            style    = opts.style or { borderRadius = 12, backgroundColor = '#141517', color = '#C1C2C5' },
        })
    elseif _system == 'qb-core' then
        exports['qb-core']:DrawText(text, opts.align or 'right')
    elseif _system == 'jg-textui' then
        exports['jg-textui']:DrawText(text)
    elseif _system == 'esx_textui' then
        exports['esx_textui']:TextUI(text)
    elseif _system == 'cd_drawtextui' then
        TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
    elseif _system == 'brutal_textui' then
        exports['brutal_textui']:Open(text, opts.color or 'blue')
    elseif _system == 'lation_ui' then
        exports.lation_ui:showText({ description = text })
    end

    _isOpen = true
end)

exports('TextUIHide', function()
    if _system == 'ox_lib' then
        lib.hideTextUI()
    elseif _system == 'qb-core' then
        exports['qb-core']:HideText()
    elseif _system == 'jg-textui' then
        exports['jg-textui']:HideText()
    elseif _system == 'esx_textui' then
        exports['esx_textui']:HideUI()
    elseif _system == 'cd_drawtextui' then
        TriggerEvent('cd_drawtextui:HideUI')
    elseif _system == 'brutal_textui' then
        exports['brutal_textui']:Close()
    elseif _system == 'lation_ui' then
        exports.lation_ui:hideText()
    end

    _isOpen  = false
    _current = nil
end)

-- Returns: isOpen (bool), currentText (string|nil)
exports('TextUIIsOpen', function()
    return _isOpen, _current
end)
