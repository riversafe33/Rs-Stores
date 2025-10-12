fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'

author 'riversafe'
description 'stores script'
version 'Version 1.0.0'

ui_page {
	'html/index.html'
}

files {
	'html/index.html',
    'html/shop.png',
}

shared_scripts { 
	'config.lua',
}

client_scripts {
    'client.lua',
}

server_scripts {
    'server.lua',	
}


