# ==========================================================================================
# constants
# ==========================================================================================
"Number of seconds in a week."
const SECONDS_IN_WEEK::Int64 = 60 * 60 * 24 * 7

"Week Number offset between GST and GnssTime."
const GAL_WEEK_OFFSET::Int = 1024

"Time difference in seconds between UTC and TAI at origin of GnssTime."
const LEAP_SECOND_TAI_OFFSET::Int = 19

"Origin of GPST."
const GPST₀::DateTime = DateTime(1980, 1, 6)

"Origin of GST."
const GST₀::DateTime = DateTime(1999, 8, 22)
