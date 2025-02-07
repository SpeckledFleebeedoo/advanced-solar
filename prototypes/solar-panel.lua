local productionsetting = settings.startup["sf-advanced-solar-production"].value
local costscaling = settings.startup["sf-advanced-solar-costscale"].value
local costfactor = math.floor(productionsetting * costscaling / 60)
-- Calculates how much more this panel produces than a normal solar panel, used for recipe balancing.

data:extend({
  {
    type = "recipe",
    name = "sf-advanced-solar",
    enabled = false,
    ingredients = {
      {type = "item", name = "advanced-circuit", amount = 20}, 
      {type = "item", name = "steel-plate", amount = 10}, 
      {type = "item", name = "solar-panel", amount = costfactor}
    },
    energy_required = costfactor * 5,
    results = {
      {type = "item", name = "sf-advanced-solar", amount = 1}
    }
  },
  {
    type = "item",
    name = "sf-advanced-solar",
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
    place_result = "sf-advanced-solar",
    stack_size = 100,
    subgroup = "energy",
    order = "d[solar-panel]-b[advanced-solar]"
  },
  {
    type = "solar-panel",
    name = "sf-advanced-solar",
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
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.1, mining_time = 0.2, result = "sf-advanced-solar"},
    max_health = 800,
    corpse = "solar-panel-remnants",
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    energy_source = {
      type = "electric",
      usage_priority = "solar"
    },
    picture = {
      {
        filename = "__Speckled-advanced-solar__/graphics/entity/big-solar-panel.png",
        priority = "high",
        width = 320,
        height = 320,
        scale = 0.5
      }
    },
    overlay = {
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
    name = "sf-advanced-solar",
    icons = {
      {
        icon = "__base__/graphics/technology/solar-energy.png",
        icon_size = 256
      },
      {
        icon = "__base__/graphics/technology/solar-energy.png",
        icon_size = 256,
        tint = {0, 0, 1, 0.001}
      }
    },
    effects = {{type = "unlock-recipe", recipe = "sf-advanced-solar"}},
    prerequisites = {"solar-energy", "production-science-pack"},
    unit = {
      count=500, 
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack",1},
        {"production-science-pack",1}
      }, 
      time=30}
  }
})
