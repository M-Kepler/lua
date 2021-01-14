local string_helper = require ("string_snippet")
local shell_helper = {}


---execute shell command
---@param cmd string 命令字符串
---@return integer 命令运行错误码
---@return nil 命令输出
function shell_helper.run_cmd(cmd)
    --TODO
    local rec = -1
    local ret = nil
    return rec, ret
end


---shell command basename
---@param path string 路径
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

return shell_helper
