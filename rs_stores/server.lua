local VORPcore = exports.vorp_core:GetCore()
local VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent("rs_stores:getItemsForUI")
AddEventHandler("rs_stores:getItemsForUI", function()
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    if not Character then return end

    local job = Character.job

    if Config.job and Config.job ~= false then
        local permitido = false

        if type(Config.job) == "string" then
            if job == Config.job then
                permitido = true
            end
        elseif type(Config.job) == "table" then
            for _, v in pairs(Config.job) do
                if job == v then
                    permitido = true
                    break
                end
            end
        end

        if not permitido then
            TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.notpermismerchat, 4000)
            return
        end
    end

    local buyItems, sellItems = {}, {}
    local categoriasComprar, categoriasVender = {}, {}

    if Config.mostrarComprar then
        for _, item in pairs(Config.ItemsToBuy) do
            table.insert(buyItems, {
                item = item.item,
                label = item.label,
                price = item.price,
                categoria = item.categoria,
                moneda = item.gold and "gold" or "dollar"
            })
            if item.categoria and item.categoria ~= false then
                categoriasComprar[item.categoria] = true
            end
        end
    end

    if Config.mostrarVender then
        for _, item in pairs(Config.ItemsToSell) do
            table.insert(sellItems, {
                item = item.item,
                label = item.label,
                price = item.price,
                categoria = item.categoria,
                moneda = item.gold and "gold" or "dollar"
            })
            if item.categoria and item.categoria ~= false then
                categoriasVender[item.categoria] = true
            end
        end
    end

    TriggerClientEvent("rs_stores:openMenu", src, {
        buyItems = buyItems,
        sellItems = sellItems,
        mostrarComprar = Config.mostrarComprar,
        mostrarVender = Config.mostrarVender,
        categoriasComprar = categoriasComprar,
        categoriasVender = categoriasVender,
        textos = Config.Textos,
        titulo = Config.titulo,
        origen = "global",
        tiendaId = "global"
    })
end)

RegisterServerEvent("rs_stores:getLocalShopItems")
AddEventHandler("rs_stores:getLocalShopItems", function(tiendaId)
    local src = source
    local tienda = Config.TiendasLocales[tiendaId]
    if not tienda then return end

    local Character = VORPcore.getUser(src).getUsedCharacter
    if not Character then return end

    local job = Character.job

    if tienda.job and tienda.job ~= false then
        local permitido = false

        if type(tienda.job) == "string" then
            if job == tienda.job then
                permitido = true
            end
        elseif type(tienda.job) == "table" then
            for _, v in pairs(tienda.job) do
                if job == v then
                    permitido = true
                    break
                end
            end
        end

        if not permitido then
            TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.notpermishop, 4000)
            return
        end
    end

    local buyItems, sellItems = {}, {}
    local categoriasComprar, categoriasVender = {}, {}

    if tienda.mostrarComprar then
        for _, item in pairs(tienda.ItemsToBuy) do
            table.insert(buyItems, {
                item = item.item,
                label = item.label,
                price = item.price,
                categoria = item.categoria,
                moneda = item.gold and "gold" or "dollar"
            })
            if item.categoria and item.categoria ~= false then
                categoriasComprar[item.categoria] = true
            end
        end
    end

    if tienda.mostrarVender then
        for _, item in pairs(tienda.ItemsToSell) do
            table.insert(sellItems, {
                item = item.item,
                label = item.label,
                price = item.price,
                categoria = item.categoria,
                moneda = item.gold and "gold" or "dollar"
            })
            if item.categoria and item.categoria ~= false then
                categoriasVender[item.categoria] = true
            end
        end
    end

    TriggerClientEvent("rs_stores:openMenu", src, {
        buyItems = buyItems,
        sellItems = sellItems,
        mostrarComprar = tienda.mostrarComprar,
        mostrarVender = tienda.mostrarVender,
        categoriasComprar = categoriasComprar,
        categoriasVender = categoriasVender,
        textos = Config.Textos,
        titulo = tienda.label,
        origen = "local",
        tiendaId = tiendaId
    })
end)

