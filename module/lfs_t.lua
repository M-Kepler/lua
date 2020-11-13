require "lfs"

function attrdir(path)
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then -- 过滤linux目录下的"."和".."目录
            local f = path .. "/" .. file
            local attr = lfs.attributes(f)
            if attr.mode == "directory" then
                print(f .. "  -->  " .. attr.mode)
                attrdir(f) -- 如果是目录，则进行递归调用
            else
                print(f .. "  -->  " .. attr.mode)
            end
        end
    end
end

attrdir("..")
