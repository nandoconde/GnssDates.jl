# [Timescales](@id timescales)

Timescales are the means by which GNSS constellations keep the track of current
time.

## Type hierarchy

All timescale types are subtypes of an abstract `SystemTime`. The precision of
the timescale is reflected by another two abstract subtypes from `SystemTime`:
`CoarseTime` and `FineTime`.

## System implementations

The basic times associated to each constellation are `CoarseTime`s.
These include:

- Galileo: `GST`
- GPS: `GPST`
- Others will come.

```jldoctest timescales
julia> using GnssDates

julia> galt = GST(967, 432000)
GST(967, 432000)

julia> galt.wn
967

julia> galt.tow
432000

julia> gpst = GPST(1991, 432000)
GPST(1991, 432000)
```

## High-resolution time

The only provided subtype of `FineTime` is `GnssTime`. It is aligned in WN
and TOW with GPS time, but also includes the decimal part of the current
second as a `Float64` between `0.0` (included) and `1.0` (not included).

```jldoctest timescales
julia> gnsst = GnssTime(967, 432000, 0.0)
GnssTime(967, 432000, 0.0)
```

## Timescale domain

These types can also represent times beyond the beginning of the timescale,
using always positve TOW but negative WN.

The WN is not limited to that disseminated by the SIS. Just like RINEX files,
it can count beyond the values that allow the usual 10 or 12 bits allocated
for them in the SIS.

```jldoctest timescales
julia> GnssTime(0, -GnssDates.SECONDS_IN_WEEK + 75, 0.5)
GnssTime(-1, 75, 0.5)

julia> GST(966, 432000 + GnssDates.SECONDS_IN_WEEK)
GST(967, 432000)

julia> GPST(1992, 432000 - GnssDates.SECONDS_IN_WEEK)
GPST(1991, 432000)
```

## Conversion between `SystemTime`s

Conversion between these types works as expected, and over/underflown values
are automatically rolled over/under and converted to the appropriate times.

```jldoctest timescales
julia> gst = GST(967, 432000)
GST(967, 432000)

julia> gpst = GPST(gst)
GPST(1991, 432000)

julia> gnsst = GnssTime(gpst)
GnssTime(1991, 432000, 0.0)

julia> GST(gnsst)
GST(967, 432000)
```
