local String = string

local Array = lockbox.util.array
local Stream = lockbox.util.stream

local CTRMode = lockbox.cipher.mode.ctr

local ZeroPadding = lockbox.padding.zero

local AES256Cipher = lockbox.cipher.aes256

local testVectors = {
    {
        cipher = CTRMode.Cipher,
        decipher = CTRMode.Decipher,
        key = Array.fromHex("603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4"),
        iv = Array.fromHex("f0f1f2f3f4f5f6f7f8f9fafbfcfdfeff"),
        plaintext = Array.fromHex("6bc1bee22e409f96e93d7e117393172aae2d8a571e03ac9c9eb76fac45" ..
                                  "af8e5130c81c46a35ce411e5fbc1191a0a52eff69f2445df4f9b17ad2b417be66c3710"),
        ciphertext = Array.fromHex("601ec313775789a5b7a7f504bbf3d228f443e3ca4d62b59aca84e990cacaf5c52b0930" ..
                                   "daa23de94ce87017ba2d84988ddfc9c58db67aada613c2dd08457941a6"),
        padding = ZeroPadding,
    }
}

function lockbox.run_AES256CipherTests()
    for _, v in pairs(testVectors) do
        local cipher = v.cipher()
                .setKey(v.key)
                .setBlockCipher(AES256Cipher)
                .setPadding(v.padding);

        minetest.log("action", "[Lockbox] " .. table.concat(v.iv, ""))
        minetest.log("action", "[Lockbox] " .. table.concat(v.plaintext, ""))
        local cipherOutput = cipher
                            .init()
                            .update(Stream.fromArray(v.iv))
                            .update(Stream.fromArray(v.plaintext))
                            .finish()
                            .asHex();

        local decipher = v.decipher()
                .setKey(v.key)
                .setBlockCipher(AES256Cipher)
                .setPadding(v.padding);

        local plainOutput = decipher
                            .init()
                            .update(Stream.fromArray(v.iv))
                            .update(Stream.fromHex(cipherOutput))
                            .finish()
                            .asHex();

        assert(cipherOutput == Array.toHex(v.ciphertext)
                    , String.format("cipher failed!  expected(%s) got(%s)", Array.toHex(v.ciphertext), cipherOutput));

        assert(plainOutput == Array.toHex(v.plaintext)
                 , String.format("decipher failed!  expected(%s) got(%s)", Array.toHex(v.plaintext), plainOutput));
    end
end