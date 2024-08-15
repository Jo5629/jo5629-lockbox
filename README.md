# Lockbox

Library for encryption/decryption and hashes. Contains AES-256 encryption/decryption.

This is a modified version from [lua-lockbox](https://github.com/somesocks/lua-lockbox) ported to work in Minetest.

License: MIT

## Commands

- Requires the privileges `server, debug` in order to be used.
- `/lockbox aes256 <encrypt | decrypt> <text>`
  - Encrypts or decrypts `text` with AES-256.
- `/lockbox sha2_256 <text>`
  - Returns a hash from `text` with SHA2-256.

## Lockbox API

Check the lua-lockbox repository for any questions on the data structures.

### Functions

- `lockbox.functions.aes256(mode, input, optional_parameters)`. Returns `boolean, output`.
  - Function used for encryption/decryption with AES-256.
  - `mode` is a string. Either `encrypt` or `decrypt`.
  - `input` is a string.
  - `optional_parameters` is a table. This is not necessary, but can be used if wanted to. See example below for any questions.
    - Changing any of the values in `key` and `iv` will change the encrypted string.
  - `boolean` - `true` for success, `false` for failure.
  - `output` - Is a hexadecimal string.

**EXAMPLE:**

``` lua
local CTRMode = lockbox.cipher.mode.ctr
local Array = lockbox.util.array
local ZeroPadding = lockbox.padding.zero

local CipherValues = {
    cipher = CTRMode.Cipher,
    decipher = CTRMode.Decipher,
    key = Array.fromHex("acd9d4cfb24e758c090c72f680288ce03aeed00a7f448d1e9cf18526a1d854a3"), --> This string can be changed to any 64 long hexadecimal value.
    iv = Array.fromHex("5cbbda5e7d407e9890c0c5ed680610e5"), --> This string can be changed to any 32 long hexadecimal value.
    padding = ZeroPadding,
}

--> Encryption.
local success, output = lockbox.functions.aes256("encrypt", "this is a test", CipherValues)
if success then
  print(output) --> 215FB5A428AFB1885D1E6F5795765277
end

--> Decryption.
local success, output = lockbox.functions.aes256("decrypt", "215FB5A428AFB1885D1E6F5795765277", CipherValues)
if success then
  print(output) --> 74686973206973206120746573740000
end

--> To convert from a hex to a readable string.
print(Array.toString(Array.fromHex(output))) --> this is a test
```

- `lockbox.functions.sha2_256(input)`. Returns `boolean, hash`.
  - Function used for producing a hash.
  - `input` is a string.
  - `hash` is a hexadecimal string.

**EXAMPLE:**

``` lua
local success, output = lockbox.functions.sha2_256("this is a test")
if success then
  print(output) --> 2e99758548972a8e8822ad47fa1017ff72f06f3ff6a016851f45c398732bc50c
end
```

### Lockbox Modules

I do not fully know how they function, visit the main repository for more info.

- `lockbox`
- `lockbox.cipher.aes128`
- `lockbox.cipher.aes192`
- `lockbox.cipher.aes256`
- `lockbox.cipher.des3`
- `lockbox.cipher.des`
- `lockbox.cipher.mode.cbc`
- `lockbox.cipher.mode.cfb`
- `lockbox.cipher.mode.ctr`
- `lockbox.cipher.mode.ecb`
- `lockbox.cipher.mode.ige`
- `lockbox.cipher.mode.ofb`
- `lockbox.cipher.mode.pcbc`
- `lockbox.digest.md2`
- `lockbox.digest.md4`
- `lockbox.digest.md5`
- `lockbox.digest.ripemd128`
- `lockbox.digest.ripemd160`
- `lockbox.digest.sha1`
- `lockbox.digest.sha2_224`
- `lockbox.digest.sha2_256`
- `lockbox.kdf.hkdf`
- `lockbox.kdf.pbkdf2`
- `lockbox.mac.hmac`
- `lockbox.padding.ansix923`
- `lockbox.padding.isoiec7816`
- `lockbox.padding.pkcs7`
- `lockbox.padding.zero`
- `lockbox.util.base64`
- `lockbox.util.array`
- `lockbox.util.bit`
- `lockbox.util.queue`
- `lockbox.util.stream`
