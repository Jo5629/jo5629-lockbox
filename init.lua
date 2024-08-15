lockbox = {}

local modpath = minetest.get_modpath(minetest.get_current_modname())

local miscpath = modpath .. "/misc"
dofile(miscpath .. "/lockbox.init.lua")
dofile(miscpath .. "/functions.lua")

local src_modpath = modpath .. "/src"
--dofile(src_modpath .. "/test/AES256CipherTests.lua")
--dofile(src_modpath .. "/test/SHA2_256Tests.lua")

if minetest.get_modpath("lib_chatcmdbuilder") then
    dofile(miscpath .. "/commands.lua")
end