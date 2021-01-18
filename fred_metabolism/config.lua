Config = {

["MSG"] = "Has consumido ", -- Message to display when consumed

-- INITIAL VALUES
["InitialFood"] = 100, -- INITIAL FOOD -- MAX VALUE 100%
["InitialWater"] = 100, -- INITIAL FOOD -- MAX VALUE 100%

-- TICK: This is the time (rate) it takes to excecute every check 
-- For e.g: 2 food is drain per tick
["Tick"] = 20000, -- 1000 = 1 second; 20000 = 20 seconds; 3600 = 3,5 seconds

-- DRAINS PER TICK
["FoodDrainIdle"] = 0.5, -- Food drop rate on stand by
["FoodDrainRunning"] = 2, -- Food drop rate while running
["FoodDrainWalking"] = 0.5, -- Food drop rate while walking
["WaterDrainIdle"] = 0.5, -- Water drop rate on stand by
["WaterDrainRunning"] = 3, -- Water drop rate while running
["WaterDrainWalking"] = 1, -- Water drio rate while walking

-- HEALTH LOSS STRIPE
["HealthLoss"] = 15, -- Health you lose per tick
["FoodStripe"] = 20, -- Food stripe that determines when you start to lose health
["WaterStripe"] = 20, -- Water stripe that determines when you start to lose health

-- TEMPERATURE DEBUFF STRIPE
["MinTemperature"] = -20, -- -20°C From this temperature below, you'll lose more food and water
["MaxTemperature"] = 20, -- 20°C From this temperature avobe, you'll lose more food and water

-- FOOD AND WATER DROP RATE FROM TEMPERATURE
["WaterHotLoss"] = 3, -- Water drop rate increment for higher temperatures
["FoodColdLoss"] = 3, -- Food drop rate increment for lower temperatures


}


-- JUST ADD YOUR ITEMS HERE WITH THE VALUES YOU WANT
Config.ItemsToUse = {

    --
    -- FOOD
    --
    {
        ["Name"] = "consumable_peach", -- Item DB NAME
        ["DisplayName"] = "Durazno", -- Name on screen (label from DB)
        ["Hunger"] = 35, -- Food it gives
        ["Thirst"] = 5, -- Water it gives
        ["InnerCoreStamina"] = 0, -- Inner Core Stamina effect
        ["InnerCoreStaminaGold"] = 0.0, -- Inner Core Stamina Gold overpower
        ["OuterCoreStaminaGold"] = 0.0, -- Outer Core Stamina Gold overpower
        ["InnerCoreHealth"] = 0, -- Inner Core Health effect
        --["OuterCoreHealth"] = 0,
        ["InnerCoreHealthGold"] = 0.0, -- Inner Core Health Gold overpower
        ["OuterCoreHealthGold"] = 100.0, -- Outer Core Health Gold overpower


    },
    {
        ["Name"] = "consumable_meat_greavy", -- DB NAME
        ["DisplayName"] = "Carne Cocinada", 
        ["Hunger"] = 0,
        ["Thirst"] = 50,
        ["InnerCoreStamina"] = 0,
        ["InnerCoreStaminaGold"] = 0.0,
        ["OuterCoreStaminaGold"] = 100.0,
        ["InnerCoreHealth"] = 0,
        --["OuterCoreHealth"] = 0,
        ["InnerCoreHealthGold"] = 0.0,
        ["OuterCoreHealthGold"] = 0.0,


    },

    --
    -- DRINKS
    --
    {
        ["Name"] = "consumable_coffee", -- DB NAME
        ["DisplayName"] = "Cafe", 
        ["Hunger"] = 0,
        ["Thirst"] = 50,
        ["InnerCoreStamina"] = 0,
        ["InnerCoreStaminaGold"] = 0.0,
        ["OuterCoreStaminaGold"] = 100.0,
        ["InnerCoreHealth"] = 0,
        --["OuterCoreHealth"] = 0,
        ["InnerCoreHealthGold"] = 0.0,
        ["OuterCoreHealthGold"] = 0.0,


    },

    --
    -- MEDICINES
    --
    {
        ["Name"] = "consumable_medicine", -- DB NAME
        ["DisplayName"] = "Medicina", 
        ["Hunger"] = 0,
        ["Thirst"] = 5,
        ["InnerCoreStamina"] = 0,
        ["InnerCoreStaminaGold"] = 0.0,
        ["OuterCoreStaminaGold"] = 100.0,
        ["InnerCoreHealth"] = 0,
        --["OuterCoreHealth"] = 0,
        ["InnerCoreHealthGold"] = 100.0,
        ["OuterCoreHealthGold"] = 0.0,


    },






}