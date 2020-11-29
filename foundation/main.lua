-- local mod = require("module")

local function test_table_diff()
    local tb1 = {}
    tb1['a'] = 1
    tb1['b'] = 2
    local tb2 = {}
    tb2['c'] = 3
    tb2['a'] = 4
end

local function allwords()
    local line = io.read() -- 当前行
    local pos = 1 -- 当前行位置
    return function()
        -- 迭代函数
        while line do -- 遍历所有行
            local s, e = string.find(line, "%w+", pos)
            if s then
                pos = e + 1
                return string.gsub(line, s, e)
            else
                line = io.read()
                pos = 1
            end
        end
        return nil
    end
end

local function test_allwords()
    -- 每次循环都会执行以下allwords函数创建一个闭包
    for word in allwords() do
        print(word)
    end
end

--[[
    打印table
--]]
local function print_r(t)
    local print_r_cache = {}
    local function sub_print_r(t, indent)
        if (print_r_cache[tostring(t)]) then
            print(indent .. "*" .. tostring(t))
        else
            print_r_cache[tostring(t)] = true
            if (type(t) == "table") then
                for pos, val in pairs(t) do
                    if (type(val) == "table") then
                        print(indent .. "[" .. pos .. "] => " .. tostring(t) .. " {")
                        sub_print_r(val, indent .. string.rep(" ", string.len(pos) + 8))
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
        sub_print_r(t, "  ")
        print("}")
    else
        sub_print_r(t, "  ")
    end
    print()
end

local function sortbygrade(names, grades)
    table.sort(
        names,
        function(n1, n2)
            return grades[n1] > grades[n2]
        end
    )
end

--[[
    多行注释
--]]
local function test()
    local test_table = {2, 1, 3, "SORT", "sort"}
    table.sort(
        test_table,
        function(a, b)
            return tostring(a) > tostring(b)
        end
    )
    for key, value in pairs(test_table) do
        print(key, value)
    end
end

local function add(...)
    local s = 0
    for _, v in ipairs {...} do
        s = s + v
    end
    print(s)
end

local function test_while()
    print("in test while")
    local a = 10
    while a < 20 do
        print("a的值是:", a)
        a = a + 1
    end
end

local function test_repeat()
    print("in test_repeat")
    local a = 10
    repeat
        print("a的值是:", a)
        a = a + 1
    until a > 15
end

local function test_repeat2()
    local count = 10
    for i=1, count, 2 do
        repeat
            if i == 5 then
                break
            end
            print(i)
        until True
    end
end

local function test_sort()
    local names = {"peter", "marry", "huangjj"}
    local grades = {peter = 10, marry = 39, huangjj = 100}
    print_r(names)
    print_r(grades)
    sortbygrade(names, grades)
end

local function main()
    -- add(3, 4, 5, 6, 7)
    -- test()
    -- test_while()
    -- test_repeat()
    test_repeat2()
    -- print(mod.constant)
    -- test_allwords()
    -- test_table_diff()
end

main()
