local function handleSleepSignal(asleep)
    local now = os.time()                       -- Return value between 0.0 -> 23.9
    if now >= 5 and now <= 19.5 then return end -- Ignore during the day

    if asleep then
        return sendSleepSignal()
    end

    if FORCE_SLEEP then
        if now < 5 then now = now + 24 end
        if SLEEP_TIME < 5 then SLEEP_TIME = SLEEP_TIME + 24 end
        if now > SLEEP_TIME then
            return sendSleepSignal()
        end
    end
end

return handleSleepSignal
