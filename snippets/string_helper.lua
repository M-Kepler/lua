
local string_helper = {}

-- 去除字符串两边的空格
function string_helper.trim(str)
    return (string.gsub(str, "^%s*(.-)%s*$", "%1"))
end

function string_helper.split(str, reps )
    local resultStrList = {}
    string.gsub(str, '[^'..reps..']+', function(w)
        table.insert(resultStrList, w)
    end)
    return resultStrList
end


return string_helper
