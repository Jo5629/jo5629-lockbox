local Stream = lockbox.util.stream
local Digest = lockbox.digest.sha2_256

local test = {};

test[""] = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";
test["abc"] = "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad";
test["abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"] =
"248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1";
test["abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmnhij" ..
     "klmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu"] =
"cf5b16a778af8380036ce59e7b0492370b249b11e8f07a51afac45037afee9d1";
test["this is a test"] = "2e99758548972a8e8822ad47fa1017ff72f06f3ff6a016851f45c398732bc50c"

function lockbox.run_SHA2_256CipherTests()
    for k, v in pairs(test) do
        local message = k;
        local expected = v;
        local actual = Digest()
            .init()
            .update(Stream.fromString(k))
            .finish()
            .asHex();

        assert(actual == expected, string.format("Test failed! MESSAGE(%s) Expected(%s) Actual(%s)",
        message, expected, actual));
    end
end