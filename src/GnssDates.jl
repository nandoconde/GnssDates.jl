"""
Package with definitions to work with GNSS datetimes and time intervals.

- Abstract types: `SystemTime`, `CoarseTime`, `FineTime`, `TimeDelta`
- Time references: `GnssTime`, `GPST`, `GST`
- Time intervals: `CoarseTimeDelta`, `FineTimeDelta`
- Operators: `+`, `-`, `==`, `>`, `>=`, `<`, `<=`
"""
module GnssDates

# import names from `Base` and `Dates` to add methods
import Base: Base, convert
import Dates: Date, DateTime, UTC, Dates, Week, Second, Millisecond

# used for UTC conversion
import LeapSeconds

# export public names destined for user
export GnssTime, GPST, GST, SystemTime, CoarseTime, FineTime
export TimeDelta, CoarseTimeDelta, FineTimeDelta

# make some nams public
if VERSION >= v"1.11.0-DEV.469"
    eval(Meta.parse("public GnssTime, GPST, GST, SystemTime, CoarseTime, FineTime"))
    eval(Meta.parse("public TimeDelta, CoarseTimeDelta, FineTimeDelta"))
    eval(Meta.parse("public SECONDS_IN_WEEK, GAL_WEEK_OFFSET, LEAP_SECOND_TAI_OFFSET"))
    eval(Meta.parse("public GPST₀, GST₀"))
end

# include package code
include("constants.jl")
include("helpers.jl")
include("timedelta.jl")
include("systemtime.jl")
include("operations.jl")

end
