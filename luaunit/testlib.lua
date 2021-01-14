local testlib = {}

function testlib.add(v1, v2)
    if v1 < 0 or v2 < 0 then
        error('Can only add positive or null numbers, received: ' .. v1 .. ' and ' .. v2)
    end
    if v1 == 0 or v2 == 0 then
        return 0
    end
    return v1 + v2
end

function testlib.div(v1, v2)
    if v2 == 0 then
        error('Can only add positive or null numbers, received: ' .. v1 .. ' and ' .. v2)
    end
    if v1 == 0 then
        return 0
    end
    return v1 / v2
end


return testlib

