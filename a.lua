-- 之前有好多操作，忽略不看
-- ...
-- ...
print("os.clock example :\n");
-- 记录开始时间
local starttime = os.clock();                           --> os.clock()用法
print(string.format("start time : %.4f", starttime));

-- 进行耗时操作
-- os.execute("sleep 2")
local sum = 0
for var = 0, 100000000 do
    sum = sum +1
end


local endtime = os.clock();                           --> os.clock()用法
print(string.format("end time   : %.4f", endtime));
print(string.format("cost time  : %.4f", endtime - starttime));

