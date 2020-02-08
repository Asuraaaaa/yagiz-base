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

local oyuncu = GetPlayerPed(-1)

function Silahver(hashkodu)
	Citizen.Wait(1)
    GiveWeaponToPed(oyuncu, GetHashKey(hashkodu), 100, false, false) -- 100 mermi miktarı
end

function aracSpawnla(arac)
    local arac = GetHashKey(arac)

    RequestModel(arac)
    while not HasModelLoaded(arac) do
        RequestModel(arac)
        Citizen.Wait(1)
    end

    local x,y,z = table.unpack(GetEntityCoords(oyuncu, false))
    local araba = CreateVehicle(arac, x + 3, y + 3, z + 1, 0.0, true, false)
    SetEntityAsMissionEntity(araba, true, true)
end

function silahEkstrasiekle(silahhash, ekstra)
    if HasPedGotWeapon(oyuncu, GetHashKey(silahhash), false) then
        Citizen.Wait(1)
    GiveWeaponComponentToPed(oyuncu, GetHashKey(silahhash), GetHashKey(ekstra))
    end
end

3DYAZI = function(x, y, z, icerik)
    local kamerakor = GetGameplayCamCoords()
	local ekranda,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(kamerakor)
	local olcek = 0.35
	if onScreen then
		SetTextScale(olcek, olcek)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(icerik)
        DrawText(_x,_y)
        local factor = (string.len(icerik)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
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
