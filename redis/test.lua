-- 设置测试数据 redis-cli set apple '{"color": "red", "type": "fruit"}'
-- redis-cli --eval test.lua apple , type
if redis.call("EXISTS", KEYS[1]) == 1 then
    local payload = redis.call("GET", KEYS[1])
    return cjson.decode(payload)[ARGV[1]]
else
    return KEYS
end
