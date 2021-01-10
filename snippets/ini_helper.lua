local ini_helper = {}

function ini_helper.load(file_name)
    assert(type(file_name) == "string", 'Parameter "file_name" must be a string.')
    local file = assert(io.open(file_name, "r"), "Error loading file : " .. file_name)
    local data = {}
    local section
    for line in file:lines() do
        local tmp_section = line:match("^%[([^%[%]]+)%]$")
        if (tmp_section) then
            section = tonumber(tmp_section) and tonumber(tmp_section) or tmp_section
            data[section] = data[section] or {}
        end
        local param, value = line:match("^([%w|_|%s]+)%s-=%s-(.+)$")
        if (param and value ~= nil) then
            if (tonumber(value)) then
                value = tonumber(value)
            elseif (value == "true") then
                value = true
            elseif (value == "false") then
                value = false
            end
            if (tonumber(param)) then
                param = tonumber(param)
            end
            -- 需要处理一下
            data[section][param] = value
        end
    end
    file:close()
    return data
end

--写全部
function ini_helper.save(file_name, data)
    assert(type(file_name) == "string", 'Parameter "file_name" must be a string.')
    assert(type(data) == "table", 'Parameter "data" must be a table.')
    local file = assert(io.open(file_name, "w+b"), "Error loading file :" .. file_name)
    local contents = ""
    for section, param in pairs(data) do
        contents = contents .. ("[%s]\n"):format(section)
        for key, value in pairs(param) do
            contents = contents .. ("%s=%s\n"):format(key, tostring(value))
        end
        contents = contents .. "\n"
    end
    file:write(contents)
    file:close()
end

--读单条
function ini_helper.read(ini_path, section, key)
    local data = ini_helper.load(ini_path)
    if data and data[section] and data[section][key] then
        return data[section][key]
    end
    return nil
end

--写单条
function ini_helper.write(ini_path, section, key, value)
    local data = ini_helper.load(ini_path)
    data[section][key] = value
    ini_helper.save(ini_path, data)
end

return ini_helper
