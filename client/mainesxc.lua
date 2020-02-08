ESX = nil
PlayerData = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('yagiz-base:menuAc')
AddEventHandler('yagiz-base:menuAc', function(menu)

    local type = alolmazsa(menu.type, 'default')

    if type == 'default' then
        OpenDefaultMenu(menu)
    elseif type == 'dialog' then
        OpenDialogMenu(menu)
    elseif type == 'list' then
        OpenListMenu(menu)
    elseif type == 'confirmation' then
        OpenConfirmationMenu(menu)
    end
end)

function OpenDefaultMenu(menu)

    local emptyMenu = { { label = 'Empty Menu', action = nil } }

    local elements = {}
    local actions = {}

    for k, v in pairs(alolmazsa(menu.options, emptyMenu)) do
        local key = alolmazsa(v.value, k)
        table.insert(elements, { label = v.label, value = key })
        actions[key] = v.action
    end

    if menu.onOpen then
        menu.onOpen()
    end

    ESX.UI.Menu.Open(alolmazsa(menu.type, 'default'), GetCurrentResourceName(), alolmazsa(menu.name, alolmazsa(menu.title, 'default-menu-name')), {
        title = alolmazsa(menu.title, 'default-menu-title'),
        align = alolmazsa(menu.align, 'bottom-right'),
        elements = alolmazsa(elements, emptyMenu)
    }, function(data, m)
        if alolmazsa(actions[data.current.value], nil) then
            actions[data.current.value](data.current, m)
        else
            ESX.ShowNotification("This menu dont have any action(s).")
        end
    end, function(data, m)
        if alolmazsa(menu.close, nil) then
            menu.close()
        end
        m.close()
    end, function(data, m)
        if menu.onChange then
            menu.onChange(data, m)
        end
    end)
end

function OpenDialogMenu(menu)
    ESX.UI.Menu.Open(alolmazsa(menu.type, 'dialog'), GetCurrentResourceName(), alolmazsa(menu.name, alolmazsa(menu.title, 'default-menu-name')), {
        title = alolmazsa(menu.title, 'default-menu-title'),
        align = alolmazsa(menu.align, 'middle')
    },
            function(data, m)
                if alolmazsa(menu.action, nil) then
                    menu.action(data.value)
                    m.close()
                else
                    ESX.ShowNotification("This menu have no action!")
                end
            end,
            function(data, m)
                if alolmazsa(menu.close, nil) then
                    menu.close()
                end
                m.close()
            end)
end

function OpenListMenu(menu)

    local elements = {
        head = menu.head or {},
        rows = menu.rows or {}
    }

    for k, v in pairs(menu.options) do
        local cols = {}
        for _, v2 in pairs(v) do
            table.insert(cols, v2)
        end
        table.insert(elements.rows, {
            data = v,
            cols = cols
        })
    end

    ESX.UI.Menu.Open('list', GetCurrentResourceName(), menu.name or 'default_list_menu', elements, function(data, menu)
        ESX.UI.Menu.CloseAll()
    end, function(data, menu)
        ESX.UI.Menu.CloseAll()
    end, function(data, menu)
        ESX.UI.Menu.CloseAll()
    end, function(data, menu)
        ESX.UI.Menu.CloseAll()
    end)
end

function OpenConfirmationMenu(menu)
    local options = {
        { label = 'Evet', action = menu.confirmation },
        { label = 'Hayır', action = menu.denial },
    }

    local confirmation = {
        title = 'Onaylama',
        name = 'confirmation_' .. menu.name,
        options = options
    }

    OpenDefaultMenu(confirmation)
end

