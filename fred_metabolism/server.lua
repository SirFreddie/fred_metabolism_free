local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)
VORP = exports.vorp_core:vorpAPI()
VorpInv = exports.vorp_inventory:vorp_inventoryApi()


---------------------
--
--REGISTER USABLES--   
--
---------------------


Citizen.CreateThread(function()    
    for i = 1, #Config.ItemsToUse do
        
        local index = i

        VorpInv.RegisterUsableItem(Config.ItemsToUse[i]["Name"], function(data)


            TriggerClientEvent("fred:useItem", data.source, index)
            VorpInv.subItem(data.source, Config.ItemsToUse[index]["Name"], 1)
            TriggerClientEvent("vorp:TipRight", data.source, "Has Consumido "..Config.ItemsToUse[index]["Name"], 5000)
            print(index)
        end)
    end
end)