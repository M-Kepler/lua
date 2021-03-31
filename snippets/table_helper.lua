--- https://blog.csdn.net/shimazhuge/article/details/38373571

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
        if type(val) == "table" and type(basic_tb[key] or false) == "table" then
            self.merge(basic_tb, new_tb)
        else
            -- 不存在才插入，存在不更新
            if basic_tb[key] == nil then
                basic_tb[key] = val
            end
        end
    end
    return basic_tb
end

---获取表长度
---lua table 的 "#" 和 table.getn 操作只对依次排序的数值下标数组有效，
--- 计算 table 中所有不为 nil 的值的个数。
---@param tb table
---@return integer
function table_helper.len(tb)
    local count = 0
    for k, v in pairs(tb) do
        count = count + 1
    end
    return count
end

---返回表的所有键
---@param hashtable table
---@return table
function table_helper.keys(hashtable)
    local keys = {}
    for k, v in pairs(hashtable) do
        keys[#keys + 1] = k
    end
    return keys
end

---返回表中的所有值
---@param hashtable table
---@return table
function table.values(hashtable)
    local values = {}
    for k, v in pairs(hashtable) do
        values[#values + 1] = v
    end
    return values
end

---返回数组元素下标
---@param array table
---@param value any
---@param begin any
---@return integer
function table_helper.indexof(array, value, begin)
    for i = begin or 1, #array do
        if array[i] == value then
            return i
        end
    end
    return false
end

---从表格中查找指定值，返回其 key，如果没找到返回 nil
---@param hashtable table
---@param value any
---@return any
function table_helper.keyof(hashtable, value)
    for k, v in pairs(hashtable) do
        if v == value then
            return k
        end
    end
    return nil
end

---类似python的map
---@param func function
---@param tb table
function table_helper.map(func, tb)
    for k, v in pairs(tb) do
        tb[k] = func(v, k)
    end
end

---类似python的filter
---@param func any
---@param tb any
function table_helper.filter(func, tb)
    for k, v in pairs(tb) do
        if not func(v, k) then
            tb[k] = nil
        end
    end
end

---去重
---@param array any
---@return table
function table_helper.union(array)
    local check = {}
    local n = {}
    for k, v in pairs(array) do
        if not check[v] then
            n[k] = v
            check[v] = true
        end
    end
    return n
end

return table_helper
