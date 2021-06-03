---

local cjson = require "cjson"

local json_helper = {}


---json 字符串转 table
---@param json_str any
---@return table or nil
function json_helper.str_to_table(json_str)
    if not json_str then
        return nil
    end
    local ret, decoded_obj = pcall(cjson.decode, json_str)
    if not ret then
        return nil
    end
    return decoded_obj
end

---table 转 json 字符串
---@param table_obj any
---@return string or nil
function json_helper.table_to_str(table_obj)
    if not table_obj then
        return nil
    end
    local ret, json_str = pcall(cjson.encod, table_obj)
    if not ret then
        return nil
    end
    return json_str
end

return json_helper
