ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(30)
  end
end)


local robberyAlert = false

local isLoggedIn = true

local firstAlarm = false

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function()
    isLoggedIn = false
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        inRange = false

        if ESX  ~= nil then
            if isLoggedIn then
                PlayerData = ESX.GetPlayerData()
                for case,_ in pairs(Config.Locations) do
                    local dist = GetDistanceBetweenCoords(pos, Config.Locations[case]["coords"]["x"], Config.Locations[case]["coords"]["y"], Config.Locations[case]["coords"]["z"])
                    if dist < 30 then
                        inRange = true

                        if dist < 0.6 then
                            if not Config.Locations[case]["isBusy"] and not Config.Locations[case]["isOpened"] then
                                DrawText3Ds(Config.Locations[case]["coords"]["x"], Config.Locations[case]["coords"]["y"], Config.Locations[case]["coords"]["z"], '[E] Kır')
                                if IsControlJustPressed(0, Keys["E"]) then
                                    ESX.TriggerServerCallback('z12:checkcops', function(policeCount)
                                        if policeCount then
                                                smashVitrine(case)
                                                if not robberyAlert then
                                                local player = PlayerPedId()
                                                local pCoords = GetEntityCoords(player)
                                                TriggerServerEvent('m3:dispatch:notify', 'GunShop Soygunu', 'Anonim', 'Yok', pCoords)
                                                robberyAlert = true
                                                end
                                end
                            end)
                        end
                    end
                end

                    end
                end
            end
        end

        if not inRange then
            Citizen.Wait(2000)
        end

        Citizen.Wait(3)
    end
end)

function loadParticle()
	if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
    RequestNamedPtfxAsset("scr_jewelheist")
    end
    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
    Citizen.Wait(0)
    end
    SetPtfxAssetNextCall("scr_jewelheist")
end

function loadAnimDict(dict)  
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(3)
    end
end

function validWeapon()
    local ped = PlayerPedId()
    local pedWeapon = GetSelectedPedWeapon(ped)

    for k, v in pairs(Config.WhitelistedWeapons) do
        if pedWeapon == k then
            return true
        end
    end
    return false
end

local smashing = false

function smashVitrine(k)
    local animDict = "missheist_jewel"
    local animName = "smash_case"
    local ped = PlayerPedId()
    local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0, 0.6, 0)
    local pedWeapon = GetSelectedPedWeapon(ped)


    smashing = true
    exports['mythic_progbar']:Progress({
        name = "armor",
        duration = 6000,
        label = 'Kırılıyor...',
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(cancelled)
        if not cancelled then
            ESX.TriggerServerCallback('z12-weashop:server:setVitrineState', function(result)
            end, "isOpened", true, k)
            ESX.TriggerServerCallback('z12-weashop:server:setVitrineState', function(result)
            end, "isBusy", false, k)
            ESX.TriggerServerCallback('z12-weashop:vitrineReward', function()
            end)
            ESX.TriggerServerCallback('z12-weashop:server:setTimeout', function(result)
            end)
            smashing = false
            TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
            ESX.TriggerServerCallback('z12-weashop:server:setVitrineState', function(result)
            end, "isBusy", false, k)
            TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
            smashing = false
        end
    end)
    ESX.TriggerServerCallback('z12-weashop:server:setVitrineState', function(result)
    end, "isBusy", true, k)

    Citizen.CreateThread(function()
        while smashing do
            loadAnimDict(animDict)
            TaskPlayAnim(ped, animDict, animName, 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
            Citizen.Wait(500)
            loadParticle()
            StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", plyCoords.x, plyCoords.y, plyCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
            Citizen.Wait(2500)
        end
    end)
end

RegisterNetEvent('z12-weashop:client:setVitrineState')
AddEventHandler('z12-weashop:client:setVitrineState', function(stateType, state, k)
    Config.Locations[k][stateType] = state
end)


RegisterNetEvent('z12-weashop:client:executeEvents')
AddEventHandler('z12-weashop:client:executeEvents', function()
    TriggerServerEvent('z12-weashop:server:vitrineReward')
end)
