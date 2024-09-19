local modpath = minetest.get_modpath(minetest.get_current_modname())

local init = modpath .. "/lockbox.init.lua"
dofile(init)
minetest.register_async_dofile(init)

--[[
local src_modpath = modpath .. "/src"
dofile(src_modpath .. "/test/AES256CipherTests.lua")
dofile(src_modpath .. "/test/SHA2_256Tests.lua")
]]

local version = "v1.1.0-dev"
minetest.log("action", "[Lockbox] Mod is initialized. VERSION: " .. version)