# ==========================================================================================
# generic gnss time
# ==========================================================================================
# TODO Document struct and field
struct GnssTime <: FineTime
    wn::Int
    tow_int::Int
    tow_frac::Float64

    function GnssTime(wn, tow_int, tow_frac)
        wn_, tow_, towf_ = _canon_finetime(Int(wn), Int(tow_int), Float64(tow_frac))
        return new(wn_, tow_, towf_)
    end
end


# ==========================================================================================
# conversion
# ==========================================================================================
function Base.convert(::Type{T}, t::DateTime) where {T <: GnssTime}
    # note: CompoundPeriods are not used because they allocate :)
    Δms = (t - GPST₀).value # Milliseconds
    # Δms < 0 && throw(DomainError(t, "GnssTime cannot represent a date before GPST₀"))
    Δs, tow_frac_ms = fldmod(Δms, 1000)
    tow_frac = tow_frac_ms / 1000
    wn, tow_int = fldmod(Δs, SECONDS_IN_WEEK)
    return GnssTime(wn, tow_int, tow_frac)
end
function Base.convert(::Type{T}, t::GnssTime) where {T <: DateTime}
    return GPST₀ + Week(t.wn) + Second(t.tow_int) + Millisecond(floor(t.tow_frac * 1000))
end
function Base.convert(::Type{T}, t::GnssTime) where {T <: Date}
    return Date(convert(DateTime, t))
end
function Base.convert(::Type{T}, t::Union{Date, DateTime}) where {T <: GnssTime}
    return convert(GnssTime, DateTime(t))
end


# ==========================================================================================
# convenience constructors
# ==========================================================================================
# Convenience conversion
GnssTime(t::Union{SystemTime, Date, DateTime}) = Base.convert(GnssTime, t)

# UTC
#   NOTE:
#   The concept of 'Date' is independent of UTC.
#   Thus, conversion from Date to GnssTime does not take them into account.
#   However, GnssTime does account for seconds, and thus leap seconds are accounted for
#   before converting to a Date.
function DateTime(t::GnssTime, ::Type{UTC})
    dt = DateTime(t)
    return dt - Second(Int(LeapSeconds.offset_tai_utc(dt)) - LEAP_SECOND_TAI_OFFSET)
end
function GnssTime(t::DateTime, ::Type{UTC})
    s_offset = Int(LeapSeconds.offset_tai_utc(t)) - LEAP_SECOND_TAI_OFFSET
    return GnssTime(t + Second(s_offset))
end
Date(t::GnssTime, ::Type{UTC}) = Date(DateTime(t, UTC))

# I think asserting Date as UTC should be unsupported, it does not make sense.
# GnssTime(t::Date, ::Type{UTC}) = GnssTime(t)
