local water = 100
local food = 100


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


		if temp > 20 then 
			hot = 3
		else 
			hot = 0
		end

		if temp < -20 then
			cold = 3
		else 
			cold = 0
		end

        if IsPedRunning(PlayerPedId()) then
            food = food - (2 + cold)
            water = water - (3 + hot)
        elseif IsPedWalking(PlayerPedId()) then
            food = food - (0.5 + cold)
            water = water - (1 + hot)
        else
    		food = food - (0.5 + cold)
			water = water - (0.5 + hot)
		end
		Citizen.Wait(40000)
		if food < 20 or water < 20 then
			local newhealth = GetAttributeCoreValue(PlayerPedId(), 0) - 15
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

-- stamina, innerCoreHealth, outerCoreHealth, thirst, hunger ARE INTS
--
RegisterNetEvent('fred:consume')
AddEventHandler('fred:consume', function(hunger, thirst, innerCoreStamina, innerCoreStaminaGold, outerCoreStaminaGold, innerCoreHealth, innerCoreHealthGold, outerCoreHealthGold)
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

	if (innerCoreStamina ~= 0) then
		stamina = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 1) --ACTUAL STAMINA CORE GETTER
		newStamina = stamina + tonumber(innerCoreStamina)

		if (newStamina > 100) then
		newStamina = 100
		end
		Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, newStamina)
	end

	if (innerCoreHealth ~= 0)then
		health = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 0) --ACTUAL HEALTH CORE GETTER
		newHealth = health + tonumber(innerCoreHealth)

		if (newHealth > 100) then
		newHealth = 100
		end
		Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, newHealth)
	end

		--TO DO OUTER CORE HEALTH parametro = outerCoreHealth

	--GOLDS

	if (innerCoreStaminaGold ~= 0.0) then
		Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 1, innerCoreStaminaGold, true)
	end
	if (outerCoreStaminaGold ~= 0.0) then
		Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerPedId(), 1, outerCoreStaminaGold, true)
	end
	if (innerCoreHealthGold ~= 0.0) then
		Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 0, innerCoreHealthGold, true)
	end
	if	(outerCoreHealthGold ~= 0.0) then
		Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerPedId(), 0, outerCoreHealthGold, true)
	end
end)

function DisplayHelp( _message, x, y, w, h, enableShadow, col1, col2, col3, a, centre )

	local str = CreateVarString(10, "LITERAL_STRING", _message, Citizen.ResultAsLong())

	SetTextScale(w, h)
	SetTextColor(col1, col2, col3, a)


	if enableShadow then
		SetTextDropshadow(1, 0, 0, 0, 255)
	end

	Citizen.InvokeNative(0xADA9255D, 10);

	DisplayText(str, x, y)

end

--
--CONSUMIBLES
--

--FOOD

RegisterNetEvent("fred:peach")
AddEventHandler("fred:peach", function(source)
	local _source = source
	-- CORE VALUES --
	local hunger = 35
	local thirst = 5
	local innerStamina = 0
	local innerStaminaGold = 0.0
	local outerStaminaGold = 0.0
	local innerHealth = 0
	--local outerHealth = 5
	local innerHealthGold = 0.0
	local outerHealthGold = 0.0
    TaskItemInteraction(PlayerPedId(), nil, GetHashKey("EAT_MULTI_BITE_FOOD_SPHERE_D8-2_SANDWICH_QUICK_LEFT_HAND"), true, 0, 0)
        Citizen.Wait(1000)
			TriggerEvent('fred:consume', hunger, thirst, innerStamina, innerStaminaGold, outerStaminaGold, innerHealth, innerHealthGold, outerHealthGold)
end)

RegisterNetEvent("fred:cookedMeat")
AddEventHandler("fred:cookedMeat", function(source)
	local _source = source
	local hunger = 50
	local thirst = 0
	local innerStamina = 0
	local innerStaminaGold = 0.0
	local outerStaminaGold = 0.0
	local innerHealth = 0
	--local outerHealth = 5
	local innerHealthGold = 100.0
	local outerHealthGold = 0.0
    TaskItemInteraction(PlayerPedId(), nil, GetHashKey("EAT_MULTI_BITE_FOOD_SPHERE_D8-2_SANDWICH_QUICK_LEFT_HAND"), true, 0, 0)
        Citizen.Wait(1000)
			TriggerEvent('fred:consume', hunger, thirst, innerStamina, innerStaminaGold, outerStaminaGold, innerHealth, innerHealthGold, outerHealthGold)
end)

--DRINKS

RegisterNetEvent("fred:coffee")
AddEventHandler("fred:coffee", function(source)
	local _source = source
	local hunger = 0
	local thirst = 35
	local innerStamina = 0
	local innerStaminaGold = 100.0
	local outerStaminaGold = 0.0
	local innerHealth = 0
	--local outerHealth = 5
	local innerHealthGold = 0.0
	local outerHealthGold = 0.0
    TaskItemInteraction(PlayerPedId(), nil, GetHashKey("EAT_MULTI_BITE_FOOD_SPHERE_D8-2_SANDWICH_QUICK_LEFT_HAND"), true, 0, 0)
        Citizen.Wait(1000)
			TriggerEvent('fred:consume', hunger, thirst, innerStamina, innerStaminaGold, outerStaminaGold, innerHealth, innerHealthGold, outerHealthGold)
end)

--MEDICINES

RegisterNetEvent("fred:medicine")
AddEventHandler("fred:medicine", function(source)
	local _source = source
	local hunger = 0
	local thirst = 10
	local innerStamina = 0
	local innerStaminaGold = 0.0
	local outerStaminaGold = 0.0
	local innerHealth = 0
	--local outerHealth = 5
	local innerHealthGold = 0.0
	local outerHealthGold = 100.0

	TaskItemInteraction(PlayerPedId(), nil, GetHashKey("EAT_MULTI_BITE_FOOD_SPHERE_D8-2_SANDWICH_QUICK_LEFT_HAND"), true, 0, 0)
        Citizen.Wait(1000)
			TriggerEvent('fred:consume', hunger, thirst, innerStamina, innerStaminaGold, outerStaminaGold, innerHealth, innerHealthGold, outerHealthGold)

end)

--Medicine with bottle animation ON DEVELOPMENT
--[[RegisterNetEvent("fred:medicine")
AddEventHandler("fred:medicine", function(source)
    local _source = source

	local hunger = 0
	local thirst = 10
	local innerStamina = 0
	local innerStaminaGold = 0.0
	local outerStaminaGold = 0.0
	local innerHealth = 0
	--local outerHealth = 5
	local innerHealthGold = 0.0
	local outerHealthGold = 100.0

    local status = false

    if status == false then
    	local playerPed = PlayerPedId()
        local propEntity = CreateObject(GetHashKey('p_bottlemedicine09x'), GetEntityCoords(PlayerPedId()), false, false, 1, 1, 0)
        TaskItemInteraction_2(PlayerPedId(), 1737033966, propEntity, GetHashKey("p_bottleJD01x_ph_r_hand"), GetHashKey("DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_UNCORK"), true, 0, 0)
        status = true
        Citizen.Wait(10000)
        DeleteEntity(propEntity)
        for i=1, 10 do
            
              TriggerEvent('fred:consume', hunger, thirst, innerStamina, innerStaminaGold, outerStaminaGold, innerHealth, innerHealthGold, outerHealthGold)
                        
        end
    elseif status == true then
        TriggerEvent("vorp:TipBottom", "You're already drinking a Medicine", 4000)
    end
    status = false

end)]]--