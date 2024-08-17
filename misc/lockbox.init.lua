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

local srcpath = minetest.get_modpath(minetest.get_current_modname()) .. "/src"
for _, entry in ipairs({"util", "padding", "cipher", "mac", "digest", "kdf"}) do --> util and padding must go first or the mod will crash.
    lockbox[entry] = {}
    if entry == "cipher" then
        lockbox[entry].mode = {}
        for _, mode in ipairs(folders[entry].mode) do
            local path = string.format("/%s/mode/%s.lua", entry, mode)
            lockbox[entry].mode[mode] = dofile(srcpath .. path)
            minetest.log("action", string.format("[Lockbox] Loaded file: %s into lockbox.%s.mode.%s", path, entry, mode))
        end
    end
    for _, filename in ipairs(folders[entry]) do
        local path = string.format("/%s/%s.lua", entry, filename)
        lockbox[entry][filename] = dofile(srcpath .. path)
        minetest.log("action", string.format("[Lockbox] Loaded file: %s into lockbox.%s.%s", path, entry, filename))
    end
end