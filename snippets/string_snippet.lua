
local string_helper = {}

function string_helper.split(str, reps )
    local resultStrList = {}
    string.gsub(str, '[^'..reps..']+', function ( w )
        table.insert(resultStrList, w)
    end)
    return resultStrList
end

function string_helper.trim()
end

local function main()
end

main()
