local openmenu = nil
local tiendaPrompts = {}
local tiendaBlips = {}
local NpcTienda = {}
local npcshop = nil
local npcBlip = nil
local rutaActual = 1
local showingPrompt = false
local npcshop_creating = false

Citizen.CreateThread(function()
    while not Config or not Config.rutas or #Config.rutas == 0 do
        Wait(1000)
    end

    Wait(1000)

    if Config.TiendaNPCActiva then
        crearNPCShop()
    end
end)

function crearNPCShop()
    if npcshop_creating then
        return
    end
    npcshop_creating = true

    if npcshop and DoesEntityExist(npcshop) then
        DeleteEntity(npcshop)
        npcshop = nil
    end

    local model = GetHashKey(Config.npcModel)
    if not IsModelValid(model) then
        npcshop_creating = false
        return
    end

    RequestModel(model)
    while not HasModelLoaded(model) do Wait(10) end

    local datos = Config.rutas[rutaActual]
    if not datos or not datos.coords then
        npcshop_creating = false
        return
    end

    local x, y, z = datos.coords.x, datos.coords.y, datos.coords.z - 1.0
    local heading = datos.heading or 0.0

    npcshop = Citizen.InvokeNative(0xD49F9B0955C367DE, model, x, y, z, heading, true, true, true, true)

    if npcshop and DoesEntityExist(npcshop) then
        Citizen.InvokeNative(0x283978A15512B2FE, npcshop, true)
        SetEntityNoCollisionEntity(PlayerPedId(), npcshop, true)
        SetEntityCanBeDamaged(npcshop, false)
        SetEntityInvincible(npcshop, true)
        FreezeEntityPosition(npcshop, true)
        SetBlockingOfNonTemporaryEvents(npcshop, true)
        SetModelAsNoLongerNeeded(model)

        if Config.TiendaBlipActivo then
            if npcBlip then RemoveBlip(npcBlip) end
            local coords = GetEntityCoords(npcshop)
            npcBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, coords.x, coords.y, coords.z)
            SetBlipSprite(npcBlip, Config.spriteBlip, true)
            SetBlipScale(npcBlip, 0.8)
            Citizen.InvokeNative(0x9CB1A1623062F402, npcBlip, Config.nameBlip)
        end

        npcshop_creating = false
        moverNPCShop()
    else
        npcshop_creating = false
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(5000)
        if Config.TiendaNPCActiva then
            if not npcshop_creating and (not npcshop or not DoesEntityExist(npcshop)) then
                crearNPCShop()
            end
        end
    end
end)

function moverNPCShop()
    Citizen.CreateThread(function()
        while Config.TiendaNPCActiva and npcshop and DoesEntityExist(npcshop) do
            local destino = Config.rutas[rutaActual]
            if destino then
                local x, y, z = destino.coords.x, destino.coords.y, destino.coords.z - 1.0
                local heading = destino.heading or 0.0
                SetEntityCoords(npcshop, x, y, z, false, false, false, true)
                SetEntityHeading(npcshop, heading)
                FreezeEntityPosition(npcshop, true)

                if npcBlip then SetBlipCoords(npcBlip, x, y, z) end
            end

            Citizen.Wait(Config.merchattimelocation * 60 * 1000)
            rutaActual = rutaActual % #Config.rutas + 1
            FreezeEntityPosition(npcshop, false)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local nearNPC = false

        if Config.TiendaNPCActiva and npcshop and DoesEntityExist(npcshop) then
            local npcCoords = GetEntityCoords(npcshop)
            if #(playerCoords - npcCoords) < 3.0 then
                nearNPC = true
                if not showingPrompt then
                    SendNUIMessage({ type = "showmerchant", text = Config.promptmerchant })
                    showingPrompt = true
                end

                if IsControlJustReleased(0, Config.Key) then
                    TriggerServerEvent("rs_stores:getItemsForUI")
                end
            end
        end

        if not nearNPC and showingPrompt then
            SendNUIMessage({ type = "hidemerchant" })
            showingPrompt = false
        end

        Citizen.Wait(nearNPC and 0 or 500)
    end
end)

function CrearPromptTienda(id, label, coords)
    local groupId = GetRandomIntInRange(0, 0xffffff)
    local prompt = UiPromptRegisterBegin()
    UiPromptSetControlAction(prompt, Config.Key)
    local str = VarString(10, 'LITERAL_STRING', label)
    UiPromptSetText(prompt, str)
    UiPromptSetEnabled(prompt, true)
    UiPromptSetVisible(prompt, true)
    UiPromptSetStandardMode(prompt, true)
    UiPromptSetGroup(prompt, groupId, 0)
    UiPromptRegisterEnd(prompt)

    tiendaPrompts[id] = {
        prompt = prompt,
        group = groupId,
        label = label,
        coords = coords
    }
