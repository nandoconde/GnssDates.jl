# ==========================================================================================
# generic gnss time
# ==========================================================================================
# TODO Document struct and field
struct GnssTime <: FineTime
    wn::Int
    tow_int::Int
    tow_frac::Float64

    # main constructor
    function GnssTime(wn, tow_int, tow_frac)
        if wn < 0
            throw(DomainError(wn, "GnssTime cannot have a negative week number"))
        elseif tow_int < 0
            throw(DomainError(tow_int, "GnssTime cannot have a negative time of week"))
        elseif tow_int >= SECONDS_IN_WEEK
            throw(
                DomainError(
                    tow_int,
                    "GnssTime cannot have a time of week greater than SECONDS_IN_WEEK",
                ),
            )
        elseif tow_frac < 0.0
            throw(
                DomainError(
                    tow_frac,
                    "GnssTime cannot have a negative fractional time of week",
                ),
            )
        elseif tow_frac >= 1.0
            throw(
                DomainError(
                    tow_frac,
                    "GnssTime cannot have a fractional time of week greater than 1.0",
                ),
            )
        else
            return new(Int(wn), Int(tow_int), Float64(tow_frac))
        end
    end

    # unchecked constructor
    function GnssTime(wn, tow_int, tow_frac, ::Unchecked)
        return new(Int(wn), Int(tow_int), Float64(tow_frac))
    end
end


# ==========================================================================================
# canonicalization
# ==========================================================================================
function Dates.canonicalize(t::GnssTime)
    Δtow, tow_frac = fldmod(t.tow_frac, 1.0)
    Δweeks, tow_int = fldmod(t.tow_int + Int(Δtow), SECONDS_IN_WEEK)
    wn = t.wn + Δweeks
    if wn < 0
        throw(DomainError(wn, "GnssTime cannot be a negative time."))
    else
        return GnssTime(wn, tow_int, tow_frac, Unchecked())
    end
end


# ==========================================================================================
# conversion
# ==========================================================================================
# unchecked_convert (DateTime)
function unchecked_convert(::Type{GnssTime}, t::DateTime)
    # note: CompoundPeriods are not used because they allocate :)
    Δms = (t - GPST₀).value # Milliseconds
    # Δms < 0 && throw(DomainError(t, "GnssTime cannot represent a date before GPST₀"))
    Δs, tow_frac_ms = fldmod(Δms, 1000)
    tow_frac = tow_frac_ms / 1000
    wn, tow_int = fldmod(Δs, SECONDS_IN_WEEK)
    return GnssTime(wn, tow_int, tow_frac, Unchecked())
end

# GnssTime to DateTime
function Base.convert(::Type{T}, t::GnssTime) where {T <: DateTime}
    return GPST₀ + Week(t.wn) + Second(t.tow_int) + Millisecond(floor(t.tow_frac * 1000))
end
function Base.convert(::Type{T}, t::GnssTime) where {T <: Date}
    return Date(Base.convert(DateTime, t))
end
function Base.convert(::Type{T}, t::Union{Date, DateTime}) where {T <: GnssTime}
    return Dates.canonicalize(unchecked_convert(GnssTime, DateTime(t)))
end


# ==========================================================================================
# convenience constructors
# ==========================================================================================
# GnssTime (checked)
GnssTime(t::GnssTime) = Dates.canonicalize(t)

# GnssTime (unchecked)
GnssTime_(t::GnssTime) = t
GnssTime(t::GnssTime, ::Unchecked) = t
GnssTime_(wn, tow_int, tow_frac) = GnssTime(wn, tow_int, tow_frac, Unchecked())

# Dates to Gnss
GnssTime(t::DateTime) = Base.convert(GnssTime, t)
GnssTime(t::Date) = Base.convert(GnssTime, t)
GnssTime(t::DateTime, ::Unchecked) = unchecked_convert(GnssTime, t)
GnssTime(t::Date, ::Unchecked) = unchecked_convert(GnssTime, DateTime(t))
GnssTime_(t::DateTime) = GnssTime(t, Unchecked())
GnssTime_(t::Date) = GnssTime(t, Unchecked())

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
