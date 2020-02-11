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
	if ekranda then
		SetTextScale(olcek, olcek)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(icerik)
        DrawText(_x,_y)
        local faktor = (string.len(icerik)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ faktor, 0.03, 41, 11, 41, 68)
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

Busyspinnerciz = function(yazi)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(yazi)
    ShowLoadingPrompt(3)
end

Silahlabelial = function(Silahmodeli)
    local playerInventory = ESX.PlayerData["inventory"]

    if not playerInventory then playerInventory = ESX.GetPlayerData()["inventory"] end

    for itemIndex, itemData in ipairs(playerInventory) do
        if string.lower(itemData["name"]) == string.lower(Silahmodeli) then
            return itemData["label"]
        end
    end

    return Silahmodeli
end

DisariFade = function(sure)
    DoScreenFadeOut(sure)
    
    while not IsScreenFadedOut() do
        Citizen.Wait(0)
    end
end

IceriFade = function(sure)
    DoScreenFadeIn(500)

    while not IsScreenFadedIn() do
        Citizen.Wait(0)
    end
end

AnimasyonOynat = function(ped, dict, anim, ayarlar)
	if dict then
        Citizen.CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end

            if ayarlar == nil then
                TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else 
                local hiz = 1.0
                local hizmultiplier = -1.0
                local sure = 1.0
                local bayrak = 0
                local oynatRate = 0

                if ayarlar["hiz"] then
                    hiz = ayarlar["hiz"]
                end

                if ayarlar["hizmultiplier"] then
                    hizmultiplier = ayarlar["hizmultiplier"]
                end

                if ayarlar["sure"] then
                    sure = ayarlar["sure"]
                end

                if ayarlar["bayrak"] then
                    bayrak = ayarlar["bayrak"]
                end

                if ayarlar["oynatRate"] then
                    oynatRate = ayarlar["oynatRate"]
                end

                TaskPlayAnim(ped, dict, anim, hiz, hizmultiplier, sure, bayrak, oynatRate, 0, 0, 0)
            end
      
            RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end

function peditemizle(oyuncu)
	SetPedArmour(oyuncu, 0)
	ClearPedBloodDamage(oyuncu)
	ResetPedVisibleDamage(oyuncu)
	ClearPedLastWeaponDamage(oyuncu)
	ResetPedMovementClipset(oyuncu, 0)
end
