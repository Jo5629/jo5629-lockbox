lockbox = {}

--> Insecure functions.
lockbox.ALLOW_INSECURE = false
local INSECURE_MODULES = {}
function lockbox.REQUEST_INSECURE(name, module)
    INSECURE_MODULES[name] = module
    if not lockbox.ALLOW_INSECURE then
        return nil
    end
    return module
end

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

local function log(success, filepath, module)
    minetest.log("action", string.format("[Lockbox] %s file: %s into %s", success, filepath, module))
end

local mt = {}
function mt:__index(key)
    if INSECURE_MODULES[key] then --> Module actually exists, let's try and access it.
        if lockbox.ALLOW_INSECURE then
            minetest.log("action", "[Lockbox] An insecure module has been accessed.")
            return INSECURE_MODULES[key]
        else
            minetest.log("warning", "[Lockbox] An insecure module was unable to be accessed.")
        end
    end
end

local srcpath = minetest.get_modpath(minetest.get_current_modname()) .. "/src"
for _, entry in ipairs({"util", "padding", "cipher", "mac", "digest", "kdf"}) do --> util and padding must go first or the mod will crash.
    lockbox[entry] = {}
    setmetatable(lockbox[entry], mt)

    if entry == "cipher" then
        lockbox[entry].mode = {}
        setmetatable(lockbox[entry].mode, mt)

        for _, mode in ipairs(folders[entry].mode) do
            local path = string.format("/%s/mode/%s.lua", entry, mode)

            local output = dofile(srcpath .. path)
            lockbox[entry].mode[mode] = output

            local success = "Loaded"
            if output == nil then
                success = "Did not load"
            end

            log(success, path, string.format("lockbox.%s.mode.%s", entry, mode))
        end
    end
    for _, filename in ipairs(folders[entry]) do
        local path = string.format("/%s/%s.lua", entry, filename)

        local output = dofile(srcpath .. path)
        lockbox[entry][filename] = output

        local success = "Loaded"
        if output == nil then --> File was unable to load.
            success = "Did not load"
        end
        log(success, path, string.format("lockbox.%s.%s", entry, filename))
    end
end

--[[ Debugging.
minetest.after(1.5, function()
    lockbox.ALLOW_INSECURE = true
    minetest.chat_send_all(tostring(lockbox.digest.ripemd160 ~= nil))
end)
]]