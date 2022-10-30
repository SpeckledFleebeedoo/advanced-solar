data:extend({
    {
        type = "int-setting",
        name = "sf-advanced-solar-production",
        localised_description = "How much energy each advanced solar panel produces in kW. (Minimum 167, default = 1000)",
        default_value = 1000,
        minimum_value = 167,
        setting_type = "startup"
    },
    {
        type = "double-setting",
        name = "sf-advanced-solar-costscale",
        localised_description = "How the recipe cost scales with solar panel output.",
        default_value = 1.0,
        minimum_value = 0.01,
        setting_type = "startup"
    }
})