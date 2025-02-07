local productionsetting = settings.startup["sf-advanced-solar-production"].value
local costscaling = settings.startup["sf-advanced-solar-costscale"].value
local capacitysetting = (productionsetting * costscaling / 60) * 5
local chargespeedsetting = (productionsetting * costscaling / 60) * 300
local costfactor = math.floor(productionsetting * costscaling / 60)
-- Calculates how much more an item should cost compared to a standard accumulator.

function advanced_accumulator_picture(tint, repeat_count)
  return
  {
    layers =
    {
      {
        filename = "__Speckled-advanced-solar__/graphics/entity/advanced-accumulator.png",
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
        filename = "__Speckled-advanced-solar__/graphics/entity/advanced-accumulator-shadow.png",
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
          filename = "__Speckled-advanced-solar__/graphics/entity/advanced-accumulator-charge.png",
          priority = "high",
          width = 178,
          height = 210,
          line_length = 6,
          frame_count = 24,
          draw_as_glow = true,
          shift = util.by_pixel(2, -10),
          scale = 0.75
      }
    }
  }
end
  
function advanced_accumulator_reflection()
  return
  {
    pictures =
      {
        filename = "__Speckled-advanced-solar__/graphics/entity/advanced-accumulator-reflection.png",
        priority = "low",
        width = 24,
        height = 24,
        shift = util.by_pixel(-5, 50),
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
          filename = "__Speckled-advanced-solar__/graphics/entity/advanced-accumulator-discharge.png",
          priority = "high",
          width = 174,
          height = 214,
          line_length = 6,
          frame_count = 24,
          draw_as_glow = true,
          shift = util.by_pixel(-1, -10),
          scale = 0.75
      }
    }
  }
end

data:extend(
  {
    {
      type = "recipe",
      name = "sf-advanced-accumulator",
      enabled = false,
      ingredients = {
        {type = "item", name = "advanced-circuit", amount = 10}, 
        {type = "item", name = "iron-plate", amount = 15}, 
        {type = "item", name = "accumulator", amount =  costfactor}
      },
      energy_required = costfactor * 5,
      results = {
        {type = "item", name = "sf-advanced-accumulator", amount = 1}
      }
    },
    {
      type = "item",
      name = "sf-advanced-accumulator",
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
      place_result = "sf-advanced-accumulator",
      stack_size = 100,
      subgroup = "energy",
      order = "e[accumulator]-b[advanced-accumulator]"
    },
    {
      type = "accumulator",
      name = "sf-advanced-accumulator",
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
      minable = {hardness = 0.1, mining_time = 0.2, result = "sf-advanced-accumulator"},
      max_health = 800,
      corpse = "accumulator-remnants",
      collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
      selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
      energy_source =
      {
        type = "electric",
        usage_priority = "tertiary",
        buffer_capacity = tostring(capacitysetting).."MJ",
        input_flow_limit = tostring(chargespeedsetting).."kW",
        output_flow_limit = tostring(chargespeedsetting).."kW"
      },
      chargable_graphics = {
        picture = advanced_accumulator_picture(),
        charge_animation = advanced_accumulator_charge(),
        discharge_animation = advanced_accumulator_discharge(),
        charge_cooldown = 30,
        discharge_cooldown = 60
      },
      water_reflection = advanced_accumulator_reflection(),
      working_sound =
        {
          main_sounds =
          {
            {
              sound = {filename = "__base__/sound/accumulator-working.ogg", volume = 0.4, modifiers = volume_multiplier("main-menu", 1.44)},
              match_volume_to_activity = true,
              activity_to_volume_modifiers = {offset = 2, inverted = true},
              fade_in_ticks = 4,
              fade_out_ticks = 20
            },
            {
              sound = {filename = "__base__/sound/accumulator-discharging.ogg", volume = 0.4, modifiers = volume_multiplier("main-menu", 1.44)},
              match_volume_to_activity = true,
              activity_to_volume_modifiers = {offset = 1},
              fade_in_ticks = 4,
              fade_out_ticks = 20
            }
          },
          idle_sound = {filename = "__base__/sound/accumulator-idle.ogg", volume = 0.35},
          max_sounds_per_type = 3,
          audible_distance_modifier = 0.5
        },
      circuit_connector = circuit_connector_definitions["accumulator"],
      circuit_wire_max_distance = default_circuit_wire_max_distance,

      default_output_signal = {type = "virtual", name = "signal-A"}
    },
    {
      type = "technology",
      name = "sf-advanced-accumulator",
      icons = {
        {
            icon = "__base__/graphics/technology/electric-energy-acumulators.png",
            icon_size = 256
        },
        {
            icon = "__base__/graphics/technology/electric-energy-acumulators.png",
            icon_size = 256,
            tint = {0, 0, 1, 0.001}
        }
      },
      effects = {{type = "unlock-recipe", recipe = "sf-advanced-accumulator"}},
      prerequisites = {"electric-energy-accumulators", "production-science-pack"},
      unit = {count=500, ingredients = {{"automation-science-pack", 1},{"logistic-science-pack", 1},{"chemical-science-pack",1},{"production-science-pack",1}}, time=30}
    }
  }
)
