---

local datetime_helper = {}

---日期时间转时间戳
---@example tm = date_to_timestamp("2020-07-01T14:53:40","(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)")
---@param str_date string
---@param format string
---@return any
function datetime_helper.date2tm(str_date, format)
    local _, _, y, m, d, _hour, _min, _sec = string.find(tostring(str_date), format)
    local end_tm =
        os.time(
        {
            year = y,
            month = m,
            day = d,
            hour = _hour,
            min = _min,
            sec = _sec
        }
    )
    return end_tm
end

return datetime_helper
