module GnssDates


import Base
import Dates: Date, DateTime, canonicalize, UTC, Dates, Week, Second, Millisecond
import LeapSeconds

export GnssTime, GPST, GST, SystemTime, CoarseTime, FineTime
export TimeDelta, CoarseTimeDelta, FineTimeDelta

if VERSION >= v"1.11.0-DEV.469"
    eval(Meta.parse("public GnssTime, GPST, GST, SystemTime, CoarseTime, FineTime"))
    eval(Meta.parse("public TimeDelta, CoarseTimeDelta, FineTimeDelta"))
    eval(Meta.parse("public SECONDS_IN_WEEK, GAL_WEEK_OFFSET, LEAP_SECOND_TAI_OFFSET"))
    eval(Meta.parse("public GPST₀, GST₀"))
    eval(Meta.parse("public Unchecked"))
end

include("constants.jl")
include("timedelta.jl")
include("systemtime.jl")
include("operations.jl")

end
