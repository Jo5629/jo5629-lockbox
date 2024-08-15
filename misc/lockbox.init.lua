local srcpath = minetest.get_modpath(minetest.get_current_modname()) .. "/src"
local order = {"util", "padding", "cipher", "mac", "digest", "kdf"}
local folders = {
    util = {"queue", "bit", "array", "base64", "stream"},
    padding = {"zero", "pkcs7", "isoiec7816", "ansix923"},
    mac = {"hmac"},
    kdf = {"hkdf", "pbkdf2"},
    cipher = {
        mode = {"cbc", "cfb", "ctr", "ecb", "ige", "ofb", "pcbc"},
        "aes128", "aes192", "aes256", "des", "des3", "tea", "xtea"
    },
    digest = {"md2", "md4", "md5", "ripemd128", "ripemd160", "sha1", "sha2_224", "sha2_256"}
}

for _, entry in ipairs(order) do
    lockbox[entry] = {}
    if entry == "cipher" then
        lockbox[entry].mode = {}
        for _, mode in ipairs(folders.cipher.mode) do
            local path = string.format("/%s/mode/%s.lua", entry, mode)
            lockbox[entry].mode[mode] = dofile(srcpath .. path)
            minetest.log("action", "[Lockbox] Loaded file: " .. path)
        end
    end
    for _, filename in ipairs(folders[entry]) do
        local path = string.format("/%s/%s.lua", entry, filename)
        lockbox[entry][filename] = dofile(srcpath .. path)
        minetest.log("action", "[Lockbox] Loaded file: " .. path)
    end
end