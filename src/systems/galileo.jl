# ==========================================================================================
# generic galileo time
# ==========================================================================================
"""
    GST(wn, tow) <: CoarseTime

Coarse time reference as disseminated by Galileo.

# Resolution
It has integer-second resolution because TOW is represented by an `Int64`.
WN does not rollover (it keeps counting since GST₀ continuously.)

# More info
Check
[Time References in GNSS](https://gssc.esa.int/navipedia/index.php/Time_References_in_GNSS)
for more info.
"""
struct GST <: CoarseTime
    "Week number as complete weeks elapsed since GST₀."
    wn::Int
    "Time of week as complete seconds since the beginning of week."
    tow::Int

    function GST(wn, tow)
        wn_, tow_ = _canon_coarsetime(Int(wn), Int(tow))
        return new(wn_, tow_)
    end
end


# ==========================================================================================
# conversion
# ==========================================================================================
# NOTE
#   This discards the fractional part directly without checking first.
function Base.convert(::Type{T}, t::GnssTime) where {T <: GST}
    GST(t.wn - GAL_WEEK_OFFSET, t.tow_int)
end
function Base.convert(::Type{T}, t::GST) where {T <: GnssTime}
    GnssTime(t.wn + GAL_WEEK_OFFSET, t.tow, 0.0)
end


# ==========================================================================================
# convenience constructors
# ==========================================================================================
# Convenience conversion
"""
    GST(t::T)

Convert from time reference of type `T` to `GST`.

Valid types are:
- `T::SystemTime`
- `T::Date`
- `T::DateTime`
"""
GST(t::Union{Date, DateTime, SystemTime}) = Base.convert(GST, t)

# Convenience conversion (UTC)
"""
    GST(t::DateTime, UTC)

Convert from `DateTime` assumming that `t` is a UTC time.
"""
GST(t::DateTime, ::Type{UTC}) = GST(GnssTime(t, UTC))
