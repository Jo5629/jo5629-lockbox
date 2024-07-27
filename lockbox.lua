local src_modpath = minetest.get_modpath(minetest.get_current_modname()) .. "/src"

dofile(src_modpath .. "/util/queue.lua")
dofile(src_modpath .. "/util/bit.lua")
dofile(src_modpath .. "/util/array.lua")
dofile(src_modpath .. "/util/base64.lua")
dofile(src_modpath .. "/util/stream.lua")

lockbox = {
    util = lockbox.util,
    cipher = {
        aes256 = dofile(src_modpath .. "/cipher/aes256.lua"),
        mode = {
            ctr = dofile(src_modpath .. "/cipher/mode/ctr.lua"),
        },
    },    
    digest = {
        sha2_256 = dofile(src_modpath .. "/digest/sha2_256.lua"),
    },
    padding = {
        zero = dofile(src_modpath .. "/padding/zero.lua"),
    },
}