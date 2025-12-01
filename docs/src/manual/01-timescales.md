# [GNSS Time](@id gnsstime)

GNSS Time represents a timescale that can be used to keep track of time for GNSS constellations.

## Type hierarchy

All GNSS time types are subtypes of an abstract `AbstractGnssTime`. The precision of
the timescale gives raise to two concrete subtypes: `GnssTime` and `GnssTimeCoarse`.

All `AbstractGnssTime` implementations contain at least two fields:

- `wn::Int`: weeks elapsed since the origin of the continuous timescale, which is GPST₀.
- `tow::Int`: seconds elapsed since the beginning of the week, which is aligned to GPST's and GST's.

To retrieve these fields as a tuple, check the function [`wntow`](#coarse-time-serialization---wntow).

### High-resolution GNSS time

`GnssTime` can be used to represent time in a GNSS constellation down to femtoseconds
without loss of precision. It has another field, `frac` to track sub-second time. `GnssTime` contains:

- `wn::Int`: weeks elapsed since the origin of the continuous timescale, which is GPST₀.
- `tow::Int`: seconds elapsed since the beginning of the week, which is aligned to GPST's and GST's.
- `frac::Float64`: seconds elapsed since the last second. Strictly in the `[0.0, 1.0)` interval.

```jldoctest timescales
julia> using GnssDates

julia> gnsst = GnssTime(2375, 496170, 0.75)
GnssTime(2375, 496170, 0.75)

julia> gnsst.wn
2375

julia> gnsst.tow
496170

julia> gnsst.frac
0.75
```

### Coarse-resolution GNSS time

For many applications, it is only important to keep track of time down to seconds. In this case,
`GnssTimeCoarse` is enough. It contains:

- `wn::Int`: weeks elapsed since the origin of the continuous timescale, which is GPST₀.
- `tow::Int`: seconds elapsed since the beginning of the week, which is aligned to GPST's and GST's.

```jldoctest timescales
julia> gnsstc = GnssTimeCoarse(2375, 496170)
GnssTimeCoarse(2375, 496170)

julia> gnsstc.wn
2375

julia> gnsstc.tow
496170
```

## GNSS systems

This package includes functions to build `GnssTime` or `GnssTimeCoarse` from the timestamps of
different constellations:

- GPS: `GPST`
- Galileo: `GST`
- BeiDou: `BDT`
- GLONASS: `GLONASST`
- Others will come.

### GPS

GPS timestamps are usually represented as a Week Number and a Time of Week. Thus, to construct
a `GnssTime` or a `GnssTimeCoarse` from them, `GPST` is provided with them:

```jldoctest timescales
julia> gpstc = GPST(2375, 496170)
GnssTimeCoarse(2375, 496170)

julia> (gpstc.wn, gpstc.tow)
(2375, 496170)

julia> gpst = GPST(2375, 496170, 0.5) # same as GPST(2375, 496170.5)
GnssTime(2375, 496170, 0.5)

julia> (gpst.wn, gpst.tow)
(2375, 496170)

julia> gpst.frac
0.5
```

### Galileo

Galileo timestamps are usually represented as a Week Number and a Time of Week. Thus, to construct
a `GnssTime` or a `GnssTimeCoarse` from them, `GST` is provided with them:

```jldoctest timescales
julia> gstc = GST(1351, 496170)
GnssTimeCoarse(2375, 496170)

julia> (gstc.wn, gstc.tow)
(2375, 496170)

julia> gst = GST(1351, 496170, 0.5) # same as GST(1351, 496170.5)
GnssTime(2375, 496170, 0.5)

julia> (gst.wn, gst.tow)
(2375, 496170)

julia> gst.frac
0.5
```

### BeiDou

BeiDou timestamps are usually represented as a Week Number and a Time of Week. Thus, to construct
a `GnssTime` or a `GnssTimeCoarse` from them, `BDT` is provided with them:

```jldoctest timescales
julia> bdtc = BDT(1019, 496156)
GnssTimeCoarse(2375, 496170)

julia> (bdtc.wn, bdtc.tow)
(2375, 496170)

julia> bdt = BDT(1019, 496156, 0.5) # same as BDT(1019, 496156.5)
GnssTime(2375, 496170, 0.5)

julia> (bdt.wn, bdt.tow)
(2375, 496170)

julia> bdt.frac
0.5
```

### GLONASS

GLONASS timestamps are usually represented as datetimes in Moscow Time (UTC+3). Thus, to construct
a `GnssTime` or a `GnssTimeCoarse` from them, `GLONASST` must be provided with a `DateTime`
representing Moscow Time:

!!! warning "Caveat!"

    Since GLONASS timestamps are always a `DateTime` objects, they are automatically
    converted to `GnssTime`.

    To retrieve a `GnssTimeCoarse` it must be converted after construction.

```jldoctest timescales
julia> glonasst = GLONASST(DateTime(2025, 07, 18, 20, 49, 12))
GnssTime(2375, 496170, 0.0)

julia> (glonasst.wn, glonasst.tow)
(2375, 496170)

julia> glonasst.frac
0.0

julia> glonasstc = GnssTimeCoarse(glonasst)
GnssTimeCoarse(2375, 496170)

julia> (glonasstc.wn, glonasstc.tow)
(2375, 496170)
```

To convert back to a GLONASS timestamp in Moscow Time, convert from an `AbstractGnssTime` to `DateTime`
and manually add 3 hours.

## Coarse time serialization - `wntow`

Most navigation systems (with the notable exception of GLONASS) define a tuple, (WN, TOW),
which they use to represent coarse timestamps (integer-second resolution).

The function `wntow` is used to retrieve this tuple from an `AbstractGnssTime` for any
navigation system.

```jldoctest timescales
julia> (gnsstc.wn, gnsstc.tow)
(2375, 496170)

julia> wntow(GnssTime, gnsstc)
(2375, 496170)

julia> wntow(GnssTimeCoarse, gnsstc)
(2375, 496170)

julia> wntow(GPST, gnsstc) # GnssTime origin matches GPS's
(2375, 496170)

julia> julia> wntow(GST, gnsstc) # There is a 1024-week offset between GPST and GST
(1351, 496170)

julia> julia> wntow(BDT, gnsstc) # There is a 136-week and 14-second offset between GPST and BDT
(1019, 496156)
```
