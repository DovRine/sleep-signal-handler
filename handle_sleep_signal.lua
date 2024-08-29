local DAY_START = 5          -- 5:00 AM
local DAY_END = 19.5         -- 7:30 PM
local MIDNIGHT_THRESHOLD = 5 -- 5:00 AM, threshold for crossing midnight
local HOURS_PER_DAY = 24

local function handleSleepSignal(asleep)
    local now = os.time()
    local isDaytime = now >= DAY_START and now <= DAY_END

    -- Ignore during the day
    if isDaytime then return end

    if asleep then
        return sendSleepSignal()
    end

    if FORCE_SLEEP then
        local isBeforeMidnightNow = now < MIDNIGHT_THRESHOLD
        local isBeforeMidnightSleepTime = SLEEP_TIME < MIDNIGHT_THRESHOLD

        local timeAfterMidnight = isBeforeMidnightNow and now + HOURS_PER_DAY or now
        local sleepTimeAfterMidnight = isBeforeMidnightSleepTime and SLEEP_TIME + HOURS_PER_DAY or SLEEP_TIME

        local hasPassedSleepTime = timeAfterMidnight > sleepTimeAfterMidnight

        if hasPassedSleepTime then
            return sendSleepSignal()
        end
    end
end

return handleSleepSignal
