---

local string_helper = require("string_snippet")
local shell_helper = {}

---execute shell command
---@param cmd string 命令字符串
---@return boolean 命令运行错误码
---@return table 命令输出
function shell_helper.run_cmd(cmd)
    local fd = io.open(cmd)
    if fd == nil then
        return false, nil
    end
    local content = fd:read("*a")
    fd:close()
    return true, content
end

---shell command basename
---@param path string 文件路径
---@return string
function shell_helper.basename(path)
    return string.gsub(path, "(.*[/\\])(.*)", "%2")
end

---shell command dirname
---@param path string 文件路径
---@return string
function shell_helper.dirname(path)
    local paths = string_helper.split(path, "/")
    return paths[#paths - 1]
end

---shell command mkdir
---@param path string 文件路径
---@return boolean
function shell_helper.mkdir(path)
    if not path then
        return false
    end
    local rec = os.execute("mkdir -p " .. path)
    if rec ~= 0 then
        return false
    end
    return true
end

return shell_helper
