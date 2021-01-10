local curPath
local curr_path = ''
if(...)then curr_path= (...):match("(.-)[^%.]+$") end

local ini_helper = require ("../snippets/ini_helper")

local function main()
    local test_value1 = ini_helper.read("./test.ini", "test_sec1", "test_key1")
    print(test_value1)
end

main()
