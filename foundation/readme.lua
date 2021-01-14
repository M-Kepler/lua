-- 单行注释
--[[
   [多行注释]
--]]
----------
-- 1. 变量 & 控制流
----------
----------
-- 3.1 Metatables & metamethods
----------



-- 元表(metatable)就是表的表，像 Javascript 的原型(prototype)一样
-- 为表重载一些元方法(metamethods)
f1 = {a = 1, b = 2}
f2 = {a = 2, b = 3}
-- s = f1 + f2 为错
mm = {}
function mm.__add(x, y)
    sum = {}
    sum.a = x.a + y.a
    sum.b = x.b + y.b
return sum
end

setmetatable(f1, mm)
setmetatable(f2, mm)
-- 实际调用 f1 的 metatable 中的 __add(f1, f2)
-- 只为 f1 设置元表也可以
s = f1 + f2 -- s = {a = 3, b = 5}

-- s2 = s + s 为错，s 未定义元表
-- __index 元方法重载表中 key 的提取符号 `.`
defaultFavs = {animal = 'gru', food = 'donuts'}
myFavs = {food = 'pizza'}
setmetatable(myFavs, {__index = defaultFavs})
food = myFavs.food


-- Lua 中的值都具有元方法，只有 Table 可以重载
-- 所有元方法如下
-- __add(a, b)                     for a + b
-- __sub(a, b)                     for a - b
-- __mul(a, b)                     for a * b
-- __div(a, b)                     for a / b
-- __mod(a, b)                     for a % b
-- __pow(a, b)                     for a ^ b
-- __unm(a)                        for -a
-- __concat(a, b)                  for a .. b
-- __len(a)                        for #a
-- __eq(a, b)                      for a == b
-- __lt(a, b)                      for a < b
-- __le(a, b)                      for a <= b
-- __index(a, b)    for a.b
-- __newindex(a, b, c)             for a.b = c
-- __call(a, ...)                  for a(...)



----------
-- 3.2 类风格的 Table 与继承
----------



-- 像 Javascript 一样并没有内置 Class
-- 但可以通过 Table `{}` 实现
Dog = {}                                -- 1.
function Dog:new()                      -- 2.
    newObj = {sound = 'woof'}           -- 3.
    self.__index = self                 -- 4.
    return setmetatable(newObj, self)   -- 5.
end
function Dog:makeSound()                -- 6.
    print('I say ' .. self.sound)
end
mrDog = Dog:new()                       -- 7.
mrDog:makeSound() --> "I say woof"
-- 1. Dog 像类但实际是 Table
-- 2. Dog:new(...) := Dog.new(self, ...)
-- 3. newObj 作 Dog 的实例
-- 4. self 是 Lua 中默认的参数，在这里 self = Dog
--    继承的时候可以改变
--    self.__index 与 self 的元方法 __index 不是一回事
--    self = {__index = self, metatable = {__index = ...}}
-- 5. setmetatable(newObj, self) 相当于 setmetatable(newObj, {__index = self})
--    赋予实例所有类方法
-- 6. 同 2.
-- 7. mrDog = Dog.new(Dog)

-- 继承
LoudDog = Dog:new()
function LoudDog:makeSound()
    s = self.sound .. ' '
    print(s .. s .. s)
end
seymour = LoudDog:new()
seymour:makeSound() --> "woof woof woof"





----------
-- 4. 模块
----------

-- 以下来自文件 mod.lua
local M = {}
local function sayMyName()
    print('Hrunkner')
end
function M.sayHello()
    print('Why hello there')
    sayMyName()
end
return M

-- 以上
-- 回到主文件
-- 运行 mod.lua 中的代码
local mod = require('mod')
-- 操作同下
local mod = (function()
-- 像 Javascript 一样
--[[
mod.lua 中的代码
]]--
end)()

mod.sayHello() --> "Why hello there"
mod.sayMyName() --> 错！sayMyName() 是 mod.lua 中的局部变量
-- require 返回的值将被缓存
-- 即使多次调用 require 被调用文件也只运行一次
-- mod2.lua 包含 print("mod2")
local a = require("mod2") --> "mod2"
local b = require("mod2") -- 不输出， 实际为 b = a
-- dofile 是不缓存的版本的 require
dofile("mod2") --> "mod2"
dofile("mod2") --> "mod2"
-- loadfile 读取文件但不执行
-- 勘误：f = loadfile('mod2')，需加后缀名，否则找不到文件
f = loadfile('mod2.lua')
f() --> "mod2"
-- loadstring 读取代码字符串
f = loadstring("print('Lua is cool!')")
f() --> "Lua is cool!"
