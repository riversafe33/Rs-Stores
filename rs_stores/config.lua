Config = {}

--################################ Wandering Shop ###########################--
Config.job = false 
-- Config.job = false -- Everyone has access 
-- Config.job = {"merchant"} -- Only players with that job have access

Config.TiendaNPCActiva = true          -- If true, the wandering shop will appear at the first coordinate in Config.rutas and change its position every time the time set in Config.merchattimelocation passes
Config.npcModel = "u_m_m_sdtrapper_01" -- Name of the NPC
Config.merchattimelocation = 30         -- Time in minutes before the shop changes position
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
    { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
    { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
    { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
    { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
    { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
}

Config.ItemsToSell = {
    { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
    { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
    { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
    { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
    { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
}

--################################ Static store ##############################--

Config.TiendasLocales = {
    ["valentine"] = {
        -- If StoreHoursAllowed = true, the store will open at the time marked in -- StoreOpen and close at the time marked in -- StoreClose.  
        -- If StoreHoursAllowed = false, it will not close.
        StoreHoursAllowed = true,
        StoreOpen = 8,
        StoreClose = 20,
        job = false, -- Config.job = false, -- Everyone has access -- job = {"miner", "merchant"}, -- Only players with that job have access
        enablenpc = true,                                      -- enablenpc = false means only the prompt will appear at the coordinates, no NPC
        cordnpc = vector4(-324.02, 803.56, 117.88, 282.1),     -- NPC position
        npcmodel = "u_m_m_nbxgeneralstoreowner_01",            -- NPC model name
        enableblip = true,                                     -- enableblip = false means the shop will not show a blip on the map
        coords = vector3(-324.02, 803.56, 117.88),              -- Position of the prompt and blip
        sprite = 819673798,                                    -- Blip hash (you can change it to any you want) -- https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/textures/blips
        label = "Valentine Shop",                              -- Name of the shop; also appears as the menu title
        mostrarComprar = true,                                 -- If true, the “Buy” option will appear in the menu; if false, it won’t
        mostrarVender = true,                                  -- If true, the “Sell” option will appear in the menu; if false, it won’t
        ItemsToBuy = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
        },
        ItemsToSell = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
        }
    },

    ["blackwater"] = {
        StoreHoursAllowed = true,
        StoreOpen = 8,
        StoreClose = 20,
        job = false,
        enablenpc = true,
        cordnpc = vector4(-784.64, -1322.14, 43.88, 180.9),
        npcmodel = "u_m_m_nbxgeneralstoreowner_01",
        enableblip = true,
        coords = vector3(-784.64, -1322.14, 43.88),
        sprite = 819673798,
        label = "Blackwater Shop",
        mostrarComprar = true,
        mostrarVender = true,
        ItemsToBuy = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
        },
        ItemsToSell = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
        }
    },

    ["rhodes"] = {
        StoreHoursAllowed = true,
        StoreOpen = 8,
        StoreClose = 20,
        job = false,
        enablenpc = true,
        cordnpc = vector4(1329.81, -1294.33, 77.02, 59.95),
        npcmodel = "u_m_m_nbxgeneralstoreowner_01",
        enableblip = true,
        coords = vector3(1329.81, -1294.33, 77.02),
        sprite = 819673798,
        label = "Rhodes Shop",
        mostrarComprar = true,
        mostrarVender = true,
        ItemsToBuy = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
        },
        ItemsToSell = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
        }
    },

    ["stdenis"] = {
        StoreHoursAllowed = true,
        StoreOpen = 8,
        StoreClose = 20,
        job = false,
        enablenpc = true,
        cordnpc = vector4(2824.54, -1319.46, 46.76, 324.32),
        npcmodel = "u_m_m_nbxgeneralstoreowner_01",
        enableblip = true,
        coords = vector3(2824.54, -1319.46, 46.76),
        sprite = 819673798,
        label = "Saint Denis Shop",
        mostrarComprar = true,
        mostrarVender = true,
        ItemsToBuy = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
        },
        ItemsToSell = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
        }
    },

    ["strawberry"] = {
        StoreHoursAllowed = true,
        StoreOpen = 8,
        StoreClose = 20,
        job = false,
        enablenpc = true,
        cordnpc = vector4(-1789.78, -388.09, 160.33, 57.93),
        npcmodel = "u_m_m_nbxgeneralstoreowner_01",
        enableblip = true,
        coords = vector3(-1789.78, -388.09, 160.33),
        sprite = 819673798,
        label = "Strawberry Shop",
        mostrarComprar = true,
        mostrarVender = true,
        ItemsToBuy = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
        },
        ItemsToSell = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
        }
    },

    ["vanhorn"] = {
        StoreHoursAllowed = true,
        StoreOpen = 8,
        StoreClose = 20,
        job = false,
        enablenpc = true,
        cordnpc = vector4(3025.57, 562.32, 44.72, 258.64),
        npcmodel = "u_m_m_nbxgeneralstoreowner_01",
        enableblip = true,
        coords = vector3(3025.57, 562.32, 44.72),
        sprite = 819673798,
        label = "Van Horn Shop",
        mostrarComprar = true,
        mostrarVender = true,
        ItemsToBuy = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
        },
        ItemsToSell = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
        }
    },

    ["armadillo"] = {
        StoreHoursAllowed = true,
        StoreOpen = 8,
        StoreClose = 20,
        job = false,
        enablenpc = true,
        cordnpc = vector4(-3687.32, -2623.57, -13.43, 279.92),
        npcmodel = "u_m_m_nbxgeneralstoreowner_01",
        enableblip = true,
        coords = vector3(-3687.32, -2623.57, -13.43),
        sprite = 819673798,
        label = "Armadillo Shop",
        mostrarComprar = true,
        mostrarVender = true,
        ItemsToBuy = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
        },
        ItemsToSell = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
        }
    },

    ["tumbleweed"] = {
        StoreHoursAllowed = true,
        StoreOpen = 8,
        StoreClose = 20,
        job = false,
        enablenpc = true,
        cordnpc = vector4(-5485.89, -2938.21, -0.4, 124.92),
        npcmodel = "u_m_m_nbxgeneralstoreowner_01",
        enableblip = true,
        coords = vector3(-5485.89, -2938.21, -0.4),
        sprite = 819673798,
        label = "Tumbleweed Shop",
        mostrarComprar = true,
        mostrarVender = true,
        ItemsToBuy = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
        },
        ItemsToSell = {
            { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
            { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
            { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
            { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
            { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
        }
    },
}


--############################# Translation ######################--

Config.Textos = {
    btnComprar = "BUY",
    btnVender = "SELL",
    btnCerrar = "CLOSE",
    btnVolver = "BACK",
    tituloComprar = "Buy Items",
    tituloVender = "Sell Items",
    sinCategoria = "No category",
    sinObjetos = "You don't have any items to sell",
    btnAccionComprar = "Buy",
    btnAccionVender = "Sell",
    monedaGold = "🪙",
    monedaDollar = "$",
    btnMax = "Max", 
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
