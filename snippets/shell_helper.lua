local string_helper = require ("string_snippet")
local shell_helper = {}


function shell_helper.run_cmd()
    -- TODO
end


function shell_helper.basename(str)
    return string.gsub(str, "(.*[/\\])(.*)", "%2")
end


function shell_helper.dirname(file_path)
    local paths = string_helper.split(file_path, "/")
    return paths[#paths - 1]
end

