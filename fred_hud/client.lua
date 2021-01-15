money = 0
-- mystress = nil

 RegisterNetEvent("gui:getItems")
 AddEventHandler("gui:getItems", function(THEITEMS)
     SendNUIMessage({
        items = THEITEMS,
     })
 end)

-- RegisterNetEvent("gui:getStress") --[[ THIS FUNCTION SHIFTS THE STRESS VARIABLE FROM THE SERVER SIDE TO THE CLIENT SIDE ]]
-- AddEventHandler("gui:getStress", function(stress)
--     mystress = stress
--     print("This is your stress:", mystress)
-- end) 

-- RegisterNetEvent("gui:setstress") --[[ THIS FUNCTION RECORDS THE PLAYER'S STRESS ON A VARIABLE SERVER ]]
-- AddEventHandler("gui:setstress", function()
--     local _src = source
--     TriggerServerEvent("maliko:notstress")
-- end)

-- Citizen.CreateThread(function() --[[ THIS THREAD CHARGES PLAYER STRESS AT LOGIN]]
--     TriggerEvent("gui:setstress")
--     print("I activate the Server side")
-- end)

-- Citizen.CreateThread(function() --[[ THIS THREAD DECREASES PLAYER STRESS EVERY 30 SECONDS BY 3. ]]
-- while true do 
--     Wait(30000)
--     TriggerServerEvent("AbbassaStress", mystress)
--     mystress = nil
-- end
-- end)

Citizen.CreateThread(function()
    while true do
        local _source = source 
		--TriggerServerEvent("hud:checkmoney")
        Citizen.InvokeNative(0x50C803A4CD5932C5 , true)
        local myhunger = exports["fred_metabolism"]:getHunger()
        local mythirst = exports["fred_metabolism"]:getThirst()

        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        Citizen.InvokeNative(0xB98B78C3768AF6E0,true)
        local temp = GetTemperatureAtCoords(coords)
		local _src = source
        SendNUIMessage({
            action = "updateStatusHud",
                show = not IsRadarHidden(),
                hunger = myhunger,
                thirst = mythirst,
                --stress = mystress,
                --cash = money,
                --temp = math.floor(temp * 1.8 + 32.0).."°",
				temp= math.floor(temp).."°C",
		})
        Citizen.Wait(1000)
    end
end)

-- RegisterNetEvent("StressaPlayer")
-- AddEventHandler("StressaPlayer", function(qt)
--     stress = 0
--     mystress = nil
--     TriggerServerEvent("maliko:stressa",qt)
--     print("The player was stressed out of "..qt)
-- end)



-- RegisterCommand("malikomistressa", function()
--     TriggerEvent("StressaPlayer", 10)
-- end)


--  TriggerEvent("StressaPlayer", 100)  -- AGGIUNGE X STRESS 