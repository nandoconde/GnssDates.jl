# ==========================================================================================
# bdt time
# ==========================================================================================
"""
Generic function related to conversion to/from BeiDou Time reference.

# Resolution
WN does not rollover (it keeps counting since BDT₀ continuously.)

# Relationship with UTC, TAI and GnssTime

At 2025-07-16, relationship between UTC, TAI, GnssTime and BDT is:
```
    <-----------------------leap seconds---------------------->
    <-----var-----><---14 seconds---><-------19 seconds------->
  UTC            BDT             GnssTime                    TAI
15:56:23       15:56:27          15:56:41                  15:57:00
```
where the difference between BDT and TAI is fixed by 33 seconds, and the difference
between BDT and UTC depends on the currently introduced leap seconds.

# More info
Check [Time References in GNSS](https://gssc.esa.int/navipedia/index.php/Time_References_in_GNSS)
for more info.
"""
function BDT end

"""
    BDT(wn, tow)

Create GnssTimeCoarse from WN and TOW reference disseminated by BeiDou.

# Arguments
- `wn::Int64`: BeiDou Week Number
- `tow::Int64`: BeiDou Time of Week
"""
function BDT(wn, tow::Integer)
    return GnssTimeCoarse(wn + BDS_WEEK_OFFSET, tow + BDS_SECOND_OFFSET)
end

"""
    BDT(wn, tow, frac)

Create GnssTime from WN and TOW reference disseminated by BeiDou, plus fractional part of
seconds.

# Arguments
- `wn::Integer`: BeiDou Week Number
- `tow::Integer`: BeiDou Time of Week
- `frac`: fractional part of a second
"""
BDT(wn, tow, frac) = GnssTime(wn + BDS_WEEK_OFFSET, tow + BDS_SECOND_OFFSET, frac)

function BDT(wn, tow::AbstractFloat)
    tow_ = Int(floor(tow))
    return GnssTime(wn + BDS_WEEK_OFFSET, tow_ + BDS_SECOND_OFFSET, tow - tow_)
end

# ==========================================================================================
# reverse BDT retrieval
# ==========================================================================================
function wntow(::typeof(BDT), t::AbstractGnssTime, rollover::Bool)
    wn_bds = t.wn - BDS_WEEK_OFFSET
    tow_bds = t.tow - BDS_SECOND_OFFSET
    if rollover
        return (wn_bds % BDS_WEEK_NUMBER_ROLLOVER, tow_bds)
    else
        return (wn_bds, tow_bds)
    end
end
