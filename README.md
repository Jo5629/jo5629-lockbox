# Lockbox

This is a modified version from [lua-lockbox](https://github.com/somesocks/lua-lockbox) ported to work in Minetest.

License: MIT

## Security

Some primitives are disabled for some reasons. In order for them to be enabled, change the setting `lockbox.ALLOW_INSECURE` to `true` **before** accessing any of the insecure functions.

## Lockbox Modules

I do not fully know how they function. If you want to try some of them, I suggest finding which one you want to test then go to its respective test file [here](https://github.com/somesocks/lua-lockbox/tree/master/test) and copy/change some their contents to your liking.

- `lockbox`
- `lockbox.cipher.aes128`
- `lockbox.cipher.aes192`
- `lockbox.cipher.aes256`
- `lockbox.cipher.des3` [^1]
- `lockbox.cipher.des` [^1]
- `lockbox.cipher.tea` [^1]
- `lockbox.cipher.xtea` [^1]
- `lockbox.cipher.mode.cbc`
- `lockbox.cipher.mode.cfb`
- `lockbox.cipher.mode.ctr`
- `lockbox.cipher.mode.ecb` [^1]
- `lockbox.cipher.mode.ige`
- `lockbox.cipher.mode.ofb`
- `lockbox.cipher.mode.pcbc`
- `lockbox.digest.md2` [^1]
- `lockbox.digest.md4` [^1]
- `lockbox.digest.md5` [^1]
- `lockbox.digest.ripemd128` [^1]
- `lockbox.digest.ripemd160` [^1]
- `lockbox.digest.sha1` [^1]
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

[^1]: This is an insecure function.
