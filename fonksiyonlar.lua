function uyari(mesaj)
    SetTextComponentFormat("STRING")
    AddTextComponentString(mesaj)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function bildirim(mesaj)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(mesaj)
    DrawNotification(true,false)
end

function mesaj(yazi)
    TriggerEvent("chatMessage",  "[Sunucu]", {255,0,0}, yazi)
end

function Silahver(hashkodu)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(hashkodu), 100, false, false) -- 100 mermi miktarı
end

function aracSpawnla(arac)
    local arac = GetHashKey(arac)

    RequestModel(arac)
    while not HasModelLoaded(arac) do
        RequestModel(arac)
        Citizen.Wait(0)
    end

    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local araba = CreateVehicle(arac, x + 3, y + 3, z + 1, 0.0, true, false)
    SetEntityAsMissionEntity(araba, true, true)
end

function silahEkstrasiekle(silahhash, ekstra)
    if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(silahhash), false) then
    GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(silahhash), GetHashKey(ekstra))
    end
end

function YAZICIZ3D(x, y, z, yazi)
    local ekranda, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local uzaklik = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if ekranda then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function mesaj(icerik) 
    SetTextFont(1)
    SetTextProportional(0)
    SetTextScale(1.9,1.9)
    SetTextEntry("STRING")
    AddTextComponentString(content)
    DrawText(0.7,0.9)
end

