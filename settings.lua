data:extend({
    {
        type = "bool-setting",
        name = "extangels-adjust-ordering",
        setting_type = "startup",
        default_value = true,
    },
    {
        type = "bool-setting",
        name = "extangels-legacy-inventory-sizes",
        setting_type = "startup",
        default_value = false,
    }
})

if not mods["bobplates"] then
    if not mods["angelsindustries"] then
        error("Without bobplates, extendedangels requires angelsindustries!")
    else
        data.raw["bool-setting"]["angels-enable-industries"].hidden = true
        data.raw["bool-setting"]["angels-enable-industries"].forced_value = true
    end
end
