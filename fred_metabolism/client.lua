local water = Config["InitialWater"]
local food = Config["InitialFood"]


function getThirst()
	return water
end

function getHunger()
	return food
end


Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        Citizen.InvokeNative(0xB98B78C3768AF6E0,true)
		local temp = math.floor(GetTemperatureAtCoords(coords))
		local hot = 0
		local cold = 0


		if temp > Config["MaxTemperature"] then 
			hot = Config["WaterHotLoss"]
		else 
			hot = 0
		end

		if temp < Config["MinTemperature"] then
			cold = Config["FoodColdLoss"]
		else 
			cold = 0
		end

        if IsPedRunning(PlayerPedId()) then
            food = food - (Config["FoodDrainRunning"] + cold)
            water = water - (Config["WaterDrainRunning"] + hot)
        elseif IsPedWalking(PlayerPedId()) then
            food = food - (Config["FoodDrainWalking"] + cold)
            water = water - (Config["WaterDrainWalking"] + hot)
        else
    		food = food - (Config["FoodDrainIdle"] + cold)
			water = water - (Config["WaterDrainIdle"] + hot)
		end
		Citizen.Wait(Config["Tick"])
		if food < Config["FoodStripe"] or water < Config["WaterStripe"] then
			local newhealth = GetAttributeCoreValue(PlayerPedId(), 0) - Config["HealthLoss"]
			Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, newhealth) 
        end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if food <= 1 or water <= 1 then
            food = 0
            water = 0
            local pl = Citizen.InvokeNative(0x217E9DC48139933D)
    		local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
        	Citizen.InvokeNative(0x697157CED63F18D4, PlayerPedId(), 500000, false, true, true)
            food = 40
            water = 40
        end
    end
end)



RegisterNetEvent("fred:useItem")
AddEventHandler("fred:useItem", function(index)

	food = food + tonumber(Config.ItemsToUse[index]["Hunger"])
	water = water + tonumber(Config.ItemsToUse[index]["Thirst"])

	if (food < 0) then
		food = 0
	end

	if (food > 100) then
		food = 100
	end

	if water < 0 then
		water = 0
	end

	if water > 100 then
		water = 100
	end

	TaskItemInteraction(PlayerPedId(), nil, GetHashKey("EAT_MULTI_BITE_FOOD_SPHERE_D8-2_SANDWICH_QUICK_LEFT_HAND"), true, 0, 0)
	
	if (Config.ItemsToUse[index]["InnerCoreStamina"] ~= 0) then
		stamina = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 1) --ACTUAL STAMINA CORE GETTER
		newStamina = stamina + tonumber(Config.ItemsToUse[index]["InnerCoreStamina"])

		if (newStamina > 100) then
		newStamina = 100
		end
		Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, newStamina)
	end

	if (Config.ItemsToUse[index]["InnerCoreHealth"] ~= 0)then
		health = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 0) --ACTUAL HEALTH CORE GETTER
		newHealth = health + tonumber(Config.ItemsToUse[index]["InnerCoreHealth"])

		if (newHealth > 100) then
		newHealth = 100
		end
		Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, newHealth)
	end

		--TO DO OUTER CORE HEALTH parametro = outerCoreHealth

	--GOLDS

	if (Config.ItemsToUse[index]["InnerCoreStaminaGold"] ~= 0.0) then
		Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 1, Config.ItemsToUse[index]["InnerCoreStaminaGold"], true)
	end
	if (Config.ItemsToUse[index]["OuterCoreStaminaGold"] ~= 0.0) then
		Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerPedId(), 1, Config.ItemsToUse[index]["OuterCoreStaminaGold"], true)
	end
	if (Config.ItemsToUse[index]["InnerCoreHealthGold"] ~= 0.0) then
		Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 0, Config.ItemsToUse[index]["InnerCoreHealthGold"], true)
	end
	if	(Config.ItemsToUse[index]["OuterCoreHealthGold"] ~= 0.0) then
		Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerPedId(), 0, Config.ItemsToUse[index]["OuterCoreHealthGold"], true)
	end

	TaskItemInteraction(PlayerPedId(), nil, GetHashKey("EAT_MULTI_BITE_FOOD_SPHERE_D8-2_SANDWICH_QUICK_LEFT_HAND"), true, 0, 0)
end)

-- EVENT, USE THIS FOR OTHER RESOURCES
RegisterNetEvent("fred:consume")
AddEventHandler("fred:consume", function(hunger, thirst, innercorestamina, innercorestaminagold, outercorestaminagold, innercorehealth, innercorehealthgold, outercorehealthgold)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	food = food + tonumber(hunger)
	water = water + tonumber(thirst)

	if (food < 0) then
		food = 0
	end

	if (food > 100) then
		food = 100
	end

	if water < 0 then
		water = 0
	end

	if water > 100 then
		water = 100
	end


	if (innercorestamina ~= 0) then
		stamina = Citizen.InvokeNative(0x36731AC041289BB1, ped, 1) --ACTUAL STAMINA CORE GETTER
		newStamina = stamina + tonumber(innercorestamina)

		if (newStamina > 100) then
		newStamina = 100
		end
		Citizen.InvokeNative(0xC6258F41D86676E0, ped, 1, newStamina)
	end

	if (innercorehealth ~= 0)then
		health = Citizen.InvokeNative(0x36731AC041289BB1, ped, 0) --ACTUAL HEALTH CORE GETTER
		newHealth = health + tonumber(innercorehealth)

		if (newHealth > 100) then
		newHealth = 100
		end
		Citizen.InvokeNative(0xC6258F41D86676E0, ped, 0, newHealth)
	end

		--TO DO OUTER CORE HEALTH parametro = outerCoreHealth

	--GOLDS

	if (innercorestaminagold ~= 0.0) then
		Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 1, innercorestaminagold, true)
	end
	if (outercorestaminagold ~= 0.0) then
		Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerPedId(), 1, outercorestaminagold, true)
	end
	if (innercorehealthgold ~= 0.0) then
		Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 0, innercorehealthgold, true)
	end
	if	(outercorehealthgold ~= 0.0) then
		Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerPedId(), 0, outercorehealthgold, true)
	end
end)