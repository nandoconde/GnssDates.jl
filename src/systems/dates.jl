# ==========================================================================================
# AbstractGnssTime interface
# ==========================================================================================
function wntow(T, t::DateTime)
    return wntow(T, GnssTime(t))
end


# ==========================================================================================
# conversion to/from `AbstractGnssTime`
# ==========================================================================================
function Base.convert(::Type{GnssTime}, t_utc::DateTime)
    # note: it assumes `t` is a UTC time -> convert to TAI first
    # note: CompoundPeriods are not used because they allocate :)
    t_tai = t_utc + Second(LeapSeconds.offset_tai_utc(t_utc))
    t_gps = t_tai - Second(GNSS_TAI_SECOND_OFFSET)
    Δms = (t_gps - GPST₀).value # Milliseconds
    Δs, frac_ms = fldmod(Δms, 1000)
    frac = frac_ms / 1000
    wn, tow = fldmod(Δs, SECONDS_IN_WEEK)
    return GnssTime(wn, tow, frac)
end

function Base.convert(::Type{DateTime}, t::GnssTime)
    t_gps = GPST₀ + Week(t.wn) + Second(t.tow) + Millisecond(floor(t.frac * 1000))
    t_tai = t_gps + Second(GNSS_TAI_SECOND_OFFSET)
    t_utc = t_tai + Second(LeapSeconds.offset_utc_tai(t_tai))
    return t_utc
end

function Base.convert(::Type{GnssTimeCoarse}, t_utc::DateTime)
    # note: it assumes `t` is a UTC time -> convert to TAI first
    # note: CompoundPeriods are not used because they allocate :)
    t_tai = t_utc + Second(LeapSeconds.offset_tai_utc(t_utc))
    t_gps = t_tai - Second(GNSS_TAI_SECOND_OFFSET)
    Δms = (t_gps - GPST₀).value # Milliseconds
    Δs, frac_ms = fldmod(Δms, 1000)
    wn, tow = fldmod(Δs, SECONDS_IN_WEEK)
    return GnssTimeCoarse(wn, tow)
end

function Base.convert(::Type{DateTime}, t::GnssTimeCoarse)
    t_gps = GPST₀ + Week(t.wn) + Second(t.tow)
    t_tai = t_gps + Second(GNSS_TAI_SECOND_OFFSET)
    t_utc = t_tai + Second(LeapSeconds.offset_utc_tai(t_tai))
    return t_utc
end

# ==========================================================================================
# convenience constructors
# ==========================================================================================
# Convenience conversion
"""
    GnssTime(t::DateTime)

Convert from `DateTime` in UTC to `GnssTime`.
"""
GnssTime(t::DateTime) = Base.convert(GnssTime, t)

"""
    DateTime(t::AbstractGnssTime)

Retrieve DateTime of `t`.
"""
DateTime(t::AbstractGnssTime) = Base.convert(DateTime, t)


# Convenience conversion to/from Dates types
"""
    GnssTimeCoarse(t::T)

Convert from `DateTime` in UTC to `GnssTimeCoarse`.
"""
GnssTimeCoarse(t::DateTime) = Base.convert(GnssTimeCoarse, t)
