Config = {}

--################################ Wandering Shop ###########################--
Config.job = false 
-- Config.job = false -- Everyone has access 
-- Config.job = {"merchant"} -- Only players with that job have access

Config.TiendaNPCActiva = true          -- If true, the wandering shop will appear at the first coordinate in Config.rutas and change its position every time the time set in Config.merchattimelocation passes
Config.npcModel = "u_m_m_sdtrapper_01" -- Name of the NPC
Config.merchattimelocation = 30        -- Time in minutes before the shop changes position
Config.titulo = "Wandering Merchant"   -- This is the name that will appear as the title in the shop menu

Config.promptmerchant = "[G] Open Shop"
Config.Key = 0x760A9C6F

Config.TiendaBlipActivo = true         -- If true, a blip will be shown at the shop’s position
Config.nameBlip = "Wandering Merchant" -- Name that will appear on the blip
Config.spriteBlip = 819673798          -- Blip hash (you can change it to any you want) -- https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/textures/blips

Config.mostrarComprar = true -- If true, the “Buy” option will appear in the menu; if false, it won’t
Config.mostrarVender = true  -- If true, the “Sell” option will appear in the menu; if false, it won’t


Config.rutas = {
    { coords = vector3(-334.11, 773.24, 116.25), heading = 90.66 }, -- First coordinate where the shop appears
    { coords = vector3(-343.84, 784.05, 115.83), heading = 180.0 }, -- After Config.merchattimelocation time passes, it will move here
    -- Add as many positions as you want for the shop to rotate around the map
}

Config.ItemsToBuy = {
    { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false }, -- gold = true means it charges in gold instead of dollars -- weapon = false for items -- weapon = true for weapons
    { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
    { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
    { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "weapons", gold = true, weapon = true },
    { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "weapons", gold = false, weapon = true },
}

Config.ItemsToSell = {
    { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
    { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
    { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
    { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "weapons", gold = true, weapon = true },
    { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "weapons", gold = false, weapon = true },
}

--################################ Static stores ##############################--

Config.TiendasLocales = {
    ["valentine"] = {
        job = false, -- Config.job = false, -- Everyone has access -- job = {"miner", "merchant"}, -- Only players with that job have access
        enablenpc = true,                                      -- enablenpc = false means only the prompt will appear at the coordinates, no NPC
        cordnpc = vector4(-356.22, 793.28, 116.23, 289.42),    -- NPC position
        npcmodel = "u_m_m_nbxgeneralstoreowner_01",            -- NPC model name
        enableblip = true,                                     -- enableblip = false means the shop will not show a blip on the map
        coords = vector3(-356.9, 794.38, 116.22),              -- Position of the prompt and blip
        sprite = 819673798,                                    -- Blip hash (you can change it to any you want) -- https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/textures/blips
        label = "Valentine Shop",                              -- Name of the shop; also appears as the menu title
        mostrarComprar = true,                                 -- If true, the “Buy” option will appear in the menu; if false, it won’t
        mostrarVender = true,                                  -- If true, the “Sell” option will appear in the menu; if false, it won’t
        ItemsToBuy = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false }, -- gold = true means it charges in gold instead of dollars -- weapon = false for items -- weapon = true for weapons
            { label = "Water", item = "water", price = 1.21, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "weapons", gold = true, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "weapons", gold = false, weapon = true },
        },
        ItemsToSell = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "weapons", gold = true, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "weapons", gold = false, weapon = true },
        }
    },

    ["blackwater"] = {
        job = {"miner", "merchant"},
        enablenpc = true,
        cordnpc = vector4(-358.54, 800.95, 116.25, 196.33),
        npcmodel = "u_m_m_nbxgeneralstoreowner_01",
        enableblip = true,
        coords = vector3(-359.69, 801.05, 116.26),
        sprite = 819673798,
        label = "Blackwater Shop",
        mostrarComprar = true,
        mostrarVender = false,
        ItemsToBuy = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "weapons", gold = true, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "weapons", gold = false, weapon = true },
        },
        ItemsToSell = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "weapons", gold = true, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "weapons", gold = false, weapon = true },
        }
    },

    --add more stores
}


--############################# Translation ######################--

Config.Textos = {
    btnComprar = "Buy",
    btnVender = "Sell",
    btnCerrar = "Close",
    btnVolver = "Back",
    tituloComprar = "Buy",
    tituloVender = "Sell",
    sinCategoria = "No category",
    sinObjetos = "No items available in this category.",
    btnAccionComprar = "Buy",
    btnAccionVender = "Sell",
    monedaGold = "🪙",
    monedaDollar = "$",
    Notify = {
        notpermismerchat = "You do not have permission to access this merchant.",
        notpermishop = "You do not have permission to access this shop.",
        buy = "You bought",
        sell = "You sold",
        ford = "for",
        gold = "gold",
        dollar = "for $",
        errorobject = "Error removing the item",
        notobject = "You don’t have enough",
        tobuy = "to sell",
        notbuy = "This item cannot be sold",
        notmoney = "You don’t have enough money",
        notgold = "You don’t have enough gold",
        notspace = "You can’t carry more of this item",
        notmoreweapons = "You can’t carry more weapons",
    },
}
