local cmd = chatcmdbuilder.register("lockbox", {
    description = "Functions in the lockbox mod.",
    privs = {
        server = true,
        debug = true,
    },
})

cmd:sub("test :type", function(name, type)
    if type == "aes256" then
        lockbox.run_AES256CipherTests()
        return true, "Tested AES256."
    elseif type == "sha2_256" then
        lockbox.run_SHA2_256CipherTests()
        return true, "Tested SHA2_256."
    end
end)

local Array = lockbox.util.array

cmd:sub("aes256 :mode :text:text", function(name, mode, text)
    if mode == "encrypt" then
        local success, output = lockbox.functions.aes256("encrypt", text)
        if success then
            return true, string.format("OUTPUT: %s", output)
        end
        return false, "Unsuccessful."
    elseif mode == "decrypt" then
        local success, output = lockbox.functions.aes256("decrypt", text)
        if success then
            return true, string.format("OUTPUT: %s", Array.toString(Array.fromHex(output)))
        end
        return false, "Unsuccessful."
    else
        return false, "invalid mode."
    end
end)

cmd:sub("sha2_256 :text:text", function(name, text)
    local success, output = lockbox.functions.sha2_256(text)
    if success then
        return true, string.format("OUTPUT: %s", output)
    end
    return false, "Unsuccessful."
end)