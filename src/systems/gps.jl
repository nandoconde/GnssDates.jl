# ==========================================================================================
# gps time
# ==========================================================================================
"""
Generic function related to conversion to/from GPS Time reference.

# Resolution
WN does not rollover (it keeps counting since GPST₀ continuously.)

# Relationship with UTC and TAI

At 2025-07-16, relationship between UTC, TAI and GPST is:
```
    <------------------leap seconds----------------->
    <--------var--------><--------19 seconds-------->
  UTC                 GPST                         TAI
15:56:23            15:56:41                     15:57:00
```
where the difference between GPST and TAI is fixed by 19 seconds, and the difference
between GnssTime and UTC depends on the currently introduced leap seconds.

# More info
Check [Time References in GNSS](https://gssc.esa.int/navipedia/index.php/Time_References_in_GNSS)
for more info.
"""
function GPST end

"""
    GPST(wn, tow)

Create GnssTimeCoarse from WN and TOW reference disseminated by GPS.

# Arguments
- `wn::Int64`: GPS Week Number
- `tow::Int64`: GPS Time of Week
"""
function GPST(wn, tow::Integer)
    return GnssTimeCoarse(wn, tow)
end

"""
    GPST(wn, tow, frac)

Create GnssTime from WN and TOW reference disseminated by GPS, plus fractional part of
seconds.

# Arguments
- `wn::Integer`: GPS Week Number
- `tow::Integer`: GPS Time of Week
- `frac`: fractional part of a second
"""
GPST(wn, tow, frac) = GnssTime(wn, tow, frac)

function GPST(wn, tow::AbstractFloat)
    tow_ = Int(floor(tow))
    return GnssTime(wn, tow_, tow - tow_)
end

# ==========================================================================================
# reverse GPST retrieval
# ==========================================================================================
function wntow(::typeof(GPST), t::AbstractGnssTime, rollover::Bool)
    if rollover
        return (t.wn % GPS_WEEK_NUMBER_ROLLOVER, t.tow)
    else
        return (t.wn, t.tow)
    end
end
