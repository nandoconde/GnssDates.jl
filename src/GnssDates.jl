"""
Package with definitions to work with GNSS datetimes and time intervals.

- Abstract types: `SystemTime`, `CoarseTime`, `FineTime`, `AbstractTimeDelta`
- Time references: `GnssTime`, `BDT`, `GPST`, `GST`
- Time intervals: `TimeDeltaCoarse`, `TimeDelta`
- Operators: `+`, `-`, `==`, `>`, `>=`, `<`, `<=`
"""
module GnssDates

# import names from `Base` and `Dates` to add methods
import Base
import Dates: DateTime, UTC, Week, Day, Hour, Second, Millisecond
import GnssCore.Constants.Time: SECONDS_IN_WEEK
import GnssCore.Constants.Time: GPS_WEEK_NUMBER_ROLLOVER
import GnssCore.Constants.Time: GAL_WEEK_OFFSET, GAL_WEEK_NUMBER_ROLLOVER
import GnssCore.Constants.Time: BDS_WEEK_OFFSET, BDS_SECOND_OFFSET, BDS_WEEK_NUMBER_ROLLOVER

# used for UTC conversion
import LeapSeconds
# usage:
#   t_utc = t_tai + Second(LeapSeconds.offset_utc_tai(t_tai))
#   t_tai = t_utc + Second(LeapSeconds.offset_tai_utc(t_utc))

# export public names destined for user
export AbstractGnssTime, GnssTime, GnssTimeCoarse
export AbstractTimeDelta, TimeDelta, TimeDeltaCoarse
export BDT, GPST, GST, GLONASST
export wntow

# make some names public in v1.11 and later
VERSION >= v"1.11" && include("auxiliary/public.jl")

# include package code
include("auxiliary/constants.jl")
include("auxiliary/helpers.jl")
include("systems/systems.jl")
include("operations/operations.jl")

# precompile package
include("auxiliary/precompile.jl")

end
