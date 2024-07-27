local e = bit

-- Workaround to support Lua 5.2 bit32 API with the LuaJIT bit one
if e.rol and not e.lrotate then
    e.lrotate = e.rol
end
if e.ror and not e.rrotate then
    e.rrotate = e.ror
end

-- Workaround to support incomplete bit operations set
if not e.ror and not e.rrotate then
    local ror = function(b, n)
        return e.bor(e.rshift(b, n), e.lshift(b, 32 - n))
    end

    e.ror = ror
    e.rrotate = ror
end

if not e.rol and not e.lrotate then
    local rol = function(b, n)
        return e.bor(e.lshift(b, n), e.rshift(b, 32 - n))
    end

    e.rol = rol
    e.lrotate = rol
end

lockbox.util.bit = e