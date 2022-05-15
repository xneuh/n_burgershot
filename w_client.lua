ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)


Config = {
    Burbyr = {    
        itemsToCraft = vec3(-1203.0603, -895.3937, 13.04),
        makeBurger = vec3(-1197.6243, -897.3528, 13.0452)
    }
}

RegisterNetEvent('w_burgerShot:openMenuMake', function()
    openMakeMenu()
end)

RegisterNetEvent('w_burgerShot:openMenuTake', function()
    openJobMenu()
end)

startTask = function(_type)

    if(exports['s-taskbarskill']:taskBar(1,1) == 100) then
        TriggerServerEvent('_neuh_internal_SV:burgerMake', _type .. 't3')
    else
        local RAND_ITEMS = {
            ['1'] = 't1',
            ['2'] = 't2'
        }
        ITEM_NAME_RAND = _type .. RAND_ITEMS[tostring(math.random(1, 2))]
        TriggerServerEvent('_neuh_internal_SV:burgerMake', ITEM_NAME_RAND)
    end

end

openJobMenu = function()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'skladniki',
        {
            align    = 'center',
            title    = 'nazwa',
            elements = {
                    {label = 'Bułka',  value = 'bun'},
                    {label = 'Mięso',  value = 'meat'},
                    {label = 'Sałata',  value = 'salad'},

            }
        },
        function(data, menu)
            TriggerServerEvent('_neuh_internal_SV:burgerJob', data.current.value)
        end,
        function(data, menu)
            menu.close()
        end
    )
end

openMakeMenu = function()
        ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'skladniki',
            {
                align    = 'center',
                title    = 'nazwa',
                elements = {
                      {label = 'Veggie Burger',  value = 'veggieburger_'},
                      {label = 'Heart Stopper',  value = 'heartstopper_'},
                }
            },
            function(data, menu)
                startTask(data.current.value)
            end,
            function(data, menu)
                menu.close()
            end
        )

end