RegisterServerEvent("rs_stores:buyItem")
AddEventHandler("rs_stores:buyItem", function(itemName, cantidad, tiendaId)
    local src = source
    local User = VORPcore.getUser(src)
    local Character = User.getUsedCharacter
    local money = Character.money
    local gold = Character.gold

    local tienda = tiendaId == "global" and {
        ItemsToBuy = Config.ItemsToBuy
    } or Config.TiendasLocales[tiendaId]

    if not tienda then return end

    local itemData = nil
    for _, v in pairs(tienda.ItemsToBuy) do
        if v.item == itemName then
            itemData = v
            break
        end
    end

    if not itemData then return end

    local totalPrice = itemData.price * cantidad
    totalPrice = math.floor(totalPrice * 100) / 100

    if itemData.weapon then
        local canCarry = exports.vorp_inventory:canCarryWeapons(src, cantidad, nil, itemData.item)
        if not canCarry then
            TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.notmoreweapons, 4000)
            return
        end

        if itemData.gold then
            if gold >= totalPrice then
                Character.removeCurrency(1, totalPrice)
                for i = 1, cantidad do
                    exports.vorp_inventory:createWeapon(src, itemData.item, {}, {})
                    Wait(100)
                end
                TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.buy .. " " .. cantidad .. " x " .. itemData.label .. " " .. Config.Textos.Notify.ford .. " " .. totalPrice .. " " .. Config.Textos.Notify.gold, 4000)
            else
                TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.notgold, 4000)
            end
        else
            if money >= totalPrice then
                Character.removeCurrency(0, totalPrice)
                for i = 1, cantidad do
                    exports.vorp_inventory:createWeapon(src, itemData.item, {}, {})
                    Wait(100)
                end
                TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.buy .. " " .. cantidad .. " x " .. itemData.label .. " " .. Config.Textos.Notify.ford .. " " .. totalPrice .. "$", 4000)
            else
                TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.notmoney, 4000)
            end
        end

    else
        local canCarry = exports.vorp_inventory:canCarryItem(src, itemData.item, cantidad)
        if not canCarry then
            TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.notspace, 4000)
            return
        end

        if itemData.gold then
            if gold >= totalPrice then
                Character.removeCurrency(1, totalPrice)
                VorpInv.addItem(src, itemData.item, cantidad)
                TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.buy .. " " .. cantidad .. " x " .. itemData.label .. " " .. Config.Textos.Notify.ford .. " " .. totalPrice .. " " .. Config.Textos.Notify.gold, 4000)
            else
                TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.notgold, 4000)
            end
        else
            if money >= totalPrice then
                Character.removeCurrency(0, totalPrice)
                VorpInv.addItem(src, itemData.item, cantidad)
                TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.buy .. " " .. cantidad .. " x " .. itemData.label .. " " .. Config.Textos.Notify.ford .. " " .. totalPrice .. "$", 4000)
            else
                TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.notmoney, 4000)
            end
        end
    end
end)

RegisterServerEvent("rs_stores:sellItem")
AddEventHandler("rs_stores:sellItem", function(itemName, cantidad, tiendaId)
    local src = source
    local User = VORPcore.getUser(src)
    local Character = User.getUsedCharacter

    local tienda = tiendaId == "global" and { ItemsToSell = Config.ItemsToSell } or Config.TiendasLocales[tiendaId]
    if not tienda then return end

    local itemData = nil
    for _, v in pairs(tienda.ItemsToSell) do
        if v.item == itemName then
            itemData = v
            break
        end
    end
    if not itemData then
        TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.notbuy, 4000)
        return
    end

    local count = 0
    if itemData.weapon then
        local userWeapons = exports.vorp_inventory:getUserInventoryWeapons(src)
        for _, weap in pairs(userWeapons) do
            if weap.name == itemName then
                count = count + 1
            end
        end

        if count < cantidad then
            TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.notobject .. " " .. itemData.label .. " " .. Config.Textos.Notify.tobuy, 4000)
            return
        end

        local removed = 0
        for _, weap in pairs(userWeapons) do
            if weap.name == itemName and removed < cantidad then
                exports.vorp_inventory:subWeapon(src, weap.id)
                exports.vorp_inventory:deleteWeapon(src, weap.id)
                removed = removed + 1
            end
        end
    else
        count = exports.vorp_inventory:getItemCount(src, nil, itemName)
        if count < cantidad then
            TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.notobject .. " " .. itemData.label .. " " .. Config.Textos.Notify.tobuy, 4000)
            return
        end

        local success = exports.vorp_inventory:subItem(src, itemName, cantidad, {}, function(s) end, nil, 100)
        if not success then
            TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.errorobject, 4000)
            return
        end
    end

    local total = itemData.price * cantidad
    total = math.floor(total * 100) / 100

    if itemData.gold then
        Character.addCurrency(1, total)
        TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.sell .. " " .. cantidad .. " x " .. itemData.label .. " " .. Config.Textos.Notify.ford .. " " .. total .. " " .. Config.Textos.Notify.gold, 4000)
    else
        Character.addCurrency(0, total)
        TriggerClientEvent("vorp:TipBottom", src, Config.Textos.Notify.sell .. " " .. cantidad .. " x " .. itemData.label .. " " .. Config.Textos.Notify.ford .. " " .. total .. "$", 4000)
    end
end)
