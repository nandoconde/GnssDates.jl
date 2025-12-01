# ==========================================================================================
# abstract gnss time interface
# ==========================================================================================
"""
    AbstractGnssTime

Parent type for `GnssTime` and `GnssTimeCoarse`.

Any children of `AbstractGnssTime` must have at least the following fields:
- `wn::Int64`: Week Number counting from GPST₀
- `tow::Int64`: Time of Week counting from the beginning of GPS week
"""
abstract type AbstractGnssTime end

"""
    wntow(T, t[, rollover=false]) -> (wn::Int64, tow::Int64)

Retrieve Week Number and Time of Week associated to `t` using the time origin
from time reference `T`, optionally doing week number rollover.

# Arguments

`T` can be either:
- `GnssTime`
- `GnssTimeCoarse`
- `GPS`
- `GST`
- `BDT`

`t` can be either:
- `t::AbstractGnssTime`
- `t::DateTime`: it assumes UTC time.

`rollover` is an optional boolean
"""
function wntow end

function wntow(T, t)
    return wntow(T, t, false)
end

function wntow(::Type{<:AbstractGnssTime}, t::AbstractGnssTime, rollover::Bool)
    return (t.wn, t.tow)
end


# ==========================================================================================
# generic gnss time
# ==========================================================================================
"""
    GnssTime(wn, tow, frac)

Absolute and continuous time reference whose origin is aligned to GPS's.
GPS Time origin is at 1980-01-06 (Jan 6th, 1980) UTC.

# Resolution
It has subsecond resolution down to **femtoseconds** because it uses `Float64` to represent
decimal part of the current second.
WN does not rollover (it keeps counting since GPST₀ continuously.)

# Relationship with UTC and TAI

At 2025-07-16, relationship between UTC, TAI and GnssTime is:
```
    <------------------leap seconds----------------->
    <--------var--------><--------19 seconds-------->
  UTC               GnssTime                       TAI
15:56:23            15:56:41                     15:57:00
```
where the difference between GnssTime and TAI is fixed by 19 seconds, and the difference
between GnssTime and UTC depends on the currently introduced leap seconds.
"""
struct GnssTime <: AbstractGnssTime
    "Week number as complete weeks elapsed since GPST₀."
    wn::Int
    "Time of week as complete seconds since the beginning of GPS/GST week."
    tow::Int
    "Seconds elapsed since the previous integer second."
    frac::Float64

    function GnssTime(wn, tow, frac)
        wn_, tow_, towf_ = _canon_finetime(Int(wn), Int(tow), Float64(frac))
        return new(wn_, tow_, towf_)
    end
end


"""
    GnssTimeCoarse(wn, tow, frac)

Absolute and continuous time reference whose origin is aligned to GPS's.
GPS Time origin is at 1980-01-06 (Jan 6th, 1980) UTC.

# Resolution
It has integer-second resolution.
WN does not rollover (it keeps counting since GPST₀ continuously.)

# Relationship with UTC and TAI

At 2025-07-16, relationship between UTC, TAI and GnssTimeCoarse is:
```
    <------------------leap seconds----------------->
    <--------var--------><--------19 seconds-------->
  UTC            GnssTimeCoarse                    TAI
15:56:23            15:56:41                     15:57:00
```
where the difference between GnssTimeCoarse and TAI is fixed by 19 seconds, and the
difference between GnssTimeCoarse and UTC depends on the currently introduced leap seconds.
"""
struct GnssTimeCoarse <: AbstractGnssTime
    "Week number as complete weeks elapsed since GPST₀."
    wn::Int
    "Time of week as complete seconds since the beginning of GPS/GST week."
    tow::Int

    function GnssTimeCoarse(wn, tow)
        wn_, tow_ = _canon_coarsetime(Int(wn), Int(tow))
        return new(wn_, tow_)
    end
end


# ==========================================================================================
# convenience constructors
# ==========================================================================================
function GnssTime(wn, tow)
    tow_ = Int(floor(tow))
    return GnssTime(wn, tow_, tow - tow_)
end


# ==========================================================================================
# conversion between `AbstractGnssTime`
# ==========================================================================================
function Base.convert(::Type{GnssTimeCoarse}, t::GnssTime)
    # as with integers, convert only when fractional part is zeroa
    iszero(t.frac) || throw(InexactError(:GnssTimeCoarse, GnssTimeCoarse, t))
    return GnssTimeCoarse(t.wn, t.tow)
end

function Base.convert(::Type{GnssTime}, t::GnssTimeCoarse)
    return GnssTime(t.wn, t.tow, 0.0)
end


# ==========================================================================================
# convenience conversion
# ==========================================================================================
"""
    GnssTime(t::T)

Convert from a time with type `T` to `GnssTime`.
"""
function GnssTime(t)
    return Base.convert(GnssTime, t)
end

"""
    GnssTime(t::T)

Convert from a time with type `T` to `GnssTimeCoarse`.
"""
function GnssTimeCoarse(t)
    return Base.convert(GnssTimeCoarse, t)
end
