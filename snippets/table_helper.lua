
local table_helper = {}


---打印 table
---@param t table
function table_helper.print_t(t)
    local print_t_cache = {}
    local function sub_print_t(t, indent)
        if (print_t_cache[tostring(t)]) then
            print(indent .. "*" .. tostring(t))
        else
            print_t_cache[tostring(t)] = true
            if (type(t) == "table") then
                for pos, val in pairs(t) do
                    if (type(val) == "table") then
                        print(indent .. "[" .. pos .. "] => " .. tostring(t) .. " {")
                        sub_print_t(val, indent .. string.rep(" ", string.len(pos) + 8))
                        print(indent .. string.rep(" ", string.len(pos) + 6) .. "}")
                    elseif (type(val) == "string") then
                        print(indent .. "[" .. pos .. '] => "' .. val .. '"')
                    else
                        print(indent .. "[" .. pos .. "] => " .. tostring(val))
                    end
                end
            else
                print(indent .. tostring(t))
            end
        end
    end
    if (type(t) == "table") then
        print(tostring(t) .. " {")
        sub_print_t(t, "  ")
        print("}")
    else
        sub_print_t(t, "  ")
    end
end


---判断是否是控标
---@param t table 表
---@return boolean
function table_helper.is_empty_table(t)
    if not t or type(t) ~= "table" then
        return true
    end
    return _G.next(t) == nil
end


---合并两个 table， 把新表的内容更新到旧表的内容中, 返回并集
---@param basic_tb table 基准表
---@param new_tb table 新表
---@return table
function table_helper:merge(basic_tb, new_tb)
    for key, val in ipairs(new_tb) do
        if type(val) == "table" and type(basic_tb[key] or false ) == "table" then
            self.merge(basic_tb, new_tb)
        else
            basic_tb[key] = val
        end
    end
    return basic_tb
end


return table_helper
