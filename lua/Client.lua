local display = false

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "FalconStorenui",
        status = bool,
    })
end

RegisterNUICallback("close", function()
    SetDisplay(false)
end)

RegisterNUICallback("Gun", function()
    TriggerEvent("Falcon:Gun")
end)

RegisterNetEvent("Falcon:Gun")
AddEventHandler("Falcon:Gun", function()
    for weapon, ammo in pairs(Config.Weapons) do
        local weaponHash = GetHashKey(weapon)
        GiveWeaponToPed(PlayerPedId(), weaponHash, ammo, true, true)
    end
    SetDisplay(false)
end)

CreateThread(function()
    while true do
        time = 3000
        local Player = PlayerPedId()
        local coords = GetEntityCoords(Player)
        
        local nearestLocation = nil
        local nearestDistance = math.huge
        
        for location, locationCoords in pairs(Config.Coords) do
            local dist = #(coords - vector3(locationCoords[1], locationCoords[2], locationCoords[3]))
            
            if dist < nearestDistance then
                nearestDistance = dist
                nearestLocation = location
            end
        end

        if nearestDistance < 5 then
            time = 0
            DrawMarker(30, Config.Coords[nearestLocation][1], Config.Coords[nearestLocation][2], Config.Coords[nearestLocation][3], 0.0, 0.0, 0.0, 0.0, 360.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 50, true, true, 2, nil, nil, false)
            
            if IsControlJustPressed(0, 38) then
                SetDisplay(not display)
            end
        else
            SetDisplay(false)
        end
        
        Wait(time)
    end
end)