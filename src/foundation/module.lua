-- 定义一个名为 module 的模块
module = {}
-- 定义一个常量
module.constant = "这是一个常量"
-- 定义一个函数

function module.func1()
    io.write("public func!\n")
end

-- 所谓私有函数就是不把这个函数放到模块里。。。
local function func2()
    print("private func!")
end
function module.func3()
    func2()
end
print("test")
return module
