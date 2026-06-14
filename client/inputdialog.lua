local _system = PLLib.InputDialog

-- ShowInputDialog(title, options, submitText) → table of results, or nil if cancelled
-- options format follows ox_lib inputDialog spec; lation_ui receives the same table
exports('ShowInputDialog', PLLib.Wrap('ShowInputDialog', function(title, options, submitText)
    if _system == 'ox_lib' then
        return lib.inputDialog(title, options)
    elseif _system == 'lation_ui' then
        return exports.lation_ui:input({
            title      = title,
            submitText = submitText,
            options    = options,
        })
    end
end))
