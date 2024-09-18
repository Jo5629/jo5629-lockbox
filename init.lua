lockbox = {}

local modpath = minetest.get_modpath(minetest.get_current_modname())

dofile(modpath .. "/lockbox.init.lua")

--local src_modpath = modpath .. "/src"
--dofile(src_modpath .. "/test/AES256CipherTests.lua")
--dofile(src_modpath .. "/test/SHA2_256Tests.lua")

local version = "v1.0.0-dev"
minetest.log("action", "[Lockbox] Mod is initialized. VERSION: " .. version)