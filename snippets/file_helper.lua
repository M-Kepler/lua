
local file_helper = {}

---获取路径下的文件列表
---@param path 路径
---@return table
function file_helper.get_file_list(path)
    local ls_output = io.popen("ls " .. path .. "/")
    local files_tb = {}
    if ls_output == nil then
    else
        for file_item in ls_output:lines() do
            table.insert(files_tb, file_item)
        end
    end
    return files_tb
end

---获取目录下全部文件
---@param folder_path 目录路径
---@param result_path 输出结果
function file_helper.get_all_files_in_folder(folder_path, result_path)
    local file_tb = {}
    local file_list = {}
    local new_path = ""
    local result_fd = io.open(result_path .. "/all_files.txt", "a")
    file_list = file_helper.get_file_list(folder_path)
    for index = 1, #file_list do
        -- 如果非文件，则递归进去查找
        if string.find(file_list[index], "%.") == nil then
            new_path = folder_path .. "/" .. file_list[index]
            file_helper.get_file_list(new_path, result_path)
        else
            result_fd:write(folder_path .. "/" .. file_list[index] .. "\n")
        end
    end
    result_fd:close()
end


---删除文件夹下的所有文件 rm -rf
---@param folder_path string
function file_helper.delete_all_folder(folder_path)
    os.execute("rm -rf " .. folder_path)
end

---删除空文件夹或文件
---@param folder_path 文件路径
function file_helper.delete_all_folder(folder_path)
    os.remove(folder_path)
end


---判断文件是否存在
---@param file_path 文件路径
function file_helper.is_file_exist(file_path)
    local fd = io.open(file_path, "w")
    return fd ~= nil and fd:close()
end

return file_helper
