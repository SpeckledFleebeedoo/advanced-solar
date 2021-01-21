local productionsetting = settings.startup["advanced-solar-production"].value
local capacitysetting = (productionsetting / 60) * 5
local chargespeedsetting = (productionsetting / 60) * 300
local costfactor = math.floor(productionsetting / 60)
-- Calculates how much more an item should cost compared to a standard accumulator.

function advanced_accumulator_picture(tint, repeat_count)
    return
    {
      layers =
      {
        {
          filename = "__Speckled-advanced-solar__/graphics/entity/hr-advanced-accumulator.png",
          priority = "high",
          width = 188,
          height = 230,
          repeat_count = repeat_count,
          shift = util.by_pixel(0, -5),
          tint = tint,
          animation_speed = 0.5,
          scale = 0.52
        },
        {
          filename = "__Speckled-advanced-solar__/graphics/entity/hr-accumulator-shadow.png",
          priority = "high",
          width = 234,
          height = 147,
          repeat_count = repeat_count,
          shift = util.by_pixel(29, 6),
          draw_as_shadow = true,
          scale = 0.52,
        }
      }
    }
  end

  
  function advanced_accumulator_charge()
    return
    {
      layers =
      {
        advanced_accumulator_picture({ r=1, g=1, b=1, a=1 } , 24),
        {
          filename = "__base__/graphics/entity/accumulator/accumulator-charge.png",
          priority = "high",
          width = 90,
          height = 100,
          line_length = 6,
          frame_count = 24,
          draw_as_glow = true,
          shift = util.by_pixel(0, -15),
          scale = 1.5,
          hr_version =
          {
            filename = "__base__/graphics/entity/accumulator/hr-accumulator-charge.png",
            priority = "high",
            width = 178,
            height = 206,
            line_length = 6,
            frame_count = 24,
            draw_as_glow = true,
            shift = util.by_pixel(0, -15),
            scale = 0.75
          }
        }
      }
    }
  end
  
  function advanced_accumulator_reflection()
    return
    {
      pictures =
        {
          filename = "__base__/graphics/entity/accumulator/accumulator-reflection.png",
          priority = "extra-high",
          width = 20,
          height = 24,
          shift = util.by_pixel(0, 50),
          variation_count = 1,
          scale = 7.5,
        },
        rotate = false,
        orientation_to_variation = false
    }
  end
  
  function advanced_accumulator_discharge()
    return
    {
      layers =
      {
        advanced_accumulator_picture({ r=1, g=1, b=1, a=1 } , 24),
        {
          filename = "__base__/graphics/entity/accumulator/accumulator-discharge.png",
          priority = "high",
          width = 88,
          height = 104,
          line_length = 6,
          frame_count = 24,
          draw_as_glow = true,
          shift = util.by_pixel(-2, -15),
          scale = 1.5,
          hr_version =
          {
            filename = "__base__/graphics/entity/accumulator/hr-accumulator-discharge.png",
            priority = "high",
            width = 170,
            height = 210,
            line_length = 6,
            frame_count = 24,
            draw_as_glow = true,
            shift = util.by_pixel(-1, -15),
            scale = 0.75
          }
        }
      }
    }
  end



data:extend(
{
    {
      type = "recipe",
      name = "advanced-accumulator",
      enabled = false,
      ingredients = {{"advanced-circuit", 10}, {"iron-plate",15}, {"accumulator", costfactor}},
      energy_required = costfactor * 5,
      result = "advanced-accumulator"
    },
    {
        type = "item",
        name = "advanced-accumulator",
        icons = {
          {
              icon = "__base__/graphics/icons/accumulator.png",
          },
          {
              icon = "__base__/graphics/icons/accumulator.png",
              tint = {0, 0, 1, 0.001}
          }
        },
        icon_size = 64,
        place_result = "advanced-accumulator",
        stack_size = 100,
        subgroup = "energy",
        order = "e[accumulator]-b[advanced-accumulator]"
    },
    {
        type = "accumulator",
        name = "advanced-accumulator",
        icons = {
          {
              icon = "__base__/graphics/icons/accumulator.png",
          },
          {
              icon = "__base__/graphics/icons/accumulator.png",
              tint = {0, 0, 1, 0.001}
          }
        },
        icon_size = 64,
        flags = {"placeable-neutral", "player-creation"},
        minable = {hardness = 0.1, mining_time = 0.2, result = "advanced-accumulator"},
        max_health = 800,
        corpse = "accumulator-remnants",
        collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        energy_source =
        {
          type = "electric",
          usage_priority = "tertiary",
          buffer_capacity = tostring(capacitysetting).."MJ",
          input_flow_limit = tostring(chargespeedsetting).."MW",
          output_flow_limit = tostring(chargespeedsetting).."MW"
        },

        picture = advanced_accumulator_picture(),
        charge_animation = advanced_accumulator_charge(),
        discharge_animation = advanced_accumulator_discharge(),
        charge_cooldown = 30,
        discharge_cooldown = 60
    },
    {
        type = "technology",
        name = "advanced-accumulator",
        icons = {
          {
              icon = "__base__/graphics/technology/electric-energy-acumulators.png",
          },
          {
              icon = "__base__/graphics/technology/electric-energy-acumulators.png",
              tint = {0, 0, 1, 0.001}
          }
        },
        icon_size = 256,
        effects = {{type = "unlock-recipe", recipe = "advanced-accumulator"}},
        prerequisites = {"solar-energy", "advanced-electronics", "chemical-science-pack"},
        unit = {count=200, ingredients = {{"automation-science-pack", 1},{"logistic-science-pack", 1},{"chemical-science-pack",1},{"production-science-pack",1}}, time=30}
    }
}
)
