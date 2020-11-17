function print_r ( t )
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
end

local function get_memory()
    return collectgarbage("count")
end
collectgarbage("stop")


local before = get_memory()
polyline =
{
    { x = 10.3, y = 98.5 },
    { x = 10.3, y = 18.3 },
    { x = 15.0, y = 98.5 }
}
local after = get_memory()
print_r(polyline)
print("polyline table used memory: " .. (after - before) * 1024 .. " bits")

local before2 = get_memory()
local a = {}
local after2 = get_memory()
print("polyline table used memory: " .. (after2 - before2) * 1024 .. " bits")

new_polyline =
{
    x = { 10.3, 10.3, 15.0, ...},
    y = { 98.5, 18.3, 98.5, ...}
}

print_r(new_polyline)

