VORP = exports.vorp_core:vorpAPI()

local stress = nil 
local stressnuovo = nil

RegisterServerEvent("maliko:notstress")
RegisterServerEvent("AbbassaStress")

AddEventHandler("maliko:notstress", function()
print("LMAO")
local _source = source
TriggerEvent("vorp:getCharacter",source,function(user)
    utente = user.identifier
    --print(utente)
    exports.ghmattimysql:execute("SELECT * FROM characters WHERE identifier = @identifier",{["@identifier"] = utente}, function(result)
        --print(json.encode(result))
        if result[1] ~= nil then
             stress = result[1].mystress
            TriggerClientEvent("gui:getStress",_source, stress)
            --print("Arrivo Lato Server")
            --print("Questo è lo stress: "..stress)
        end
     end)
    end)
end)


AddEventHandler("AbbassaStress", function(mystress)
local _source = source
print("Stress prima dell'AbbassaStress: "..mystress)
TriggerEvent("vorp:getCharacter", source, function(user)
    utente = user.identifier
    name = user.firstname
    cognome = user.lastname
    --print("Aggiorno lo stress dell'utente "..utente) mystress = mystress-1
    exports.ghmattimysql:execute("SELECT * FROM characters WHERE identifier = @identifier",{["@identifier"] = utente}, function(result)
        --print(json.encode(result))
        if result[1] ~= nil then
             stress = result[1].mystress
             stressnuovo = stress-2.0
            end
    end)
    if stressnuovo > 0 then
    exports.ghmattimysql:execute("UPDATE characters SET mystress=@stressnuovo WHERE identifier=@utente", {["@stressnuovo"] = stressnuovo, ["@utente"] = utente})
    TriggerClientEvent("gui:getStress",_source, stressnuovo)
    elseif stressnuovo <= 0 then
        print("Lo stress di "..name.." "..cognome.." è Zero")
    end
end)
end)

RegisterServerEvent("maliko:stressa")
AddEventHandler("maliko:stressa", function(qt)
    local _source = source
    TriggerEvent("vorp:getCharacter", source, function(user)
    utente = user.identifier
    exports.ghmattimysql:execute("SELECT * FROM characters WHERE identifier = @identifier",{["@identifier"] = utente}, function(result)
        if result[1] ~= nil then
             stress = result[1].mystress
            --TriggerClientEvent("gui:getStress",_source, stress)
            stressnuovo = stress+qt
        end
    end)
    print(stressnuovo)
    print("Lo stress nuovo è questo: "..stressnuovo)
    exports.ghmattimysql:execute("UPDATE characters SET mystress=@stressnuovo WHERE identifier=@utente", {["@stressnuovo"] = stressnuovo, ["@utente"] = utente})
    TriggerClientEvent("gui:getStress",_source, stressnuovo)
    end)
    print("MALIKO STRESS")
end)

