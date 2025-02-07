# ==========================================================================================
# generic gps time
# ==========================================================================================
"""
    GPST(wn, tow) <: CoarseTime

Coarse time reference as disseminated by GPS.

# Resolution
It has integer-second resolution because TOW is represented by an `Int64`.
WN does not rollover (it keeps counting since GPST₀ continuously.)

# More info
Check
[Time References in GNSS](https://gssc.esa.int/navipedia/index.php/Time_References_in_GNSS)
for more info.
"""
struct GPST <: CoarseTime
    "Week number as complete weeks elapsed since GPST₀."
    wn::Int
    "Time of week as complete seconds since the beginning of week."
    tow::Int

    function GPST(wn, tow)
        wn_, tow_ = _canon_coarsetime(Int(wn), Int(tow))
        return new(wn_, tow_)
    end
end


# ==========================================================================================
# conversion
# ==========================================================================================
# unchecked conversion (GnssTime)
# NOTE
#   This discards the fractional part direclty without checking first.
Base.convert(::Type{T}, t::GnssTime) where {T <: GPST} = GPST(t.wn, t.tow_int)
Base.convert(::Type{T}, t::GPST) where {T <: GnssTime} = GnssTime(t.wn, t.tow, 0.0)    


# ==========================================================================================
# convenience constructors
# ==========================================================================================
# Convenience conversion
"""
    GPST(t::T)

Convert from time reference of type `T` to `GPST`.

Valid types are:
- `T::SystemTime`
- `T::Date`
- `T::DateTime`
"""
GPST(t::Union{SystemTime, Date, DateTime}) = Base.convert(GPST, t)

# Convenience conversion (UTC)
"""
    GPST(t::DateTime, UTC)

Convert from `DateTime` assumming that `t` is a UTC time.
"""
GPST(t::DateTime, ::Type{UTC}) = GPST(GnssTime(t, UTC))