end

Citizen.CreateThread(function()
    for nombre, tienda in pairs(Config.TiendasLocales) do
        if tienda.enableblip then
            local coords = tienda.coords
            local blip = N_0x554d9d53f696d002(1664425300, coords.x, coords.y, coords.z)
            SetBlipSprite(blip, tienda.sprite or 1, true)
            SetBlipScale(blip, 0.2)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, tienda.label or nombre)
            tiendaBlips[nombre] = blip
        end
    end
end)

Citizen.CreateThread(function()
    for id, tienda in pairs(Config.TiendasLocales) do
        CrearPromptTienda(id, tienda.label, tienda.coords)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        for id, datos in pairs(tiendaPrompts) do
            if #(playerCoords - datos.coords) < 2.5 then
                UiPromptSetActiveGroupThisFrame(datos.group, datos.label)
                if UiPromptHasStandardModeCompleted(datos.prompt) then
                    TriggerServerEvent("rs_stores:getLocalShopItems", id)
                end
            end
        end
    end
end)

RegisterNetEvent("rs_stores:openMenu")
AddEventHandler("rs_stores:openMenu", function(data)
    SetNuiFocus(true, true)

    local buyItems = data.buyItems or {}
    local sellItems = data.sellItems or {}
    local mostrarComprar = data.mostrarComprar
    local mostrarVender = data.mostrarVender
    local categoriasComprar = data.categoriasComprar or {}
    local categoriasVender = data.categoriasVender or {}
    local textos = data.textos or {}
    local titulo = data.titulo or textos.titulo or ""
    local origen = data.origen or "global"

    for _, item in pairs(buyItems) do
        item.label = item.label or item.item
        item.img = "nui://vorp_inventory/html/img/items/" .. item.item .. ".png"
    end

    for _, item in pairs(sellItems) do
        item.label = item.label or item.item
        item.img = "nui://vorp_inventory/html/img/items/" .. item.item .. ".png"
    end

    SendNUIMessage({
        type = "open",
        buyItems = buyItems,
        sellItems = sellItems,
        mostrarComprar = mostrarComprar,
        mostrarVender = mostrarVender,
        categoriasComprar = categoriasComprar,
        categoriasVender = categoriasVender,
        textos = textos,
        titulo = titulo,
        origen = origen,
        tiendaId = data.tiendaId
    })
end)

RegisterNUICallback("buyItem", function(data, cb)
    TriggerServerEvent("rs_stores:buyItem", data.item, data.cantidad, data.tiendaId)
    cb("ok")
end)

RegisterNUICallback("sellItem", function(data, cb)
    TriggerServerEvent("rs_stores:sellItem", data.item, data.cantidad, data.tiendaId)
    cb("ok")
end)

RegisterNUICallback("close", function(_, cb)
    SetNuiFocus(false, false)
    cb("ok")
end)

Citizen.CreateThread(function()
    for nombre, tienda in pairs(Config.TiendasLocales) do
        if tienda.enablenpc and tienda.cordnpc and tienda.npcmodel then
            TriggerEvent("rs_stores:CreateNPC", tienda.cordnpc, tienda.npcmodel)
        end
    end
end)

RegisterNetEvent("rs_stores:CreateNPC")
AddEventHandler("rs_stores:CreateNPC", function(coords, modelName)
    if not coords or not modelName then return end

    local model = GetHashKey(modelName)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(500) end

    local npc = CreatePed(model, coords.x, coords.y, coords.z - 1.0, coords.w, false, true)
    Citizen.InvokeNative(0x283978A15512B2FE, npc, true)
    SetEntityNoCollisionEntity(PlayerPedId(), npc, true)
    SetEntityCanBeDamaged(npc, false)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetModelAsNoLongerNeeded(model)
    table.insert(NpcTienda, npc)
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        if npcshop and DoesEntityExist(npcshop) then DeleteEntity(npcshop) end
        if npcBlip then RemoveBlip(npcBlip) end

        for _, blip in pairs(tiendaBlips) do
            if blip then RemoveBlip(blip) end
        end

        for _, entidad in pairs(NpcTienda) do
            if entidad and DoesEntityExist(entidad) then DeleteEntity(entidad) end
        end

        npcshop, npcBlip, tiendaBlips, NpcTienda = nil, nil, {}, {}
    end
end)
