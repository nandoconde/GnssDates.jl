# ==========================================================================================
# galileo time
# ==========================================================================================
"""
Generic function related to conversion to/from Galileo Time reference.

# Resolution
WN does not rollover (it keeps counting since GST₀ continuously.)

# Relationship with UTC and TAI

At 2025-07-16, relationship between UTC, TAI and GST is:
```
    <------------------leap seconds----------------->
    <--------var--------><--------19 seconds-------->
  UTC                  GST                         TAI
15:56:23            15:56:41                     15:57:00
```
where the difference between GST and TAI is fixed by 19 seconds, and the difference
between GST and UTC depends on the currently introduced leap seconds.

# More info
Check [Time References in GNSS](https://gssc.esa.int/navipedia/index.php/Time_References_in_GNSS)
for more info.
"""
function GST end


"""
    GST(wn, tow)

Create GnssTimeCoarse from WN and TOW reference disseminated by Galileo.

# Arguments
- `wn::Int64`: Galileo Week Number
- `tow::Int64`: Galileo Time of Week
"""
function GST(wn, tow::Integer)
    return GnssTimeCoarse(wn + GAL_WEEK_OFFSET, tow)
end

"""
    GST(wn, tow, frac)

Create GnssTime from WN and TOW reference disseminated by Galileo, plus fractional part of
seconds.

# Arguments
- `wn::Integer`: Galileo Week Number
- `tow::Integer`: Galileo Time of Week
- `frac`: fractional part of a second
"""
GST(wn, tow, frac) = GnssTime(wn + GAL_WEEK_OFFSET, tow, frac)

function GST(wn, tow::AbstractFloat)
    tow_ = Int(floor(tow))
    return GnssTime(wn + GAL_WEEK_OFFSET, tow_, tow - tow_)
end

# ==========================================================================================
# reverse GST retrieval
# ==========================================================================================
function wntow(::typeof(GST), t::AbstractGnssTime, rollover::Bool)
    wn_gal = t.wn - GAL_WEEK_OFFSET
    tow_gal = t.tow
    if rollover
        return (wn_gal % GAL_WEEK_NUMBER_ROLLOVER, tow_gal)
    else
        return (wn_gal, tow_gal)
    end
end
