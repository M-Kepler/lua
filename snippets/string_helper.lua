local string_helper = {}

--- 去除字符串两边的空格
---@param str string 字符串
---@return string
function string_helper.trim(str)
    return (string.gsub(str, "^%s*(.-)%s*$", "%1"))
end

---切割字符串
---@param str string 字符串
---@param reps string 切割符
---@return table
function string_helper.split(str, reps)
    local resultStrList = {}
    string.gsub(
        str,
        "[^" .. reps .. "]+",
        function(w)
            table.insert(resultStrList, w)
        end
    )
    return resultStrList
end

return string_helper
