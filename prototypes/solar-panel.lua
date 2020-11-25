data:extend(
{
    {
        type = "recipe",
        name = "advanced-solar",
        enabled = false,
        ingredients = {{"advanced-circuit", 10}, {"steel-plate",10}, {"solar-panel",4}},
        energy_required = 20,
        result = "advanced-solar"
    },
    {
        type = "item",
        name = "advanced-solar",
        icon = "__base__/graphics/icons/solar-panel.png",
        icon_size = 64,
        place_result = "advanced-solar",
        stack_size = 100,
        subgroup = "energy",
        order = "d[solar-panel]-b[advanced-solar]"
    },
    {
        type = "solar-panel",
        name = "advanced-solar",
        icon = "__base__/graphics/icons/solar-panel.png",
        icon_size = 64,
        flags = {"placeable-neutral", "player-creation"},
        minable = {haredness = 0.1, mining_time = 0.2, result = "advanced-solar"},
        max_health = 800,
        corpse = "solar-panel-remnants",
        collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
        selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
        energy_source =
        {
            type = "electric",
            usage_priority = "solar"
        },
        picture = 
        {
                {
                    filename = "__Speckled-advanced-solar__/graphics/entity/big-solar-panel.png",
                    priority = "high",
                    width = 320,
                    height = 320,
                    scale = 0.5
                }
        },
        overlay =
        {
            {
                filename = "__Speckled-advanced-solar__/graphics/entity/big-solar-panel-shadow.png",
                priority = "high",
                width = 347,
                height = 304,
                scale = 0.5,
                shift = util.by_pixel(10,7)
            }
        },
        production = "1MW"
    },
    {
        type = "technology",
        name = "advanced-solar",
        icon = "__base__/graphics/technology/solar-energy.png",
        icon_size = 128,
        effects = {{type = "unlock-recipe", recipe = "advanced-solar"}},
        prerequisites = {"solar-energy", "advanced-electronics", "chemical-science-pack"},
        unit = {count=200, ingredients = {{"automation-science-pack", 1},{"logistic-science-pack", 1},{"chemical-science-pack",1}}, time=30}
    }
}
)
