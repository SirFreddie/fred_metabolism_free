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

--FOOD

VorpInv.RegisterUsableItem("consumable_peach", function(data)

  VorpInv.subItem(data.source, "consumable_peach", 1)
  TriggerClientEvent("vorp:TipRight", data.source, "Has comido un melocoton", 5000)
  TriggerClientEvent("fred:peach", data.source)
end)


VorpInv.RegisterUsableItem("consumable_meat_greavy", function(data)

    VorpInv.subItem(data.source, "consumable_meat_greavy", 1)
    TriggerClientEvent("vorp:TipRight", data.source, "Has comido carne cocinada", 5000)
    TriggerClientEvent("fred:cookedMeat", data.source)
end)

--DRINKS

VorpInv.RegisterUsableItem("consumable_coffee", function(data)

    VorpInv.subItem(data.source, "consumable_coffee", 1)
    TriggerClientEvent("vorp:TipRight", data.source, "Has bebido cafe", 5000)
    TriggerClientEvent("fred:coffee", data.source)
end)

--MEDICINES

VorpInv.RegisterUsableItem("consumable_medicine", function(data)

    VorpInv.subItem(data.source, "consumable_medicine", 1)
    TriggerClientEvent("vorp:TipRight", data.source, "Has consumido medicina", 5000)
    TriggerClientEvent("fred:medicine", data.source)
end)


