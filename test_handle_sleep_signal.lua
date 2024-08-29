-- Import the handleSleepSignal function
-- local handleSleepSignal = require("handle_sleep_signal_original")
local handleSleepSignal = require("handle_sleep_signal")

-- Mock os.time to control the current time in the test environment
function mockTime(time)
    os.time = function() return time end
end

-- Mock sendSleepSignal to capture when it's called
local sleepSignalCalled = false
function sendSleepSignal()
    sleepSignalCalled = true
end

local function testHandleSleepSignal()
    -- Test case 1: Daytime, no sleep signal expected
    mockTime(10) -- 10 AM
    sleepSignalCalled = false
    handleSleepSignal(false)
    print("Test 1 - No sleep signal (Daytime, not asleep):", not sleepSignalCalled)

    -- Test case 2: Nighttime, sleep signal expected when asleep
    mockTime(23) -- 11 PM
    sleepSignalCalled = false
    handleSleepSignal(true)
    print("Test 2 - Sleep signal sent (Nighttime, asleep):", sleepSignalCalled)

    -- Test case 3: Nighttime, no sleep signal when not asleep
    mockTime(23) -- 11 PM
    sleepSignalCalled = false
    handleSleepSignal(false)
    print("Test 3 - No sleep signal (Nighttime, not asleep):", not sleepSignalCalled)

    -- Test case 4: Force sleep active, sleep time passed
    FORCE_SLEEP = true
    SLEEP_TIME = 22 -- 10 PM
    mockTime(23)    -- 11 PM
    sleepSignalCalled = false
    handleSleepSignal(false)
    print("Test 4 - Sleep signal sent (Force sleep, sleep time passed):", sleepSignalCalled)

    -- Test case 5: Force sleep active, sleep time not passed
    FORCE_SLEEP = true
    SLEEP_TIME = 2 -- 2 AM
    mockTime(1)    -- 1 AM
    sleepSignalCalled = false
    handleSleepSignal(false)
    print("Test 5 - No sleep signal (Force sleep, sleep time not passed):", not sleepSignalCalled)
end

-- Run the tests
testHandleSleepSignal()
