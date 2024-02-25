RDV = RDV or {}
RDV.LIBRARY = RDV.LIBRARY or {}
RDV.LIBRARY.TIMERS = RDV.LIBRARY.TIMERS or {}

local DELAY = CurTime()

hook.Add("Think", "RDV.LIBRARY.TIMERS", function()
    if DELAY > CurTime() then
        return
    end    

    RDV.LIBRARY.TIMERS = RDV.LIBRARY.TIMERS or {}

    for k, v in pairs(RDV.LIBRARY.TIMERS) do
        if v.START + v.SECONDS < SysTime() then
            if v.ITERATIONS and v.ITERATIONS >= 1 then
                v.START = SysTime()

                v.ITERATIONS = v.ITERATIONS - 1

                if v.ITERATIONS <= 0 then
                    RDV.LIBRARY.TIMERS[k] = nil
                end
            else
                RDV.LIBRARY.TIMERS[k] = nil

                continue
            end

            v.CALLBACK()
        end
    end

    DELAY = CurTime() + engine.TickInterval()
end)

local SIMPLE_COUNT = 0

function RDV.LIBRARY.TimerSimple(SECONDS, CALLBACK)
    if not SECONDS or not CALLBACK then
        return
    end

    SIMPLE_COUNT = SIMPLE_COUNT + 1

    RDV.LIBRARY.TIMERS[SIMPLE_COUNT] = {
        START = SysTime(),
        SECONDS = SECONDS,
        CALLBACK = CALLBACK
    }
end

function RDV.LIBRARY.Timer(IDENTIFIER, SECONDS, ITERATIONS, CALLBACK)
    if not SECONDS or not CALLBACK then
        return
    end

    if tonumber(ITERATIONS) == 0 then
        ITERATIONS = math.huge
    end

    RDV.LIBRARY.TIMERS[IDENTIFIER] = {
        START = SysTime(),
        SECONDS = SECONDS,
        ITERATIONS = ITERATIONS,
        CALLBACK = CALLBACK
    }
end

function RDV.LIBRARY.TimerExists(IDENTIFIER)
    if RDV.LIBRARY.TIMERS[IDENTIFIER] then
        return true
    else
        return false
    end
end

function RDV.LIBRARY.TimerRemove(IDENTIFIER)
    if RDV.LIBRARY.TIMERS[IDENTIFIER] then
        RDV.LIBRARY.TIMERS[IDENTIFIER] = nil

        return true
    else
        return false
    end
end