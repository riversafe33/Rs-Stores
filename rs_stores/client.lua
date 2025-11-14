local openmenu = nil
local tiendaPrompts = {}
local tiendaBlips = {}
local NpcTienda = {}
local npcshop = nil
local npcBlip = nil
local rutaActual = 1
local showingPrompt = false
local npcshop_creating = false

function crearNPCShop()
    if npcshop_creating then return end
    npcshop_creating = true

    if npcshop and DoesEntityExist(npcshop) then
        DeleteEntity(npcshop)
        while DoesEntityExist(npcshop) do Wait(10) end
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
    for id, tienda in pairs(Config.TiendasLocales) do
        CrearPromptTienda(id, tienda.label, tienda.coords)
    end
end)

local MOD_RED = GetHashKey("BLIP_MODIFIER_MP_COLOR_10")
local MOD_WHITE = GetHashKey("BLIP_MODIFIER_MP_COLOR_32")

local function BlipAddModifier(blip, modifierHash)
    Citizen.InvokeNative(0x662D364ABF16DE2F, blip, modifierHash)
end

local function BlipRemoveModifier(blip, modifierHash)
    Citizen.InvokeNative(0xB059D7BD3D78C16F, blip, modifierHash)
end

local function BlipHasModifier(blip, modifierHash)
    return Citizen.InvokeNative(0xD8C3BE3EE94CAF2D, blip, modifierHash)
end

function IsStoreOpen(tienda)
    if not tienda.StoreHoursAllowed then return true end
    local hora = GetClockHours()
    return hora >= tienda.StoreOpen and hora < tienda.StoreClose
end

Citizen.CreateThread(function()
    for nombre, tienda in pairs(Config.TiendasLocales) do
        if tienda.enableblip and tienda.coords then
            local c = tienda.coords
            local blip = Citizen.InvokeNative(0x554D9D53F696D002, GetHashKey("BLIP_STYLE_PICKUP"), c.x, c.y, c.z)
            SetBlipSprite(blip, tienda.sprite, 0)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, tienda.label or nombre)

            if IsStoreOpen(tienda) then
                BlipAddModifier(blip, MOD_WHITE)
            else
                BlipAddModifier(blip, MOD_RED)
            end

            tiendaBlips[nombre] = {
                blip = blip,
                tienda = tienda
            }
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for nombre, info in pairs(tiendaBlips) do
            local blip = info.blip
            local tienda = info.tienda

            local isClosed = not IsStoreOpen(tienda)
            local hasRed = BlipHasModifier(blip, MOD_RED)
            local hasWhite = BlipHasModifier(blip, MOD_WHITE)

            if isClosed then
                if hasWhite then BlipRemoveModifier(blip, MOD_WHITE) end
                if not hasRed then BlipAddModifier(blip, MOD_RED) end
            else
                if hasRed then BlipRemoveModifier(blip, MOD_RED) end
                if not hasWhite then BlipAddModifier(blip, MOD_WHITE) end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        for nombre, tienda in pairs(Config.TiendasLocales) do
            if tienda.enablenpc and tienda.cordnpc and tienda.npcmodel then
                local npcActual = NpcTienda[nombre]

                if IsStoreOpen(tienda) then
                    if not npcActual or not DoesEntityExist(npcActual) then
                        local model = GetHashKey(tienda.npcmodel)
                        RequestModel(model)
                        while not HasModelLoaded(model) do Wait(100) end
                        local npc = CreatePed(model, tienda.cordnpc.x, tienda.cordnpc.y, tienda.cordnpc.z - 1.0, tienda.cordnpc.w, false, true)
                        Citizen.InvokeNative(0x283978A15512B2FE, npc, true)
                        SetEntityNoCollisionEntity(PlayerPedId(), npc, true)
                        SetEntityCanBeDamaged(npc, false)
                        SetEntityInvincible(npc, true)
                        FreezeEntityPosition(npc, true)
                        SetBlockingOfNonTemporaryEvents(npc, true)
                        SetModelAsNoLongerNeeded(model)
                        NpcTienda[nombre] = npc
                    end
                else
                    if npcActual and DoesEntityExist(npcActual) then
                        DeleteEntity(npcActual)
                        NpcTienda[nombre] = nil
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        for id, datos in pairs(tiendaPrompts) do
            local tienda = Config.TiendasLocales[id]
            if #(playerCoords - datos.coords) < 2.5 and IsStoreOpen(tienda) then
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

RegisterNetEvent("rs_stores:removeSoldItemFromUI")
AddEventHandler("rs_stores:removeSoldItemFromUI", function(itemName)
    SendNUIMessage({
        action = "removeSellItem",
        item = itemName
    })
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        if npcshop and DoesEntityExist(npcshop) then DeleteEntity(npcshop) end
        if npcBlip then RemoveBlip(npcBlip) end

        for _, info in pairs(tiendaBlips) do
            if info.blip then RemoveBlip(info.blip) end
        end

        for _, entidad in pairs(NpcTienda) do
            if entidad and DoesEntityExist(entidad) then DeleteEntity(entidad) end
        end

        npcshop, npcBlip, tiendaBlips, NpcTienda = nil, nil, {}, {}
    end
end)
