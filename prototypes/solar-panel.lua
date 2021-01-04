local productionsetting = settings.startup["advanced-solar-production"].value
local costfactor = math.floor(productionsetting / 60)

data:extend(
{
    {
        type = "recipe",
        name = "advanced-solar",
        enabled = false,
        ingredients = {{"advanced-circuit", 20}, {"steel-plate",10}, {"solar-panel", costfactor}},
        energy_required = costfactor * 5,
        result = "advanced-solar"
    },
    {
        type = "item",
        name = "advanced-solar",
        icons = {
            {
                icon = "__base__/graphics/icons/solar-panel.png",
            },
            {
                icon = "__base__/graphics/icons/solar-panel.png",
                tint = {0, 0, 1, 0.001}
            }
        },
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
        minable = {hardness = 0.1, mining_time = 0.2, result = "advanced-solar"},
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
        production = tostring(productionsetting).."kW"
    },
    
    {
        type = "technology",
        name = "advanced-solar",
        icons = {
            {
                icon = "__base__/graphics/technology/solar-energy.png",
            },
            {
                icon = "__base__/graphics/technology/solar-energy.png",
                tint = {0, 0, 1, 0.001}
            }
        },
        icon_size = 256, icon_mipmaps = 4,
        effects = {{type = "unlock-recipe", recipe = "advanced-solar"}},
        prerequisites = {"solar-energy", "advanced-electronics", "production-science-pack"},
        unit = {count=200, ingredients = {{"automation-science-pack", 1},{"logistic-science-pack", 1},{"chemical-science-pack",1},{"production-science-pack",1}}, time=30}
    }
}
)
