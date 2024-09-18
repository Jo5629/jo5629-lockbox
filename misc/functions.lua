lockbox.functions = {}

local Array = lockbox.util.array
local Stream = lockbox.util.stream

local CTRMode = lockbox.cipher.mode.ctr

local ZeroPadding = lockbox.padding.zero

local AES256Cipher = lockbox.cipher.aes256

local CipherValues = {
    cipher = CTRMode.Cipher,
    decipher = CTRMode.Decipher,
    key = Array.fromHex("acd9d4cfb24e758c090c72f680288ce03aeed00a7f448d1e9cf18526a1d854a3"), --> This string can be changed to any 64 digit hex code.
    iv = Array.fromHex("5cbbda5e7d407e9890c0c5ed680610e5"), --> This string can be changed to any 32 digit hex code.
    padding = ZeroPadding,
}

function lockbox.functions.aes256(mode, input, optional_parameters)
    local settings = table.copy(CipherValues)
    if optional_parameters and type(optional_parameters) == "table" then
        for k, v in pairs(optional_parameters) do
            settings[k] = v
        end
    end

    if type(input) ~= "string" then
        return nil, false
    end

    if mode == "encrypt" then
        input = Array.fromString(input)

        local cipher = settings.cipher()
            .setKey(settings.key)
            .setBlockCipher(AES256Cipher)
            .setPadding(settings.padding);

        local cipherOutput = cipher
            .init()
            .update(Stream.fromArray(settings.iv))
            .update(Stream.fromArray(input))
            .finish()
            .asHex();

        minetest.log("action", "[Lockbox] AES256: " .. cipherOutput)
        return cipherOutput, true
    elseif mode == "decrypt" then
        local decipher = settings.decipher()
            .setKey(settings.key)
            .setBlockCipher(AES256Cipher)
            .setPadding(settings.padding);

        local plainOutput = decipher
            .init()
            .update(Stream.fromArray(settings.iv))
            .update(Stream.fromHex(input))
            .finish()
            .asHex();

        minetest.log("action", "[Lockbox] AES256: " .. plainOutput)
        return plainOutput, true
    end

    return nil, false
end

local Digest = lockbox.digest.sha2_256
function lockbox.functions.sha2_256(input)
    if type(input) ~= "string" then
        return false, nil
    end

    local Output = Digest()
        .init()
        .update(Stream.fromString(input))
        .finish()
        .asHex()

    minetest.log("action", "[Lockbox] SHA2_256: " .. Output)
    return Output, true
end