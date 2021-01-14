EXPORT_ASSERT_TO_GLOBALS = true
local luaunit = require "luaunit"
--引入测试框架luaunit

--[[
UT
--]]
local test_lib = require ("testlib")
--包含所要测试的函数库（测试目标）

-- 以下按照table分类测试用例（分组TestAdd与TestDiv）
TestAdd = {}
function TestAdd:testAddPositive()
    local args = {1, 1}
    luaunit.assertEquals(test_lib.add(1, 1), 2)
end

function TestAdd:testAddZero()
    luaunit.assertEquals(test_lib.add(1, 0), 0)
    luaunit.assertEquals(test_lib.add(0, 5), 0)
    luaunit.assertEquals(test_lib.add(0, 0), 0)
end

function TestAdd:testAddError()
    luaunit.assertErrorMsgContains("Can only test_lib.add positive or null numbers, received 2 and -3", test_lib.add, 2, -3)
end

function TestAdd:testAdder()
    local f = adder(3)
    luaunit.assertIsFunction(f)
    luaunit.assertEquals(f(2), 5)
end
-- end of table TestAdd

TestDiv = {}
function TestDiv:testDivPositive()
    luaunit.assertEquals(test_lib.div(4, 2), 2)
end

function TestDiv:testDivZero()
    luaunit.assertEquals(test_lib.div(4, 0), 0)
    luaunit.assertEquals(test_lib.div(0, 5), 0)
    luaunit.assertEquals(test_lib.div(0, 0), 0)
end

function TestDiv:testDivError()
    luaunit.assertErrorMsgContains("Can only test_lib.divide positive or null numbers, received 2 and -3", test_lib.div, 2, -3)
end
-- end of table TestDiv

--以下为用于每个测试用例执行前后的资源初始化setUp和释放tearDown
TestLogger = {}
function TestLogger:setUp()
    -- define the fname to use for logging
    self.fname = "mytmplog.log"
    -- make sure the file does not already exists
    os.remove(self.fname)
end

function TestLogger:tearDown()
    -- cleanup our log file after all tests
    os.remove(self.fname)
end
-- end of table TestLogger
--[[
UT
--]]
os.exit(luaunit.LuaUnit.run())
